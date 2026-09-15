package service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.SignupDAO;
import model.UserDTO;

/**
 * 회원가입 처리 서비스 (users 테이블 기준)
 * - email, password, nickname 모두 필수
 * - 상세 검증(이메일 형식, 비밀번호 규칙 등)은 지금 단계에서는 생략 - 마이페이지 확인용 최소 기능만
 */
public class SignupService {

    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String nickname = request.getParameter("nickname");

        PrintWriter out = response.getWriter();

        // 필수값만 체크 (형식 검증은 생략)
        if (email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || nickname == null || nickname.trim().isEmpty()) {
            out.print("empty");
            out.flush();
            return;
        }

        UserDTO dto = new UserDTO();
        dto.setEmail(email);
        dto.setPassword(password);
        dto.setNickname(nickname);

        // email/nickname UNIQUE 제약 위반 시 JoinDAO 내부에서 예외 처리되어 0(실패) 반환됨
        SignupDAO dao = new SignupDAO();
        int result = dao.Signup(dto);

        if (result > 0) {
            out.print("success");
        } else {
            out.print("fail");
        }
        out.flush();
    }
}