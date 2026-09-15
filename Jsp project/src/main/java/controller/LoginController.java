package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.SignupService;
import service.LoginService;
import service.LogoutService;
import service.FindPasswordService;
import service.FindEmailService;

@WebServlet("/log/*")
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doAction(request, response);
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doAction(request, response);
    }


    protected void doAction(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        String action =
                request.getPathInfo();


        if (action == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/main.do"
            );

            return;
        }


        System.out.println(
                "action : " + action
        );


        String page = null;


        switch (action) {


            /*
             * 로그인 화면
             */
            case "/login.do": {

                HttpSession session =
                        request.getSession();


                String redirect =
                        request.getParameter(
                                "redirect"
                        );


                /*
                 * redirect가 들어온 경우에만
                 * 세션에 저장
                 */
                if (redirect != null
                        && !redirect.trim().isEmpty()
                        && redirect.startsWith("/")
                        && !redirect.startsWith("//")) {

                    session.setAttribute(
                            "loginRedirect",
                            redirect
                    );
                }


                page = "/login.jsp";

                break;
            }



            /*
             * 로그인 처리 AJAX
             */
            case "/loginpro.do":

                new LoginService()
                        .doCommand(
                                request,
                                response
                        );

                return;



            /*
             * 이메일 찾기 화면
             */
            case "/findEmail.do":

                page = "/findEmail.jsp";

                break;



            /*
             * 이메일 찾기 처리 AJAX
             */
            case "/findEmailPro.do":

                new FindEmailService()
                        .doCommand(
                                request,
                                response
                        );

                return;



            /*
             * 비밀번호 찾기 화면
             */
            case "/findPassword.do":

                page = "/findPassword.jsp";

                break;



            /*
             * 비밀번호 찾기 / 변경 처리 AJAX
             */
            case "/findPasswordPro.do":

                new FindPasswordService()
                        .doCommand(
                                request,
                                response
                        );

                return;



            /*
             * 회원가입 화면
             */
            case "/signup.do":

                page = "/signup.jsp";

                break;



            /*
             * 회원가입 처리
             */
            case "/signuppro.do":

                new SignupService()
                        .doCommand(
                                request,
                                response
                        );

                return;



            /*
             * 로그아웃
             */
            case "/logout.do":

                new LogoutService()
                        .doCommand(
                                request,
                                response
                        );


                response.sendRedirect(
                        request.getContextPath()
                        + "/main.do"
                );

                return;



            /*
             * 마이페이지
             */
            case "/mypage.do": {

                HttpSession session =
                        request.getSession(false);


                if (session == null
                        || session.getAttribute(
                                "loginUser"
                        ) == null) {


                    String lang =
                            request.getParameter(
                                    "lang"
                            );


                    if (lang == null
                            || lang.trim().isEmpty()) {

                        lang = "ko";
                    }


                    HttpSession newSession =
                            request.getSession();


                    /*
                     * 로그인 후 마이페이지로
                     */
                    newSession.setAttribute(
                            "loginRedirect",
                            "/log/mypage.do"
                    );


                    response.sendRedirect(
                            request.getContextPath()
                            + "/log/login.do?lang="
                            + lang
                    );


                    return;
                }


                page = "/mypage.jsp";

                break;
            }



            /*
             * 정의되지 않은 URL
             */
            default:

                response.sendRedirect(
                        request.getContextPath()
                        + "/main.do"
                );

                return;
        }



        /*
         * JSP forward
         */
        if (page != null) {

            request
                .getRequestDispatcher(
                        page
                )
                .forward(
                        request,
                        response
                );
        }
    }
}