package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.PlacesDAO;
import model.PlacesDTO;
import model.ReviewsDAO;
import model.ReviewsDTO;

public class ReviewAllService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        // 1. 장소 ID 가져오기
        String placesIdParam = request.getParameter("id");

        if (placesIdParam == null || placesIdParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int placesId = Integer.parseInt(placesIdParam);


        // 2. 장소 정보 가져오기
        PlacesDAO placesDAO = new PlacesDAO();

        PlacesDTO place = placesDAO.PlacesSelectById(placesId);

        request.setAttribute("place", place);


        // 3. 해당 장소의 리뷰 목록 가져오기
        ReviewsDAO reviewsDAO = new ReviewsDAO();

        List<ReviewsDTO> reviewList =
                reviewsDAO.selectByPlacesId(placesId);

        request.setAttribute("reviewList", reviewList);
        
     // 리뷰 통계 계산
        int totalCount = reviewList.size();
        System.out.println(totalCount);
        int[] scoreCounts = new int[6];

        int scoreSum = 0;

        for (ReviewsDTO review : reviewList) {

            int rating = review.getRating();

            if (rating >= 1 && rating <= 5) {
                scoreCounts[rating]++;
                scoreSum += rating;
            }
        }


        // 평균 점수
        double averageRating = 0.0;

        if (totalCount > 0) {
            averageRating = (double) scoreSum / totalCount;
        }

        // 소수점 첫째 자리까지
        averageRating = Math.round(averageRating * 10) / 10.0;


        request.setAttribute("totalCount", totalCount);
        request.setAttribute("averageRating", averageRating);
        request.setAttribute("scoreCounts", scoreCounts);
    }
}