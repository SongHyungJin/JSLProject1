<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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


            <!-- 지역 선택: 선택한 한 지역 안에서만 추천 (지역 혼합 방지) -->
            <div class="recommend-region" style="margin:14px 0 6px; text-align:center;">
                <label style="font-weight:600; margin-right:8px;">지역</label>
                <select id="bestRegion" onchange="changeBestRegion(this.value)"
                        style="padding:8px 14px; border:1px solid #ccd2e0; border-radius:8px; font-size:14px;">
                    <option value="seoul">한국 - 서울</option>
                    <option value="busan">한국 - 부산</option>
                    <option value="tokyo">일본 - 도쿄</option>
                    <option value="osaka">일본 - 오사카</option>
                    <option value="kyoto">일본 - 교토</option>
                    <option value="newyork">미국 - 뉴욕</option>
                    <option value="sanfrancisco">미국 - 샌프란시스코</option>
                    <option value="la">미국 - LA</option>
                </select>
            </div>

            <script>
                (function () {
                    var cur = "${param.region}";
                    if (cur) {
                        var el = document.getElementById("bestRegion");
                        if (el) { el.value = cur; }
                    }
                })();
                function changeBestRegion(region) {
                    var theme = "${param.theme}";
                    var lang = "<%= lang %>";
                    var url = "<%= request.getContextPath() %>/route/bestroute.do?region=" + encodeURIComponent(region);
                    if (theme) { url += "&theme=" + encodeURIComponent(theme); }
                    if (lang)  { url += "&lang=" + encodeURIComponent(lang); }
                    location.href = url;
                }
            </script>

            <div class="recommend-layout">


                <!-- 지도 -->
                <div class="recommend-map">

                    <div class="map-area">


                        <!-- 구글맵 -->
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
                             * 추천 알고리즘(RouteController /bestroute.do) 결과를 지도에 표시.
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


                    <c:choose>
                        <c:when test="${empty course}">
                            <p style="padding:20px; color:#868e96;">
                                추천할 점포가 없습니다. (DB의 places 데이터가 필요합니다)
                            </p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${course}" varStatus="st">
                                <div class="recommend-item">

                                    <div class="route-number">${st.count}</div>
                                    <div class="route-vertical-line"></div>

                                    <div class="recommend-card">
                                        <div class="recommend-card-top">
                                            <div class="recommend-info">
                                                <span class="recommend-step">
                                                    <c:choose>
                                                        <c:when test="${st.first}">출발</c:when>
                                                        <c:when test="${st.last}">도착</c:when>
                                                        <c:otherwise>경유</c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <h2>${p.name}</h2>
                                                <p>
                                                    <c:choose>
                                                        <c:when test="${not empty p.description}">${p.description}</c:when>
                                                        <c:otherwise>${p.category} · ${p.region}</c:otherwise>
                                                    </c:choose>
                                                    <c:if test="${p.rating > 0}"> · ★ ${p.rating}</c:if>
                                                </p>
                                            </div>
                                            <div class="recommend-photo">
                                                <c:choose>
                                                    <c:when test="${not empty p.image_url}">
                                                        <img src="${p.image_url}" alt="${p.name}"
                                                             style="width:100%;height:100%;object-fit:cover;border-radius:12px;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${p.category eq 'restaurant'}">🍜</c:when>
                                                            <c:when test="${p.category eq 'cafe'}">☕</c:when>
                                                            <c:when test="${p.category eq 'shop'}">🛍️</c:when>
                                                            <c:when test="${p.category eq 'attraction'}">🏛️</c:when>
                                                            <c:otherwise>📍</c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <c:if test="${not st.last}">
                                            <div class="move-box">
                                                <div class="move-icon">🚶</div>
                                                <div class="move-info">
                                                    <strong>${moves[st.index]}</strong>
                                                    <span>다음 · ${course[st.index + 1].name}</span>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>

                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

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