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

                        <!-- 실제 구글맵 (찜한 점포 순회 코스) -->
                        <div id="map"
                             style="position:absolute; inset:0; z-index:1; border-radius:18px;"></div>

                        <%
                            Object _cj = request.getAttribute("courseJson");
                            String courseJson = (_cj != null) ? _cj.toString() : "[]";
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
                            // 나의 여행루트: 찜한 점포들을 최적 동선(RouteController)으로 받아 표시
                            var myRouteSpots = <%= courseJson %>;

                            function initMyRouteMap() {
                                var el = document.getElementById("map");
                                var map = new google.maps.Map(el, {
                                    mapTypeControl: false,
                                    streetViewControl: false
                                });

                                // 찜한 곳이 없으면 기본 위치만 표시
                                if (!myRouteSpots || myRouteSpots.length === 0) {
                                    map.setCenter({ lat: 35.0116, lng: 135.7681 });
                                    map.setZoom(11);
                                    return;
                                }

                                var bounds = new google.maps.LatLngBounds();
                                var path = [];
                                var info = new google.maps.InfoWindow();

                                myRouteSpots.forEach(function (s, i) {
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
                            src="https://maps.googleapis.com/maps/api/js?key=<%= gmapKey %>&callback=initMyRouteMap"></script>

                        <% } %>

                    </div>

                </div>


                <!-- 타임라인 -->
                <div class="route-timeline">

                    <c:choose>
                        <c:when test="${empty course}">
                            <p style="padding:20px; color:#868e96;">
                                아직 찜한 장소가 없습니다. 점포를 찜하면 여기에 최적 동선으로 표시돼요.
                            </p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${course}" varStatus="st">
                                <div class="route-item">

                                    <div class="route-number">${st.count}</div>
                                    <div class="route-line"></div>

                                    <div class="route-card">
                                        <div class="route-card-top">
                                            <div class="route-info">
                                                <span class="route-step">
                                                    <c:choose>
                                                        <c:when test="${st.first}">출발 · 찜한 곳</c:when>
                                                        <c:when test="${st.last}">도착 · 찜한 곳</c:when>
                                                        <c:otherwise>${st.count}번째 · 찜한 곳</c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <h2>${p.name}</h2>
                                                <p>${p.category} · ${p.region}<c:if test="${p.rating > 0}"> · ★ ${p.rating}</c:if></p>
                                            </div>
                                            <div class="route-photo">
                                                <c:choose>
                                                    <c:when test="${not empty p.image_url}">
                                                        <img src="${p.image_url}" alt="${p.name}"
                                                             style="width:100%;height:100%;object-fit:cover;border-radius:12px;">
                                                    </c:when>
                                                    <c:otherwise>📍</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <c:if test="${not st.last}">
                                            <div class="route-move">
                                                <div class="move-icon">🚗</div>
                                                <div class="move-text">
                                                    <p style="margin:0; font-weight:600;">${moves[st.index]}</p>
                                                    <span>다음 갈 곳 <strong>${course[st.index + 1].name}</strong></span>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>

                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                </div>

            </div>

        </div>

    </main>

    <%@ include file="footer.jsp"%>

</body>

</html>