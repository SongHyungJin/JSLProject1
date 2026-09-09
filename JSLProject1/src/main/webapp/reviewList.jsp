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
        "review.list.title",
        "TripStamp - 방문자 리뷰"
    ) %>
</title>

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/review.css">

</head>

<body>

<%@ include file="header.jsp"%>


<div class="review-page">


    <c:if test="${not empty place}">

        <p class="review-place-name">
            ${place.name}
        </p>

    </c:if>


    <div class="review-header">


        <h2>

            <%= messages.getProperty(
                "review.list.heading",
                "방문자 리뷰"
            ) %>

        </h2>


        <div class="review-meta">


            <span class="review-count">

                <%= messages.getProperty(
                    "review.list.count",
                    "리뷰 128개"
                ) %>

            </span>


            <a href="${pageContext.request.contextPath}/review/all.do?id=${place.id}&lang=<%= lang %>"
               class="review-all-link">

                <%= messages.getProperty(
                    "review.list.all",
                    "전체보기"
                ) %>
                &gt;

            </a>


        </div>

    </div>



    <div class="review-slider-wrapper">


        <button type="button"
                class="review-nav prev"
                onclick="moveReview(-1)">
            ‹
        </button>


        <div class="review-track"
             id="reviewTrack">


            <!-- 리뷰 1 -->
            <div class="review-card">

                <div class="review-photo">
                    📷
                </div>

                <div class="review-body">

                    <div class="review-rating">
                        ⭐⭐⭐⭐⭐
                        <span>5.0</span>
                    </div>

                    <p class="review-author">
                        <%= messages.getProperty(
                            "review.list.author1",
                            "김○○"
                        ) %>
                    </p>

                    <p class="review-text">

                        "<%= messages.getProperty(
                            "review.list.text1",
                            "음식도 맛있고 분위기도 좋아요"
                        ) %>"

                    </p>

                    <div class="review-like">
                        ❤️ 24
                    </div>

                </div>

            </div>



            <!-- 리뷰 2 -->
            <div class="review-card">

                <div class="review-photo">
                    📷
                </div>

                <div class="review-body">

                    <div class="review-rating">
                        ⭐⭐⭐⭐☆
                        <span>4.0</span>
                    </div>

                    <p class="review-author">
                        <%= messages.getProperty(
                            "review.list.author2",
                            "이○○"
                        ) %>
                    </p>

                    <p class="review-text">

                        "<%= messages.getProperty(
                            "review.list.text2",
                            "여행 중 들렀는데 만족했습니다."
                        ) %>"

                    </p>

                    <div class="review-like">
                        ❤️ 8
                    </div>

                </div>

            </div>



            <!-- 리뷰 3 -->
            <div class="review-card">

                <div class="review-photo">
                    📷
                </div>

                <div class="review-body">

                    <div class="review-rating">
                        ⭐⭐⭐⭐⭐
                        <span>5.0</span>
                    </div>

                    <p class="review-author">
                        <%= messages.getProperty(
                            "review.list.author3",
                            "박○○"
                        ) %>
                    </p>

                    <p class="review-text">

                        "<%= messages.getProperty(
                            "review.list.text3",
                            "분위기가 정말 좋았습니다."
                        ) %>"

                    </p>

                    <div class="review-like">
                        ❤️ 17
                    </div>

                </div>

            </div>



            <!-- 리뷰 4 -->
            <div class="review-card">

                <div class="review-photo">
                    📷
                </div>

                <div class="review-body">

                    <div class="review-rating">
                        ⭐⭐⭐⭐☆
                        <span>4.5</span>
                    </div>

                    <p class="review-author">
                        <%= messages.getProperty(
                            "review.list.author4",
                            "최○○"
                        ) %>
                    </p>

                    <p class="review-text">

                        "<%= messages.getProperty(
                            "review.list.text4",
                            "재방문 의사 있습니다!"
                        ) %>"

                    </p>

                    <div class="review-like">
                        ❤️ 5
                    </div>

                </div>

            </div>



            <!-- 리뷰 5 -->
            <div class="review-card">

                <div class="review-photo">
                    📷
                </div>

                <div class="review-body">

                    <div class="review-rating">
                        ⭐⭐⭐⭐⭐
                        <span>5.0</span>
                    </div>

                    <p class="review-author">
                        <%= messages.getProperty(
                            "review.list.author5",
                            "정○○"
                        ) %>
                    </p>

                    <p class="review-text">

                        "<%= messages.getProperty(
                            "review.list.text5",
                            "직원분들이 친절했어요."
                        ) %>"

                    </p>

                    <div class="review-like">
                        ❤️ 12
                    </div>

                </div>

            </div>


        </div>


        <button type="button"
                class="review-nav next"
                onclick="moveReview(1)">
            ›
        </button>


    </div>


</div>


<%@ include file="footer.jsp"%>


<script>

const REVIEW_STEP = 250;

function moveReview(direction) {

    const track =
        document.getElementById(
            'reviewTrack'
        );

    if (!track) {
        return;
    }

    track.scrollBy({
        left: direction * REVIEW_STEP,
        behavior: 'smooth'
    });
}

</script>


</body>

</html>