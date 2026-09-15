package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UsersDAO;
import model.UsersDTO;
import util.PasswordUtil;

public class PasswordUpdateService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        UsersDAO dao = new UsersDAO();

        HttpSession session = request.getSession(false);

        // 로그인 여부 확인
        if (session == null || session.getAttribute("id") == null) {
            response.getWriter().write("login");
            return;
        }

        int id = Integer.parseInt(session.getAttribute("id").toString());

        UsersDTO dto = dao.getProfile(id);

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // 현재 비밀번호 입력 여부
        if (currentPassword == null || currentPassword.trim().isEmpty()) {
            response.getWriter().write("currentEmpty");
            return;
        }

        // 현재 비밀번호 확인
        if (!PasswordUtil.checkPassword(
                currentPassword,
                dto.getPassword())) {

            response.getWriter().write("wrongCurrent");
            return;
        }

        // 새 비밀번호 입력 여부
        if (newPassword == null || newPassword.trim().isEmpty()) {
            response.getWriter().write("newEmpty");
            return;
        }

        // 새 비밀번호 확인 입력 여부
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            response.getWriter().write("confirmEmpty");
            return;
        }

        // 새 비밀번호 일치 여부
        if (!newPassword.equals(confirmPassword)) {
            response.getWriter().write("mismatch");
            return;
        }

        // 비밀번호 형식 검사
        // 8자 이상 + 영문 + 숫자
        String regex =
            "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";

        if (!newPassword.matches(regex)) {
            response.getWriter().write("format");
            return;
        }

        // 새 비밀번호 암호화
        String pw = PasswordUtil.hashPassword(newPassword);

        int result = dao.updatePassword(id, pw);

        // DB 수정 실패
        if (result == 0) {
            response.getWriter().write("fail");
            return;
        }

        // 변경 성공
        response.getWriter().write("success");
        
        
    }
}