package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.PlaceDAO;
import model.PlaceDTO;

/**
 * 가게 상세 조회 처리
 * - /place/view.do?id=번호  (예전 bno -> id 로 파라미터명 변경)
 */
public class PlaceViewService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                long id = Long.parseLong(idParam);
                PlaceDAO placeDAO = new PlaceDAO();
                PlaceDTO place = placeDAO.getDetail(id);
                request.setAttribute("place", place);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
    }
}
