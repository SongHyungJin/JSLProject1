package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BookmarksDAO;

public class BookmarkDeleteService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession(false);

		// 로그인 여부 확인
		if (session == null || session.getAttribute("id") == null) {
			response.getWriter().write("login");
			return;
		}

		int userId = Integer.parseInt(
				session.getAttribute("id").toString()
		);

		int placeId = Integer.parseInt(
				request.getParameter("placeId")
		);

		BookmarksDAO dao = new BookmarksDAO();

		int result = dao.delete(userId, placeId);

		if (result == 0) {
			response.getWriter().write("fail");
			return;
		}

		response.getWriter().write("delete");
	}
}