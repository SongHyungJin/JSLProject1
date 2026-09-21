package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BookmarkAddService;
import service.BookmarkDeleteService;
import service.PlacesDetailViewService;


@WebServlet("/bookmark/*")
public class BookmarkController extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public BookmarkController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    

	    request.setCharacterEncoding("utf-8");

	    String action = request.getPathInfo();

	    String page = null;

	    switch (action) {

	    case "/toggle.do":

	        String bookmarkAction = request.getParameter("action");

	        if ("add".equals(bookmarkAction)) {

	            new BookmarkAddService().doCommand(request, response);

	        } else if ("delete".equals(bookmarkAction)) {

	            new BookmarkDeleteService().doCommand(request, response);

	        } else {

	            response.getWriter().write("fail");
	        }

	        break;
	    case "/bookingview.do": //예약 화면 
			new PlacesDetailViewService().doCommand(request, response);
			page = "/booking.jsp";
			break;   
	    }
	    if(page != null) {
			request.getRequestDispatcher(page).forward(request, response);
		}
	}
}
