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
		HttpSession session = request.getSession(false);
		// 로그인여부 확인
		if (session == null || session.getAttribute("id") == null) {
			request.setAttribute("message", "로그인이 필요합니다.");
			return;
		}
		int id = Integer.parseInt(session.getAttribute("id").toString());
		String nickname = request.getParameter("nickname");
		UsersDAO dao = new UsersDAO();
		// 입력 여부 확인
		if (nickname == null || nickname.trim().isEmpty()) {
			request.setAttribute("message", "닉네임을 입력해주세요.");
			return;
		}
		// 닉네임 (2-10자) 확인
		String nicknameRegex = "^[a-zA-Z0-9가-힣]{2,10}$";
		if (!nickname.matches(nicknameRegex)) {
			request.setAttribute("message", "닉네임은 2~10자 사이의 영문, 숫자, 한글만 가능합니다.");
			return;
		}
		// 닉네임 중복 검사
		int nicknameCheck = dao.checkNickname(nickname);

		if (nicknameCheck == 1) {
			request.setAttribute("message", "이미 사용 중인 닉네임입니다.");
			return;
		} // 현재와 똑같은 닉네임으로 수정은 불가
		int result = dao.updateNickname(id, nickname);
		if (result == 0) {
			request.setAttribute("message", "닉네임 변경에 실패했습니다.");
			return;
		}

		request.setAttribute("message", "닉네임이 성공적으로 변경되었습니다.");

	}

}
