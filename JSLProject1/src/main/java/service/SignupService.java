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
		String email = request.getParameter("email");
		//이메일 입력 여부 확인
		if (email == null || email.trim().isEmpty()) {
		    request.setAttribute("message", "이메일을 입력해주세요.");
		    return;
		}
		//이메일 중복 검사
		int emailCheck = dao.checkEmail(email);
		if(emailCheck == 1) {
		    request.setAttribute("message", "이미 사용 중인 이메일입니다.");
		    return;
		}
		dto.setEmail(email);
		//닉네임 입력 여부 확인
		String nickname = request.getParameter("nickname");
		if (nickname == null ||nickname.trim().isEmpty()) {
			request.setAttribute("message", "닉네임을 입력해주세요.");
			return;
		}
		//닉네임 (2-10자) 확인 
		String nicknameRegex = "^[a-zA-Z0-9가-힣]{2,10}$";
		if (!nickname.matches(nicknameRegex)) {
			request.setAttribute("message", "닉네임은 2~10자 사이의 영문, 숫자, 한글만 가능합니다.");
			return;
		}
		//닉네임 중복 검사
		int nicknameCheck = dao.checkNickname(nickname);
		
		if(nicknameCheck == 1) {
		    request.setAttribute("message", "이미 사용 중인 닉네임입니다.");
		    return;
		}
		dto.setNickname(nickname);
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword"); //비밀번호 일치 여부 확인용
		//비밀번호 8자 이상, 영문+숫자 조합 검사
		String regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";

		if (password==null||!password.matches(regex)) {
		    request.setAttribute("message",
		            "비밀번호는 8자 이상이며 영문과 숫자를 포함해야 합니다.");
		    return;
		}
		
		//비밀번호 일치 여부 확인
		if (confirmPassword==null||!password.equals(confirmPassword)) {
		    request.setAttribute("message", "비밀번호가 일치하지 않습니다.");
		    return;
		}
		String pw =PasswordUtil.hashPassword(password);
		dto.setPassword(pw);
		
		int result = dao.insertUsers(dto);
		if(result==0) {
			request.setAttribute("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
			return;
		}
			request.setAttribute("message", "회원가입이 완료되었습니다. 로그인 해주세요.");
		
	}

}
