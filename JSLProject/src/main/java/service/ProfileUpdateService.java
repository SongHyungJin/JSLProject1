package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.UsersDAO;

public class ProfileUpdateService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        HttpSession session = request.getSession(false);

        // 로그인 여부 확인
        if (session == null || session.getAttribute("id") == null) {
            response.getWriter().write("login");
            return;
        }

        int id = Integer.parseInt(session.getAttribute("id").toString());

        String nickname = request.getParameter("nickname");

        UsersDAO dao = new UsersDAO();

        // 닉네임 입력 여부 확인
        if (nickname == null || nickname.trim().isEmpty()) {
            response.getWriter().write("empty");
            return;
        }

        nickname = nickname.trim();

        // 닉네임 2~10자 확인
        String nicknameRegex = "^[a-zA-Z0-9가-힣]{2,10}$";

        if (!nickname.matches(nicknameRegex)) {
            response.getWriter().write("format");
            return;
        }

        // 닉네임 중복 확인
        int nicknameCheck = dao.checkNickname(nickname);

        if (nicknameCheck == 1) {
            // 중복이면 DB에 저장하지 않음
            response.getWriter().write("duplicate");
            return;
        }

        // 닉네임 변경
        int result = dao.updateNickname(id, nickname);

        if (result == 0) {
            response.getWriter().write("fail");
            return;
        }

        // 정상적으로 변경된 경우
        response.getWriter().write("success");
    }
}