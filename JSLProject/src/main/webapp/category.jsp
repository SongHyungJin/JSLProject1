<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Properties,java.io.InputStream,java.io.InputStreamReader" %>

<%
    String lang = request.getParameter("lang");

    if (lang == null ||
        (!lang.equals("ko") &&
         !lang.equals("en") &&
         !lang.equals("ja"))) {

        lang = "ko";
    }

    Properties messages = new Properties();

    String resourcePath =
        "/i18n/messages_" + lang + ".properties";

    InputStream is =
        application.getResourceAsStream(resourcePath);

    if (is != null) {
        messages.load(
            new InputStreamReader(is, "UTF-8")
        );
        is.close();
    }
%>

<!DOCTYPE html>

<html lang="<%= lang %>">

<head>

<meta charset="UTF-8">

<title>
    <%= messages.getProperty(
        "category.page.title",
        "카테고리 - Travel Route"
    ) %>
</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/category.css">

</head>


<body>

<%@ include file="header.jsp" %>


<main class="main-content" id="categoryPage">

    <!-- =========================
         계절 장식
    ========================== -->

    <div class="season-decoration"
         id="seasonDecoration"
         aria-hidden="true">
    </div>


    <!-- =========================
         카테고리 제목
    ========================== -->

    <section class="category-header">

        <div class="category-eyebrow">
            Travel Category
        </div>

        <h1>
            <%= messages.getProperty(
                "category.title",
                "카테고리"
            ) %>
        </h1>

        <p class="category-description">
            <%= messages.getProperty(
                "category.description",
                "원하는 종류의 장소를 골라 둘러보세요"
            ) %>
        </p>

    </section>


    <!-- =========================
         카테고리 카드
    ========================== -->

    <div class="category-container">


        <!-- 식당 -->
        <a href="<%= request.getContextPath() %>/places/placesSearch.do?category=restaurant&lang=<%= lang %>"
           class="category-card">

            <div class="card-decoration"></div>

            <div class="category-icon">
                🍽️
            </div>

            <div class="category-name">
                <%= messages.getProperty(
                    "category.restaurant",
                    "식당"
                ) %>
            </div>

            <div class="category-card-description">
                <%= messages.getProperty(
                    "category.restaurant.description",
                    "맛있는 한 끼를 즐길 수 있는 곳"
                ) %>
            </div>

            <div class="category-more">
                <span>
                    <%= messages.getProperty(
                        "category.more",
                        "둘러보기"
                    ) %>
                </span>

                <span class="category-arrow">
                    →
                </span>
            </div>

        </a>


        <!-- 카페 -->
        <a href="<%= request.getContextPath() %>/places/placesSearch.do?category=cafe&lang=<%= lang %>"
           class="category-card">

            <div class="card-decoration"></div>

            <div class="category-icon">
                ☕
            </div>

            <div class="category-name">
                <%= messages.getProperty(
                    "category.cafe",
                    "카페"
                ) %>
            </div>

            <div class="category-card-description">
                <%= messages.getProperty(
                    "category.cafe.description",
                    "여유롭게 쉬어갈 수 있는 곳"
                ) %>
            </div>

            <div class="category-more">
                <span>
                    <%= messages.getProperty(
                        "category.more",
                        "둘러보기"
                    ) %>
                </span>

                <span class="category-arrow">
                    →
                </span>
            </div>

        </a>


        <!-- 상점 -->
        <a href="<%= request.getContextPath() %>/places/placesSearch.do?category=shop&lang=<%= lang %>"
           class="category-card">

            <div class="card-decoration"></div>

            <div class="category-icon">
                🛍️
            </div>

            <div class="category-name">
                <%= messages.getProperty(
                    "category.shop",
                    "상점"
                ) %>
            </div>

            <div class="category-card-description">
                <%= messages.getProperty(
                    "category.shop.description",
                    "특별한 물건을 만날 수 있는 곳"
                ) %>
            </div>

            <div class="category-more">
                <span>
                    <%= messages.getProperty(
                        "category.more",
                        "둘러보기"
                    ) %>
                </span>

                <span class="category-arrow">
                    →
                </span>
            </div>

        </a>


        <!-- 관광지 -->
        <a href="<%= request.getContextPath() %>/places/placesSearch.do?category=attraction&lang=<%= lang %>"
           class="category-card">

            <div class="card-decoration"></div>

            <div class="category-icon">
                🗺️
            </div>

            <div class="category-name">
                <%= messages.getProperty(
                    "category.attraction",
                    "관광지"
                ) %>
            </div>

            <div class="category-card-description">
                <%= messages.getProperty(
                    "category.attraction.description",
                    "여행의 즐거움을 더해줄 명소"
                ) %>
            </div>

            <div class="category-more">
                <span>
                    <%= messages.getProperty(
                        "category.more",
                        "둘러보기"
                    ) %>
                </span>

                <span class="category-arrow">
                    →
                </span>
            </div>

        </a>

    </div>

</main>


<%@ include file="footer.jsp" %>


<!-- =========================
     계절 적용
========================== -->

<script>

document.addEventListener("DOMContentLoaded", function () {

    const categoryPage =
        document.getElementById("categoryPage");

    const decoration =
        document.getElementById("seasonDecoration");

    const params =
        new URLSearchParams(window.location.search);

    const heroSeason =
        params.get("heroSeason");

    const now = new Date();

    const month =
        now.getMonth() + 1;

    let season;


    /* =========================
       실제 계절 자동 선택
    ========================== */

    if (month >= 3 && month <= 5) {

        season = "spring";

    } else if (month >= 6 && month <= 8) {

        season = "summer";

    } else if (month >= 9 && month <= 11) {

        season = "autumn";

    } else {

        season = "winter";

    }


    /* =========================
       URL 테스트 계절
    ========================== */

    if (
        heroSeason === "spring" ||
        heroSeason === "summer" ||
        heroSeason === "autumn" ||
        heroSeason === "winter"
    ) {

        season = heroSeason;

    }


    /* =========================
       계절 클래스 적용
    ========================== */

    if (categoryPage) {

        categoryPage.classList.add(
            "season-" + season
        );

    }


    /* =========================
       계절 장식 생성
    ========================== */

    if (!decoration) {
        return;
    }


    let count = 18;


    for (let i = 0; i < count; i++) {

        const particle =
            document.createElement("span");

        particle.className =
            "season-particle";


        particle.style.left =
            Math.random() * 100 + "%";

        particle.style.top =
            Math.random() * 100 + "%";

        particle.style.animationDelay =
            -(Math.random() * 12) + "s";

        particle.style.animationDuration =
            (8 + Math.random() * 8) + "s";


        decoration.appendChild(
            particle
        );

    }


    console.log(
        "[Category Season]",
        "month =", month,
        "season =", season
    );

});

</script>


</body>

</html>