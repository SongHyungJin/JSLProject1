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
		case "회원가입 주소":

			new SignupService().doCommand(request, response);

			Boolean signupSuccess = (Boolean) request.getAttribute("signupSuccess");

			if (signupSuccess != null && signupSuccess) {
				page = "로그인화면";
			} else {
				page = "회원가입화면";
			}
			break;
		case "이메일 인증 주소":
			new EmailVerifyService().doCommand(request, response);
			break;
			
		case "이메일 전송 주소":
			new EmailSendService().doCommand(request, response);
			break;
		case "로그인 주소":
			new LoginService().doCommand(request, response);
			int result = (int) request.getAttribute("result");
			if(result == 1) {
				page = "로그인 성공 시 이동할 페이지";
			} else {
				page = "로그인 실패 시 이동할 페이지";
			}
			break;
		case "로그아웃 주소":
			new LogoutService().doCommand(request, response);
			break;
		case "회원정보 view 주소":
			new ProfileViewService().doCommand(request, response);
			page = "회원정보 view 페이지";
			break;
		case "회원정보 수정 주소":
			new ProfileUpdateService().doCommand(request, response);
			page = "회원정보 view 페이지";
			break;
		}
		if (page != null) {
//			RequestDispatcher rs = request.getRequestDispatcher(page);
//			rs.forward(request, response);
			request.getRequestDispatcher(page).forward(request, response);
		}
	}

}
