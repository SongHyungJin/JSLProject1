package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EmailVerifyService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String UsersEmailCode = request.getParameter("UsersEmailCode");
		HttpSession session = request.getSession();
		String sessionEmailCode =
		        (String) session.getAttribute("emailCode");
		Long emailCodeTime = (long)session.getAttribute("emailCodeTime");
		// 5분 유효시간 확인
		long currentTime = System.currentTimeMillis();

		if (sessionEmailCode == null || UsersEmailCode ==null  ) {
			request.getSession().setAttribute("emailVerified", false);
			response.getWriter().write( "signup.msg.email.verify.empty" );
		    return;
			
		} else if(!sessionEmailCode.equals(UsersEmailCode)) {
		    request.getSession().setAttribute("emailVerified", false);
		    response.getWriter().write( "signup.msg.email.verify.wrong" );
		    return;
		}else if(currentTime - emailCodeTime > 5 * 60 * 1000) {
			 request.getSession().setAttribute("emailVerified", false);
			 response.getWriter().write( "signup.msg.email.verify.expired" );
			 return;
		}
		
		request.getSession().setAttribute("emailVerified", true);
	    request.getSession().removeAttribute("emailCode");
	    response.getWriter().write( "signup.msg.email.verify.success" );
		
	}

}
