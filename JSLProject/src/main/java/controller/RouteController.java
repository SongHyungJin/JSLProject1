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
		case "/myroute.do": { //나의 루트: 찜한 점포를 최적 동선으로 순회
				Object uid = (request.getSession(false) != null)
						? request.getSession(false).getAttribute("id") : null;
				if (uid == null) { // 로그인 필요
					response.sendRedirect(request.getContextPath()
							+ "/users/loginview.do?lang=" + request.getParameter("lang"));
					return;
				}
				int myUserId = (Integer) uid;

				java.util.List<model.PlacesDTO> bookmarked =
						new model.GoogleBookmarkDAO().selectBookmarkedPlaces(myUserId);
				// 찜한 점포 전체를 방문 순서(동선)만 최적화 (선정 없이)
				java.util.List<model.PlacesDTO> myCourse =
						util.RouteRecommender.orderRoute(bookmarked);

				request.setAttribute("course", myCourse);                          // 목록용
				request.setAttribute("moves", util.RouteRecommender.moveInfoList(myCourse)); // 구간 이동정보
				request.setAttribute("courseJson", util.RouteRecommender.toJson(myCourse)); // 지도용
				page = "/MyRoute.jsp";
				break;
		}

		case "/bestroute.do": { // 추천 코스 화면 (우리 DB 후보 + 추천 알고리즘)
				String region = request.getParameter("region");
				String theme = request.getParameter("theme"); // city / cafe / nature

				// 지역 미지정 시 기본 지역(서울). 여러 지역이 섞이지 않도록 항상 단일 지역으로.
				if (region == null || region.trim().isEmpty()) {
					region = "seoul";
				}

				// 테마 → 대상 카테고리 (도시=섞임 / 카페=cafe / 자연=attraction)
				String themeCategory = null;
				if ("cafe".equals(theme)) {
					themeCategory = "cafe";
				} else if ("nature".equals(theme)) {
					themeCategory = "attraction";
				}

				model.PlacesDAO placesDAO = new model.PlacesDAO();
				// 지정된 "한 지역" 안에서만 후보를 뽑는다 (국가/도시를 넘나들지 않음)
				java.util.List<model.PlacesDTO> candidates = placesDAO.searchPlaces(region, themeCategory);

				java.util.List<model.PlacesDTO> course =
						util.RouteRecommender.recommend(candidates, 6);

				request.setAttribute("theme", theme);
				request.setAttribute("region", region);
				request.setAttribute("course", course);                          // 목록용
				request.setAttribute("moves", util.RouteRecommender.moveInfoList(course)); // 구간 이동정보
				request.setAttribute("courseJson", util.RouteRecommender.toJson(course)); // 지도용
				page = "/BestRoute.jsp";
				break;
		}

		}
		if(page != null) {
			request.getRequestDispatcher(page).forward(request, response);
		}
	}

}
