package service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.UsersDAO;
import model.UsersDTO;
import util.PasswordUtil;

/**
 * 비밀번호 찾기 / 변경 처리 서비스
 */
public class FindPasswordService {

	public void doCommand(HttpServletRequest request, HttpServletResponse response) throws IOException {

		response.setContentType("text/plain; charset=UTF-8");

		String mode = request.getParameter("mode");

		PrintWriter out = response.getWriter();

		// mode가 없는 경우
		if (mode == null || mode.trim().isEmpty()) {
			out.print("fail");
			out.flush();
			return;
		}

		UsersDAO dao = new UsersDAO();

		/*
		 * ==================================
		 * 이메일 존재 여부 확인
		 * ==================================
		 */
		if ("checkEmail".equals(mode)) {

			String email = request.getParameter("email");

			// 이메일 미입력
			if (email == null || email.trim().isEmpty()) {
				out.print("empty");
				out.flush();
				return;
			}

			email = email.trim();

			// 이메일 존재 여부 확인
			int exists = dao.checkEmail(email);

			if (exists == 0) {
				out.print("notFound");
				out.flush();
				return;
			}

			// 탈퇴 회원 여부 확인
			String status = dao.checkEmailStatus(email);

			if ("WITHDRAWN".equalsIgnoreCase(status)) {
				out.print("withdrawn");
				out.flush();
				return;
			}

			// 정상 회원
			out.print("success");
			out.flush();
			return;
		}

		/*
		 * ==================================
		 * 새 비밀번호 변경
		 * ==================================
		 */
		if ("updatePassword".equals(mode)) {

			String email = request.getParameter("email");
			String newPassword = request.getParameter("newPassword");

			// 이메일 / 새 비밀번호 입력 여부
			if (email == null || email.trim().isEmpty()
					|| newPassword == null || newPassword.trim().isEmpty()) {

				out.print("empty");
				out.flush();
				return;
			}

			email = email.trim();

			/*
			 * 실제 가입 이메일인지 확인
			 */
			int exists = dao.checkEmail(email);

			if (exists == 0) {
				out.print("notFound");
				out.flush();
				return;
			}

			/*
			 * 탈퇴 회원인지 확인
			 */
			String status = dao.checkEmailStatus(email);

			if ("WITHDRAWN".equalsIgnoreCase(status)) {
				out.print("withdrawn");
				out.flush();
				return;
			}

			/*
			 * 이메일로 회원 정보 조회
			 */
			UsersDTO dto = dao.findByEmail(email);

			if (dto == null || dto.getId() == 0) {
				out.print("notFound");
				out.flush();
				return;
			}

			int id = dto.getId();

			/*
			 * 비밀번호 형식 검사
			 * 8자 이상 + 영문 + 숫자
			 */
			String regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";

			if (!newPassword.matches(regex)) {
				out.print("wrongregex");
				out.flush();
				return;
			}

			/*
			 * 새 비밀번호 암호화
			 */
			String pw = PasswordUtil.hashPassword(newPassword);

			/*
			 * DB 비밀번호 변경
			 */
			int result = dao.updatePassword(id, pw);

			if (result > 0) {
				out.print("success");
			} else {
				out.print("fail");
			}

			out.flush();
			return;
		}

		/*
		 * ==================================
		 * 정의되지 않은 mode
		 * ==================================
		 */
		out.print("fail");
		out.flush();
	}
}