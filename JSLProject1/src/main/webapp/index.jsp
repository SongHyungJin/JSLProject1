<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // 사이트에 처음 들어오면 곧바로 컨트롤러의 목록 조회 기능으로 보낸다.
    // (main.jsp를 바로 열면 DB 조회를 안 거쳐서 목록이 비어있기 때문)
    response.sendRedirect(request.getContextPath() + "/place/list.do");
%>