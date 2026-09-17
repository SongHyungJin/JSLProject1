package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.GoogleBookmarkDAO;

/**
 * 구글 Places 점포 찜 토글. (프론트 placelist.jsp 의 AJAX 대상)
 *  POST /placebookmark/toggle.do
 *  파라미터: placeId(구글 place_id), name, category, region, lat, lng, rating
 *  응답: {"success":true,"bookmarked":true|false} 또는 {"success":false,"needLogin":true}
 *
 * 처리: 로그인 확인 → 구글 점포를 places 에 upsert(google_place_id 기준) → bookmarks 토글
 */
@WebServlet("/placebookmark/toggle.do")
public class PlaceBookmarkController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=UTF-8");

        // 로그인 확인 (LoginService 가 session 에 "id" 저장)
        HttpSession session = request.getSession(false);
        Object uid = (session != null) ? session.getAttribute("id") : null;
        if (uid == null) {
            response.getWriter().write("{\"success\":false,\"needLogin\":true}");
            return;
        }
        int usersId = (Integer) uid;

        String googlePlaceId = trim(request.getParameter("placeId"));
        String name = trim(request.getParameter("name"));
        String category = normalizeCategory(request.getParameter("category"));
        String region = trim(request.getParameter("region"));
        double lat = parseDouble(request.getParameter("lat"));
        double lng = parseDouble(request.getParameter("lng"));
        double rating = round1(parseDouble(request.getParameter("rating")));

        if (region == null || region.isEmpty()) region = "etc";
        if (name == null || name.isEmpty()) name = "(이름 없음)";

        // 필수값 검증 (구글 place_id, 좌표)
        if (googlePlaceId == null || googlePlaceId.isEmpty()
                || lat < -90 || lat > 90 || lng < -180 || lng > 180) {
            response.getWriter().write("{\"success\":false}");
            return;
        }

        GoogleBookmarkDAO dao = new GoogleBookmarkDAO();
        int placesId = dao.upsertPlace(googlePlaceId, name, category, region, lat, lng, rating);
        if (placesId <= 0) {
            response.getWriter().write("{\"success\":false}");
            return;
        }

        boolean bookmarked = dao.toggleBookmark(usersId, placesId);
        response.getWriter().write("{\"success\":true,\"bookmarked\":" + bookmarked + "}");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    // ===== 유틸 =====
    private String normalizeCategory(String c) {
        if (c == null) return "etc";
        c = c.trim();
        if (c.equals("restaurant") || c.equals("cafe") || c.equals("shop") || c.equals("attraction")) {
            return c;
        }
        return "etc"; // 체크 제약: restaurant/cafe/shop/attraction/etc
    }

    private double parseDouble(String s) {
        try {
            return (s == null || s.isEmpty()) ? 0.0 : Double.parseDouble(s.trim());
        } catch (NumberFormatException e) {
            return 0.0;
        }
    }

    private double round1(double v) {
        if (v < 0) v = 0;
        if (v > 5) v = 5;
        return Math.round(v * 10.0) / 10.0; // rating number(2,1)
    }

    private String trim(String s) {
        return (s == null) ? null : s.trim();
    }
}
