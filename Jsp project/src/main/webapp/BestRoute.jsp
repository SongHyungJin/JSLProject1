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
        "bestroute.title",
        "TripStamp - 추천 루트"
    ) %>
</title>

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/bestroute.css">

</head>

<body>

    <%@ include file="header.jsp"%>

    <main class="recommend-main">

        <div class="recommend-container">

            <div class="recommend-title">

                <span class="recommend-label">
                    TRIPSTAMP RECOMMEND
                </span>

                <h1>
                    <%= messages.getProperty(
                        "bestroute.heading",
                        "추천 루트"
                    ) %>
                </h1>

                <p>
                    <%= messages.getProperty(
                        "bestroute.subtitle",
                        "TripStamp가 추천하는 코스대로 하루를 즐겨보세요"
                    ) %>
                </p>

            </div>


            <div class="recommend-layout">


                <!-- 지도 -->
                <div class="recommend-map">

                    <div class="map-area">


                        <div class="map-city city-seoul">
                            <%= messages.getProperty(
                                "bestroute.city.seoul",
                                "서울"
                            ) %>
                        </div>


                        <div class="map-city city-jongno">
                            <%= messages.getProperty(
                                "bestroute.city.jongno",
                                "종로"
                            ) %>
                        </div>


                        <div class="map-city city-jung">
                            <%= messages.getProperty(
                                "bestroute.city.jung",
                                "중구"
                            ) %>
                        </div>


                        <div class="map-city city-yongsan">
                            <%= messages.getProperty(
                                "bestroute.city.yongsan",
                                "용산"
                            ) %>
                        </div>


                        <div class="map-pin pin-one">
                            1
                        </div>

                        <div class="map-pin pin-two">
                            2
                        </div>

                        <div class="map-pin pin-three">
                            3
                        </div>


                        <div class="map-guide">

                            <div class="map-guide-icon">
                                📍
                            </div>

                            <h2>
                                <%= messages.getProperty(
                                    "bestroute.map.title",
                                    "지도 영역"
                                ) %>
                            </h2>

                            <p>
                                <%= messages.getProperty(
                                    "bestroute.map.description",
                                    "추천 루트가 지도 위에 표시될 예정이에요"
                                ) %>
                            </p>

                        </div>


                        <div class="map-control">

                            <button type="button">
                                +
                            </button>

                            <button type="button">
                                －
                            </button>

                        </div>

                    </div>

                </div>


                <!-- 추천 코스 리스트 -->
                <div class="recommend-route-list">


                    <!-- 1번 -->
                    <div class="recommend-item">

                        <div class="route-number">
                            1
                        </div>

                        <div class="route-vertical-line"></div>

                        <div class="recommend-card">

                            <div class="recommend-card-top">

                                <div class="recommend-info">

                                    <span class="recommend-step">
                                        <%= messages.getProperty(
                                            "bestroute.step.start",
                                            "출발"
                                        ) %>
                                    </span>

                                    <h2>
                                        <%= messages.getProperty(
                                            "bestroute.place1.name",
                                            "교토 라멘집"
                                        ) %>
                                    </h2>

                                    <p>
                                        <%= messages.getProperty(
                                            "bestroute.place1.description",
                                            "진한 돈코츠 육수로 유명한 라멘 맛집"
                                        ) %>
                                    </p>

                                </div>

                                <div class="recommend-photo">
                                    🍜
                                </div>

                            </div>


                            <div class="move-box">

                                <div class="move-icon">
                                    🚶
                                </div>

                                <div class="move-info">

                                    <strong>
                                        <%= messages.getProperty(
                                            "bestroute.move1",
                                            "도보 12분"
                                        ) %>
                                    </strong>

                                    <span>
                                        <%= messages.getProperty(
                                            "bestroute.next",
                                            "다음 장소"
                                        ) %>
                                        ·
                                        <%= messages.getProperty(
                                            "bestroute.place2.name",
                                            "도쿄 스시야"
                                        ) %>
                                    </span>

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- 2번 -->
                    <div class="recommend-item">

                        <div class="route-number">
                            2
                        </div>

                        <div class="route-vertical-line"></div>

                        <div class="recommend-card">

                            <div class="recommend-card-top">

                                <div class="recommend-info">

                                    <span class="recommend-step">
                                        <%= messages.getProperty(
                                            "bestroute.step.second",
                                            "두 번째"
                                        ) %>
                                    </span>

                                    <h2>
                                        <%= messages.getProperty(
                                            "bestroute.place2.name",
                                            "도쿄 스시야"
                                        ) %>
                                    </h2>

                                    <p>
                                        <%= messages.getProperty(
                                            "bestroute.place2.description",
                                            "신선한 초밥을 맛볼 수 있는 곳"
                                        ) %>
                                    </p>

                                </div>

                                <div class="recommend-photo">
                                    🍣
                                </div>

                            </div>


                            <div class="move-box">

                                <div class="move-icon">
                                    🚌
                                </div>

                                <div class="move-info">

                                    <strong>
                                        <%= messages.getProperty(
                                            "bestroute.move2",
                                            "버스 25분"
                                        ) %>
                                    </strong>

                                    <span>
                                        <%= messages.getProperty(
                                            "bestroute.next",
                                            "다음 장소"
                                        ) %>
                                        ·
                                        <%= messages.getProperty(
                                            "bestroute.place3.name",
                                            "서울 카페"
                                        ) %>
                                    </span>

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- 3번 -->
                    <div class="recommend-item">

                        <div class="route-number">
                            3
                        </div>

                        <div class="recommend-card">

                            <div class="recommend-card-top">

                                <div class="recommend-info">

                                    <span class="recommend-step">
                                        <%= messages.getProperty(
                                            "bestroute.step.arrival",
                                            "도착"
                                        ) %>
                                    </span>

                                    <h2>
                                        <%= messages.getProperty(
                                            "bestroute.place3.name",
                                            "서울 카페"
                                        ) %>
                                    </h2>

                                    <p>
                                        <%= messages.getProperty(
                                            "bestroute.place3.description",
                                            "분위기 좋은 감성 카페"
                                        ) %>
                                    </p>

                                </div>

                                <div class="recommend-photo">
                                    ☕
                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- 전체 루트 요약 -->
                    <div class="recommend-summary">

                        <h3>
                            <%= messages.getProperty(
                                "bestroute.summary.title",
                                "이런 분께 추천해요"
                            ) %>
                        </h3>

                        <p>
                            <%= messages.getProperty(
                                "bestroute.summary.description",
                                "맛집 탐방과 여유로운 카페 타임을 함께 즐기고 싶은 분께 딱 맞는 코스예요."
                            ) %>
                        </p>


                        <div class="recommend-tags">

                            <span>
                                <%= messages.getProperty(
                                    "bestroute.tag.food",
                                    "#맛집투어"
                                ) %>
                            </span>

                            <span>
                                <%= messages.getProperty(
                                    "bestroute.tag.cafe",
                                    "#카페추천"
                                ) %>
                            </span>

                            <span>
                                <%= messages.getProperty(
                                    "bestroute.tag.halfday",
                                    "#반나절코스"
                                ) %>
                            </span>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </main>

    <%@ include file="footer.jsp"%>

</body>

</html>