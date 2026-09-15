<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

<title><%= messages.getProperty(
            "signup.title",
            "회원가입"
        ) %></title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/signup.css">

</head>

<body>

	<main class="signup-main">

		<div class="signup-card">


			<div class="signup-header">

				<h1>
					<%= messages.getProperty(
                        "signup.heading",
                        "회원가입"
                    ) %>
				</h1>

				<p>
					<%= messages.getProperty(
                        "signup.subtitle",
                        "Travel Route에 가입하고 나만의 여행을 시작해보세요."
                    ) %>
				</p>

			</div>


			<form class="signup-form" id="signupForm"
				action="${pageContext.request.contextPath}/users/signup.do"
				method="post">
				<input type="hidden" name="lang" value="<%= lang %>">


				<!-- 이메일 -->
				<div class="form-group">

					<label for="email"> <%= messages.getProperty(
                            "signup.email",
                            "이메일"
                        ) %>
					</label>


					<div class="email-auth-row">

						<input type="text" id="email" name="email"
							placeholder="<%= messages.getProperty(
                                   "signup.email.placeholder",
                                   "이메일을 입력하세요"
                               ) %>"
							value="${requestScope.email}">


						<button type="button" class="email-auth-btn" id="emailAuthBtn">

							<%= messages.getProperty(
                                "signup.email.auth",
                                "인증코드 받기"
                            ) %>

						</button>

					</div>
					<%-- <span class="emailVerified" id="emailVerified">${message} </span> --%>


					<!-- 인증번호 UI -->
					<div class="verification-area" id="verificationArea">


						<div class="verification-input-wrap">

							<input type="text" id="UsersEmailCode"
								placeholder="<%= messages.getProperty(
                                       "signup.verification.placeholder",
                                       "인증번호 6자리"
                                   ) %>">

							<span class="verification-timer" id="verificationTimer"> </span>

						</div>


						<button type="button" class="verify-btn" id="verifyBtn">

							<%= messages.getProperty(
                                "signup.verify",
                                "확인"
                            ) %>

						</button>

					</div>


					<p class="verification-message" id="verificationMessage"></p>

				</div>


				<!-- 비밀번호 -->
				<div class="form-group">

					<label for="password"> <%= messages.getProperty(
                            "signup.password",
                            "비밀번호"
                        ) %>

					</label> <input type="password" id="password" name="password"
						placeholder="<%= messages.getProperty(
                               "signup.password.placeholder",
                               "비밀번호를 입력하세요"
                           ) %>">

					
				</div>


				<!-- 비밀번호 확인 -->
				<div class="form-group">

					<label for="passwordConfirm"> <%= messages.getProperty(
                            "signup.password.confirm",
                            "비밀번호 확인"
                        ) %>

					</label> <input type="password" id="confirmPassword" name="confirmPassword"
						placeholder="<%= messages.getProperty(
                               "signup.password.confirm.placeholder",
                               "비밀번호를 다시 입력하세요"
                           ) %>">

					

				</div>


				<!-- 닉네임 -->
				<div class="form-group">

					<label for="nickname"> <%= messages.getProperty(
                            "signup.nickname",
                            "닉네임"
                        ) %>

					</label> <input type="text" id="nickname" name="nickname"
						placeholder="<%= messages.getProperty(
                               "signup.nickname.placeholder",
                               "닉네임을 입력하세요"
                           ) %>"
						value="${requestScope.nickname}">

					
				</div>
				<%
				String messageKey = (String) request.getAttribute("message");
				String messageText = "";

				if (messageKey != null) {
					messageText = messages.getProperty(messageKey, "");
				}
				%>


				<p id="signupMsg"
					style="color: #e45b68; font-size: 13px; text-align: center; margin: 0 0 14px; min-height: 16px;">
					<%= messageText %>
				</p>


				<button type="submit" class="signup-submit">

					<%= messages.getProperty(
                        "signup.button",
                        "회원가입"
                    ) %>

				</button>


			</form>


			<div class="login-guide">

				<span> <%= messages.getProperty(
                        "signup.login.question",
                        "이미 회원이신가요?"
                    ) %>
				</span> <a
					href="${pageContext.request.contextPath}/users/loginview.do?lang=<%= lang %>">

					<%= messages.getProperty(
                        "signup.login",
                        "로그인"
                    ) %>

				</a>

			</div>


			<div class="language-box">

				<a href="#" onclick="changeLanguage('ko'); return false;"
					class="<%= "ko".equals(lang) ? "active" : "" %>"> 한국어 </a> <a
					href="#" onclick="changeLanguage('en'); return false;"
					class="<%= "en".equals(lang) ? "active" : "" %>"> English </a> <a
					href="#" onclick="changeLanguage('ja'); return false;"
					class="<%= "ja".equals(lang) ? "active" : "" %>"> 日本語 </a>

			</div>


		</div>

	</main>


	<script>
	
	var emailSendSuccess =
	    '<%= messages.getProperty(
	        "signup.msg.email.send.success",
	        "인증코드를 전송했습니다."
	    ) %>';

	var emailSendFail =
	    '<%= messages.getProperty(
	        "signup.msg.email.send.fail",
	        "인증코드 전송에 실패했습니다."
	    ) %>';
	var emailEmpty =
	    '<%= messages.getProperty(
	        "signup.msg.email.empty",
	        "이메일을 입력하세요"
	    ) %>';
	    var verifyEmpty =
	        '<%= messages.getProperty(
	            "signup.msg.email.verify.empty",
	            "인증코드를 입력해주세요."
	        ) %>';

	    var verifyWrong =
	        '<%= messages.getProperty(
	            "signup.msg.email.verify.wrong",
	            "인증코드가 다릅니다."
	        ) %>';

	    var verifyExpired =
	        '<%= messages.getProperty(
	            "signup.msg.email.verify.expired",
	            "유효시간이 지났습니다. 인증코드를 다시 발급받아주세요."
	        ) %>';

	    var verifySuccess =
	        '<%= messages.getProperty(
	            "signup.msg.email.verify.success",
	            "인증이 완료되었습니다."
	        ) %>';

	        var timerInterval;

	        function startVerificationTimer() {

	            // 기존 타이머가 있다면 중지
	            clearInterval(timerInterval);

	            // 5분 = 300초
	            var remainingTime = 5 * 60;

	            updateTimer();

	            timerInterval = setInterval(function() {

	                remainingTime--;

	                updateTimer();

	                if (remainingTime <= 0) {

	                    clearInterval(timerInterval);

	                    /* $('#verificationTimer').text(
	                            verifyExpired
	                        ); */
	                }

	            }, 1000);


	            function updateTimer() {

	                var minutes = Math.floor(remainingTime / 60);

	                var seconds = remainingTime % 60;

	                seconds = String(seconds).padStart(2, '0');

	                $('#verificationTimer').text(
	                    minutes + ':' + seconds
	                );
	            }
	        }

$(function() {


    // 인증코드 UI만 표시
    $('#emailAuthBtn').on(
        'click',
        function() {
        	 // 이메일 입력값 가져오기
            const email = $('#email').val().trim();
            if(email == ''){

                $('#verificationMessage').text(emailEmpty);

                $('#email').focus();

            }else{
				$.ajax({ //비동기식 전송함수 
					type:"post", //전송방식
					url:"${pageContext.request.contextPath}/users/emailsend.do",
					//요청하는 주소
					data:{email:email},
					//서버로 보내는 자료
					success:function(res){ //통신이 성공했을때
						if(res === 'signup.msg.email.send.success'){

					        $('#verificationArea').addClass('show');

					        $('#verificationMessage').text(emailSendSuccess);
					     	// 인증번호 5분 타이머 시작 
					     	startVerificationTimer();

					    }else{

					        $('#verificationMessage').text(emailSendFail);
					    }
					},
					error:function(){
						
					}
				});
			}
            

        }
    );
    //인증번호 확인 
    $('#verifyBtn').on(
        'click',
        function() {
        //인증번호 
        const UsersEmailCode = $('#UsersEmailCode').val().trim();
        if (UsersEmailCode == '') {

            $('#verificationMessage').text(verifyEmpty);

            $('#UsersEmailCode').focus();

        } else {

            $.ajax({

                type: "post",

                url:
                    "${pageContext.request.contextPath}/users/emailverify.do",

                data: {
                    UsersEmailCode: UsersEmailCode
                },

                success: function(res) {

                    if (res === 'signup.msg.email.verify.success') {

                        $('#verificationMessage').text(
                            verifySuccess
                        );
                     	// 인증번호 영역 숨기기
                        $('#verificationArea').removeClass('show');

                        // 인증코드 받기 버튼 숨기기
                        $('#emailAuthBtn').hide();

                    } else if (
                        res === 'signup.msg.email.verify.empty'
                    ) {

                        $('#verificationMessage').text(
                            verifyEmpty
                        );

                    } else if (
                        res === 'signup.msg.email.verify.wrong'
                    ) {

                        $('#verificationMessage').text(
                            verifyWrong
                        );

                    } else if (
                        res === 'signup.msg.email.verify.expired'
                    ) {

                        $('#verificationMessage').text(
                            verifyExpired
                        );
                    }
                },

                error: function() {

                }
            });
        }
       }
    );



});


function changeLanguage(lang) {

    const url =
        new URL(window.location.href);

    url.searchParams.set(
        'lang',
        lang
    );

    window.location.href =
        url.toString();

}

</script>




</body>

</html>