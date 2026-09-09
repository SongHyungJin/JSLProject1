<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Properties,java.io.InputStream,java.io.InputStreamReader" %>
<%
    String footerLang = request.getParameter("lang");
    if (footerLang == null || (!footerLang.equals("ko") && !footerLang.equals("en") && !footerLang.equals("ja"))) footerLang = "ko";
    Properties footerMsg = new Properties();
    InputStream footerIs = application.getResourceAsStream("/i18n/messages_" + footerLang + ".properties");
    if (footerIs != null) {
        footerMsg.load(new InputStreamReader(footerIs, "UTF-8"));
        footerIs.close();
    }
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/footer.css">
<footer class="site-footer">
    <div class="footer-inner">
        <div class="footer-brand">
            <strong>Travel Route</strong>
            <p><%= footerMsg.getProperty("footer.description", "여행을 더 쉽고 즐겁게.") %></p>
        </div>
        <p class="footer-copy"><%= footerMsg.getProperty("footer.copyright", "© 2026 Travel Route. All rights reserved.") %></p>
    </div>
</footer>
