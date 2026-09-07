package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BookmarksDAO;
import model.BookmarksDTO;

public class BookmarkAddService implements Command {
	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
		// 로그인여부 확인
		if (session == null || session.getAttribute("id") == null) {
			request.setAttribute("message", "로그인이 필요합니다.");
			return;
		}
		int userId = Integer.parseInt(session.getAttribute("id").toString());
		int placeId = Integer.parseInt(request.getParameter("placeId"));
		BookmarksDAO dao = new BookmarksDAO();
		BookmarksDTO dto = new BookmarksDTO();
		dto.setUsersId(userId);
		dto.setPlacesId(placeId);
		int result = dao.insert(dto);
		if (result == 0) {
			request.setAttribute("message", "북마크 추가에 실패했습니다.");
			return;
		}
		request.setAttribute("message", "북마크가 추가되었습니다.");
		
	}
}
