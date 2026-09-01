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
		
		UsersDTO dto = new UsersDTO();
		UsersDAO dao = new UsersDAO();
		dto =dao.loginByEmail(email);
		
		
		if(dto!=null&& PasswordUtil.checkPassword(password, dto.getPassword())) {
			//세션(서버저장)생성
			HttpSession session = request.getSession();
			session.setAttribute("email", email); //계속 서버에 저장
			//request.setAttribute("userid", userid); //다른 페이지로 이동하면 속성값 사라짐
			response.getWriter().write("success");//다시 ajax success로 돌아가는 값
			
		}else {
			response.getWriter().write("fail");
		}
	}

}
