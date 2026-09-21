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

String resourcePath = "/i18n/messages_" + lang + ".properties";

InputStream is = application.getResourceAsStream(resourcePath);

if (is != null) {
	messages.load(new InputStreamReader(is, "UTF-8"));
	is.close();
}
%>

<!DOCTYPE html>

<html lang="<%=lang%>">

<head>

<meta charset="UTF-8">

<title>TripStamp - ${place.name}</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/view.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/review.css">

</head>

<body>

	<%@ include file="header.jsp"%>


	<div class="page-wrap">


		<!-- 상단 검색 -->
		<div class="top-search">

			<form class="search-box"
				action="${pageContext.request.contextPath}/places/placesSearch.do"
				method="get">

				<input type="hidden" name="lang" value="<%=lang%>"> <input
					type="text" name="keyword"
					placeholder="<%=messages.getProperty("place.search.placeholder", "가게 이름이나 지역으로 검색")%>">

				<button type="submit">

					<%=messages.getProperty("place.search.button", "검색")%>

				</button>

			</form>

		</div>



		<c:if test="${not empty place}">


			<!-- 이미지 갤러리 -->
			<div class="image-gallery">

				<div class="main-image"
					style="
                     background-image:url('${place.image_url}');
                     background-size:cover;
                     background-position:center;
                 ">

					<span> <%=messages.getProperty("view.photo.none", "사진 정보 없음")%>

					</span>

				</div>


				<div class="side-images">

					<div class="side-image">

						<span> <%=messages.getProperty("view.photo.none", "사진 정보 없음")%>

						</span>

					</div>


					<div class="side-image">

						<span> <%=messages.getProperty("view.photo.none", "사진 정보 없음")%>

						</span>

					</div>

				</div>

			</div>



			<!-- 가게 정보 -->
			<div class="place-summary">

				<div class="place-summary-left">

					<h1 class="place-title">

						${place.name}

						<c:if test="${not empty sessionScope.id}">

							<button type="button" class="like-btn"
								onclick="toggleLike(event, this, ${place.id})">☆</button>

						</c:if>

					</h1>


					<div class="rating-line">

						<span class="rating"> ★ ${place.rating} </span> <span
							class="review no-data"> <%=messages.getProperty("view.review.none", "리뷰 정보 없음")%>

						</span> <span class="dot"> · </span>


						<c:choose>

							<c:when
								test="${place.category == 'restraunt'
                                || place.category == 'restaurant'
                                || place.category == '식당'}">

								<span> <%=messages.getProperty("category.restaurant", "식당")%>

								</span>

							</c:when>

							<c:when
								test="${place.category == 'CAFE'
                                || place.category == 'cafe'
                                || place.category == '카페'}">

								<span> <%=messages.getProperty("category.cafe", "카페")%>

								</span>

							</c:when>

							<c:when
								test="${place.category == 'SHOP'
                                || place.category == 'shop'
                                || place.category == '상점'}">

								<span> <%=messages.getProperty("category.shop", "상점")%>

								</span>

							</c:when>

							<c:when
								test="${place.category == 'ATTRACTION'
                                || place.category == 'attraction'
                                || place.category == '관광지'}">

								<span> <%=messages.getProperty("category.attraction", "관광지")%>

								</span>

							</c:when>

							<c:when test="${not empty place.category}">

								<span> ${place.category} </span>

							</c:when>

							<c:otherwise>

								<span class="no-data"> <%=messages.getProperty("view.category.none", "카테고리 정보 없음")%>

								</span>

							</c:otherwise>

						</c:choose>

					</div>


					<p class="address">

						📍

						<c:choose>

							<c:when test="${not empty place.region}">

                            ${place.region}

                        </c:when>

							<c:otherwise>

								<span class="no-data"> <%=messages.getProperty("view.region.none", "지역 정보 없음")%>

								</span>

							</c:otherwise>

						</c:choose>

					</p>

				</div>



				<!-- 예약 / 길찾기 -->
				<div class="action-card">

					<c:choose>

						<c:when test="${not place.reservable}">
							<button type="button" class="reserve-btn disabled" disabled>
								<%=messages.getProperty("view.reserve.unavailable", "예약 불가 매장")%>
							</button>
						</c:when>

						<c:when test="${not empty sessionScope.id}">

							<a
								href="${pageContext.request.contextPath}/booking/bookingview.do?id=${place.id}&lang=<%= lang %>"
								class="reserve-btn"> <%=messages.getProperty("view.reserve.button", "예약하기")%>

							</a>

						</c:when>

						<c:otherwise>

							<c:url var="bookingLoginUrl" value="/users/loginview.do">

								<c:param name="lang" value="<%=lang%>" />

								<c:param name="redirect"
									value="/booking/bookingview.do?id=${place.id}" />

							</c:url>

							<a href="${bookingLoginUrl}" class="reserve-btn"> <%=messages.getProperty("view.reserve.button", "예약하기")%>

							</a>

						</c:otherwise>

					</c:choose>


					<c:choose>

						<c:when
							test="${not empty place.latitude
                            and not empty place.longitude}">

							<a
								href="https://www.google.com/maps/search/?api=1&query=${place.latitude},${place.longitude}"
								target="_blank" class="route-btn"> <%=messages.getProperty("place.directions", "길찾기")%>

							</a>

						</c:when>

						<c:otherwise>

							<button type="button" class="route-btn disabled" disabled>

								<%=messages.getProperty("view.directions.none", "길찾기 (정보 없음)")%>

							</button>

						</c:otherwise>

					</c:choose>

				</div>

			</div>



			<!-- 위치 / 영업시간 / 주차 -->
			<div class="quick-info">

				<div class="quick-item">

					<div class="quick-icon">📍</div>

					<div>

						<span class="quick-label"> <%=messages.getProperty("view.location", "위치")%>

						</span>

						<c:choose>

							<c:when test="${not empty place.region}">

								<span class="quick-value"> ${place.region} </span>

							</c:when>

							<c:otherwise>

								<span class="quick-value no-data"> <%=messages.getProperty("view.no.info", "정보 없음")%>

								</span>

							</c:otherwise>

						</c:choose>

					</div>

				</div>


				<div class="quick-item">

					<div class="quick-icon">⏰</div>

					<div>

						<span class="quick-label"> <%=messages.getProperty("view.business.hours", "영업시간")%>

						</span>

						<c:choose>

							<c:when test="${not empty place.business_hours}">

								<span class="quick-value"> ${place.business_hours} </span>

							</c:when>

							<c:otherwise>

								<span class="quick-value no-data"> <%=messages.getProperty("view.no.info", "정보 없음")%>

								</span>

							</c:otherwise>

						</c:choose>

					</div>

				</div>


				<div class="quick-item">

					<div class="quick-icon">🅿️</div>

					<div>

						<span class="quick-label"> <%=messages.getProperty("view.parking", "주차")%>

						</span> <span class="quick-value no-data"> <%=messages.getProperty("view.no.info", "정보 없음")%>

						</span>

					</div>

				</div>

			</div>



			<!-- 대표 메뉴 -->
			<div class="detail-section">

				<h2 class="section-title">

					<%=messages.getProperty("view.menu.title", "대표 메뉴")%>

				</h2>

				<div class="menu-tags">

					<span class="menu-tag no-data"> <%=messages.getProperty("view.menu.none", "메뉴 정보 없음")%>

					</span>

				</div>

			</div>



			<!-- 소개 -->
			<div class="detail-section">

				<h2 class="section-title">

					<%=messages.getProperty("view.description.title", "소개")%>

				</h2>

				<c:choose>

					<c:when test="${not empty place.description}">

						<p class="description">${place.description}</p>

					</c:when>

					<c:otherwise>

						<p class="description no-data">

							<%=messages.getProperty("view.no.info", "정보 없음")%>

						</p>

					</c:otherwise>

				</c:choose>

			</div>



			<!-- 방문자 리뷰 -->
			<div class="detail-section">

				<div class="section-title-row">

					<h2 class="section-title">
						<%=messages.getProperty("view.review.visitor", "방문자 리뷰")%>
					</h2>
					<a
						href="${pageContext.request.contextPath}/review/all.do?id=${place.id}&lang=<%= lang %>"
						class="review-more-btn"> <%=messages.getProperty("review.list.all", "전체보기")%>
						&gt;

					</a>
				</div>


				<!-- 리뷰 슬라이더 -->
				<c:choose>


					<c:when test="${not empty reviewList}">

						<div class="review-slider-wrapper">


							<button type="button" class="review-nav prev"
								onclick="moveReview(-1)">‹</button>


							<div class="review-track" id="reviewTrack">

								<c:forEach var="review" items="${reviewList}">

									<div class="review-card">


										<div class="review-photo">

											<c:choose>

												<c:when test="${not empty review.imageUrl}">

													<img src="${review.imageUrl}" alt="리뷰 이미지">

												</c:when>

												<c:otherwise>

                                        📷

                                    </c:otherwise>

											</c:choose>

										</div>



										<div class="review-body">



											<div class="review-rating">

												<c:forEach begin="1" end="5" var="star">

													<c:choose>

														<c:when test="${star <= review.rating}">

                                                ★

                                            </c:when>

														<c:otherwise>

                                                ☆

                                            </c:otherwise>

													</c:choose>

												</c:forEach>

												<span> ${review.rating}.0 </span>

											</div>



											<p class="review-author">${review.nickname}</p>



											<p class="review-text">"${review.content}"</p>





										</div>

									</div>

								</c:forEach>

							</div>



							<button type="button" class="review-nav next"
								onclick="moveReview(1)">›</button>

						</div>

					</c:when>



					<c:otherwise>

						<p class="description no-data">

							<%=messages.getProperty("view.review.empty", "아직 등록된 리뷰가 없습니다.")%>

						</p>

					</c:otherwise>

				</c:choose>
				<div class="review-write-area">

					<a
						href="${pageContext.request.contextPath}/review/write.do?id=${place.id}&lang=<%= lang %>"
						class="review-write-btn"> 리뷰 작성 </a>

				</div>
			</div>



			<!-- 목록으로 -->
			<div class="back-section">

				<a
					href="${pageContext.request.contextPath}/places/placesAllList.do?lang=<%= lang %>"
					class="back-btn"> ← <%=messages.getProperty("view.back.list", "목록으로")%>

				</a>

			</div>


		</c:if>



		<c:if test="${empty place}">

			<div class="detail-section" style="text-align: center; color: #999;">

				<p>

					<%=messages.getProperty("view.place.notfound", "가게 정보를 찾을 수 없습니다.")%>

				</p>

				<div class="back-section">

					<a
						href="${pageContext.request.contextPath}/places/placesAllList.do?lang=<%= lang %>"
						class="back-btn"> ← <%=messages.getProperty("view.back.list", "목록으로")%>

					</a>

				</div>

			</div>

		</c:if>


	</div>


	<%@ include file="footer.jsp"%>


	<script>
	function toggleLike(event, btn, placeId) {

	    event.preventDefault();
	    event.stopPropagation();

	    const isLiked = btn.classList.contains('liked');

	    $.ajax({
	        url: '${pageContext.request.contextPath}/bookmark/toggle.do',
	        type: 'POST',
	        data: {
	            placeId: placeId,
	            action: isLiked ? 'delete' : 'add'
	        },

	        success: function(result) {

	            result = result.trim();

	            if (result === 'add') {

	                btn.classList.add('liked');
	                btn.textContent = '★';

	            } else if (result === 'delete') {

	                btn.classList.remove('liked');
	                btn.textContent = '☆';

	            } else if (result === 'login') {

	                alert('로그인이 필요합니다.');

	            } else {

	                alert('북마크 처리에 실패했습니다.');
	            }
	        },

	        error: function() {
	            alert('북마크 처리 중 오류가 발생했습니다.');
	        }
	    });
	}
	</script>


</body>

</html>