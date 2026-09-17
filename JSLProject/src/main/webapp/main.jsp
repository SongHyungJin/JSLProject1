<%@ page language="java"

    contentType="text/html; charset=UTF-8"

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

            new InputStreamReader(

                input,

                "UTF-8"

            )

        );

        input.close();

    }

%>

<!DOCTYPE html>

<html lang="<%= lang %>">

<head>

<meta charset="UTF-8">

<meta

    name="viewport"

    content="width=device-width, initial-scale=1.0">

<title>

    <%= messages.getProperty(

        "main.title",

        "Travel Route"

    ) %>

</title>

<link

    rel="stylesheet"

    href="<%= request.getContextPath() %>/css/main.css?v=52">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
    href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&family=Gowun+Dodum&display=swap"
    rel="stylesheet">

</head>





<body>





<!-- =====================================================

     HEADER

     기존 header.jsp 절대 변경하지 않음

====================================================== -->

<%@ include file="header.jsp"%>









<main>





    <!-- =====================================================

         HERO

    ====================================================== -->

    <section class="hero">

        <div

            class="hero-scene"

            id="heroScene">





            <!-- ============================================

                 머리카락 흔들림용 SVG FILTER

            ============================================= -->

            <svg

                width="0"

                height="0"

                style="position:absolute">

                <filter

                    id="hairFlowFilter"

                    x="-40%"

                    y="-40%"

                    width="180%"

                    height="180%">

                    <feTurbulence

                        type="fractalNoise"

                        baseFrequency="0.018 0.075"

                        numOctaves="2"

                        seed="7"

                        result="turb">

                        <animate

                            attributeName="baseFrequency"

                            values="

                                0.018 0.075;

                                0.026 0.095;

                                0.020 0.080;

                                0.018 0.075

                            "

                            dur="3s"

                            repeatCount="indefinite" />

                    </feTurbulence>





                    <feDisplacementMap

                        in="SourceGraphic"

                        in2="turb"

                        scale="3"

                        xChannelSelector="R"

                        yChannelSelector="G" />

                </filter>

            </svg>









            <!-- ============================================

                 움직이는 비행기

            ============================================= -->

            <div class="plane-only"></div>



            <!-- ============================================

                 V9 왼쪽 벚꽃 전경 레이어

            \============================================= -->

            <div class="branch-left"></div>



            <!-- ============================================

                 V9 오른쪽 전경 레이어

            \============================================= -->

            <div class="foreground-right"></div>









            <!-- ============================================

                 머리카락 애니메이션

            ============================================= -->

            <div class="hair-group">

                <div class="thread-0"></div>

                <div class="thread-1"></div>

                <div class="thread-2"></div>

                <div class="thread-3"></div>

                <div class="thread-4"></div>

                <div class="thread-5"></div>

                <div class="thread-6"></div>

                <div class="thread-7"></div>

            </div>









            <!-- ============================================

                 벚꽃

            ============================================= -->

            <div

                class="petals-layer"

                id="heroPetals">

            </div>









            <!-- ============================================

                 HERO TEXT

                 기존 다국어 기능 유지

            ============================================= -->

            <div class="hero-content">

                <h1 class="hero-title">

                    <span class="hero-title-line1">
                        <%= messages.getProperty(
                            "main.hero.title.line1",
                            "en".equals(lang)
                                ? "Choose where you want to go"
                                : "ja".equals(lang)
                                    ? "\u884C\u304D\u305F\u3044\u5834\u6240\u3092\u9078\u3093\u3067"
                                    : "가고 싶은 곳을 골라"
                        ) %>
                    </span>

                    <span class="hero-title-line2">
                        <%= messages.getProperty(
                            "main.hero.title.line2",
                            "en".equals(lang)
                                ? "Create your own journey"
                                : "ja".equals(lang)
                                    ? "\u81EA\u5206\u3060\u3051\u306E\u65C5\u3092\u4F5C\u3063\u3066\u307F\u307E\u3057\u3087\u3046"
                                    : "나만의 여행을 만들어보세요"
                        ) %>
                    </span>

                </h1>





                <p>

                    <%= messages.getProperty(

                        "main.hero.description",

                        "가고 싶은 장소를 찾고, 나만의 여행 동선을 만들어보세요."

                    ) %>

                </p>









                <!-- ========================================

                     검색

                     기존 /places/placesSearch.do 유지

                ========================================= -->

                <form

                    class="search-box"

                    action="<%= request.getContextPath() %>/places/placesSearch.do"

                    method="get">





                    <input

                        type="hidden"

                        name="lang"

                        value="<%= lang %>">





                    <span

                        class="search-icon"

                        aria-hidden="true">

                        ⌕

                    </span>





                    <input

                        type="text"

                        name="keyword"

                        placeholder="<%= messages.getProperty(

                            "main.search.placeholder",

                            "가게 이름이나 지역으로 검색"

                        ) %>">





                    <button type="submit">

                        <%= messages.getProperty(

                            "main.search.button",

                            "검색"

                        ) %>

                    </button>





                </form>









                <!-- ========================================

                     인기 검색어

                ========================================= -->

                <div class="popular-search">

                    <span class="popular-title">
                        <%= messages.getProperty(
                            "main.popular.title",
                            lang.equals("ja") ? "人気の検索ワード" :
                            lang.equals("en") ? "Popular Searches" :
                            "인기 검색어"
                        ) %>
                    </span>

                    <a href="<%= request.getContextPath() %>/places/placesSearch.do?keyword=도쿄&lang=<%= lang %>">
                        #<%= messages.getProperty(
                            "main.popular.tokyo",
                            lang.equals("ja") ? "東京" :
                            lang.equals("en") ? "Tokyo" :
                            "도쿄"
                        ) %>
                    </a>

                    <a href="<%= request.getContextPath() %>/places/placesSearch.do?keyword=오사카&lang=<%= lang %>">
                        #<%= messages.getProperty(
                            "main.popular.osaka",
                            lang.equals("ja") ? "大阪" :
                            lang.equals("en") ? "Osaka" :
                            "오사카"
                        ) %>
                    </a>

                    <a href="<%= request.getContextPath() %>/places/placesSearch.do?keyword=후쿠오카&lang=<%= lang %>">
                        #<%= messages.getProperty(
                            "main.popular.fukuoka",
                            lang.equals("ja") ? "福岡" :
                            lang.equals("en") ? "Fukuoka" :
                            "후쿠오카"
                        ) %>
                    </a>

                    <a href="<%= request.getContextPath() %>/places/placesSearch.do?keyword=맛집&lang=<%= lang %>">
                        #<%= messages.getProperty(
                            "main.popular.food",
                            lang.equals("ja") ? "グルメ" :
                            lang.equals("en") ? "Food" :
                            "맛집"
                        ) %>
                    </a>

                    <a href="<%= request.getContextPath() %>/places/placesSearch.do?keyword=카페&lang=<%= lang %>">
                        #<%= messages.getProperty(
                            "main.popular.cafe",
                            lang.equals("ja") ? "カフェ" :
                            lang.equals("en") ? "Cafe" :
                            "카페"
                        ) %>
                    </a>

                    <a href="<%= request.getContextPath() %>/places/placesSearch.do?keyword=온천&lang=<%= lang %>">
                        #<%= messages.getProperty(
                            "main.popular.onsen",
                            lang.equals("ja") ? "温泉" :
                            lang.equals("en") ? "Hot Springs" :
                            "온천"
                        ) %>
                    </a>

                </div>





            </div>









            <!-- ============================================

                 SCROLL

            ============================================= -->

            <a

                href="#categorySection"

                class="scroll-guide">





                <span class="scroll-mouse"></span>

                <span class="scroll-text">

                    SCROLL

                </span>

                <span class="scroll-arrow">

                    ↓

                </span>





            </a>





        </div>

    </section>









    <!-- =====================================================

         언어 선택

         ★ 기존 기능 그대로 유지

    ====================================================== -->

    <section class="language-section">

        <div class="language-box">





            <a

                href="<%= request.getContextPath() %>/main.do?lang=ko"

                class="<%= lang.equals("ko") ? "active" : "" %>">

                한국어

            </a>





            <a

                href="<%= request.getContextPath() %>/main.do?lang=en"

                class="<%= lang.equals("en") ? "active" : "" %>">

                English

            </a>





            <a

                href="<%= request.getContextPath() %>/main.do?lang=ja"

                class="<%= lang.equals("ja") ? "active" : "" %>">

                日本語

            </a>





        </div>

    </section>









    <!-- =====================================================

         카테고리

    ====================================================== -->

    <section

        class="main-section category-section"

        id="categorySection">





        <div class="section-title">





            <div class="section-heading">





                <h2>

                    <%= messages.getProperty(

                        "main.category.title",

                        "카테고리"

                    ) %>

                </h2>





                <p>

                    <%= messages.getProperty(

                        "main.category.subtitle",

                        "가고 싶은 장소를 찾아 특별한 여행을 시작해보세요."

                    ) %>

                </p>





            </div>









            <a

                href="<%= request.getContextPath() %>/places/placesAllList.do?lang=<%= lang %>">

                <%= messages.getProperty(

                    "main.category.more",

                    "전체보기"

                ) %>

            </a>





        </div>









        <div class="category-grid">





            <!-- 식당 -->

            <a

                href="<%= request.getContextPath() %>/places/placesSearch.do?category=restaurant&lang=<%= lang %>"

                class="category-card restaurant-card">





                <div class="category-visual">

                    <div class="category-icon">

                        🍴

                    </div>

                </div>





                <div class="category-content">





                    <strong>

                        <%= messages.getProperty(

                            "category.restaurant",

                            "식당"

                        ) %>

                    </strong>





                    <p>

                        <%= messages.getProperty(

                            "main.category.restaurant.description",

                            "현지의 맛있는 요리로 특별한 한때를 즐겨보세요."

                        ) %>

                    </p>





                    <span class="card-arrow">

                        →

                    </span>





                </div>





            </a>









            <!-- 상점 -->

            <a

                href="<%= request.getContextPath() %>/places/placesSearch.do?category=shop&lang=<%= lang %>"

                class="category-card shop-card">





                <div class="category-visual">

                    <div class="category-icon">

                        🛍️

                    </div>

                </div>





                <div class="category-content">





                    <strong>

                        <%= messages.getProperty(

                            "category.shop",

                            "상점"

                        ) %>

                    </strong>





                    <p>

                        <%= messages.getProperty(

                            "main.category.shop.description",

                            "여행지에서만 만날 수 있는 특별한 아이템을 찾아보세요."

                        ) %>

                    </p>





                    <span class="card-arrow">

                        →

                    </span>





                </div>





            </a>









            <!-- 카페 -->

            <a

                href="<%= request.getContextPath() %>/places/placesSearch.do?category=cafe&lang=<%= lang %>"

                class="category-card cafe-card">





                <div class="category-visual">

                    <div class="category-icon">

                        ☕

                    </div>

                </div>





                <div class="category-content">





                    <strong>

                        <%= messages.getProperty(

                            "category.cafe",

                            "카페"

                        ) %>

                    </strong>





                    <p>

                        <%= messages.getProperty(

                            "main.category.cafe.description",

                            "감성적인 카페에서 여유로운 시간을 보내보세요."

                        ) %>

                    </p>





                    <span class="card-arrow">

                        →

                    </span>





                </div>





            </a>





        </div>

    </section>









    <!-- =====================================================

         추천 여행 루트

         기존 기능 그대로

    ====================================================== -->

    <section class="main-section route-section">





        <div class="section-title">





            <div class="section-heading">





                <h2>

                    <%= messages.getProperty(

                        "main.route.title",

                        "추천 여행 루트"

                    ) %>

                </h2>

                <span class="route-style-label" aria-hidden="true">
                    Best Route
                    <span class="route-style-plane">✈</span>
                </span>





                <p>

                    <%= messages.getProperty(

                        "main.route.subtitle",

                        "인기 명소와 맛집을 함께 즐겨보세요."

                    ) %>

                </p>





            </div>









            <a

                href="<%= request.getContextPath() %>/route/bestroute.do?lang=<%= lang %>"

                class="route-more">

                <%= messages.getProperty(

                    "main.route.more",

                    "모든 루트 보기"

                ) %>

            </a>





        </div>









        <div class="route-grid">





            <!-- 도시 여행 -->

            <a

                href="<%= request.getContextPath() %>/route/bestroute.do?lang=<%= lang %>"

                class="route-card">





                <div class="route-photo city-photo">

                    <span class="route-badge">

                        <%= messages.getProperty(

                            "main.route.city",

                            "도시 여행"

                        ) %>

                    </span>

                </div>





                <div class="route-content">





                    <h3>

                        <%= messages.getProperty(

                            "main.route.city",

                            "도시 여행"

                        ) %>

                    </h3>





                    <p>

                        <%= messages.getProperty(

                            "main.route.city.description",

                            "도시의 인기 명소와 맛집을 함께 즐겨보세요."

                        ) %>

                    </p>





                    <span class="card-arrow">

                        →

                    </span>





                </div>





            </a>









            <!-- 카페 여행 -->

            <a

                href="<%= request.getContextPath() %>/route/bestroute.do?lang=<%= lang %>"

                class="route-card">





                <div class="route-photo cafe-photo">

                    <span class="route-badge">

                        <%= messages.getProperty(

                            "main.route.cafe",

                            "카페 여행"

                        ) %>

                    </span>

                </div>





                <div class="route-content">





                    <h3>

                        <%= messages.getProperty(

                            "main.route.cafe",

                            "카페 여행"

                        ) %>

                    </h3>





                    <p>

                        <%= messages.getProperty(

                            "main.route.cafe.description",

                            "감성 카페를 따라 여유로운 하루를 보내보세요."

                        ) %>

                    </p>





                    <span class="card-arrow">

                        →

                    </span>





                </div>





            </a>









            <!-- 자연 여행 -->

            <a

                href="<%= request.getContextPath() %>/route/bestroute.do?lang=<%= lang %>"

                class="route-card">





                <div class="route-photo nature-photo">

                    <span class="route-badge">

                        <%= messages.getProperty(

                            "main.route.nature",

                            "자연 여행"

                        ) %>

                    </span>

                </div>





                <div class="route-content">





                    <h3>

                        <%= messages.getProperty(

                            "main.route.nature",

                            "자연 여행"

                        ) %>

                    </h3>





                    <p>

                        <%= messages.getProperty(

                            "main.route.nature.description",

                            "자연 속에서 힐링할 수 있는 코스를 만나보세요."

                        ) %>

                    </p>





                    <span class="card-arrow">

                        →

                    </span>





                </div>





            </a>





        </div>

    </section>





</main>









<!-- =====================================================

     FOOTER

====================================================== -->

<%@ include file="footer.jsp"%>









<script

    src="<%= request.getContextPath() %>/js/hero-animation.js?v=50">

</script>





</body>

</html>