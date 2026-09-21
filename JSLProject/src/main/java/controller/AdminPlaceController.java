package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.PlacesDAO;
import model.PlacesDTO;
import model.UsersDAO;
import model.UsersDTO;

/**
 * 관리자 점포 등록 (방법 2: 관리자 화면으로 places 데이터 채우기).
 *  GET  /admin/place/form.do    → 등록 폼 (관리자만)
 *  POST /admin/place/insert.do  → 점포 저장 (관리자만)
 *
 * 권한: 세션의 id 로 사용자 role 을 조회해 'admin' 인 경우만 허용.
 */
@WebServlet("/admin/place/*")
public class AdminPlaceController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) { deny(request, response); return; }
        // 등록 폼 표시
        request.getRequestDispatcher("/placeRegister.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) { deny(request, response); return; }
        request.setCharacterEncoding("utf-8");

        PlacesDTO dto = new PlacesDTO();
        dto.setName(trim(request.getParameter("name")));
        dto.setCategory(normalizeCategory(request.getParameter("category")));
        dto.setRegion(trim(request.getParameter("region")));
        dto.setLatitude(parseDouble(request.getParameter("latitude")));
        dto.setLongitude(parseDouble(request.getParameter("longitude")));
        dto.setRating(clampRating(parseDouble(request.getParameter("rating"))));
        dto.setDescription(trim(request.getParameter("description")));
        dto.setBusiness_hours(trim(request.getParameter("businessHours")));
        dto.setImage_url(trim(request.getParameter("imageUrl")));
        dto.setReservable("on".equals(request.getParameter("reservable")));

        String result = "fail";
        // 필수값 + 좌표 범위 검증
        if (dto.getName() != null && !dto.getName().isEmpty()
                && dto.getRegion() != null && !dto.getRegion().isEmpty()
                && dto.getLatitude() >= -90 && dto.getLatitude() <= 90
                && dto.getLongitude() >= -180 && dto.getLongitude() <= 180) {
            int n = new PlacesDAO().PlacesInsert(dto);
            if (n > 0) result = "success";
        }
        response.sendRedirect(request.getContextPath() + "/admin/place/form.do?result=" + result);
    }

    // ===== 권한 확인 =====
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        Object uid = (session != null) ? session.getAttribute("id") : null;
        if (uid == null) return false;
        try {
            UsersDTO me = new UsersDAO().getProfile((Integer) uid);
            return me != null && "admin".equals(me.getRole());
        } catch (Exception e) {
            return false;
        }
    }

    private void deny(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 권한 없음 → 메인으로
        response.sendRedirect(request.getContextPath() + "/main.do");
    }

    // ===== 유틸 =====
    private String normalizeCategory(String c) {
        if (c == null) return "etc";
        c = c.trim();
        if (c.equals("restaurant") || c.equals("cafe") || c.equals("shop")
                || c.equals("attraction") || c.equals("etc")) {
            return c;
        }
        return "etc";
    }

    private double parseDouble(String s) {
        try {
            return (s == null || s.isEmpty()) ? 0.0 : Double.parseDouble(s.trim());
        } catch (NumberFormatException e) {
            return 0.0;
        }
    }

    private double clampRating(double v) {
        if (v < 0) v = 0;
        if (v > 5) v = 5;
        return Math.round(v * 10.0) / 10.0; // rating number(2,1)
    }

    private String trim(String s) {
        return (s == null) ? null : s.trim();
    }
}
