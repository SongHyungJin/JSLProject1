package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UsersDAO;

public class WithdrawService implements Command {

    @Override
    public void doCommand(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {


        HttpSession session = request.getSession();

        Object sessionId = session.getAttribute("id");


        if (sessionId == null) {
            response.getWriter().write("login");
            return;
        }

        int usersId = Integer.parseInt(sessionId.toString());

        UsersDAO dao = new UsersDAO();

        int result = dao.withdrawUser(usersId);


        if (result > 0) {

            session.invalidate();

            response.getWriter().write("success");

        } else {

            response.getWriter().write("fail");
        }
    }
}