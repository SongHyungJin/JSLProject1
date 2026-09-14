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

<title><%=messages.getProperty("review.all.title", "TripStamp - 리뷰 전체보기")%></title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reviewAll.css">

</head>

<body>

	<%@ include file="header.jsp"%>


	<div class="review-all-page">


		<c:if test="${not empty place}">

			<p class="review-all-place-name">${place.name}</p>

		</c:if>



		<!-- 리뷰 요약 -->

		<div class="review-summary">

			<div class="summary-score">

				<div class="score-number">${averageRating}</div>

				<div class="score-stars">⭐⭐⭐⭐⭐</div>

				<div class="score-count">
					${totalCount}<%=messages.getProperty("review.all.count", "개 리뷰")%>
				</div>

			</div>


			<div class="summary-bars">


				<!-- 5점 -->

				<div class="bar-row">

					<span class="bar-label"> <%=messages.getProperty("review.all.score5", "5점")%>
					</span>

					<div class="bar-track">

						<div class="bar-fill"
							style="width:${totalCount > 0 ? scoreCounts[5] * 100 / totalCount : 0}%;">
						</div>

					</div>

					<span class="bar-count"> ${scoreCounts[5]} </span>

				</div>


				<!-- 4점 -->

				<div class="bar-row">

					<span class="bar-label"> <%=messages.getProperty("review.all.score4", "4점")%>
					</span>

					<div class="bar-track">

						<div class="bar-fill"
							style="width:${totalCount > 0 ? scoreCounts[4] * 100 / totalCount : 0}%;">
						</div>

					</div>

					<span class="bar-count"> ${scoreCounts[4]} </span>

				</div>


				<!-- 3점 -->

				<div class="bar-row">

					<span class="bar-label"> <%=messages.getProperty("review.all.score3", "3점")%>
					</span>

					<div class="bar-track">

						<div class="bar-fill"
							style="width:${totalCount > 0 ? scoreCounts[3] * 100 / totalCount : 0}%;">
						</div>

					</div>

					<span class="bar-count"> ${scoreCounts[3]} </span>

				</div>


				<!-- 2점 -->

				<div class="bar-row">

					<span class="bar-label"> <%=messages.getProperty("review.all.score2", "2점")%>
					</span>

					<div class="bar-track">

						<div class="bar-fill"
							style="width:${totalCount > 0 ? scoreCounts[2] * 100 / totalCount : 0}%;">
						</div>

					</div>

					<span class="bar-count"> ${scoreCounts[2]} </span>

				</div>


				<!-- 1점 -->

				<div class="bar-row">

					<span class="bar-label"> <%=messages.getProperty("review.all.score1", "1점")%>
					</span>

					<div class="bar-track">

						<div class="bar-fill"
							style="width:${totalCount > 0 ? scoreCounts[1] * 100 / totalCount : 0}%;">
						</div>

					</div>

					<span class="bar-count"> ${scoreCounts[1]} </span>

				</div>


			</div>

		</div>



		<!-- 정렬 / 필터 -->
		<div class="review-toolbar">


			<div class="sort-buttons">


				<button type="button" class="sort-btn active"
					onclick="sortReviews('latest', this)">

					<%=messages.getProperty("review.all.sort.latest", "최신순")%>

				</button>


				<button type="button" class="sort-btn"
					onclick="sortReviews('high', this)">

					<%=messages.getProperty("review.all.sort.high", "평점 높은순")%>

				</button>


				<button type="button" class="sort-btn"
					onclick="sortReviews('low', this)">

					<%=messages.getProperty("review.all.sort.low", "평점 낮은순")%>

				</button>


			</div>


			<label class="photo-filter"> <input type="checkbox"
				id="photoOnly" onchange="filterPhotoReviews()"> <%=messages.getProperty("review.all.photo.only", "사진 있는 리뷰만")%>

			</label>


		</div>



		<!-- 리뷰 작성하기 -->
		<c:if test="${not empty sessionScope.loginUser}">

			<div class="write-review-bar">

				<a
					href="${pageContext.request.contextPath}/review/write.do?id=${place.id}&lang=<%= lang %>"
					class="write-review-btn"> <%=messages.getProperty("review.all.write", "리뷰 작성하기")%>

				</a>

			</div>

		</c:if>



		<div class="review-all-list">

			<c:choose>

				<c:when test="${not empty reviewList}">

					<c:forEach var="review" items="${reviewList}">

						<div class="review-all-item" data-date="${review.createdAt}"
							data-rating="${review.rating}"
							data-has-photo="${not empty review.imageUrl}">

							<div class="review-all-photos">

								<c:choose>

									<c:when test="${not empty review.imageUrl}">

										<div class="photo-thumb">
											<img src="${review.imageUrl}" alt="리뷰 이미지">
										</div>

									</c:when>

									<c:otherwise>

										<div class="photo-thumb">📷</div>

									</c:otherwise>

								</c:choose>

							</div>


							<div class="review-all-body">

								<div class="review-all-top">

									<div class="review-all-rating">

										<c:forEach begin="1" end="5" var="star">

											<c:choose>

												<c:when test="${star <= review.rating}">
                                            ⭐
                                        </c:when>

												<c:otherwise>
                                            ☆
                                        </c:otherwise>

											</c:choose>

										</c:forEach>

										<span> ${review.rating}.0 </span>

									</div>


									<span class="review-all-date"> ${review.createdDate} </span>

								</div>


								<p class="review-all-author">${review.nickname}</p>


								<p class="review-all-text">${review.content}</p>


								<div class="review-all-actions">

									<button type="button" class="like-toggle-btn"
										onclick="toggleLikeBtn(this)">

										🤍 <span>0</span>

									</button>

								</div>

							</div>

						</div>

					</c:forEach>

				</c:when>


				<c:otherwise>

					<p class="review-empty">
						<%=messages.getProperty("review.all.empty", "아직 등록된 리뷰가 없습니다.")%>
					</p>

				</c:otherwise>

			</c:choose>

		</div>



		<!-- 페이지네이션 -->
		<div class="review-pagination"></div>


	</div>


	<%@ include file="footer.jsp"%>



	<script>
		const REVIEWS_PER_PAGE = 5;

		let currentPage = 1;

		let currentSort = 'latest';

		/* =========================
		   정렬
		========================= */

		function sortReviews(type, btn) {

			currentSort = type;

			currentPage = 1;

			document.querySelectorAll('.sort-btn').forEach(function(button) {

				button.classList.remove('active');

			});

			btn.classList.add('active');

			updateReviews();
		}

		/* =========================
		   사진 필터
		========================= */

		function filterPhotoReviews() {

			currentPage = 1;

			updateReviews();
		}

		/* =========================
		   리뷰 출력
		========================= */

		function updateReviews() {

			const list = document.querySelector('.review-all-list');

			if (!list) {
				return;
			}

			let reviews = Array.from(list.querySelectorAll('.review-all-item'));

			/* -------------------------
			   정렬
			------------------------- */

			reviews.sort(function(a, b) {

				if (currentSort === 'latest') {

					const dateA = new Date(a.dataset.date).getTime();

					const dateB = new Date(b.dataset.date).getTime();

					return dateB - dateA;
				}

				if (currentSort === 'high') {

					const ratingA = parseInt(a.dataset.rating, 10);

					const ratingB = parseInt(b.dataset.rating, 10);

					return ratingB - ratingA;
				}

				if (currentSort === 'low') {

					const ratingA = parseInt(a.dataset.rating, 10);

					const ratingB = parseInt(b.dataset.rating, 10);

					return ratingA - ratingB;
				}

				return 0;
			});

			/* -------------------------
			   사진 필터
			------------------------- */

			const photoOnly = document.getElementById('photoOnly');

			if (photoOnly && photoOnly.checked) {

				reviews = reviews.filter(function(review) {

					return review.dataset.hasPhoto === 'true';

				});
			}

			/* -------------------------
			   모든 리뷰 숨기기
			------------------------- */

			const allReviews = list.querySelectorAll('.review-all-item');

			allReviews.forEach(function(review) {

				review.style.display = 'none';

			});

			/* -------------------------
			   페이지 계산
			------------------------- */

			const totalReviews = reviews.length;

			const totalPages = Math.ceil(totalReviews / REVIEWS_PER_PAGE);

			if (totalPages === 0) {

				currentPage = 1;

				renderPagination(0);

				return;
			}

			if (currentPage > totalPages) {

				currentPage = totalPages;

			}

			/* -------------------------
			   현재 페이지 리뷰
			------------------------- */

			const start = (currentPage - 1) * REVIEWS_PER_PAGE;

			const end = start + REVIEWS_PER_PAGE;

			reviews.slice(start, end).forEach(function(review) {

				review.style.display = '';

			});

			/* -------------------------
			   페이지 버튼
			------------------------- */

			renderPagination(totalPages);
		}

		/* =========================
		   페이지 이동
		========================= */

		function goToPage(page) {

			currentPage = page;

			updateReviews();
		}

		/* =========================
		   페이지네이션
		========================= */

		function renderPagination(totalPages) {

			const pagination = document.querySelector('.review-pagination');

			if (!pagination) {
				return;
			}

			pagination.innerHTML = '';

			if (totalPages <= 1) {
				return;
			}

			/* 이전 */

			if (currentPage > 1) {

				const prev = document.createElement('button');

				prev.type = 'button';

				prev.className = 'page-btn';

				prev.textContent = '‹';

				prev.onclick = function() {

					goToPage(currentPage - 1);

				};

				pagination.appendChild(prev);
			}

			/* 숫자 */

			for (let i = 1; i <= totalPages; i++) {

				const button = document.createElement('button');

				button.type = 'button';

				button.className = 'page-btn';

				if (i === currentPage) {

					button.classList.add('active');

				}

				button.textContent = i;

				button.onclick = function() {

					goToPage(i);

				};

				pagination.appendChild(button);
			}

			/* 다음 */

			if (currentPage < totalPages) {

				const next = document.createElement('button');

				next.type = 'button';

				next.className = 'page-btn';

				next.textContent = '›';

				next.onclick = function() {

					goToPage(currentPage + 1);

				};

				pagination.appendChild(next);
			}
		}

		/* =========================
		   좋아요
		========================= */

		function toggleLikeBtn(btn) {

			const span = btn.querySelector('span');

			let count = parseInt(span.textContent, 10);

			if (btn.classList.contains('liked')) {

				btn.classList.remove('liked');

				btn.innerHTML = '🤍 <span>' + (count - 1) + '</span>';

			} else {

				btn.classList.add('liked');

				btn.innerHTML = '❤️ <span>' + (count + 1) + '</span>';
			}
		}

		/* =========================
		   처음 페이지 로딩
		========================= */

		document.addEventListener('DOMContentLoaded', function() {

			updateReviews();

		});
	</script>


</body>

</html>