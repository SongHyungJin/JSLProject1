package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.PlaceDAO;
import model.PlaceDTO;

/**
 * 메인화면(placelist) 처음 진입 시 처리
 * - /place/list.do
 */
public class PlaceListService implements Command {

    private static final int TOP_N = 20;
    private static final int SLIDE_COUNT = 5;

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PlaceDAO placeDAO = new PlaceDAO();

        List<PlaceDTO> placeList = placeDAO.getList(null, null, null, null);
        List<PlaceDTO> topRatedList = placeDAO.getTopRatedRandomList(TOP_N, SLIDE_COUNT);

        request.setAttribute("placeList", placeList);
        request.setAttribute("topRatedList", topRatedList);
    }
}
