package service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 로그아웃 처리 서비스
 * - 세션을 무효화(invalidate)하여 로그인 정보를 지운다.
 * - 별도 응답을 쓰지 않음 (컨트롤러가 이어서 main.jsp로 리다이렉트)
 */
public class LogoutService {

    public void doCommand(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false); // 세션 없으면 새로 만들지 않음
        if (session != null) {
            session.invalidate();
        }
    }
}
