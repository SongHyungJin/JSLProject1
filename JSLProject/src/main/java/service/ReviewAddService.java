package service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import model.ReviewsDAO;
import model.ReviewsDTO;

public class ReviewAddService implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// 1. 로그인한 사용자 ID 가져오기
		Object sessionId = request.getSession().getAttribute("id");

		if (sessionId == null) {
			response.sendRedirect(request.getContextPath() + "/users/loginview.do");
			return;
		}

		int usersId = Integer.parseInt(sessionId.toString());
		String placesIdParam = request.getParameter("placesId");


		int placesId = Integer.parseInt(placesIdParam);
		// 2. 폼에서 데이터 가져오기
		placesId = Integer.parseInt(request.getParameter("placesId"));
		
		int rating = Integer.parseInt(request.getParameter("rating"));

		String content = request.getParameter("content");
		
		

		// 3. 사진 가져오기
		Part imagePart = request.getPart("reviewImage");

		String imageUrl = null;

		// 4. 사진이 있으면 저장
		if (imagePart != null && imagePart.getSize() > 0) {
			//이미지 파일인지 검사 
			String contentType =
			        imagePart.getContentType();

			if (contentType == null
			        || !contentType.startsWith("image/")) {

			    response.sendRedirect(
			            request.getContextPath()
			            + "/review/write.do?id="
			            + placesId
			    );
			    return;
			}

			String fileName = imagePart.getSubmittedFileName();

			String extension = "";

			int dotIndex = fileName.lastIndexOf(".");

			if (dotIndex != -1) {
				extension = fileName.substring(dotIndex);
			}

			// 파일 이름 중복 방지
			String savedFileName = UUID.randomUUID().toString() + extension;

			// 업로드 폴더 경로
			String uploadPath = request.getServletContext().getRealPath("/uploads/reviews");
			File uploadDir = new File(uploadPath);

			// 폴더가 없으면 생성
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}

			// 실제 파일 저장
			imagePart.write(uploadPath + File.separator + savedFileName);

			// DB에 저장할 이미지 경로
			imageUrl = request.getContextPath() + "/uploads/reviews/" + savedFileName;
		}

		// 5. DTO에 데이터 저장
		ReviewsDTO dto = new ReviewsDTO();

		dto.setUsersId(usersId);
		dto.setPlacesId(placesId);
		dto.setRating(rating);
		dto.setContent(content);
		dto.setImageUrl(imageUrl);

		// 6. DB에 리뷰 등록

		ReviewsDAO dao = new ReviewsDAO();

		if (dao.existsReview(usersId, placesId)) {
		    request.setAttribute("reviewResult", 0);
		    request.setAttribute("placesId", placesId);
		    return;
		}
		int result = dao.insert(dto);

		// 7. 결과만 Controller에게 전달
		request.setAttribute("reviewResult", result);
		request.setAttribute("placesId", placesId);
	}
}