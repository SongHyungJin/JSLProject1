package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.PlacesDAO;
import model.PlacesDTO;

public class PlacesSearchbyKeyword implements Command {
	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		PlacesDAO dao = new PlacesDAO();
		String keyword = request.getParameter("keyword");
		String[] categories = request.getParameterValues("category");
		String region = request.getParameter("region");
		List<PlacesDTO> list=null;
		//글자수 2글자 이상 검사 
		if (keyword == null || keyword.trim().length() < 2) {
		    request.setAttribute("message", "검색어는 2글자 이상 입력해주세요.");
		    return;
			
		}
			
		list = dao.searchKeyword(keyword,region,categories);
		
		request.setAttribute("keywordlist", list);
	}

}
