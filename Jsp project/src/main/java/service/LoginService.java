package service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.LoginDAO;
import model.UserDTO;

/**
 * 로그인 처리 서비스 (users 테이블 기준)
 */
public class LoginService {

    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDTO inputDto = new UserDTO();
        inputDto.setEmail(email);
        inputDto.setPassword(password);

        LoginDAO dao = new LoginDAO();
        UserDTO resultDto = dao.login(inputDto);

        PrintWriter out = response.getWriter();

        if (resultDto != null) {
            // 로그인 성공 → 세션에 사용자 정보 저장 (다른 페이지에서 sessionScope.loginUser로 확인)
            request.getSession().setAttribute("loginUser", resultDto);
            out.print("success");
        } else {
            out.print("fail");
        }
        out.flush();
    }
}