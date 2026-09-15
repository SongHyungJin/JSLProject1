package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BookingproService;
import service.PlacesDetailViewService;
import service.ReservationListService;

@WebServlet("/route/*")
public class RouteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RouteController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAction(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAction(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String action = request.getPathInfo(); // 요청한 주소를 가져오는 메서드
		String page = null;
		switch (action) {
		case "/myroute.do": //나의 루트 화면  
				page = "/MyRoute.jsp";
				break;
	
		
	
			
		}
		if(page != null) {
			request.getRequestDispatcher(page).forward(request, response);
		}
	}

}
