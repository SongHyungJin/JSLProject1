package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.UsersDAO;
import model.UsersDTO;
import util.PasswordUtil;

public class SignupService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		UsersDTO dto = new UsersDTO();
		UsersDAO dao = new UsersDAO();

		String lang = request.getParameter("lang");
		dto.setLanguage(lang);

		String email = request.getParameter("email");
		request.setAttribute("email", email);

		// 이메일 입력 여부 확인
		if (email == null || email.trim().isEmpty()) {
			request.setAttribute("message", "signup.msg.email.empty");
			return;
		}

		// 이메일 상태 확인
		String emailStatus = dao.checkEmailStatus(email);

		if ("ACTIVE".equals(emailStatus)) {
			// 현재 정상적으로 사용 중인 이메일
			request.setAttribute("message", "signup.msg.email.duplicate");
			return;
		}

		// 이메일 인증 여부 확인
		Boolean emailVerified = (Boolean) request.getSession().getAttribute("emailVerified");

		if (emailVerified == null || !emailVerified) {
			request.setAttribute("message", "signup.msg.email.verify");
			return;
		}

		dto.setEmail(email);

		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");

		// 비밀번호 8자 이상, 영문+숫자 조합 검사
		String regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";

		if (password == null || !password.matches(regex)) {
			request.setAttribute("message", "signup.msg.password.format");
			return;
		}

		// 비밀번호 일치 여부 확인
		if (confirmPassword == null || !password.equals(confirmPassword)) {
			request.setAttribute("message", "signup.msg.password.confirm");
			return;
		}

		String pw = PasswordUtil.hashPassword(password);
		dto.setPassword(pw);

		// 닉네임 입력 여부 확인
		String nickname = request.getParameter("nickname");
		request.setAttribute("nickname", nickname);

		if (nickname == null || nickname.trim().isEmpty()) {
			request.setAttribute("message", "signup.msg.nickname.empty");
			return;
		}

		// 닉네임 (2-10자) 확인
		String nicknameRegex = "^[a-zA-Z0-9가-힣]{2,10}$";

		if (!nickname.matches(nicknameRegex)) {
			request.setAttribute("message", "signup.msg.nickname.format");
			return;
		}

		// 닉네임 중복 검사
		int nicknameCheck = dao.checkNickname(nickname);

		if (nicknameCheck == 1) {
			request.setAttribute("message", "signup.msg.nickname.duplicate");
			return;
		}

		dto.setNickname(nickname);

		int result;

		if ("WITHDRAWN".equals(emailStatus)) {

			// 탈퇴 회원이면 기존 계정 복구
			result = dao.restoreWithdrawnUser(email, pw, nickname, lang);

		} else {

			// 신규 회원이면 새로 INSERT
			result = dao.insertUsers(dto);
		}

		if (result == 0) {
			request.setAttribute("message", "signup.msg.fail");
			return;
		}

		request.setAttribute("message", "signup.msg.success");

		// 회원가입 INSERT 성공 후
		request.getSession().removeAttribute("emailVerified");

		request.setAttribute("signupSuccess", true);
	}
}