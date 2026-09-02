package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UsersDAO;
import model.UsersDTO;
import util.PasswordUtil;

public class LoginService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    request.setCharacterEncoding("utf-8");

	    String email = request.getParameter("email");
	    String password = request.getParameter("password");

	    UsersDAO dao = new UsersDAO();
	    UsersDTO dto = dao.loginByEmail(email);

	    if (dto != null && PasswordUtil.checkPassword(password, dto.getPassword())) {

	        // 로그인 성공 → 세션에 이메일 저장
	        HttpSession session = request.getSession();
	        session.setAttribute("id", dto.getId());
	        request.setAttribute("result", 1); // 로그인 성공 시 result를 1로 설정
	        return;

	    } else {

	        // 로그인 실패
	        request.setAttribute("result", 0); // 로그인 실패 시 result를 0로 설정
	        return;
	       
	    }
	}

}
