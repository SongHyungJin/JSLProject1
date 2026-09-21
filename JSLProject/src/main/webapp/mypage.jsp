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

<title><%=messages.getProperty("mypage.title", "TripStamp - 마이페이지")%></title>

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
					<%=messages.getProperty("mypage.heading", "마이페이지")%>
				</h1>

				<p>
					<%=messages.getProperty("mypage.subtitle", "내 정보와 찜한 가게, 예약 내역을 확인해보세요")%>
				</p>

			</div>



			<!-- ==============================
                 내 정보
            =============================== -->

			<section class="mypage-section">

				<div class="section-header">

					<h2>
						<%=messages.getProperty("mypage.profile.title", "내 정보")%>
					</h2>

				</div>


				<div class="profile-card">


					<!-- 닉네임 -->
					<div class="profile-row">

						<span class="profile-label"> <%=messages.getProperty("mypage.nickname", "닉네임")%>
						</span>

						<div class="profile-value" id="nicknameArea">

							<span id="nicknameText"> ${requestScope.profile.nickname}
							</span> <input type="text" id="nicknameInput" name="nickname"
								value="${requestScope.profile.nickname}" style="display: none;">

						</div>

					</div>



					<!-- 이메일 -->
					<div class="profile-row">

						<span class="profile-label"> <%=messages.getProperty("mypage.email", "이메일")%>

						</span> <span class="profile-value"> ${requestScope.profile.email}
						</span>




					</div>

					<div class="profile-edit-actions">

						<button type="button" class="small-btn" id="nicknameBtn">

							<%=messages.getProperty("mypage.nickname.change", "닉네임 변경")%>

						</button>

						<button type="button" class="small-btn" id="passwordBtn">

							<%=messages.getProperty("mypage.password.change", "비밀번호 변경")%>

						</button>

					</div>
					<div class="password-update-area" id="passwordUpdateArea"
						style="display: none;">

						<div class="password-row profile-row">

							<span class="password-label"> <%=messages.getProperty("mypage.password.current", "현재 비밀번호")%>
							</span>

							<div class="profile-value password-value">
								<input type="password" id="currentPassword">
							</div>

						</div>


						<div class="password-row profile-row">

							<span class="password-label"> <%=messages.getProperty("mypage.password.new", "새 비밀번호")%>
							</span>

							<div class="profile-value password-value">
								<input type="password" id="newPassword">
							</div>

						</div>


						<div class="password-row profile-row">

							<span class="password-label"> <%=messages.getProperty("mypage.password.confirm", "새 비밀번호 확인")%>
							</span>

							<div class="profile-value password-value">

								<input type="password" id="confirmPassword"
									name="confirmPassword">

							</div>

						</div>


						<div class="password-actions">

							<button type="button" class="small-btn" id="passwordCancelBtn">

								<%=messages.getProperty("mypage.password.cancel", "취소")%>

							</button>

							<button type="button" class="small-btn" id="passwordSaveBtn">

								<%=messages.getProperty("mypage.password.save", "변경하기")%>

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
						<%=messages.getProperty("mypage.favorite.title", "찜한 가게")%>
					</h2>

					<a
						href="${pageContext.request.contextPath}/route/myroute.do?lang=<%= lang %>"
						class="section-more"> <%=messages.getProperty("mypage.myroute", "마이 루트")%>

					</a>

				</div>


				<div class="favorite-grid">

					<c:choose>

						<%-- 북마크가 있는 경우 --%>
						<c:when test="${not empty bookmarkList}">

							<c:forEach var="bookmark" items="${bookmarkList}">

								<a
									href="${pageContext.request.contextPath}/places/placesDetail.do?id=${bookmark.placesId}&lang=<%= lang %>"
									class="favorite-card" style="position:relative;">

									<div class="favorite-image">

										<c:choose>

											<c:when test="${not empty bookmark.imageUrl}">

												<img src="${bookmark.imageUrl}" alt="${bookmark.name}">

											</c:when>

											<c:otherwise>
                                    ☕
                                </c:otherwise>

										</c:choose>

									</div>


									<div class="favorite-info">

										<h3>${bookmark.name}</h3>

										<p>${bookmark.region}</p>

										<span> ★ ${bookmark.rating} </span>

									</div>

								<button type="button" class="favorite-delete" data-pid="${bookmark.placesId}" onclick="deleteBookmark(event, this)" title="찜 삭제" style="position:absolute; top:8px; right:8px; z-index:3; border:none; background:rgba(0,0,0,0.55); color:#fff; border-radius:50%; width:26px; height:26px; cursor:pointer; font-size:15px; line-height:24px; padding:0;">&times;</button>
								</a>

							</c:forEach>

						</c:when>


						<%-- 북마크가 없는 경우 --%>
						<c:otherwise>

							<p style="color: #999; font-size: 13px;">
								<%=messages.getProperty("mypage.favorite.empty", "아직 찜한 가게가 없습니다.")%>
							</p>

						</c:otherwise>

					</c:choose>

				</div>

			</section>



			<!-- ==============================
     예약 내역
=============================== -->

			<section class="mypage-section">

				<div class="section-header">

					<h2>
						<%=messages.getProperty("mypage.reservation.title", "예약 내역")%>
					</h2>

				</div>


				<div class="reservation-list">

					<c:forEach var="reservation" items="${reservationList}">

						<div class="reservation-item">

							<div class="reservation-icon">🍣</div>


							<div class="reservation-content">

								<h3>${reservation.place_name}</h3>


								<p>
									${reservation.reservation_date} · ${reservation.time_slot} ·
									${reservation.headcount}
									<%=messages.getProperty("mypage.people.unit", "명")%>
								</p>

							</div>


							<span class="reservation-status upcoming"> <c:choose>

									<c:when test="${reservation.status eq 'reserved'}">

										<%=messages.getProperty("mypage.reservation.confirmed", "예약 확정")%>

									</c:when>


									<c:when test="${reservation.status eq 'cancelled'}">

										<%=messages.getProperty("mypage.reservation.cancelled", "예약 취소")%>

									</c:when>


									<c:otherwise>

                            ${reservation.status}

                        </c:otherwise>

								</c:choose>

							</span>

						</div>

					</c:forEach>

				</div>


				<%--
        예약 내역이 없을 때 사용할 문구

        <p style="color:#999; font-size:13px;">

            <%=messages.getProperty(
                "mypage.reservation.empty",
                "예약 내역이 없습니다."
            )%>

        </p>
    --%>

			</section>



			<!-- ==============================
                 하단 버튼
            =============================== -->

			<div class="mypage-actions">


				<a
					href="${pageContext.request.contextPath}/main.do?lang=<%= lang %>"
					class="main-btn"> <%=messages.getProperty("mypage.back.main", "메인으로")%>

				</a>


				<button type="button" class="withdraw-btn" id="withdrawBtn">

					<%=messages.getProperty("mypage.withdraw", "회원 탈퇴")%>

				</button>


			</div>


		</div>

	</main>


	<%@ include file="footer.jsp"%>


	<script>
	

$(function() {
	
	$('#withdrawBtn').on('click', function() {

	    if (!confirm('정말 회원 탈퇴하시겠습니까?')) {
	        return;
	    }


	    $.ajax({
	        type: 'POST',
	        url: '${pageContext.request.contextPath}/users/withdraw.do',

	        success: function(res) {
	            res = res.trim();

	            if (res === 'success') {
	                alert('회원 탈퇴가 완료되었습니다.');

	                window.location.href =
	                    '${pageContext.request.contextPath}/main.do?lang=<%=lang%>';
	            } else if (res === 'login') {
	                alert('로그인이 필요합니다.');
	            } else {
	                alert('회원 탈퇴에 실패했습니다.');
	            }
	        },

	        error: function(xhr) {
	            
	        }
	    });

	});
	
	

    $('#nicknameBtn').on('click', function() {

        // 닉네임 변경 모드
        if (!$(this).hasClass('save-mode')) {

            $('#nicknameText').hide();
            $('#nicknameInput').show();

            $(this)
                .text('저장')
                .addClass('save-mode');

            $('#nicknameInput').focus();

            return;
        }

        // 저장할 닉네임
        var nickname = $('#nicknameInput').val().trim();

        if (nickname === '') {

            alert('<%=messages.getProperty("mypage.nickname.empty", "닉네임을 입력해주세요.")%>');

            $('#nicknameInput').focus();

            return;
        }

        // AJAX
        $.ajax({

            type: 'POST',

            url: '${pageContext.request.contextPath}/users/profileupdate.do',

            data: {
                nickname: nickname
            },

            success: function(res) {

                res = res.trim();

                // 변경 성공
                if (res === 'success') {

                    $('#nicknameText').text(nickname);

                    $('#nicknameInput').hide();
                    $('#nicknameText').show();

                    $('#nicknameBtn')
                        .text('<%=messages.getProperty("mypage.nickname.change", "닉네임 변경")%>')
                        .removeClass('save-mode');

                    alert('<%=messages.getProperty("mypage.nickname.success", "닉네임이 성공적으로 변경되었습니다.")%>');
                }

                // 중복 닉네임
                else if (res === 'duplicate') {

                    alert('<%=messages.getProperty("mypage.nickname.duplicate", "이미 사용 중인 닉네임입니다.")%>');

                    $('#nicknameInput').focus();
                }

                // 닉네임 형식 오류
                else if (res === 'format') {

                    alert('<%=messages.getProperty("mypage.nickname.format", "닉네임은 2~10자 사이의 영문, 숫자, 한글만 가능합니다.")%>');

                    $('#nicknameInput').focus();
                }

                // 빈 값
                else if (res === 'empty') {

                    alert('<%=messages.getProperty("mypage.nickname.empty", "닉네임을 입력해주세요.")%>');

                    $('#nicknameInput').focus();
                }

                // DB 수정 실패
                else if (res === 'fail') {

                    alert('<%=messages.getProperty("mypage.nickname.fail", "닉네임 변경에 실패했습니다.")%>');
                }

                // 로그인 필요
                else if (res === 'login') {

                    alert('<%=messages.getProperty("mypage.login.required", "로그인이 필요합니다.")%>');
                }

            },

            error: function() {

                alert('<%=messages.getProperty("mypage.nickname.error", "닉네임 변경 중 오류가 발생했습니다.")%>');

            }

        });

    });

});

//==============================
//비밀번호 변경
//==============================

$('#passwordBtn').on('click', function() {

 $('#passwordUpdateArea').slideDown();

 $('#currentPassword').focus();

});


$('#passwordCancelBtn').on('click', function() {

 $('#passwordUpdateArea').slideUp();

 $('#currentPassword').val('');
 $('#newPassword').val('');
 $('#confirmPassword').val('');

});


$('#passwordSaveBtn').on('click', function() {

 var currentPassword =
     $('#currentPassword').val().trim();

 var newPassword =
     $('#newPassword').val().trim();

 var confirmPassword =
     $('#confirmPassword').val().trim();


 // 현재 비밀번호 입력 확인
 if (currentPassword === '') {

     alert('<%=messages.getProperty("mypage.password.current.empty", "현재 비밀번호를 입력해주세요.")%>');

     $('#currentPassword').focus();

     return;
 }


 // 새 비밀번호 입력 확인
 if (newPassword === '') {

     alert('<%=messages.getProperty("mypage.password.new.empty", "새 비밀번호를 입력해주세요.")%>');

     $('#newPassword').focus();

     return;
 }


 // 새 비밀번호 확인 입력
 if (confirmPassword === '') {

     alert('<%=messages.getProperty("mypage.password.confirm.empty", "새 비밀번호를 다시 입력해주세요.")%>');

     $('#confirmPassword').focus();

     return;
 }


 // AJAX
 $.ajax({

     type: 'POST',

     url:
         '${pageContext.request.contextPath}/users/passwordupdate.do',

     data: {

         currentPassword: currentPassword,

         newPassword: newPassword,

         confirmPassword: confirmPassword

     },

     success: function(res) {

         res = res.trim();


         // 변경 성공
         if (res === 'success') {

             alert('<%=messages.getProperty("mypage.password.success", "비밀번호가 성공적으로 변경되었습니다.")%>');

             $('#currentPassword').val('');
             $('#newPassword').val('');
             $('#confirmPassword').val('');

             $('#passwordUpdateArea').slideUp();

         }


         // 현재 비밀번호 불일치
         else if (res === 'wrongCurrent') {

             alert('<%=messages.getProperty("mypage.password.wrong", "현재 비밀번호가 일치하지 않습니다.")%>');

             $('#currentPassword').focus();

         }


         // 새 비밀번호 입력 안 함
         else if (res === 'newEmpty') {

             alert('<%=messages.getProperty("mypage.password.new.empty", "새 비밀번호를 입력해주세요.")%>');

             $('#newPassword').focus();

         }


         // 새 비밀번호 확인 입력 안 함
         else if (res === 'confirmEmpty') {

             alert('<%=messages.getProperty("mypage.password.confirm.empty", "새 비밀번호를 다시 입력해주세요.")%>');

             $('#confirmPassword').focus();

         }


         // 새 비밀번호 불일치
         else if (res === 'mismatch') {

             alert('<%=messages.getProperty("mypage.password.mismatch", "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.")%>');

             $('#confirmPassword').focus();

         }


         // 비밀번호 형식 오류
         else if (res === 'format') {

             alert('<%=messages.getProperty("mypage.password.format", "비밀번호는 8자 이상이며 영문과 숫자를 포함해야 합니다.")%>');

             $('#newPassword').focus();

         }


         // DB 수정 실패
         else if (res === 'fail') {

             alert('<%=messages.getProperty("mypage.password.fail", "비밀번호 변경에 실패했습니다.")%>');

         }


         // 로그인 필요
         else if (res === 'login') {

             alert('<%=messages.getProperty("mypage.login.required", "로그인이 필요합니다.")%>');

         }

     },

     error: function() {

         alert('<%=messages.getProperty("mypage.password.error", "비밀번호 변경 중 오류가 발생했습니다.")%>');

										}

									});

						});
	
 
	</script>
	
<script>
function deleteBookmark(event, btn) {
    event.preventDefault();
    event.stopPropagation();
    if (!confirm("찜을 삭제할까요?")) return;
    var pid = btn.getAttribute("data-pid");
    fetch("${pageContext.request.contextPath}/bookmark/toggle.do?action=delete&placeId=" + encodeURIComponent(pid), { method: "POST" })
        .then(function (r) { return r.text(); })
        .then(function (t) {
            t = (t || "").trim();
            if (t === "delete") {
                var card = btn.closest(".favorite-card");
                if (card && card.parentNode) card.parentNode.removeChild(card);
            } else if (t === "login") {
                alert("로그인이 필요합니다.");
            } else {
                alert("삭제에 실패했습니다.");
            }
        })
        .catch(function () { alert("요청 중 오류가 발생했습니다."); });
}
</script>
</body>


</html>