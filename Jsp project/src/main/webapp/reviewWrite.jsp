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


<!-- 로그인 안 된 경우 -->
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
        "review.write.title",
        "TripStamp - 리뷰 작성"
    ) %>
</title>

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/reviewWrite.css">

</head>


<body>

<%@ include file="header.jsp"%>


<div class="review-write-page">


    <h1 class="write-title">

        <%= messages.getProperty(
            "review.write.heading",
            "리뷰 작성"
        ) %>

    </h1>


    <c:if test="${not empty place}">

        <p class="write-place-name">
            ${place.name}
        </p>

    </c:if>



    <!-- 별점 -->
    <div class="write-section">

        <h3>

            <%= messages.getProperty(
                "review.write.rating",
                "별점"
            ) %>

        </h3>


        <div class="star-select"
             id="starSelect">

            <span class="star" data-value="1">☆</span>
            <span class="star" data-value="2">☆</span>
            <span class="star" data-value="3">☆</span>
            <span class="star" data-value="4">☆</span>
            <span class="star" data-value="5">☆</span>


            <span class="star-value"
                  id="starValue">

                <%= messages.getProperty(
                    "review.write.rating.select",
                    "별점을 선택해주세요"
                ) %>

            </span>

        </div>

    </div>



    <!-- 리뷰 내용 -->
    <div class="write-section">

        <h3>

            <%= messages.getProperty(
                "review.write.content",
                "리뷰 내용"
            ) %>

        </h3>


        <textarea
            class="write-textarea"
            id="reviewText"
            placeholder="<%= messages.getProperty(
                "review.write.placeholder",
                "방문하신 곳에 대한 솔직한 후기를 남겨주세요."
            ) %>"></textarea>

    </div>



    <!-- 사진 첨부 -->
    <div class="write-section">

        <h3>

            <%= messages.getProperty(
                "review.write.photo",
                "사진 첨부"
            ) %>

        </h3>


        <label class="photo-add-btn"
               for="photoInput">

            📷
            <%= messages.getProperty(
                "review.write.photo.add",
                "사진 추가"
            ) %>

        </label>


        <input
            type="file"
            id="photoInput"
            accept="image/*"
            multiple
            style="display:none;">


        <div class="photo-preview-list"
             id="photoPreviewList">
        </div>

    </div>



    <!-- 버튼 -->
    <div class="write-actions">


        <a href="${pageContext.request.contextPath}/place/view.do?id=${place.id}&lang=<%= lang %>"
           class="write-cancel-btn">

            <%= messages.getProperty(
                "review.write.cancel",
                "취소"
            ) %>

        </a>


        <button
            type="button"
            class="write-submit-btn"
            id="submitBtn">

            <%= messages.getProperty(
                "review.write.submit",
                "등록하기"
            ) %>

        </button>


    </div>


</div>


<%@ include file="footer.jsp"%>



<script>

let selectedRating = 0;

const stars =
    document.querySelectorAll(
        '#starSelect .star'
    );

const starValue =
    document.getElementById(
        'starValue'
    );



/* 별점 선택 */
stars.forEach(
    function(star) {

        star.addEventListener(
            'click',
            function() {

                selectedRating =
                    parseInt(
                        star.dataset.value,
                        10
                    );

                updateStars();

                starValue.textContent =
                    selectedRating
                    + '<%= messages.getProperty(
                        "review.write.rating.unit",
                        ".0점"
                    ) %>';

            }
        );

    }
);



function updateStars() {

    stars.forEach(
        function(star) {

            const value =
                parseInt(
                    star.dataset.value,
                    10
                );

            star.textContent =
                value <= selectedRating
                ? '★'
                : '☆';

            star.classList.toggle(
                'selected',
                value <= selectedRating
            );

        }
    );

}



/* 사진 미리보기 */
const photoInput =
    document.getElementById(
        'photoInput'
    );

const photoPreviewList =
    document.getElementById(
        'photoPreviewList'
    );


photoInput.addEventListener(
    'change',
    function() {

        photoPreviewList.innerHTML =
            '';

        Array
            .from(photoInput.files)
            .forEach(
                function(file) {

                    const reader =
                        new FileReader();

                    reader.onload =
                        function(e) {

                            const box =
                                document.createElement(
                                    'div'
                                );

                            box.className =
                                'photo-preview-box';

                            box.style.backgroundImage =
                                'url('
                                + e.target.result
                                + ')';

                            photoPreviewList
                                .appendChild(box);

                        };

                    reader.readAsDataURL(
                        file
                    );

                }
            );

    }
);



/* 등록하기 */
document
    .getElementById('submitBtn')
    .addEventListener(
        'click',
        function() {


            if (selectedRating === 0) {

                alert(
                    '<%= messages.getProperty(
                        "review.write.alert.rating",
                        "별점을 선택해주세요."
                    ) %>'
                );

                return;

            }


            if (
                document
                    .getElementById(
                        'reviewText'
                    )
                    .value
                    .trim()
                === ''
            ) {

                alert(
                    '<%= messages.getProperty(
                        "review.write.alert.content",
                        "리뷰 내용을 입력해주세요."
                    ) %>'
                );

                return;

            }


            alert(
                '<%= messages.getProperty(
                    "review.write.alert.preparing",
                    "리뷰 등록 기능은 준비 중입니다."
                ) %>'
            );

        }
    );

</script>


</body>

</html>