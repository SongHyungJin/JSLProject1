package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ReservationsDAO;
import model.ReservationsDTO;

public class BookingproService implements Command {

    @Override
    public void doCommand(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        // 로그인한 사용자 ID
        HttpSession session = request.getSession();

        Object id = session.getAttribute("id");

        if (id == null) {
            response.getWriter().write("login");
            return;
        }

        int usersId = (Integer) id;

        // JSP에서 넘어온 예약 정보
        int placesId = Integer.parseInt(
                request.getParameter("id")
        );

        String date = request.getParameter("date");
        String time = request.getParameter("time");

        int headcount = Integer.parseInt(
                request.getParameter("count")
        );

        String requestText = request.getParameter("note");

        // DTO 생성
        ReservationsDTO dto = new ReservationsDTO();

        dto.setUsers_id(usersId);
        dto.setPlaces_id(placesId);
        dto.setReservation_date(
                java.time.LocalDate.parse(date)
        );
        dto.setTime_slot(time);
        dto.setHeadcount(headcount);
        dto.setRequest(requestText);

        // DB 저장        
        ReservationsDAO dao = new ReservationsDAO();

        int result = dao.insert(dto);

        if (result > 0) {

            response.getWriter().write("success");

        } else if (result == -1) {

            response.getWriter().write("duplicate");

        } else {

            response.getWriter().write("fail");
        }

    }
}