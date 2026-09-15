package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.PlaceBookingService;
import service.PlaceListService;
import service.PlaceSearchService;
import service.PlaceViewService;

/**
 * 메인화면 가게 목록 / 검색 / 국가·지역 필터 / 상세 / 예약 처리
 * 매핑: /place/*
 */
@WebServlet("/place/*")
public class PlaceController extends HttpServlet {
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
            action = "/list.do"; // 그냥 /place/ 로만 들어오면 기본 목록으로 처리
        }
        System.out.println("action : " + action);

        String page = null;

        switch (action) {
            case "/list.do":
                new PlaceListService().doCommand(request, response);
                page = "/placelist.jsp"; // ← 추가: 목록 채운 뒤 placelist.jsp로 forward
                break;

            case "/search.do":
                new PlaceSearchService().doCommand(request, response);
                page = "/placelist.jsp";
                break;

            case "/view.do":
                new PlaceViewService().doCommand(request, response);
                page = "/view.jsp";
                break;
                
            case "/category.do":
                page = "/category.jsp";
                break;

            case "/booking.do":
                // 로그인 안 했으면 로그인 화면으로 (직접 URL 접근 방어)
                HttpSession session = request.getSession(false);
                if (session == null || session.getAttribute("loginUser") == null) {
                    response.sendRedirect(request.getContextPath() + "/log/login.do");
                    return;
                }
                new PlaceViewService().doCommand(request, response); // 가게 정보(place)는 재사용
                page = "/booking.jsp";
                break;

            case "/bookingpro.do":
                // ajax 요청 - 이 안에서 응답을 직접 씀 (forward 안 함)
                new PlaceBookingService().doCommand(request, response);
                return; // ★ 여기서 바로 끝내야 함 (아래 forward 코드 타면 안 됨)

            default:
                response.sendRedirect(request.getContextPath() + "/main.jsp");
                return;
        }

        // page가 정해진 경우에만 딱 한 번 forward
        if (page != null) {
            request.getRequestDispatcher(page).forward(request, response);
        }
    }
}