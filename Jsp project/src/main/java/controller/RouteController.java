package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 추천 루트 / 내 루트 화면 진입 처리
 * 매핑: /route/*
 *
 *  /route/bestroute.do → BestRoute.jsp (홈페이지 추천 루트)
 *  /route/myroute.do   → MyRoute.jsp   (내가 찜한 곳 잇는 루트)
 *
 * 지금은 둘 다 화면만 있고 DB 연동 전이라 forward만 해줌.
 * 나중에 실제 루트 데이터 연동 시 여기서 Service 호출 후 request.setAttribute()로 넘기면 됨.
 */
@WebServlet("/route/*")
public class RouteController extends HttpServlet {
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
            case "/bestroute.do":
                page = "/BestRoute.jsp";
                break;

            case "/myroute.do":
                page = "/MyRoute.jsp";
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/main.do");
                return;
        }

        request.getRequestDispatcher(page).forward(request, response);
    }
}
