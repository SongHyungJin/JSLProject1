package service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.FindPasswordDAO;
import util.PasswordUtil;

/**
 * 비밀번호 찾기(재설정) 처리.
 *  mode=checkEmail     : 이메일 가입 여부 확인 (empty / success / notFound)
 *  mode=updatePassword : 새 비밀번호로 재설정 (empty / notFound / success / fail)
 *
 * ※ 비밀번호는 jBCrypt 해시로 저장되므로, 재설정 시에도 PasswordUtil 로 해시해서 저장한다.
 */
public class FindPasswordService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain; charset=UTF-8");
        PrintWriter out = response.getWriter();

        String mode = request.getParameter("mode");
        if (mode == null || mode.trim().isEmpty()) {
            out.print("fail");
            out.flush();
            return;
        }

        FindPasswordDAO dao = new FindPasswordDAO();

        if ("checkEmail".equals(mode)) {
            String email = request.getParameter("email");
            if (email == null || email.trim().isEmpty()) {
                out.print("empty");
                out.flush();
                return;
            }
            out.print(dao.checkEmail(email.trim()) ? "success" : "notFound");
            out.flush();
            return;
        }

        if ("updatePassword".equals(mode)) {
            String email = request.getParameter("email");
            String newPassword = request.getParameter("newPassword");
            if (email == null || email.trim().isEmpty()
                    || newPassword == null || newPassword.trim().isEmpty()) {
                out.print("empty");
                out.flush();
                return;
            }
            email = email.trim();
            if (!dao.checkEmail(email)) {
                out.print("notFound");
                out.flush();
                return;
            }
            String hashed = PasswordUtil.hashPassword(newPassword); // 해시 저장 (내 로그인과 호환)
            int r = dao.updatePassword(email, hashed);
            out.print(r > 0 ? "success" : "fail");
            out.flush();
            return;
        }

        out.print("fail");
        out.flush();
    }
}
