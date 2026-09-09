<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Properties,java.io.InputStream,java.io.InputStreamReader" %>
<%
    String lang = request.getParameter("lang");
    if (lang == null || (!lang.equals("ko") && !lang.equals("en") && !lang.equals("ja"))) {
        lang = "ko";
    }
    Properties messages = new Properties();
    String resourcePath = "/i18n/messages_" + lang + ".properties";
    InputStream is = application.getResourceAsStream(resourcePath);
    if (is != null) {
        messages.load(new InputStreamReader(is, "UTF-8"));
        is.close();
    }
%>
<!DOCTYPE html>
<html lang="<%= lang %>">
<head>
<meta charset="UTF-8">
<title><%= messages.getProperty("category.page.title", "카테고리 - TripStamp") %></title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/category.css">
</head>
<body>
<%@ include file="header.jsp" %>
<main class="main-content">
    <section class="category-header">
        <h1><%= messages.getProperty("category.title", "카테고리") %></h1>
        <p class="category-description"><%= messages.getProperty("category.description", "원하는 종류의 장소를 골라 둘러보세요") %></p>
    </section>
    <div class="category-container">
        <a href="<%= request.getContextPath() %>/place/search.do?category=RESTAURANT&lang=<%= lang %>" class="category-card">
            <div class="category-icon">🍽️</div>
            <div class="category-name"><%= messages.getProperty("category.restaurant", "식당") %></div>
            <div class="category-card-description"><%= messages.getProperty("category.restaurant.description", "맛있는 한 끼를 즐길 수 있는 곳") %></div>
        </a>
        <a href="<%= request.getContextPath() %>/place/search.do?category=CAFE&lang=<%= lang %>" class="category-card">
            <div class="category-icon">☕</div>
            <div class="category-name"><%= messages.getProperty("category.cafe", "카페") %></div>
            <div class="category-card-description"><%= messages.getProperty("category.cafe.description", "여유롭게 쉬어갈 수 있는 곳") %></div>
        </a>
        <a href="<%= request.getContextPath() %>/place/search.do?category=SHOP&lang=<%= lang %>" class="category-card">
            <div class="category-icon">🛍️</div>
            <div class="category-name"><%= messages.getProperty("category.shop", "상점") %></div>
            <div class="category-card-description"><%= messages.getProperty("category.shop.description", "특별한 물건을 만날 수 있는 곳") %></div>
        </a>
        <a href="<%= request.getContextPath() %>/place/search.do?category=ATTRACTION&lang=<%= lang %>" class="category-card">
            <div class="category-icon">🗺️</div>
            <div class="category-name"><%= messages.getProperty("category.attraction", "관광지") %></div>
            <div class="category-card-description"><%= messages.getProperty("category.attraction.description", "여행의 즐거움을 더해줄 명소") %></div>
        </a>
    </div>
</main>
<%@ include file="footer.jsp" %>
</body>
</html>
