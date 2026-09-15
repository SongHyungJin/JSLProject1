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

									<option value="서울" ${param.region == '서울' ? 'selected' : ''}>
										<%=messages.getProperty("place.region.seoul", "서울")%>
									</option>

									<option value="부산" ${param.region == '부산' ? 'selected' : ''}>
										<%=messages.getProperty("place.region.busan", "부산")%>
									</option>

									<option value="제주" ${param.region == '제주' ? 'selected' : ''}>
										<%=messages.getProperty("place.region.jeju", "제주")%>
									</option>

									<option value="인천" ${param.region == '인천' ? 'selected' : ''}>
										<%=messages.getProperty("place.region.incheon", "인천")%>
									</option>

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

	<script
		src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY_HERE&callback=initMap"
		async defer>
</script>

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