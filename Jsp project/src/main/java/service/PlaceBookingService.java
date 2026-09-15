package service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 예약 처리 (ajax)
 * - /place/bookingpro.do
 *
 * ⚠️ 아직 예약 테이블이 없어서, 지금은 화면 동작 확인용으로 항상 "fail"을 응답한다.
 *    나중에 예약 테이블(예: test_booking) 만들고 나서, 여기서 실제로
 *    bno / date / time / count / note 값을 저장하는 로직으로 채워넣으면 된다.
 */
public class PlaceBookingService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        // 지금 넘어오는 값들 - 나중에 DB 저장할 때 그대로 쓰면 됨
        String bno = request.getParameter("bno");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String count = request.getParameter("count");
        String note = request.getParameter("note");

        System.out.println("[예약 요청] bno=" + bno + ", date=" + date
                + ", time=" + time + ", count=" + count + ", note=" + note);

        // TODO: 예약 테이블 생기면 여기서 INSERT 하고 성공/실패에 따라 success/fail 응답
        PrintWriter out = response.getWriter();
        out.print("fail"); // 임시 고정값
        out.flush();
    }
}
