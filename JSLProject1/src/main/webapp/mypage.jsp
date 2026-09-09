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
        "mypage.title",
        "TripStamp - 마이페이지"
    ) %>
</title>

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/mypage.css">

</head>

<body>

    <%@ include file="header.jsp"%>


    <main class="mypage-main">

        <div class="mypage-container">


            <!-- ==============================
                 제목
            =============================== -->

            <div class="mypage-title">

                <h1>
                    <%= messages.getProperty(
                        "mypage.heading",
                        "마이페이지"
                    ) %>
                </h1>

                <p>
                    <%= messages.getProperty(
                        "mypage.subtitle",
                        "내 정보와 찜한 가게, 예약 내역을 확인해보세요"
                    ) %>
                </p>

            </div>



            <!-- ==============================
                 내 정보
            =============================== -->

            <section class="mypage-section">

                <div class="section-header">

                    <h2>
                        <%= messages.getProperty(
                            "mypage.profile.title",
                            "내 정보"
                        ) %>
                    </h2>

                </div>


                <div class="profile-card">


                    <!-- 닉네임 -->
                    <div class="profile-row">

                        <span class="profile-label">

                            <%= messages.getProperty(
                                "mypage.nickname",
                                "닉네임"
                            ) %>

                        </span>


                        <span class="profile-value">
                            ${sessionScope.loginUser.nickname}
                        </span>


                        <div class="profile-actions">

                            <button type="button"
                                    class="small-btn">

                                <%= messages.getProperty(
                                    "mypage.check.duplicate",
                                    "중복확인"
                                ) %>

                            </button>


                            <button type="button"
                                    class="small-btn">

                                <%= messages.getProperty(
                                    "mypage.confirm.change",
                                    "변경확인"
                                ) %>

                            </button>

                        </div>

                    </div>



                    <!-- 이메일 -->
                    <div class="profile-row">

                        <span class="profile-label">

                            <%= messages.getProperty(
                                "mypage.email",
                                "이메일"
                            ) %>

                        </span>


                        <span class="profile-value">
                            ${sessionScope.loginUser.email}
                        </span>


                        <div class="profile-actions">

                            <button type="button"
                                    class="small-btn">

                                <%= messages.getProperty(
                                    "mypage.check.duplicate",
                                    "중복확인"
                                ) %>

                            </button>


                            <button type="button"
                                    class="small-btn">

                                <%= messages.getProperty(
                                    "mypage.confirm.change",
                                    "변경확인"
                                ) %>

                            </button>

                        </div>

                    </div>


                </div>

            </section>



            <!-- ==============================
                 찜한 가게
            =============================== -->

            <section class="mypage-section">

                <div class="section-header">

                    <h2>
                        <%= messages.getProperty(
                            "mypage.favorite.title",
                            "찜한 가게"
                        ) %>
                    </h2>


                    <a href="${pageContext.request.contextPath}/route/myroute.do?lang=<%= lang %>"
                       class="section-more">

                        <%= messages.getProperty(
                            "mypage.myroute",
                            "마이 루트"
                        ) %>

                    </a>

                </div>



                <div class="favorite-grid">


                    <!-- 교토 라멘집 -->
                    <a href="#"
                       class="favorite-card">

                        <div class="favorite-image">
                            🍜
                        </div>


                        <div class="favorite-info">

                            <h3>
                                <%= messages.getProperty(
                                    "mypage.place1.name",
                                    "교토 라멘집"
                                ) %>
                            </h3>

                            <p>
                                <%= messages.getProperty(
                                    "mypage.place1.location",
                                    "일본 교토"
                                ) %>
                            </p>

                            <span>
                                ★ 4.5
                            </span>

                        </div>

                    </a>



                    <!-- 도쿄 스시야 -->
                    <a href="#"
                       class="favorite-card">

                        <div class="favorite-image">
                            🍣
                        </div>


                        <div class="favorite-info">

                            <h3>
                                <%= messages.getProperty(
                                    "mypage.place2.name",
                                    "도쿄 스시야"
                                ) %>
                            </h3>

                            <p>
                                <%= messages.getProperty(
                                    "mypage.place2.location",
                                    "일본 도쿄"
                                ) %>
                            </p>

                            <span>
                                ★ 4.8
                            </span>

                        </div>

                    </a>



                    <!-- 서울 카페 -->
                    <a href="#"
                       class="favorite-card">

                        <div class="favorite-image">
                            ☕
                        </div>


                        <div class="favorite-info">

                            <h3>
                                <%= messages.getProperty(
                                    "mypage.place3.name",
                                    "서울 카페"
                                ) %>
                            </h3>

                            <p>
                                <%= messages.getProperty(
                                    "mypage.place3.location",
                                    "대한민국 서울"
                                ) %>
                            </p>

                            <span>
                                ★ 4.2
                            </span>

                        </div>

                    </a>


                </div>


                <%--
                찜한 가게가 없을 때 사용할 문구

                <p style="color:#999; font-size:13px;">
                    <%= messages.getProperty(
                        "mypage.favorite.empty",
                        "아직 찜한 가게가 없습니다."
                    ) %>
                </p>
                --%>

            </section>



            <!-- ==============================
                 예약 내역
            =============================== -->

            <section class="mypage-section">

                <div class="section-header">

                    <h2>
                        <%= messages.getProperty(
                            "mypage.reservation.title",
                            "예약 내역"
                        ) %>
                    </h2>

                </div>


                <div class="reservation-list">


                    <!-- 예약 1 -->
                    <div class="reservation-item">

                        <div class="reservation-icon">
                            🍣
                        </div>


                        <div class="reservation-content">

                            <h3>
                                <%= messages.getProperty(
                                    "mypage.place2.name",
                                    "도쿄 스시야"
                                ) %>
                            </h3>

                            <p>
                                2026.09.07 ·
                                <%= messages.getProperty(
                                    "mypage.time.pm",
                                    "오후"
                                ) %>
                                6:30 ·
                                2<%= messages.getProperty(
                                    "mypage.people.unit",
                                    "명"
                                ) %>
                            </p>

                        </div>


                        <span class="reservation-status upcoming">

                            <%= messages.getProperty(
                                "mypage.reservation.confirmed",
                                "예약 확정"
                            ) %>

                        </span>

                    </div>



                    <!-- 예약 2 -->
                    <div class="reservation-item">

                        <div class="reservation-icon">
                            ☕
                        </div>


                        <div class="reservation-content">

                            <h3>
                                <%= messages.getProperty(
                                    "mypage.place3.name",
                                    "서울 카페"
                                ) %>
                            </h3>

                            <p>
                                2026.09.03 ·
                                <%= messages.getProperty(
                                    "mypage.time.pm",
                                    "오후"
                                ) %>
                                2:00 ·
                                4<%= messages.getProperty(
                                    "mypage.people.unit",
                                    "명"
                                ) %>
                            </p>

                        </div>


                        <span class="reservation-status complete">

                            <%= messages.getProperty(
                                "mypage.reservation.completed",
                                "방문 완료"
                            ) %>

                        </span>

                    </div>



                    <!-- 예약 3 -->
                    <div class="reservation-item">

                        <div class="reservation-icon">
                            🍜
                        </div>


                        <div class="reservation-content">

                            <h3>
                                <%= messages.getProperty(
                                    "mypage.place1.name",
                                    "교토 라멘집"
                                ) %>
                            </h3>

                            <p>
                                2026.08.28 ·
                                <%= messages.getProperty(
                                    "mypage.time.pm",
                                    "오후"
                                ) %>
                                7:00 ·
                                1<%= messages.getProperty(
                                    "mypage.people.unit",
                                    "명"
                                ) %>
                            </p>

                        </div>


                        <span class="reservation-status complete">

                            <%= messages.getProperty(
                                "mypage.reservation.completed",
                                "방문 완료"
                            ) %>

                        </span>

                    </div>


                </div>


                <%--
                예약 내역이 없을 때 사용할 문구

                <p style="color:#999; font-size:13px;">
                    <%= messages.getProperty(
                        "mypage.reservation.empty",
                        "예약 내역이 없습니다."
                    ) %>
                </p>
                --%>

            </section>



            <!-- ==============================
                 하단 버튼
            =============================== -->

            <div class="mypage-actions">


                <a href="${pageContext.request.contextPath}/main.do?lang=<%= lang %>"
                   class="main-btn">

                    <%= messages.getProperty(
                        "mypage.back.main",
                        "메인으로"
                    ) %>

                </a>


                <button type="button"
                        class="withdraw-btn">

                    <%= messages.getProperty(
                        "mypage.withdraw",
                        "회원 탈퇴"
                    ) %>

                </button>


            </div>


        </div>

    </main>


    <%@ include file="footer.jsp"%>


</body>

</html>