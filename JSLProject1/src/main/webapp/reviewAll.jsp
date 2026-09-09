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
        "review.all.title",
        "TripStamp - 리뷰 전체보기"
    ) %>
</title>

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/reviewAll.css">

</head>

<body>

<%@ include file="header.jsp"%>


<div class="review-all-page">


    <c:if test="${not empty place}">

        <p class="review-all-place-name">
            ${place.name}
        </p>

    </c:if>



    <!-- 리뷰 요약 -->
    <div class="review-summary">

        <div class="summary-score">

            <div class="score-number">
                4.7
            </div>

            <div class="score-stars">
                ⭐⭐⭐⭐⭐
            </div>

            <div class="score-count">

                <%= messages.getProperty(
                    "review.all.count",
                    "리뷰 128개"
                ) %>

            </div>

        </div>


        <div class="summary-bars">


            <div class="bar-row">

                <span class="bar-label">

                    <%= messages.getProperty(
                        "review.all.score5",
                        "5점"
                    ) %>

                </span>

                <div class="bar-track">
                    <div class="bar-fill"
                         style="width:70%;">
                    </div>
                </div>

                <span class="bar-count">
                    89
                </span>

            </div>


            <div class="bar-row">

                <span class="bar-label">

                    <%= messages.getProperty(
                        "review.all.score4",
                        "4점"
                    ) %>

                </span>

                <div class="bar-track">
                    <div class="bar-fill"
                         style="width:20%;">
                    </div>
                </div>

                <span class="bar-count">
                    25
                </span>

            </div>


            <div class="bar-row">

                <span class="bar-label">

                    <%= messages.getProperty(
                        "review.all.score3",
                        "3점"
                    ) %>

                </span>

                <div class="bar-track">
                    <div class="bar-fill"
                         style="width:6%;">
                    </div>
                </div>

                <span class="bar-count">
                    8
                </span>

            </div>


            <div class="bar-row">

                <span class="bar-label">

                    <%= messages.getProperty(
                        "review.all.score2",
                        "2점"
                    ) %>

                </span>

                <div class="bar-track">
                    <div class="bar-fill"
                         style="width:2%;">
                    </div>
                </div>

                <span class="bar-count">
                    3
                </span>

            </div>


            <div class="bar-row">

                <span class="bar-label">

                    <%= messages.getProperty(
                        "review.all.score1",
                        "1점"
                    ) %>

                </span>

                <div class="bar-track">
                    <div class="bar-fill"
                         style="width:2%;">
                    </div>
                </div>

                <span class="bar-count">
                    3
                </span>

            </div>


        </div>

    </div>



    <!-- 정렬 / 필터 -->
    <div class="review-toolbar">


        <div class="sort-buttons">


            <button type="button"
                    class="sort-btn active"
                    onclick="selectSort(this)">

                <%= messages.getProperty(
                    "review.all.sort.latest",
                    "최신순"
                ) %>

            </button>


            <button type="button"
                    class="sort-btn"
                    onclick="selectSort(this)">

                <%= messages.getProperty(
                    "review.all.sort.high",
                    "평점 높은순"
                ) %>

            </button>


            <button type="button"
                    class="sort-btn"
                    onclick="selectSort(this)">

                <%= messages.getProperty(
                    "review.all.sort.low",
                    "평점 낮은순"
                ) %>

            </button>


        </div>


        <label class="photo-filter">

            <input type="checkbox">

            <%= messages.getProperty(
                "review.all.photo.only",
                "사진 있는 리뷰만"
            ) %>

        </label>


    </div>



    <!-- 리뷰 작성하기 -->
    <c:if test="${not empty sessionScope.loginUser}">

        <div class="write-review-bar">

            <a href="${pageContext.request.contextPath}/review/write.do?id=${place.id}&lang=<%= lang %>"
               class="write-review-btn">

                <%= messages.getProperty(
                    "review.all.write",
                    "리뷰 작성하기"
                ) %>

            </a>

        </div>

    </c:if>



    <!-- 리뷰 목록 -->
    <div class="review-all-list">


        <!-- 리뷰 1 -->
        <div class="review-all-item">

            <div class="review-all-photos">

                <div class="photo-thumb">
                    📷
                </div>

                <div class="photo-thumb">
                    📷
                </div>

            </div>


            <div class="review-all-body">


                <div class="review-all-top">

                    <div class="review-all-rating">
                        ⭐⭐⭐⭐⭐
                        <span>5.0</span>
                    </div>

                    <span class="review-all-date">
                        2026.09.05
                    </span>

                </div>


                <p class="review-all-author">

                    <%= messages.getProperty(
                        "review.all.author1",
                        "김○○"
                    ) %>

                </p>


                <p class="review-all-text">

                    <%= messages.getProperty(
                        "review.all.text1",
                        "음식도 맛있고 분위기도 좋아요. 직원분들도 친절하시고 재료도 신선해서 다음에 또 방문하고 싶은 곳이에요. 특히 창가 자리에서 보는 뷰가 정말 좋았습니다."
                    ) %>

                </p>


                <div class="review-all-actions">

                    <button type="button"
                            class="like-toggle-btn"
                            onclick="toggleLikeBtn(this)">

                        🤍
                        <span>24</span>

                    </button>

                </div>


            </div>

        </div>



        <!-- 리뷰 2 -->
        <div class="review-all-item">


            <div class="review-all-body"
                 style="margin-left:0;">


                <div class="review-all-top">

                    <div class="review-all-rating">
                        ⭐⭐⭐⭐☆
                        <span>4.0</span>
                    </div>

                    <span class="review-all-date">
                        2026.09.02
                    </span>

                </div>


                <p class="review-all-author">

                    <%= messages.getProperty(
                        "review.all.author2",
                        "이○○"
                    ) %>

                </p>


                <p class="review-all-text">

                    <%= messages.getProperty(
                        "review.all.text2",
                        "여행 중 들렀는데 만족했습니다. 대기시간이 조금 있었지만 그만한 값어치를 하는 맛이었어요."
                    ) %>

                </p>


                <div class="review-all-actions">


                    <button type="button"
                            class="like-toggle-btn"
                            onclick="toggleLikeBtn(this)">

                        🤍
                        <span>8</span>

                    </button>


                    <button type="button"
                            class="edit-btn">

                        <%= messages.getProperty(
                            "review.all.edit",
                            "수정"
                        ) %>

                    </button>


                    <button type="button"
                            class="delete-btn">

                        <%= messages.getProperty(
                            "review.all.delete",
                            "삭제"
                        ) %>

                    </button>


                </div>


            </div>

        </div>



        <!-- 리뷰 3 -->
        <div class="review-all-item">


            <div class="review-all-photos">

                <div class="photo-thumb">
                    📷
                </div>

            </div>


            <div class="review-all-body">


                <div class="review-all-top">

                    <div class="review-all-rating">
                        ⭐⭐⭐⭐⭐
                        <span>5.0</span>
                    </div>

                    <span class="review-all-date">
                        2026.08.29
                    </span>

                </div>


                <p class="review-all-author">

                    <%= messages.getProperty(
                        "review.all.author3",
                        "박○○"
                    ) %>

                </p>


                <p class="review-all-text">

                    <%= messages.getProperty(
                        "review.all.text3",
                        "분위기가 정말 좋았습니다. 데이트 코스로 추천해요!"
                    ) %>

                </p>


                <div class="review-all-actions">

                    <button type="button"
                            class="like-toggle-btn"
                            onclick="toggleLikeBtn(this)">

                        🤍
                        <span>17</span>

                    </button>

                </div>


            </div>

        </div>



        <!-- 리뷰 4 -->
        <div class="review-all-item">


            <div class="review-all-body"
                 style="margin-left:0;">


                <div class="review-all-top">

                    <div class="review-all-rating">
                        ⭐⭐⭐⭐☆
                        <span>4.5</span>
                    </div>

                    <span class="review-all-date">
                        2026.08.20
                    </span>

                </div>


                <p class="review-all-author">

                    <%= messages.getProperty(
                        "review.all.author4",
                        "최○○"
                    ) %>

                </p>


                <p class="review-all-text">

                    <%= messages.getProperty(
                        "review.all.text4",
                        "재방문 의사 있습니다! 가격 대비 만족스러웠어요."
                    ) %>

                </p>


                <div class="review-all-actions">

                    <button type="button"
                            class="like-toggle-btn"
                            onclick="toggleLikeBtn(this)">

                        🤍
                        <span>5</span>

                    </button>

                </div>


            </div>

        </div>


    </div>



    <!-- 페이지네이션 -->
    <div class="review-pagination">

        <button type="button"
                class="page-btn active">
            1
        </button>

        <button type="button"
                class="page-btn">
            2
        </button>

        <button type="button"
                class="page-btn">
            3
        </button>

        <button type="button"
                class="page-btn">
            ›
        </button>

    </div>


</div>


<%@ include file="footer.jsp"%>



<script>

function selectSort(btn) {

    document
        .querySelectorAll('.sort-btn')
        .forEach(
            b => b.classList.remove('active')
        );

    btn.classList.add('active');
}


function toggleLikeBtn(btn) {

    const span =
        btn.querySelector('span');

    let count =
        parseInt(
            span.textContent,
            10
        );


    if (btn.classList.contains('liked')) {

        btn.classList.remove('liked');

        btn.innerHTML =
            '🤍 <span>'
            + (count - 1)
            + '</span>';

    } else {

        btn.classList.add('liked');

        btn.innerHTML =
            '❤️ <span>'
            + (count + 1)
            + '</span>';

    }
}

</script>


</body>

</html>