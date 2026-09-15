package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.PlaceDAO;
import model.PlaceDTO;

/**
 * 검색/필터 처리
 * - /place/search.do
 * - keyword, category, region 조건으로 목록을 다시 조회한다.
 *   ※ country 파라미터는 PLACES 테이블에 해당 컬럼이 없어서 더 이상 사용하지 않음
 */
public class PlaceSearchService implements Command {

    private static final int TOP_N = 20;
    private static final int SLIDE_COUNT = 5;

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");
        String country = request.getParameter("country");
        String region = request.getParameter("region");

        PlaceDAO placeDAO = new PlaceDAO();

        List<PlaceDTO> placeList = placeDAO.getList(keyword, category, country, region);
        List<PlaceDTO> topRatedList = placeDAO.getTopRatedRandomList(TOP_N, SLIDE_COUNT);

        request.setAttribute("placeList", placeList);
        request.setAttribute("topRatedList", topRatedList);
    }
}
