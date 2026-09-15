package service;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ReviewsDAO;
import model.ReviewsDTO;

public class ReviewListService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException {

        // 1. 전체 리뷰 조회
        ReviewsDAO dao = new ReviewsDAO();
        List<ReviewsDTO> reviewList = dao.selectAll();

        // 2. JSP에서 사용할 수 있도록 request에 저장
        request.setAttribute("reviewList", reviewList);
    }
}