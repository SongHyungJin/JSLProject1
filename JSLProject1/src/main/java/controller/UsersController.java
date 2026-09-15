package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BookmarkListService;
import service.EmailSendService;
import service.EmailVerifyService;
import service.FindEmailService;
import service.FindPasswordService;
import service.LoginService;
import service.LogoutService;
import service.PasswordUpdateService;
import service.ProfileUpdateService;
import service.ProfileViewService;
import service.ReservationListService;
import service.SignupService;
import service.WithdrawService;

@WebServlet("/users/*")
public class UsersController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UsersController() {
		super();
	}

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
		String action = request.getPathInfo(); // 요청한 주소를 가져오는 메서드
		String page = null;
		switch (action) {
		case "/signupview.do":
			page = "/signup.jsp";
			break;
			
		case "/signup.do": //회원가입

			new SignupService().doCommand(request, response);

			Boolean signupSuccess = (Boolean) request.getAttribute("signupSuccess");

			if (signupSuccess != null && signupSuccess) {
				page = "/login.jsp";
			} else {
				page = "/signup.jsp";
			}
			break;
		case "/emailverify.do": //비동기식 이메일 확인
			new EmailVerifyService().doCommand(request, response);
			break;
			
		case "/emailsend.do": //비동기식 이메일 전송
			new EmailSendService().doCommand(request, response);
			break;
		case "/loginview.do":
			page = "/login.jsp";
			break;
		case "/login.do": //로그인 
			new LoginService().doCommand(request, response);

		    int result = (int) request.getAttribute("result");

		    if (result == 1) {
		        response.sendRedirect(request.getContextPath() + "/main.do?lang=" + request.getParameter("lang"));
		    } else {
		        page = "/login.jsp";
		    }

		    break;
		case "/logout.do": //로그아웃
			new LogoutService().doCommand(request, response);
		    break;
		case "/profile.do": //프로필 조회
			new ReservationListService().doCommand(request, response);
			new ProfileViewService().doCommand(request, response);
			new BookmarkListService().doCommand(request, response);
			page = "/mypage.jsp";
			break;
		case "/profileupdate.do": //프로필 수정
			new ProfileUpdateService().doCommand(request, response);
			break;
		case "/passwordupdate.do": //비밀번호 수정
			new PasswordUpdateService().doCommand(request, response);
			break;
		case "/findemail.do"://이메일 찾기 
			page = "/findEmail.jsp";
			break;
		case "/findpassword.do"://비밀번호 찾기
			page = "/findPassword.jsp";
			break;
		
		case "/findEmailPro.do":
			new FindEmailService().doCommand(request, response);
			return;
		case "/findPasswordPro.do":
			new FindPasswordService().doCommand(request, response);
			return;
		case "/withdraw.do"://회원 탈퇴
		    new WithdrawService().doCommand(request, response);
		    return;
		}
		if (page != null) {
//			RequestDispatcher rs = request.getRequestDispatcher(page);
//			rs.forward(request, response);
			request.getRequestDispatcher(page).forward(request, response);
		}
	}

}
