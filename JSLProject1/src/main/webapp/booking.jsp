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

<%--
  booking.jsp (예약 화면)

  place 는 컨트롤러가 담아서 forward
  로그인하지 않은 사용자는 로그인 화면으로 이동
  reservable=0이면 예약 폼 표시 안 함
--%>


<!-- 로그인 확인 -->
<c:if test="${empty sessionScope.loginUser}">

    <c:redirect url="/log/login.do">
        <c:param name="lang" value="<%= lang %>"/>
    </c:redirect>

</c:if>


<!DOCTYPE html>

<html lang="<%= lang %>">

<head>

<meta charset="UTF-8">

<title>
    <%= messages.getProperty(
        "booking.title",
        "TripStamp - 예약하기"
    ) %>
</title>


<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/booking.css">


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>


<body>


    <%@ include file="header.jsp"%>


    <!-- =================================================
         예약 불가능한 가게
    ================================================== -->

    <c:if test="${not empty place and place.reservable == 0}">

        <div class="reservation-page">

            <p style="text-align:center; color:#999; padding:80px 0;">

                <%= messages.getProperty(
                    "booking.unavailable.message",
                    "이 가게는 예약을 받지 않는 곳입니다."
                ) %>

            </p>

        </div>

    </c:if>



    <!-- =================================================
         예약 가능한 가게
    ================================================== -->

    <c:if test="${not empty place and place.reservable == 1}">


        <div class="reservation-page">


            <!-- 제목 -->

            <div class="reservation-header">

                <h1>
                    <%= messages.getProperty(
                        "booking.header",
                        "식당 예약"
                    ) %>
                </h1>

            </div>



            <!-- =================================================
                 가게 정보
            ================================================== -->

            <div class="store-section">


                <div class="store-image"
                    style="background-image:url('${place.imageUrl}');
                           background-size:cover;
                           background-position:center;">


                    <c:if test="${empty place.imageUrl}">

                        <%= messages.getProperty(
                            "view.photo.none",
                            "사진 정보 없음"
                        ) %>

                    </c:if>


                </div>



                <div class="store-info">


                    <h2>
                        ${place.name}
                    </h2>


                    <div class="store-meta">


                        <span class="rating">
                            ★ ${place.avgRating}
                        </span>


                        <span class="dot">
                            ·
                        </span>


                        <!-- 카테고리 다국어 -->

                        <c:choose>


                            <c:when test="${place.category == 'RESTAURANT'
                                || place.category == 'restaurant'
                                || place.category == '식당'}">

                                <%= messages.getProperty(
                                    "category.restaurant",
                                    "식당"
                                ) %>

                            </c:when>


                            <c:when test="${place.category == 'CAFE'
                                || place.category == 'cafe'
                                || place.category == '카페'}">

                                <%= messages.getProperty(
                                    "category.cafe",
                                    "카페"
                                ) %>

                            </c:when>


                            <c:when test="${place.category == 'SHOP'
                                || place.category == 'shop'
                                || place.category == '상점'}">

                                <%= messages.getProperty(
                                    "category.shop",
                                    "상점"
                                ) %>

                            </c:when>


                            <c:when test="${place.category == 'ATTRACTION'
                                || place.category == 'attraction'
                                || place.category == '관광지'}">

                                <%= messages.getProperty(
                                    "category.attraction",
                                    "관광지"
                                ) %>

                            </c:when>


                            <c:when test="${not empty place.category}">

                                ${place.category}

                            </c:when>


                            <c:otherwise>

                                <span class="no-data">

                                    <%= messages.getProperty(
                                        "view.category.none",
                                        "카테고리 정보 없음"
                                    ) %>

                                </span>

                            </c:otherwise>


                        </c:choose>


                    </div>



                    <!-- 지역 -->

                    <p class="store-address">

                        📍

                        <c:choose>


                            <c:when test="${not empty place.region}">

                                ${place.region}

                            </c:when>


                            <c:otherwise>

                                <span class="no-data">

                                    <%= messages.getProperty(
                                        "view.region.none",
                                        "지역 정보 없음"
                                    ) %>

                                </span>

                            </c:otherwise>


                        </c:choose>

                    </p>


                </div>


            </div>



            <!-- =================================================
                 방문 날짜
            ================================================== -->

            <div class="reservation-section">


                <h3>

                    <%= messages.getProperty(
                        "booking.visit.date",
                        "방문 날짜"
                    ) %>

                </h3>


                <div class="date-options"
                     id="dateList">

                </div>


            </div>



            <!-- =================================================
                 인원
            ================================================== -->

            <div class="reservation-section">


                <h3>

                    <%= messages.getProperty(
                        "booking.people",
                        "인원"
                    ) %>

                </h3>


                <div class="people-selector">


                    <button type="button"
                            class="people-button"
                            id="countMinus">
                        −
                    </button>


                    <span class="people-count"
                          id="countValue">

                        2<%= messages.getProperty(
                            "booking.people.unit",
                            "명"
                        ) %>

                    </span>


                    <button type="button"
                            class="people-button"
                            id="countPlus">
                        ＋
                    </button>


                </div>


            </div>



            <!-- =================================================
                 예약 가능한 시간
            ================================================== -->

            <div class="reservation-section">


                <h3>

                    <%= messages.getProperty(
                        "booking.available.time",
                        "예약 가능한 시간"
                    ) %>

                </h3>


                <div class="time-options"
                     id="timeGrid">

                </div>


            </div>



            <!-- =================================================
                 요청사항
            ================================================== -->

            <div class="reservation-section">


                <h3>

                    <%= messages.getProperty(
                        "booking.request",
                        "요청사항"
                    ) %>

                </h3>


                <textarea
                    class="request-textarea"
                    id="noteInput"
                    placeholder="<%= messages.getProperty(
                        "booking.request.placeholder",
                        "특별히 요청하실 사항이 있다면 입력해주세요."
                    ) %>"></textarea>


            </div>



            <!-- =================================================
                 예약 정보 요약
            ================================================== -->

            <div class="reservation-summary">


                <h3>

                    <%= messages.getProperty(
                        "booking.summary.title",
                        "예약 정보"
                    ) %>

                </h3>



                <div class="summary-row">


                    <span>

                        <%= messages.getProperty(
                            "booking.summary.date",
                            "날짜"
                        ) %>

                    </span>


                    <strong id="summaryDate">

                        <%= messages.getProperty(
                            "booking.not.selected",
                            "선택 전"
                        ) %>

                    </strong>


                </div>



                <div class="summary-row">


                    <span>

                        <%= messages.getProperty(
                            "booking.summary.time",
                            "시간"
                        ) %>

                    </span>


                    <strong id="summaryTime">

                        <%= messages.getProperty(
                            "booking.not.selected",
                            "선택 전"
                        ) %>

                    </strong>


                </div>



                <div class="summary-row">


                    <span>

                        <%= messages.getProperty(
                            "booking.summary.people",
                            "인원"
                        ) %>

                    </span>


                    <strong id="summaryCount">

                        2<%= messages.getProperty(
                            "booking.people.unit",
                            "명"
                        ) %>

                    </strong>


                </div>



                <button type="button"
                        class="reservation-submit"
                        id="submitBtn">

                    <%= messages.getProperty(
                        "booking.submit",
                        "예약하기"
                    ) %>

                </button>


            </div>



            <!-- =================================================
                 상세페이지로 돌아가기
            ================================================== -->

            <div class="back-area">


                <a href="${pageContext.request.contextPath}/place/view.do?id=${place.id}&lang=<%= lang %>"
                   class="back-link">

                    ←

                    <%= messages.getProperty(
                        "booking.back",
                        "가게 정보로 돌아가기"
                    ) %>

                </a>


            </div>


        </div>


    </c:if>



    <!-- =================================================
         가게 정보 없음
    ================================================== -->

    <c:if test="${empty place}">


        <div class="reservation-page">


            <p style="text-align:center; color:#999; padding:80px 0;">

                <%= messages.getProperty(
                    "view.place.notfound",
                    "가게 정보를 찾을 수 없습니다."
                ) %>

            </p>


        </div>


    </c:if>



    <%@ include file="footer.jsp"%>



<script>


    /* =================================================
       서버 / 언어 정보
    ================================================== */

    const placeId = "${place.id}";

    const currentLang = "<%= lang %>";


    let selectedDate = null;

    let selectedTime = null;

    let peopleCount = 2;



    /* =================================================
       다국어 JavaScript 문구
    ================================================== */

    const textPeopleUnit =
        '<%= messages.getProperty(
            "booking.people.unit",
            "명"
        ) %>';


    const textNotSelected =
        '<%= messages.getProperty(
            "booking.not.selected",
            "선택 전"
        ) %>';


    const textMonth =
        '<%= messages.getProperty(
            "booking.date.month",
            "월"
        ) %>';


    const textDay =
        '<%= messages.getProperty(
            "booking.date.day",
            "일"
        ) %>';


    const textAM =
        '<%= messages.getProperty(
            "booking.time.am",
            "오전"
        ) %>';


    const textPM =
        '<%= messages.getProperty(
            "booking.time.pm",
            "오후"
        ) %>';



    /* =================================================
       1. 방문 날짜
       오늘부터 5일
    ================================================== */

    function pad(n) {

        return n < 10
            ? '0' + n
            : '' + n;

    }



    function buildDateList() {


        const dateList =
            document.getElementById('dateList');


        if (!dateList) {
            return;
        }


        const today =
            new Date();



        for (let i = 0; i < 5; i++) {


            const d =
                new Date();


            d.setDate(
                today.getDate() + i
            );


            const yyyy =
                d.getFullYear();


            const mm =
                pad(d.getMonth() + 1);


            const dd =
                pad(d.getDate());


            const isoDate =
                yyyy + '-' + mm + '-' + dd;



            let label;


            /*
             * 날짜 버튼 표시
             *
             * 한국어 : 9/8
             * 영어   : 9/8
             * 일본어 : 9/8
             */

            label =
                (d.getMonth() + 1)
                + '/'
                + d.getDate();



            const btn =
                document.createElement('button');


            btn.type =
                'button';


            btn.className =
                'date-button';


            btn.textContent =
                label;


            btn.dataset.date =
                isoDate;


            btn.dataset.month =
                d.getMonth() + 1;


            btn.dataset.day =
                d.getDate();



            btn.addEventListener(
                'click',
                function() {


                    document
                        .querySelectorAll('.date-button')
                        .forEach(
                            c => c.classList.remove('active')
                        );


                    btn.classList.add('active');


                    selectedDate =
                        isoDate;



                    /*
                     * 예약정보 날짜 표시
                     */

                    if (currentLang === 'en') {


                        document.getElementById(
                            'summaryDate'
                        ).textContent =
                            btn.dataset.month
                            + '/'
                            + btn.dataset.day;


                    } else {


                        document.getElementById(
                            'summaryDate'
                        ).textContent =
                            btn.dataset.month
                            + textMonth
                            + ' '
                            + btn.dataset.day
                            + textDay;

                    }


                }
            );


            dateList.appendChild(btn);


        }

    }



    /* =================================================
       2. 인원 + / -
    ================================================== */

    function updateCountView() {


        const peopleText =
            peopleCount
            + textPeopleUnit;


        document.getElementById(
            'countValue'
        ).textContent =
            peopleText;


        document.getElementById(
            'summaryCount'
        ).textContent =
            peopleText;


    }



    const countMinusBtn =
        document.getElementById(
            'countMinus'
        );


    const countPlusBtn =
        document.getElementById(
            'countPlus'
        );



    if (countMinusBtn) {


        countMinusBtn.addEventListener(
            'click',
            function() {


                if (peopleCount > 1) {


                    peopleCount--;


                    updateCountView();


                }


            }
        );


    }



    if (countPlusBtn) {


        countPlusBtn.addEventListener(
            'click',
            function() {


                if (peopleCount < 20) {


                    peopleCount++;


                    updateCountView();


                }


            }
        );


    }



    /* =================================================
       3. 예약 가능한 시간
    ================================================== */

    const timeSlots = [

        '17:00',
        '17:30',
        '18:00',
        '18:30',
        '19:00',
        '19:30',
        '20:00',
        '20:30'

    ];



    function formatTime(t) {


        /*
         * 영어는 PM 5:00
         * 한국어는 오후 5:00
         * 일본어는 오후 5:00 대신 17:00 그대로 보여주는 방식
         */

        if (currentLang === 'ja') {

            return t;

        }


        const parts =
            t.split(':');


        let hour =
            parseInt(
                parts[0],
                10
            );


        const minute =
            parts[1];


        const period =
            hour < 12
                ? textAM
                : textPM;


        if (hour > 12) {

            hour -= 12;

        }


        if (currentLang === 'en') {

            return period
                + ' '
                + hour
                + ':'
                + minute;

        }


        return period
            + ' '
            + hour
            + ':'
            + minute;

    }



    function buildTimeGrid() {


        const timeGrid =
            document.getElementById(
                'timeGrid'
            );


        if (!timeGrid) {
            return;
        }



        timeSlots.forEach(
            function(t) {


                const btn =
                    document.createElement(
                        'button'
                    );


                btn.type =
                    'button';


                btn.className =
                    'time-button';


                btn.textContent =
                    t;



                btn.addEventListener(
                    'click',
                    function() {


                        document
                            .querySelectorAll(
                                '.time-button'
                            )
                            .forEach(
                                c =>
                                    c.classList.remove(
                                        'active'
                                    )
                            );


                        btn.classList.add(
                            'active'
                        );


                        selectedTime =
                            t;


                        document.getElementById(
                            'summaryTime'
                        ).textContent =
                            formatTime(t);


                    }
                );


                timeGrid.appendChild(btn);


            }
        );


    }



    /* =================================================
       4. 예약 폼 초기화
    ================================================== */

    function resetForm() {


        selectedDate =
            null;


        selectedTime =
            null;


        peopleCount =
            2;



        document
            .querySelectorAll(
                '.date-button'
            )
            .forEach(
                c =>
                    c.classList.remove(
                        'active'
                    )
            );



        document
            .querySelectorAll(
                '.time-button'
            )
            .forEach(
                c =>
                    c.classList.remove(
                        'active'
                    )
            );



        const noteInput =
            document.getElementById(
                'noteInput'
            );


        if (noteInput) {

            noteInput.value =
                '';

        }



        document.getElementById(
            'summaryDate'
        ).textContent =
            textNotSelected;



        document.getElementById(
            'summaryTime'
        ).textContent =
            textNotSelected;



        updateCountView();


    }



    /* =================================================
       5. 예약하기 버튼
    ================================================== */

    const submitBtn =
        document.getElementById(
            'submitBtn'
        );



    if (submitBtn) {


        submitBtn.addEventListener(
            'click',
            function() {


                /*
                 * 날짜 / 시간 선택 검사
                 */

                if (
                    !selectedDate
                    ||
                    !selectedTime
                ) {


                    alert(
                        '<%= messages.getProperty(
                            "booking.alert.select",
                            "날짜와 시간을 선택해주세요."
                        ) %>'
                    );


                    return;

                }



                const note =
                    document.getElementById(
                        'noteInput'
                    ).value;



                $.ajax({


                    url:
                        "${pageContext.request.contextPath}/place/bookingpro.do",


                    type:
                        "post",


                    data: {


                        id:
                            placeId,


                        date:
                            selectedDate,


                        time:
                            selectedTime,


                        count:
                            peopleCount,


                        note:
                            note,


                        lang:
                            currentLang


                    },


                    dataType:
                        "text",



                    success:
                        function(result) {


                            if (
                                result ===
                                "success"
                            ) {


                                alert(
                                    '<%= messages.getProperty(
                                        "booking.alert.success",
                                        "예약이 완료되었습니다."
                                    ) %>'
                                );


                                /*
                                 * 예약 완료 후에도
                                 * 현재 언어 유지
                                 */

                                location.href =
                                    "${pageContext.request.contextPath}/main.do?lang=<%= lang %>";


                            } else {


                                alert(
                                    '<%= messages.getProperty(
                                        "booking.alert.fail",
                                        "예약에 실패했습니다. 다시 시도해주세요."
                                    ) %>'
                                );


                                resetForm();


                            }


                        },



                    error:
                        function() {


                            alert(
                                '<%= messages.getProperty(
                                    "booking.alert.server",
                                    "서버 오류가 발생했습니다."
                                ) %>'
                            );


                            resetForm();


                        }


                });


            }
        );


    }



    /* =================================================
       초기화
    ================================================== */

    buildDateList();

    buildTimeGrid();

    updateCountView();


</script>


</body>

</html>