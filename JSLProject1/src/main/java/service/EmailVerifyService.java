package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EmailVerifyService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String UsersEmailCode = request.getParameter("UsersEmailCode");
		String sessionEmailCode =
		        (String) request.getSession().getAttribute("emailCode");

		if (sessionEmailCode != null && sessionEmailCode.equals(UsersEmailCode)) {
		    request.getSession().setAttribute("emailVerified", true);
		    request.getSession().removeAttribute("emailCode");
		} else {
		    request.getSession().setAttribute("emailVerified", false);
		    request.setAttribute("message", "인증코드가 다릅니다.");
		    return;
		}
	}

}
