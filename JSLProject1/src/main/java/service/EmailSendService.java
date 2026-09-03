package service;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.EmailUtil;

public class EmailSendService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 이메일 가져오기
        String email = request.getParameter("email");

        // 6자리 인증번호 생성
        Random random = new Random();
        String code = String.format("%06d", random.nextInt(1000000));

        // 세션에 인증번호 저장
        HttpSession session = request.getSession();
        session.setAttribute("emailCode", code);

        // 이메일로 인증번호 보내기
        EmailUtil.sendEmail(
            email,
            "회원가입 이메일 인증번호",
            "인증번호는 [" + code + "] 입니다."
        );

        System.out.println("인증번호: " + code);
    }
}