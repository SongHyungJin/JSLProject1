package util;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Deque;
import java.util.LinkedHashMap;
import java.util.List;

import model.PlacesDTO;

/**
 * 코스(루트) 추천 알고리즘 (우리 DB 기반). (FR-102)
 *
 *  (A) 선정: 카테고리 다양성(라운드로빈) + 카테고리 내 평점 내림차순으로 상위 N개
 *  (B) 정렬: 최근접 이웃 + 2-opt 로 동선(방문 순서) 최적화 — 거리는 기존 util.DistanceUtil 재사용
 *
 * 순수 로직이라 단위 테스트가 쉽고, 나중에 실도로 거리로 바꾸려면 dist()만 교체하면 된다.
 */
public class RouteRecommender {

    /** 후보(우리 DB places) → 선정 + 동선 정렬된 코스 반환 */
    public static List<PlacesDTO> recommend(List<PlacesDTO> candidates, int limit) {
        if (candidates == null || candidates.isEmpty()) {
            return new ArrayList<>();
        }
        return orderRoute(selectTopN(dedup(candidates), limit)); // 중복 점포 제거 후 선정
    }

    /**
     * 같은 장소 중복 제거. (시드 데이터 + 구글 찜으로 같은 점포가 두 번 들어간 경우 등)
     * 키: 이름(공백/대소문자 무시). 같은 이름이면 하나만 남긴다.
     */
    static List<PlacesDTO> dedup(List<PlacesDTO> places) {
        List<PlacesDTO> result = new ArrayList<>();
        java.util.Set<String> seen = new java.util.HashSet<>();
        for (PlacesDTO p : places) {
            String key = (p.getName() == null) ? "" : p.getName().trim().toLowerCase();
            if (seen.add(key)) {
                result.add(p);
            }
        }
        return result;
    }

    // ===== (A) 선정: 다양성 + 평점 =====
    static List<PlacesDTO> selectTopN(List<PlacesDTO> candidates, int limit) {
        List<PlacesDTO> sorted = new ArrayList<>(candidates);
        // 평점 내림차순
        sorted.sort((a, b) -> Double.compare(b.getRating(), a.getRating()));

        // 카테고리별 큐 (정렬 순서 유지)
        LinkedHashMap<String, Deque<PlacesDTO>> byCategory = new LinkedHashMap<>();
        for (PlacesDTO p : sorted) {
            String c = (p.getCategory() == null) ? "" : p.getCategory();
            byCategory.computeIfAbsent(c, k -> new ArrayDeque<>()).addLast(p);
        }

        // 카테고리 라운드로빈으로 골고루 뽑기 → 식당만 몰리지 않게
        List<PlacesDTO> result = new ArrayList<>();
        while (result.size() < limit) {
            boolean picked = false;
            for (Deque<PlacesDTO> queue : byCategory.values()) {
                if (!queue.isEmpty()) {
                    result.add(queue.pollFirst());
                    picked = true;
                    if (result.size() >= limit) break;
                }
            }
            if (!picked) break; // 후보 소진
        }
        return result;
    }

    // ===== (B) 정렬: 최근접 이웃 + 2-opt =====
    public static List<PlacesDTO> orderRoute(List<PlacesDTO> places) {
        return twoOpt(nearestNeighbor(dedup(places))); // 중복 제거 후 동선 정렬
    }

    static List<PlacesDTO> nearestNeighbor(List<PlacesDTO> places) {
        List<PlacesDTO> remaining = new ArrayList<>(places);
        List<PlacesDTO> ordered = new ArrayList<>();
        if (remaining.isEmpty()) return ordered;

        PlacesDTO current = remaining.remove(0);
        ordered.add(current);
        while (!remaining.isEmpty()) {
            PlacesDTO nearest = null;
            double best = Double.MAX_VALUE;
            for (PlacesDTO cand : remaining) {
                double d = dist(current, cand);
                if (d < best) { best = d; nearest = cand; }
            }
            ordered.add(nearest);
            remaining.remove(nearest);
            current = nearest;
        }
        return ordered;
    }

    static List<PlacesDTO> twoOpt(List<PlacesDTO> route) {
        if (route.size() < 4) return route;
        List<PlacesDTO> best = new ArrayList<>(route);
        double bestDist = total(best);
        boolean improved = true;
        while (improved) {
            improved = false;
            for (int i = 1; i < best.size() - 1; i++) {
                for (int k = i + 1; k < best.size(); k++) {
                    List<PlacesDTO> candidate = swap(best, i, k);
                    double d = total(candidate);
                    if (d < bestDist - 1e-9) {
                        best = candidate;
                        bestDist = d;
                        improved = true;
                    }
                }
            }
        }
        return best;
    }

    static List<PlacesDTO> swap(List<PlacesDTO> r, int i, int k) {
        List<PlacesDTO> out = new ArrayList<>(r.subList(0, i));
        List<PlacesDTO> mid = new ArrayList<>(r.subList(i, k + 1));
        Collections.reverse(mid);
        out.addAll(mid);
        out.addAll(r.subList(k + 1, r.size()));
        return out;
    }

    static double total(List<PlacesDTO> r) {
        double sum = 0;
        for (int i = 0; i < r.size() - 1; i++) {
            sum += dist(r.get(i), r.get(i + 1));
        }
        return sum;
    }

    /** 거리(km) — 기존 util.DistanceUtil(하버사인) 재사용 */
    static double dist(PlacesDTO a, PlacesDTO b) {
        return DistanceUtil.calculateDistance(
                a.getLatitude(), a.getLongitude(),
                b.getLatitude(), b.getLongitude());
    }

    /**
     * 코스의 구간별 이동 정보(거리 + 추정 시간) 문자열 목록. 크기 = 코스 수 - 1.
     * 예: "약 1.2km · 도보 18분". 실제 도로 시간이 아니라 직선거리 기반 추정치.
     *  - 1.5km 이하: 도보(4km/h), 그 이상: 차로(도심 30km/h)
     */
    public static List<String> moveInfoList(List<PlacesDTO> course) {
        List<String> moves = new ArrayList<>();
        if (course == null) return moves;
        for (int i = 0; i < course.size() - 1; i++) {
            moves.add(formatMove(dist(course.get(i), course.get(i + 1))));
        }
        return moves;
    }

    private static String formatMove(double km) {
        String d = String.format("약 %.1fkm", km);
        String mode;
        int min;
        if (km <= 1.5) {
            mode = "도보";
            min = (int) Math.round(km / 4.0 * 60.0);
        } else {
            mode = "차로";
            min = (int) Math.round(km / 30.0 * 60.0);
        }
        if (min < 1) min = 1;
        return d + " · " + mode + " 약 " + min + "분";
    }

    // ===== 지도 표시용 JSON =====
    /** 코스 → [{"name","lat","lng","order","category","rating"}, ...] */
    public static String toJson(List<PlacesDTO> course) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < course.size(); i++) {
            PlacesDTO p = course.get(i);
            if (i > 0) sb.append(",");
            sb.append("{\"name\":\"").append(esc(p.getName())).append("\",")
              .append("\"lat\":").append(p.getLatitude()).append(",")
              .append("\"lng\":").append(p.getLongitude()).append(",")
              .append("\"order\":").append(i).append(",")
              .append("\"category\":\"").append(esc(p.getCategory())).append("\",")
              .append("\"rating\":").append(p.getRating())
              .append("}");
        }
        return sb.append("]").toString();
    }

    private static String esc(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
