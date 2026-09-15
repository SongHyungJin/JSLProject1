package service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.FindPasswordDAO;

/**
 * 비밀번호 찾기 / 변경 처리 서비스
 */
public class FindPasswordService {


    public void doCommand(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {


        response.setContentType(
                "text/plain; charset=UTF-8"
        );


        String mode =
                request.getParameter("mode");


        PrintWriter out =
                response.getWriter();


        /*
         * mode가 없는 경우
         */
        if (mode == null
                || mode.trim().isEmpty()) {

            out.print("fail");
            out.flush();

            return;
        }



        FindPasswordDAO dao =
                new FindPasswordDAO();



        /*
         * ==================================
         * 이메일 존재 여부 확인
         * ==================================
         */
        if ("checkEmail".equals(mode)) {


            String email =
                    request.getParameter(
                            "email"
                    );


            if (email == null
                    || email.trim().isEmpty()) {

                out.print("empty");
                out.flush();

                return;
            }


            email =
                    email.trim();


            boolean exists =
                    dao.checkEmail(
                            email
                    );


            if (exists) {

                out.print("success");

            } else {

                out.print("notFound");
            }


            out.flush();

            return;
        }



        /*
         * ==================================
         * 새 비밀번호 변경
         * ==================================
         */
        if ("updatePassword".equals(mode)) {


            String email =
                    request.getParameter(
                            "email"
                    );


            String newPassword =
                    request.getParameter(
                            "newPassword"
                    );


            if (email == null
                    || email.trim().isEmpty()
                    || newPassword == null
                    || newPassword.trim().isEmpty()) {

                out.print("empty");
                out.flush();

                return;
            }


            email =
                    email.trim();


            /*
             * 실제 가입 이메일인지 다시 확인
             */
            boolean exists =
                    dao.checkEmail(
                            email
                    );


            if (!exists) {

                out.print("notFound");
                out.flush();

                return;
            }



            int result =
                    dao.updatePassword(
                            email,
                            newPassword
                    );


            if (result > 0) {

                out.print("success");

            } else {

                out.print("fail");
            }


            out.flush();

            return;
        }



        /*
         * 정의되지 않은 mode
         */
        out.print("fail");
        out.flush();
    }
}