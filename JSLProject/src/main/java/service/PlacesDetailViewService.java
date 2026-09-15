package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.PlacesDAO;
import model.PlacesDTO;
import model.ReviewsDAO;
import model.ReviewsDTO;

public class PlacesDetailViewService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int id = Integer.parseInt(request.getParameter("id"));
		PlacesDAO dao = new PlacesDAO();
		PlacesDTO dto = dao.PlacesSelectById(id);
		request.setAttribute("place", dto);
		ReviewsDAO reviewsDAO = new ReviewsDAO();

		List<ReviewsDTO> reviewList =
		        reviewsDAO.selectByPlacesId(id);

		request.setAttribute("reviewList", reviewList);
	}

}
