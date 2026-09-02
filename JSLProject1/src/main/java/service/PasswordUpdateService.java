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
		request.setCharacterEncoding("utf-8");
		UsersDAO dao = new UsersDAO();
		HttpSession session = request.getSession(false);
		// 로그인여부 확인
		if (session == null || session.getAttribute("id") == null) {
			request.setAttribute("message", "로그인이 필요합니다.");
			return;
		}
		int id = (int) session.getAttribute("id");
		UsersDTO dto =dao.getProfile(id);
		String currentPassword = request.getParameter("currentPassword");
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");
		// 비밀번호 일치 여부 확인
		if (currentPassword == null || !PasswordUtil.checkPassword(currentPassword, dto.getPassword())) {
			request.setAttribute("message", "비밀번호가 일치하지 않습니다.");
			return;
		}
		//새 비밀번호 일치 여부 확인
		if (newPassword == null || !newPassword.equals(confirmPassword)) {
			request.setAttribute("message", "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
			return;
		}
		// 비밀번호 8자 이상, 영문+숫자 조합 검사
		String regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";

		if (!newPassword.matches(regex)) {
			request.setAttribute("message", "비밀번호는 8자 이상이며 영문과 숫자를 포함해야 합니다.");
			return;
		}

		String pw = PasswordUtil.hashPassword(newPassword);
		int result=dao.updatePassword(id, pw);
		
		if (result == 0) {
			request.setAttribute("message", "비밀번호 변경에 실패했습니다.");
			return;
		}
		request.setAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");

	}
}
