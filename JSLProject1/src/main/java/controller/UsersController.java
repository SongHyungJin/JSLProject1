package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.EmailSendService;
import service.EmailVerifyService;
import service.LoginService;
import service.LogoutService;
import service.PasswordUpdateService;
import service.ProfileUpdateService;
import service.ProfileViewService;
import service.SignupService;

@WebServlet("/Users/*")
public class UsersController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UsersController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String action = request.getPathInfo(); // 요청한 주소를 가져오는 메서드
		String page = null;
		switch (action) {
		case "signup.do": //회원가입

			new SignupService().doCommand(request, response);

			Boolean signupSuccess = (Boolean) request.getAttribute("signupSuccess");

			if (signupSuccess != null && signupSuccess) {
				page = "/users/login.jsp";
			} else {
				page = "/users/signup.jsp";
			}
			break;
		case "emailverify.do": //비동기식 이메일 확인
			new EmailVerifyService().doCommand(request, response);
			break;
			
		case "emailsend.do": //비동기식 이메일 전송
			new EmailSendService().doCommand(request, response);
			break;
		case "login.do": //로그인 
			new LoginService().doCommand(request, response);
			int result = (int) request.getAttribute("result");
			if(result == 1) {
				page = "/index.jsp"; //메인 페이지
			} else {
				page = "/users/login.jsp"; //로그인 실패 시 로그인 페이지로 이동
			}
			break;
		case "logout.do": //로그아웃
			new LogoutService().doCommand(request, response);
			break;
		case "profile.do": //프로필 조회
			new ProfileViewService().doCommand(request, response);
			page = "/users/profile.jsp";
			break;
		case "profileupdate.do": //프로필 수정
			new ProfileUpdateService().doCommand(request, response);
			page = "/users/profile.jsp";
			break;
		case "passwordupdate.do": //비밀번호 수정
			new PasswordUpdateService().doCommand(request, response);
			page = "/users/profile.jsp";
			break;
		}
		if (page != null) {
//			RequestDispatcher rs = request.getRequestDispatcher(page);
//			rs.forward(request, response);
			request.getRequestDispatcher(page).forward(request, response);
		}
	}

}
