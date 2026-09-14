package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.ReviewAddService;
import service.ReviewAllService;

@WebServlet("/review/*")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2mb
		maxFileSize = 1024 * 1024 * 10, // 10mb
		maxRequestSize = 1024 * 1024 * 50 // 50mb
// byte kb mb gb tb
)
public class ReviewController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public ReviewController() {
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

		String action = request.getPathInfo();

		String page = null;

		switch (action) {

		case "/write.do":
			String placesId = request.getParameter("id");

		    request.setAttribute("placesId", placesId);
		    page = "/reviewWrite.jsp";
		    break;
		case "/writepro.do":

		    new ReviewAddService().doCommand(request, response);

		    int result = (Integer) request.getAttribute("reviewResult");
		    int placeId = (Integer) request.getAttribute("placesId");

		    if (result > 0) {

		        response.sendRedirect(
		                request.getContextPath()
		                + "/places/placesDetail.do?id="
		                + placeId
		        );

		    } else {

		        response.sendRedirect(
		                request.getContextPath()
		                + "/review/write.do?id="
		                + placeId
		        );
		    }

		    return;
		case "/list.do":
			page = "/reviewAll.jsp";
			break;
		
		case "/all.do":
			 new ReviewAllService().doCommand(request, response);
			    page = "/reviewAll.jsp";
			    break;
		}

		if (page != null) {
			request.getRequestDispatcher(page).forward(request, response);
		}
	}
}