package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.PlaceDAO;
import model.PlaceDTO;

/**
 * 리뷰 관련 화면 진입 처리
 * 매핑: /review/*
 *
 *  /review/list.do   → reviewList.jsp (가게의 전체 리뷰 목록, 미리보기 슬라이더)
 *  /review/all.do    → reviewAll.jsp (전체보기)
 *  /review/write.do  → reviewWrite.jsp (리뷰 작성, 로그인 필수)
 *  (나중에 추가 예정) /review/detail.do → 리뷰 1개 상세
 *  (나중에 추가 예정) /review/my.do     → 내가 쓴 리뷰만 모아보기
 *
 * ⚠️ 리뷰 테이블이 아직 없어서, 지금은 화면(디자인)만 구현합니다.
 *    가게 이름 등 상단 정보만 기존 PLACES 테이블(PlaceDAO)에서 가져와 보여줍니다.
 */
@WebServlet("/review/*")
public class ReviewController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doAction(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doAction(request, response);
    }

    protected void doAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        String action = request.getPathInfo();
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/main.do");
            return;
        }

        String page = null;

        switch (action) {
            case "/list.do":
                loadPlace(request);
                page = "/reviewList.jsp";
                break;

            case "/all.do":
                loadPlace(request);
                page = "/reviewAll.jsp";
                break;

            case "/write.do":
                // 로그인 안 했으면 로그인 화면으로 (직접 URL 접근 방어)
                HttpSession session = request.getSession(false);
                if (session == null || session.getAttribute("loginUser") == null) {
                    response.sendRedirect(request.getContextPath() + "/log/login.do");
                    return;
                }
                loadPlace(request);
                page = "/reviewWrite.jsp";
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/main.do");
                return;
        }

        request.getRequestDispatcher(page).forward(request, response);
    }

    /**
     * 가게 이름 등 기본 정보만 표시용으로 조회 (리뷰 자체는 아직 하드코딩된 예시)
     */
    private void loadPlace(HttpServletRequest request) {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                long id = Long.parseLong(idParam);
                PlaceDTO place = new PlaceDAO().getDetail(id);
                request.setAttribute("place", place);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
    }
}
