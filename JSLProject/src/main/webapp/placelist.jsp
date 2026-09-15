<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>

<%
String lang = request.getParameter("lang");

if (lang == null) {
	lang = "ko";
}

if (!lang.equals("ko") && !lang.equals("en") && !lang.equals("ja")) {
	lang = "ko";
}

Properties messages = new Properties();

String filePath = "/i18n/messages_" + lang + ".properties";

InputStream input = application.getResourceAsStream(filePath);

if (input != null) {
	messages.load(new InputStreamReader(input, "UTF-8"));

	input.close();
}
%>

<%--
  placelist.jsp (가게 목록 화면)
  ▶ placeList     : 검색/필터 결과 → 검색 패널 안쪽 작은 목록에 세로로 출력 (스크롤)
  ▶ topRatedList  : 별점 높은 가게 랜덤 목록 → "추천 가게" 자리에서 자동 슬라이드
  ▶ PLACES 테이블 기준: country 컬럼이 없어서 국가 선택 제거, region은 텍스트 검색으로 변경
--%>
<!DOCTYPE html>
<html lang="<%=lang%>">
<head>
<meta charset="UTF-8">
<title><%=messages.getProperty("place.list.title", "TripStamp - 여행지 추천")%>
</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/placelist.css">
</head>
<body>

	<%@ include file="header.jsp"%>

	<main class="main-content">

		<!-- 지도 + 검색 영역 -->
		<section class="hero-section">

			<div class="map-panel">
				<div id="map"></div>
			</div>

			<div class="search-panel">

				<div class="search-panel">

					<form
						action="${pageContext.request.contextPath}/places/placesSearch.do"
						method="get" class="search-form">

						<!-- 현재 선택한 언어 유지 -->
						<input type="hidden" name="lang" value="<%=lang%>">

						<div class="search-box">

							<input type="text" name="keyword"
								placeholder="<%= messages.getProperty(
                       "place.search.placeholder",
                       "가게 이름이나 지역으로 검색"
                   ) %>"
								value="${param.keyword}">

							<button type="submit" class="btn btn-primary">
								<%=messages.getProperty("place.search.button", "검색")%>
							</button>

						</div>


						<div class="category-buttons">

							<button type="submit" name="category" value=""
								class="chip ${empty param.category ? 'chip-active' : ''}">
								<%=messages.getProperty("place.category.all", "전체")%>
							</button>

							<button type="submit" name="category" value="restaurant"
								class="chip ${param.category == 'restaurant' ? 'chip-active' : ''}">
								<%=messages.getProperty("category.restaurant", "식당")%>
							</button>

							<button type="submit" name="category" value="cafe"
								class="chip ${param.category == 'cafe' ? 'chip-active' : ''}">
								<%=messages.getProperty("category.cafe", "카페")%>
							</button>

							<button type="submit" name="category" value="shop"
								class="chip ${param.category == 'shop' ? 'chip-active' : ''}">
								<%=messages.getProperty("category.shop", "상점")%>
							</button>

							<button type="submit" name="category" value="attraction"
								class="chip ${param.category == 'attraction' ? 'chip-active' : ''}">
								<%=messages.getProperty("category.attraction", "관광지")%>
							</button>

						</div>

						<div class="region-select">

							<%-- <select name="country" id="countrySelect">

        <option value="">
            <%= messages.getProperty("place.country.select", "국가 선택") %>
        </option>

        <option value="일본"
            ${param.country == '일본' ? 'selected' : ''}>
            <%= messages.getProperty("place.country.japan", "일본") %>
        </option>

        <option value="한국"
            ${param.country == '한국' ? 'selected' : ''}>
            <%= messages.getProperty("place.country.korea", "한국") %>
        </option>

        <option value="미국"
            ${param.country == '미국' ? 'selected' : ''}>
            <%= messages.getProperty("place.country.usa", "미국") %>
        </option>

    </select> --%>

							<div class="region-select">
								<select name="region" id="regionSelect">

									<option value="">
										<%=messages.getProperty("place.region.select", "지역 선택")%>
									</option>

									<option value="tokyo" ${param.region == 'tokyo' ? 'selected' : ''}>일본 - 도쿄</option>
									<option value="osaka" ${param.region == 'osaka' ? 'selected' : ''}>일본 - 오사카</option>
									<option value="kyoto" ${param.region == 'kyoto' ? 'selected' : ''}>일본 - 교토</option>
									<option value="seoul" ${param.region == 'seoul' ? 'selected' : ''}>한국 - 서울</option>
									<option value="busan" ${param.region == 'busan' ? 'selected' : ''}>한국 - 부산</option>
									<option value="newyork" ${param.region == 'newyork' ? 'selected' : ''}>미국 - 뉴욕</option>
									<option value="sanfrancisco" ${param.region == 'sanfrancisco' ? 'selected' : ''}>미국 - 샌프란시스코</option>
									<option value="la" ${param.region == 'la' ? 'selected' : ''}>미국 - LA</option>

								</select>
							</div>

						</div>

					</form>

					<!-- 검색 결과 -->
					<div class="search-result-list">

						<c:forEach var="place" items="${placeList}">

							<div class="result-item">

								 <img src="${place.image_url}"
									alt="${place.name}">

								<div class="result-info">
								<a
									href="${pageContext.request.contextPath}/places/placesDetail.do?id=${place.id}&lang=<%=lang%>">
									 

									<p class="result-name">

										${place.name}

										<c:if test="${not empty sessionScope.id}">
											<button type="button" class="like-btn"
												onclick="toggleLike(event, this)">☆</button>
										</c:if>

									</p>
									</a>

									<p class="result-rating">★ ${place.rating}</p>

									<p class="result-address">${place.region}</p>

								</div>

								</a>

								<div class="result-actions">

									<c:choose>

										<c:when test="${not place.reservable}">

											<span class="mini-btn reserve disabled"> <%=messages.getProperty("place.reserve.unavailable", "예약불가")%>
											</span>

										</c:when>

										<c:when test="${not empty sessionScope.id}">

											<a
												href="${pageContext.request.contextPath}/booking/bookingview.do?id=${place.id}&lang=<%= lang %>"
												class="mini-btn reserve"> <%=messages.getProperty("place.reserve", "예약")%>

											</a>

										</c:when>

										<c:otherwise>

											<a
												href="${pageContext.request.contextPath}/users/loginview.do?lang=<%= lang %>"
												class="mini-btn reserve"> <%=messages.getProperty("place.reserve", "예약")%>

											</a>

										</c:otherwise>

									</c:choose>


									<c:choose>

										<c:when
											test="${not empty place.latitude and not empty place.longitude}">

											<a
												href="https://www.google.com/maps/search/?api=1&query=${place.latitude},${place.longitude}"
												target="_blank" class="mini-btn map"> <%=messages.getProperty("place.directions", "길찾기")%>

											</a>

										</c:when>

										<c:otherwise>

											<span class="mini-btn map disabled"> <%=messages.getProperty("place.directions", "길찾기")%>

											</span>

										</c:otherwise>

									</c:choose>

								</div>

							</div>

						</c:forEach>


						<c:if test="${empty placeList}">

							<p class="empty-msg">

								<%=messages.getProperty("place.search.empty", "검색 결과가 없습니다.")%>

							</p>

						</c:if>

					</div>

				</div>
		</section>


		<!-- 추천 가게 -->
		<c:if test="${not empty topRatedList}">

			<section class="place-section">

				<h2 class="section-title">

					<%=messages.getProperty("place.recommended", "추천 가게")%>

				</h2>

				<div class="auto-slide-wrapper">

					<button type="button" class="slide-btn prev"
						onclick="moveSlide(-1)">‹</button>

					<div class="auto-slide-track" id="autoSlideTrack">

						<c:forEach var="loopCount" begin="1" end="2">

							<c:forEach var="place" items="${topRatedList}">

								<div class="auto-slide-card">

									<a
										href="${pageContext.request.contextPath}/places/placesDetail.do?id=${place.id}&lang=<%= lang %>"
										class="auto-slide-card-link">

										<div class="place-photo">

											<img src="${place.image_url}" alt="${place.name}">

										</div>

										<div class="place-info">

											<h3 class="place-name">

												${place.name}

												<c:if test="${not empty sessionScope.id}">

													<button type="button" class="like-btn"
														onclick="toggleLike(event, this)">☆</button>

												</c:if>

											</h3>

											<p class="place-rating">★ ${place.rating}</p>

											<p class="place-address">${place.region}</p>

										</div>

									</a>

									<div class="card-actions">

										<c:choose>

											<c:when test="${not place.reservable}">

												<span class="mini-btn reserve disabled"> <%=messages.getProperty("place.reserve.unavailable", "예약불가")%>

												</span>

											</c:when>

											<c:when test="${not empty sessionScope.id}">

												<a
													href="${pageContext.request.contextPath}/booking/bookingview.do?id=${place.id}&lang=<%= lang %>"
													class="mini-btn reserve"> <%=messages.getProperty("place.reserve", "예약")%>

												</a>

											</c:when>

											<c:otherwise>

												<a
													href="${pageContext.request.contextPath}/users/loginview.do?lang=<%= lang %>"
													class="mini-btn reserve"> <%=messages.getProperty("place.reserve", "예약")%>

												</a>

											</c:otherwise>

										</c:choose>


										<c:choose>

											<c:when
												test="${not empty place.latitude and not empty place.longitude}">

												<a
													href="https://www.google.com/maps/search/?api=1&query=${place.latitude},${place.longitude}"
													target="_blank" class="mini-btn map"> <%=messages.getProperty("place.directions", "길찾기")%>

												</a>

											</c:when>

											<c:otherwise>

												<span class="mini-btn map disabled"> <%=messages.getProperty("place.directions", "길찾기")%>

												</span>

											</c:otherwise>

										</c:choose>

									</div>

								</div>

							</c:forEach>

						</c:forEach>

					</div>

					<button type="button" class="slide-btn next" onclick="moveSlide(1)">
						›</button>

				</div>

			</section>

		</c:if>

	</main>

	<%@ include file="footer.jsp"%>

	<%
    String gmapKey = System.getenv("GOOGLE_MAPS_KEY");
    if (gmapKey == null) gmapKey = "";
%>

<script>
    /*
     * [카테고리 지도] 구글 Places API로 해당 카테고리의 실제 점포를 지도에 표시.
     * (점포 정보는 Places, 찜/루트/예약은 우리 DB — 팀 합의 방향)
     */
    // 우리 카테고리값 → 구글 Places 장소 유형
    var CATEGORY_TYPE = {
        restaurant: "restaurant",
        cafe: "cafe",
        shop: "store",
        attraction: "tourist_attraction"
    };

    // 현재 선택된 카테고리 (없으면 전체)
    var placeCategory = "${param.category}";

    // 현재 검색어(있으면 그 점포 텍스트 검색)
    var placeKeyword = "${param.keyword}";

    // 대도시 목록 → 지도 중심 좌표 (regionSelect 선택값 param.region 에 따라 결정, 없으면 도쿄)
    var CITY_CENTER = {
        tokyo:        { lat: 35.6762, lng: 139.6503 },
        osaka:        { lat: 34.6937, lng: 135.5023 },
        kyoto:        { lat: 35.0116, lng: 135.7681 },
        seoul:        { lat: 37.5665, lng: 126.9780 },
        busan:        { lat: 35.1796, lng: 129.0756 },
        newyork:      { lat: 40.7128, lng: -74.0060 },
        sanfrancisco: { lat: 37.7749, lng: -122.4194 },
        la:           { lat: 34.0522, lng: -118.2437 }
    };
    // 선택된 지역(없으면 도쿄)
    var selectedRegion = "${param.region}";
    var SEARCH_CENTER = CITY_CENTER[selectedRegion] || CITY_CENTER["tokyo"];

    // HTML 이스케이프
    function escapeHtml(t) {
        return String(t == null ? "" : t).replace(/[&<>"]/g, function (c) {
            return { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c];
        });
    }

    // Places 결과 1건 → 목록 카드 (기존 .result-item 클래스 재사용 → CSS 그대로 적용)
    function buildResultCard(place, map, openInfo) {
        var item = document.createElement("div");
        item.className = "result-item";

        var photoUrl = (place.photos && place.photos.length)
            ? place.photos[0].getUrl({ maxWidth: 120, maxHeight: 120 }) : "";
        var rating = place.rating ? place.rating : "-";
        var addr = place.vicinity ? place.vicinity : (place.formatted_address || "");
        var mapsUrl = "https://www.google.com/maps/search/?api=1&query="
            + encodeURIComponent(place.name) + "&query_place_id=" + place.place_id;

        item.innerHTML =
            (photoUrl ? '<img src="' + photoUrl + '" alt="' + escapeHtml(place.name) + '">' : '')
            + '<div class="result-info">'
            +   '<p class="result-name">' + escapeHtml(place.name) + '</p>'
            +   '<p class="result-rating">\u2605 ' + rating + '</p>'
            +   '<p class="result-address">' + escapeHtml(addr) + '</p>'
            + '</div>'
            + '<div class="result-actions">'
            +   '<a class="mini-btn map" target="_blank" rel="noopener" href="' + mapsUrl + '">\uae38\ucc3e\uae30</a>'
            + '</div>';

        // 카드 클릭 → 지도에서 해당 위치 정보창 열기 (링크 클릭은 예외)
        item.addEventListener("click", function (e) {
            if (e.target.closest("a")) return;
            if (place.geometry && place.geometry.location) {
                map.panTo(place.geometry.location);
                openInfo();
            }
        });
        return item;
    }

    function initMap() {
        var mapEl = document.getElementById("map");
        if (!mapEl) return;

        var map = new google.maps.Map(mapEl, {
            center: SEARCH_CENTER,
            zoom: 14,
            mapTypeControl: false,
            streetViewControl: false
        });

        var service = new google.maps.places.PlacesService(map);
        var info = new google.maps.InfoWindow();

        // 검색 결과(마커 + 목록) 공통 처리
        function handleResults(results, status) {
            var listEl = document.querySelector(".search-result-list");

            if (status !== google.maps.places.PlacesServiceStatus.OK || !results || results.length === 0) {
                console.warn("[Places] \uac80\uc0c9 \uc0c1\ud0dc:", status,
                    "(REQUEST_DENIED \uc774\uba74 Google Cloud\uc5d0\uc11c Places API \uc0ac\uc6a9 \uc124\uc815\uc744 \ud655\uc778\ud558\uc138\uc694)");
                if (listEl) listEl.innerHTML =
                    "<p style='padding:16px;color:#868e96'>\uac80\uc0c9 \uacb0\uacfc\uac00 \uc5c6\uc2b5\ub2c8\ub2e4.</p>";
                return;
            }

            if (listEl) listEl.innerHTML = "";

            var bounds = new google.maps.LatLngBounds();
            results.forEach(function (place) {
                if (!place.geometry || !place.geometry.location) return;

                var marker = new google.maps.Marker({
                    map: map,
                    position: place.geometry.location,
                    title: place.name
                });
                bounds.extend(place.geometry.location);

                function openInfo() {
                    var rating = place.rating ? " \u2b50 " + place.rating : "";
                    var addrText = place.vicinity || place.formatted_address || "";
                    var addr = addrText
                        ? "<br><span style='color:#868e96'>" + escapeHtml(addrText) + "</span>" : "";
                    info.setContent("<strong>" + escapeHtml(place.name) + "</strong>" + rating + addr);
                    info.open(map, marker);
                }
                marker.addListener("click", openInfo);

                if (listEl) listEl.appendChild(buildResultCard(place, map, openInfo));
            });
            if (!bounds.isEmpty()) { map.fitBounds(bounds); }
        }

        // 검색어가 있으면 텍스트 검색(그 점포만), 없으면 카테고리별 주변 검색
        if (placeKeyword && placeKeyword.trim() !== "") {
            service.textSearch(
                { query: placeKeyword, location: SEARCH_CENTER, radius: 30000 },
                handleResults
            );
        } else {
            var request = { location: SEARCH_CENTER, radius: 1500 };
            var type = CATEGORY_TYPE[placeCategory];
            if (type) { request.type = type; }
            service.nearbySearch(request, handleResults);
        }
    }

    window.gm_authFailure = function () {
        var m = document.getElementById("map");
        if (m) m.innerHTML =
            "<div style='padding:20px;color:#c92a2a'>지도 인증 실패: API 키/도메인 제한 또는 Places API 사용 설정을 확인하세요.</div>";
    };
</script>

<% if (gmapKey.isEmpty()) { %>
    <script>
        (function () {
            var m = document.getElementById("map");
            if (m) m.innerHTML =
                "<div style='padding:20px;color:#868e96'>환경변수 GOOGLE_MAPS_KEY 가 설정되어 있지 않습니다.</div>";
        })();
    </script>
<% } else { %>
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=<%= gmapKey %>&libraries=places&callback=initMap"></script>
<% } %>

</body>
<script>

    // 찜하기
    function toggleLike(event, btn) {

        event.preventDefault();
        event.stopPropagation();

        btn.classList.toggle('liked');

        btn.textContent =
            btn.classList.contains('liked') ? '★' : '☆';
    }


    // 현재 검색 조건 유지
    const currentKeyword =
        "${param.keyword}";

    const currentCategory =
        "${param.category}";

    const currentLang =
        "<%=lang%>
	";

	// 지역 선택
	const regionSelect = document.getElementById('regionSelect');

	// 지역 변경 시 검색
	regionSelect
			.addEventListener(
					'change',
					function() {

						const params = new URLSearchParams();

						// 기존 검색어 유지
						if (currentKeyword) {

							params.set('keyword', currentKeyword);
						}

						// 기존 카테고리 유지
						if (currentCategory) {

							params.set('category', currentCategory);
						}

						// 지역
						if (this.value) {

							params.set('region', this.value);
						}

						// 언어 유지
						params.set('lang', currentLang);

						location.href = "${pageContext.request.contextPath}/places/placesAllList.do?"
								+ params.toString();

					});

	// =========================
	// 추천 가게 자동 슬라이드
	// =========================

	const track = document.getElementById('autoSlideTrack');

	const SCROLL_SPEED = 0.6;

	let isPaused = false;

	function autoScrollLoop() {

		if (track && !isPaused) {

			track.scrollLeft += SCROLL_SPEED;

			const halfWidth = track.scrollWidth / 2;

			if (track.scrollLeft >= halfWidth) {

				track.scrollLeft -= halfWidth;
			}
		}

		requestAnimationFrame(autoScrollLoop);
	}

	if (track) {

		track.addEventListener('mouseenter', function() {

			isPaused = true;
		});

		track.addEventListener('mouseleave', function() {

			isPaused = false;
		});
	}

	const CARD_STEP = 272;

	function moveSlide(direction) {

		if (!track) {

			return;
		}

		track.scrollLeft += direction * CARD_STEP;

		const halfWidth = track.scrollWidth / 2;

		if (track.scrollLeft >= halfWidth) {

			track.scrollLeft -= halfWidth;

		} else if (track.scrollLeft < 0) {

			track.scrollLeft += halfWidth;
		}
	}

	requestAnimationFrame(autoScrollLoop);
</script>

</html>