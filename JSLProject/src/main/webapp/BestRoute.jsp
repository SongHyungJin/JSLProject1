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


                        <!-- 실제 구글맵 (기존 목업 지도를 대체) -->
                        <div id="map"
                             style="position:absolute; inset:0; z-index:1; border-radius:18px;"></div>

                        <%
                            String gmapKey = System.getenv("GOOGLE_MAPS_KEY");
                            if (gmapKey == null) gmapKey = "";
                        %>

                        <% if (gmapKey.isEmpty()) { %>

                            <div style="position:absolute; inset:0; z-index:2; display:flex;
                                        align-items:center; justify-content:center;
                                        text-align:center; color:#868e96; padding:20px;">
                                환경변수 GOOGLE_MAPS_KEY 가 설정되어 있지 않습니다.
                            </div>

                        <% } else { %>

                        <script>
                            /*
                             * [2단계] 추천 알고리즘(RouteController /bestroute.do) 결과를 지도에 표시.
                             * courseJson 이 없으면(페이지 직접 열람 등) 빈 배열.
                             */
<%
    Object _cj = request.getAttribute("courseJson");
    String courseJson = (_cj != null) ? _cj.toString() : "[]";
%>
                            var recommendSpots = <%= courseJson %>;

                            function initRecommendMap() {
                                var el = document.getElementById("map");
                                var map = new google.maps.Map(el, {
                                    mapTypeControl: false,
                                    streetViewControl: false
                                });

                                // 추천 코스가 없으면 기본 위치만 표시
                                if (!recommendSpots || recommendSpots.length === 0) {
                                    map.setCenter({ lat: 35.0116, lng: 135.7681 });
                                    map.setZoom(12);
                                    return;
                                }

                                var bounds = new google.maps.LatLngBounds();
                                var path = [];
                                var info = new google.maps.InfoWindow();

                                recommendSpots.forEach(function (s, i) {
                                    var pos = { lat: s.lat, lng: s.lng };
                                    path.push(pos);
                                    bounds.extend(pos);
                                    var marker = new google.maps.Marker({
                                        position: pos, map: map, label: String(i + 1)
                                    });
                                    marker.addListener("click", function () {
                                        info.setContent("<strong>" + (i + 1) + ". " + s.name + "</strong>");
                                        info.open(map, marker);
                                    });
                                });

                                if (path.length > 1) {
                                    new google.maps.Polyline({
                                        path: path, geodesic: true,
                                        strokeColor: "#4c6ef5", strokeOpacity: 0.8,
                                        strokeWeight: 4, map: map
                                    });
                                }
                                map.fitBounds(bounds);
                            }

                            window.gm_authFailure = function () {
                                document.getElementById("map").innerHTML =
                                    "<div style='padding:20px;color:#c92a2a'>지도 인증 실패: API 키 또는 도메인 제한을 확인하세요.</div>";
                            };
                        </script>

                        <script async defer
                            src="https://maps.googleapis.com/maps/api/js?key=<%= gmapKey %>&callback=initRecommendMap"></script>

                        <% } %>

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