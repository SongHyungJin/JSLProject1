package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BookmarksDAO;
import model.BookmarksDTO;

public class BookmarkListService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// 로그인 여부 확인
		if (request.getSession(false) == null || request.getSession(false).getAttribute("id") == null) {
			request.setAttribute("message", "로그인이 필요합니다.");
			return;
		}
		int userId = Integer.parseInt(request.getSession(false).getAttribute("id").toString());
		List<BookmarksDTO> bookmarkList = new BookmarksDAO().selectBookmarksBy(userId);
		request.setAttribute("bookmarkList", bookmarkList);
		
	}

}
