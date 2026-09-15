package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBManager;

/**
 * PLACES 테이블 조회 담당 DAO
 */
public class PlaceDAO {

    /**
     * 가게 목록 조회
     * - keyword가 비어있으면 필터(카테고리/국가/지역)만 적용해서 랜덤 순서로 조회
     * - keyword가 있으면 이름/설명/지역(주소) 중 하나라도 포함되면 조회 (필터도 같이 적용)
     *   ※ menu 컬럼은 PLACES 테이블에 없어서 검색 대상에서 제외
     *   ※ country 컬럼이 따로 없어서, country/region 둘 다 region 컬럼에 부분일치(LIKE)로 검색한다.
     *     (region 컬럼에 "일본 도쿄도 ..." 처럼 국가명까지 포함된 값이 들어온다는 전제)
     *
     * @param keyword  검색어 (없으면 null 또는 "") - name, description, region 전부에서 검색
     * @param category 카테고리 (없으면 null 또는 "")
     * @param country  국가 (없으면 null 또는 "") - region 컬럼에서 부분일치 검색
     * @param region   지역 (없으면 null 또는 "") - region 컬럼에서 부분일치 검색
     */
    public List<PlaceDTO> getList(String keyword, String category, String country, String region) {

        List<PlaceDTO> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT id, name, category, region, latitude, longitude, description, ");
        sql.append("business_hours, image_url, reservable, avg_rating ");
        sql.append("FROM places WHERE 1=1 ");

        boolean hasKeyword = (keyword != null && !keyword.trim().isEmpty());
        boolean hasCategory = (category != null && !category.trim().isEmpty());
        boolean hasCountry = (country != null && !country.trim().isEmpty());
        boolean hasRegion = (region != null && !region.trim().isEmpty());

        if (hasKeyword) {
            sql.append("AND (name LIKE ? OR description LIKE ? OR region LIKE ?) ");
        }
        if (hasCategory) {
            sql.append("AND category = ? ");
        }
        if (hasCountry) {
            sql.append("AND region LIKE ? ");
        }
        if (hasRegion) {
            sql.append("AND region LIKE ? ");
        }

        if (!hasKeyword) {
            sql.append("ORDER BY DBMS_RANDOM.VALUE");
        }

        try (Connection conn = DBManager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

            int idx = 1;

            if (hasKeyword) {
                String like = "%" + keyword + "%";
                pstmt.setString(idx++, like);
                pstmt.setString(idx++, like);
                pstmt.setString(idx++, like);
            }
            if (hasCategory) {
                pstmt.setString(idx++, category);
            }
            if (hasCountry) {
                pstmt.setString(idx++, "%" + country + "%");
            }
            if (hasRegion) {
                pstmt.setString(idx++, "%" + region + "%");
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 별점 높은 가게들 중 랜덤으로 count개 뽑기 (추천 슬라이드용)
     */
    public List<PlaceDTO> getTopRatedRandomList(int topN, int count) {

        List<PlaceDTO> list = new ArrayList<>();

        String sql =
            "SELECT * FROM ( " +
            "   SELECT id, name, category, region, latitude, longitude, description, " +
            "          business_hours, image_url, reservable, avg_rating " +
            "   FROM ( " +
            "       SELECT id, name, category, region, latitude, longitude, description, " +
            "              business_hours, image_url, reservable, avg_rating " +
            "       FROM places ORDER BY avg_rating DESC " +
            "   ) WHERE ROWNUM <= ? " +
            "   ORDER BY DBMS_RANDOM.VALUE " +
            ") WHERE ROWNUM <= ?";

        try (Connection conn = DBManager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, topN);
            pstmt.setInt(2, count);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 가게 상세 1건 조회 (view.jsp / booking.jsp용)
     * @param id 가게 번호 (PK)
     */
    public PlaceDTO getDetail(long id) {

        PlaceDTO dto = null;

        String sql = "SELECT id, name, category, region, latitude, longitude, description, "
                   + "business_hours, image_url, reservable, avg_rating "
                   + "FROM places WHERE id = ?";

        try (Connection conn = DBManager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    dto = mapRow(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dto;
    }

    /**
     * ResultSet 한 줄 → PlaceDTO 하나로 옮겨담는 도우미 메서드
     */
    private PlaceDTO mapRow(ResultSet rs) throws SQLException {
        PlaceDTO dto = new PlaceDTO();
        dto.setId(rs.getLong("id"));
        dto.setName(rs.getString("name"));
        dto.setCategory(rs.getString("category"));
        dto.setRegion(rs.getString("region"));

        double lat = rs.getDouble("latitude");
        dto.setLatitude(rs.wasNull() ? null : lat);

        double lng = rs.getDouble("longitude");
        dto.setLongitude(rs.wasNull() ? null : lng);

        dto.setDescription(rs.getString("description"));
        dto.setBusinessHours(rs.getString("business_hours"));
        dto.setImageUrl(rs.getString("image_url"));
        dto.setReservable(rs.getInt("reservable"));

        double rating = rs.getDouble("avg_rating");
        dto.setAvgRating(rs.wasNull() ? null : rating);

        return dto;
    }
}
