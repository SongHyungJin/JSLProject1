package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UsersDAO;
import model.UsersDTO;

public class ProfileViewService implements Command {
	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession(false);
		//로그인여부 확인 
		if (session == null || session.getAttribute("id") == null) {
		    request.setAttribute("message", "로그인이 필요합니다.");
		    return;
		}
		UsersDTO dto = new UsersDAO().getProfile(Integer.parseInt(session.getAttribute("id").toString()));
		
		request.setAttribute("profile", dto);
	}
}
