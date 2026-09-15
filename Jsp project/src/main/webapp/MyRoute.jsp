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
        "myroute.title",
        "TripStamp - 내 루트"
    ) %>
</title>

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/myroute.css">

</head>

<body>

    <%@ include file="header.jsp"%>

    <main class="route-main">

        <div class="route-container">

            <div class="route-title">

                <h1>
                    <%= messages.getProperty(
                        "myroute.heading",
                        "내 루트"
                    ) %>
                </h1>

                <p>
                    <%= messages.getProperty(
                        "myroute.subtitle",
                        "찜한 장소들을 이어서 나만의 동선을 확인해보세요"
                    ) %>
                </p>

            </div>

            <div class="route-layout">

                <!-- 지도 -->
                <div class="route-map">

                    <div class="map-background">

                        <div class="map-city">
                            MY ROUTE
                        </div>

                        <div class="map-center-box">

                            <div class="map-icon">
                                📍
                            </div>

                            <h2>
                                <%= messages.getProperty(
                                    "myroute.map.title",
                                    "지도 영역"
                                ) %>
                            </h2>

                            <p>
                                <%= messages.getProperty(
                                    "myroute.map.description",
                                    "찜한 장소를 잇는 경로가 여기에 표시될 예정이에요"
                                ) %>
                            </p>

                        </div>

                        <div class="map-controls">

                            <button type="button">+</button>
                            <button type="button">－</button>

                        </div>

                    </div>

                </div>


                <!-- 타임라인 -->
                <div class="route-timeline">


                    <!-- 1번 -->
                    <div class="route-item">

                        <div class="route-number">
                            1
                        </div>

                        <div class="route-line"></div>

                        <div class="route-card">

                            <div class="route-card-top">

                                <div class="route-info">

                                    <span class="route-step">
                                        <%= messages.getProperty(
                                            "myroute.step.start",
                                            "출발 · 찜한 곳"
                                        ) %>
                                    </span>

                                    <h2>
                                        <%= messages.getProperty(
                                            "myroute.place1.name",
                                            "서울 카페"
                                        ) %>
                                    </h2>

                                    <p>
                                        <%= messages.getProperty(
                                            "myroute.place1.description",
                                            "분위기 좋은 감성 카페"
                                        ) %>
                                    </p>

                                </div>

                                <div class="route-photo">
                                    ☕
                                </div>

                            </div>


                            <div class="route-move">

                                <div class="move-icon">
                                    🚗
                                </div>

                                <div class="move-text">

                                    <p>
                                        <%= messages.getProperty(
                                            "myroute.move1",
                                            "강남대로 방면 이동 · 약 18분"
                                        ) %>
                                    </p>

                                    <span>

                                        <%= messages.getProperty(
                                            "myroute.next",
                                            "다음 갈 곳"
                                        ) %>

                                        <strong>
                                            <%= messages.getProperty(
                                                "myroute.place2.name",
                                                "도쿄 스시야"
                                            ) %>
                                        </strong>

                                    </span>

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- 2번 -->
                    <div class="route-item">

                        <div class="route-number">
                            2
                        </div>

                        <div class="route-line"></div>

                        <div class="route-card">

                            <div class="route-card-top">

                                <div class="route-info">

                                    <span class="route-step">
                                        <%= messages.getProperty(
                                            "myroute.step.second",
                                            "두 번째 · 찜한 곳"
                                        ) %>
                                    </span>

                                    <h2>
                                        <%= messages.getProperty(
                                            "myroute.place2.name",
                                            "도쿄 스시야"
                                        ) %>
                                    </h2>

                                    <p>
                                        <%= messages.getProperty(
                                            "myroute.place2.description",
                                            "신선한 초밥을 맛볼 수 있는 곳"
                                        ) %>
                                    </p>

                                </div>

                                <div class="route-photo">
                                    🍣
                                </div>

                            </div>


                            <div class="route-move">

                                <div class="move-icon">
                                    🚶
                                </div>

                                <div class="move-text">

                                    <p>
                                        <%= messages.getProperty(
                                            "myroute.move2",
                                            "오다이바 방면 도보 이동 · 약 9분"
                                        ) %>
                                    </p>

                                    <span>

                                        <%= messages.getProperty(
                                            "myroute.next",
                                            "다음 갈 곳"
                                        ) %>

                                        <strong>
                                            <%= messages.getProperty(
                                                "myroute.place3.name",
                                                "교토 라멘집"
                                            ) %>
                                        </strong>

                                    </span>

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- 3번 -->
                    <div class="route-item">

                        <div class="route-number">
                            3
                        </div>

                        <div class="route-card">

                            <div class="route-card-top">

                                <div class="route-info">

                                    <span class="route-step">
                                        <%= messages.getProperty(
                                            "myroute.step.arrival",
                                            "도착 · 찜한 곳"
                                        ) %>
                                    </span>

                                    <h2>
                                        <%= messages.getProperty(
                                            "myroute.place3.name",
                                            "교토 라멘집"
                                        ) %>
                                    </h2>

                                    <p>
                                        <%= messages.getProperty(
                                            "myroute.place3.description",
                                            "진한 돈코츠 육수로 유명한 라멘 맛집"
                                        ) %>
                                    </p>

                                </div>

                                <div class="route-photo">
                                    🍜
                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </main>

    <%@ include file="footer.jsp"%>

</body>

</html>