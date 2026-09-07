package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.PlacesDAO;
import model.PlacesDTO;

public class PlacesListFilter implements Command {
	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		PlacesDAO dao = new PlacesDAO();
		String region =request.getParameter("region");
		String categories[] = request.getParameterValues("categories");
		List<PlacesDTO> placesList = null;
		// 지역 또는 카테고리 조건이 하나라도 있으면 필터링
        if ((region != null && !region.trim().isEmpty())
                || (categories != null && categories.length > 0)) {

            placesList = dao.searchPlaces(region, categories);

        } else {
            // 아무 조건도 없으면 전체 목록
            placesList = dao.PlacesSelectAll();
        }
		request.setAttribute("placesList", placesList);
	}
}
