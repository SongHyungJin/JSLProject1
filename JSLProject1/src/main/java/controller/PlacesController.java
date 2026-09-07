package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BookmarkAddService;
import service.BookmarkListService;
import service.PlacesDetailViewService;
import service.PlacesListFilter;
import service.PlacesSearchbyKeyword;


@WebServlet("/Places/*")
public class PlacesController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public PlacesController() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getPathInfo(); // 요청한 주소를 가져오는 메서드
		String page = null;
		switch (action) {
		case "/placesAllList.do": // 점포 전체 조회
				new PlacesListFilter().doCommand(request, response);
				page = "/places/placesAllList.jsp";
				break;
		case "/placesDetail.do": // 점포 상세정보
				new PlacesDetailViewService().doCommand(request, response);
				page = "/places/placesDetail.jsp";
				break;
		case "/placesSearch.do": // 점포 검색
				new PlacesSearchbyKeyword().doCommand(request, response);
				page = "/places/placesKeywordList.jsp"; //검색 결과 보여주는 jsp 페이지
				break;
		case "bookmarksadd.do":// 북마크 등록
				new BookmarkAddService().doCommand(request, response);
				page = "/places/bookmarksList.jsp"; //북마크 등록 후 북마크 리스트 페이지로 이동 
				break;
		case "bookmarkslist.do":// 북마크 리스트 조회
				new BookmarkListService().doCommand(request, response);
				page = "/places/bookmarksList.jsp"; //북마크 리스트 페이지로 이동 
				break;
			
		}
		if(page != null) {
			request.getRequestDispatcher(page).forward(request, response);
		}
	}

}
