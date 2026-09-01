package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutService implements Command {
	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//로그아웃이란 세션을 삭제하는 것 
		 request.setCharacterEncoding("utf-8");
		 
		 HttpSession session = request.getSession(false);
		 //기존 세션이 있으면 가져오고 없으면 null을 반환 
		 //세션을 생성하지 않고 기존 세션만 가져온다
		 if(session!=null) {
			 session.invalidate();//세션 삭제 
		 }
		 response.sendRedirect(request.getContextPath() + "/main.do"); 
		 //servlet 반환 주소 일단 main.do	
	}
}
