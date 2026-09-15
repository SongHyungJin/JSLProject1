package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.PlacesDAO;
import model.PlacesDTO;

public class PlacesSearchbyKeyword implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		PlacesDAO dao = new PlacesDAO();

		String keyword = request.getParameter("keyword");
		String category = request.getParameter("category");
		String region = request.getParameter("region");

		List<PlacesDTO> list = null;

		// 검색어가 없는 경우
		if (keyword == null || keyword.trim().isEmpty()) {

			// 지역이나 카테고리도 없으면 전체 목록
			if ((region == null || region.trim().isEmpty()) && (category == null || category.trim().isEmpty())) {

				list = dao.PlacesSelectAll();

			} else {

				// 지역 또는 카테고리가 있으면 필터 검색
				list = dao.searchPlaces(region, category);
			}

		} else {

			// 검색어 2글자 이상 검사
			if (keyword.trim().length() < 2) {

				request.setAttribute("message", "검색어는 2글자 이상 입력해주세요.");

				return;
			}

			// 키워드 검색
			list = dao.searchKeyword(keyword, region, category);
		}

		// 모든 경우에 검색 결과 전달
		request.setAttribute("placeList", list);
	}
}