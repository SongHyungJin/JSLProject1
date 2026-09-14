package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ReservationsDAO;
import model.ReservationsDTO;

public class ReservationListService implements Command {
    @Override
    public void doCommand(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession();

        if (session == null) {
            response.sendRedirect(
                request.getContextPath() + "/users/loginview.do"
            );
            return;
        }
        int id = Integer.parseInt(session.getAttribute("id").toString());
        int usersId = (Integer) id;

        ReservationsDAO dao = new ReservationsDAO();

        List<ReservationsDTO> reservationList =
                dao.userBookingList(usersId);

        request.setAttribute("reservationList", reservationList);
    }
}