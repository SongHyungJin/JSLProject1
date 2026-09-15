package service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.FindEmailDAO;

/**
 * 이메일 찾기 처리 서비스
 */
public class FindEmailService {


    public void doCommand(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {


        response.setContentType(
                "text/plain; charset=UTF-8"
        );


        String nickname =
                request.getParameter(
                        "nickname"
                );


        PrintWriter out =
                response.getWriter();


        /*
         * 닉네임 미입력
         */
        if (nickname == null
                || nickname.trim().isEmpty()) {


            out.print("empty");

            out.flush();

            return;
        }


        nickname =
                nickname.trim();


        FindEmailDAO dao =
                new FindEmailDAO();


        String email =
                dao.findEmail(
                        nickname
                );


        /*
         * 닉네임과 일치하는 회원 없음
         */
        if (email == null
                || email.trim().isEmpty()) {


            out.print("notFound");


        } else {


            /*
             * 찾은 이메일 반환
             */
            out.print(
                    "success|" + email
            );
        }


        out.flush();
    }
}