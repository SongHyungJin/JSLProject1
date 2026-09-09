<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>

<%
    String lang = request.getParameter("lang");

    if (lang == null) {
        lang = "ko";
    }

    if (!lang.equals("ko")
            && !lang.equals("en")
            && !lang.equals("ja")) {
        lang = "ko";
    }

    Properties messages = new Properties();

    String filePath =
        "/i18n/messages_" + lang + ".properties";

    InputStream input =
        application.getResourceAsStream(filePath);

    if (input != null) {

        messages.load(
            new InputStreamReader(input, "UTF-8")
        );

        input.close();
    }
%>

<!DOCTYPE html>

<html lang="<%= lang %>">

<head>

<meta charset="UTF-8">

<title>
    <%= messages.getProperty("main.title", "Travel Route") %>
</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/main.css">

</head>

<body>


<!-- ========================= -->
<!-- Header -->
<!-- ========================= -->

<%@ include file="header.jsp"%>



<main>


    <!-- ========================= -->
    <!-- Hero -->
    <!-- ========================= -->

    <section class="hero">

        <div class="hero-content">


            <h1>

                <%= messages.getProperty("main.hero.title", "나만의 여행 루트를 만들어보세요") %>

            </h1>


            <p>

                <%= messages.getProperty("main.hero.description", "가고 싶은 장소를 찾고, 나만의 여행 동선을 만들어보세요.") %>

            </p>



            <form class="search-box"
                  action="<%= request.getContextPath() %>/place/search.do" method="get">

                <input type="hidden" name="lang" value="<%= lang %>">

                <input
                    type="text"
                    name="keyword"
                    placeholder="<%= messages.getProperty("main.search.placeholder", "가게 이름이나 지역으로 검색") %>">


                <button type="submit">

                    <%= messages.getProperty("main.search.button", "검색") %>

                </button>

            </form>


        </div>

    </section>



    <!-- ========================= -->
    <!-- 언어 선택 -->
    <!-- ========================= -->

    <section class="language-section">

        <div class="language-box">


            <a href="<%= request.getContextPath() %>/main.do?lang=ko"
               class="<%= lang.equals("ko") ? "active" : "" %>">

                한국어

            </a>


            <a href="<%= request.getContextPath() %>/main.do?lang=en"
               class="<%= lang.equals("en") ? "active" : "" %>">

                English

            </a>


            <a href="<%= request.getContextPath() %>/main.do?lang=ja"
               class="<%= lang.equals("ja") ? "active" : "" %>">

                日本語

            </a>


        </div>

    </section>



    <!-- ========================= -->
    <!-- 카테고리 -->
    <!-- ========================= -->

    <section class="main-section">


        <div class="section-title">


            <h2>

                <%= messages.getProperty("main.category.title", "카테고리") %>

            </h2>


            <!-- 전체보기는 기존대로 유지 -->

            <a href="<%= request.getContextPath() %>/place/category.do?lang=<%= lang %>">

                <%= messages.getProperty("main.category.more", "전체보기") %>

            </a>


        </div>



        <div class="category-grid">


            <!-- ========================= -->
            <!-- 식당 -->
            <!-- ========================= -->

            <a href="<%= request.getContextPath() %>/place/search.do?category=RESTAURANT&lang=<%= lang %>"
               class="category-card">


                <div class="category-icon">
                    🍽️
                </div>


                <strong>

                    <%= messages.getProperty("category.restaurant", "식당") %>

                </strong>


            </a>



            <!-- ========================= -->
            <!-- 상점 -->
            <!-- ========================= -->

            <a href="<%= request.getContextPath() %>/place/search.do?category=SHOP&lang=<%= lang %>"
               class="category-card">


                <div class="category-icon">
                    🛍️
                </div>


                <strong>

                    <%= messages.getProperty("category.shop", "상점") %>

                </strong>


            </a>



            <!-- ========================= -->
            <!-- 카페 -->
            <!-- ========================= -->

            <a href="<%= request.getContextPath() %>/place/search.do?category=CAFE&lang=<%= lang %>"
               class="category-card">


                <div class="category-icon">
                    ☕
                </div>


                <strong>

                    <%= messages.getProperty("category.cafe", "카페") %>

                </strong>


            </a>


        </div>


    </section>



    <!-- ========================= -->
    <!-- 추천 여행 루트 -->
    <!-- ========================= -->

    <section class="main-section">


        <div class="section-title">


            <h2>

                <%= messages.getProperty("main.route.title", "추천 여행 루트") %>

            </h2>


        </div>



        <div class="route-grid">


            <!-- 도시 여행 -->

            <a href="<%= request.getContextPath() %>/route/bestroute.do?lang=<%= lang %>"
               class="route-card">


                <div class="route-icon">
                    🏙️
                </div>


                <h3>

                    <%= messages.getProperty("main.route.city", "도시 여행") %>

                </h3>


                <p>

                    <%= messages.getProperty("main.route.city.description", "도시의 인기 명소와 맛집을 함께 즐겨보세요.") %>

                </p>


            </a>



            <!-- 카페 여행 -->

            <a href="<%= request.getContextPath() %>/route/bestroute.do?lang=<%= lang %>"
               class="route-card">


                <div class="route-icon">
                    ☕
                </div>


                <h3>

                    <%= messages.getProperty("main.route.cafe", "카페 여행") %>

                </h3>


                <p>

                    <%= messages.getProperty("main.route.cafe.description", "감성 카페를 따라 여유로운 하루를 보내보세요.") %>

                </p>


            </a>



            <!-- 자연 여행 -->

            <a href="<%= request.getContextPath() %>/route/bestroute.do?lang=<%= lang %>"
               class="route-card">


                <div class="route-icon">
                    🌿
                </div>


                <h3>

                    <%= messages.getProperty("main.route.nature", "자연 여행") %>

                </h3>


                <p>

                    <%= messages.getProperty("main.route.nature.description", "자연 속에서 힐링할 수 있는 코스를 만나보세요.") %>

                </p>


            </a>


        </div>


    </section>


</main>



<!-- ========================= -->
<!-- Footer -->
<!-- ========================= -->

<%@ include file="footer.jsp"%>


</body>

</html>