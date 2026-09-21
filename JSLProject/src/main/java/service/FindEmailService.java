package service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.FindEmailDAO;

/**
 * 이메일(아이디) 찾기 처리. (AJAX 응답: empty / notFound / success|이메일)
 */
public class FindEmailService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain; charset=UTF-8");
        PrintWriter out = response.getWriter();

        String nickname = request.getParameter("nickname");
        if (nickname == null || nickname.trim().isEmpty()) {
            out.print("empty");
            out.flush();
            return;
        }
        nickname = nickname.trim();

        String email = new FindEmailDAO().findEmail(nickname);
        if (email == null || email.trim().isEmpty()) {
            out.print("notFound");
        } else {
            out.print("success|" + email);
        }
        out.flush();
    }
}
