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

/*
 * 로그인 후 이동할 주소
 *
 * LoginController가 세션에 저장함
 */
String redirect = (String) session.getAttribute("loginRedirect");

/*
 * 저장된 주소가 없으면 메인
 */
if (redirect == null || redirect.trim().isEmpty() || !redirect.startsWith("/") || redirect.startsWith("//")) {

	redirect = "/main.do";
}

/*
 * JavaScript 문자열 안에서 문제 없게 최소 처리
 */
String redirectJs = redirect.replace("\\", "\\\\").replace("'", "\\'");
%>


<!DOCTYPE html>

<html lang="<%=lang%>">

<head>

<meta charset="UTF-8">


<title><%=messages.getProperty("login.title", "로그인")%></title>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/login.css">

</head>


<body>



	<header class="header">

		<div class="header-inner">


			<h1 class="logo">

				<a
					href="${pageContext.request.contextPath}/main.do?lang=<%= lang %>">

					Travel Route </a>

			</h1>



			<a href="${pageContext.request.contextPath}/main.do?lang=<%= lang %>"
				class="back-home"> <%=messages.getProperty("login.back.main", "메인으로")%>

			</a>


		</div>

	</header>



	<main class="login-main">

		<div class="login-card">


			<div class="login-header">


				<h1>

					<%=messages.getProperty("login.heading", "로그인")%>

				</h1>


				<p>

					<%=messages.getProperty("login.subtitle", "이메일과 비밀번호를 입력해주세요")%>

				</p>


			</div>



			<form class="login-form" id="loginForm"
				action="${pageContext.request.contextPath}/users/login.do"
				method="post">
					


				<div class="form-group">

					
					<label for="email"> <%=messages.getProperty("login.email", "이메일")%>

					</label> <input type="text" id="email" name="email"
						placeholder="<%=messages.getProperty("login.email.placeholder", "이메일을 입력하세요")%>">


				</div>



				<div class="form-group">


					<label for="password"> <%=messages.getProperty("login.password", "비밀번호")%>

					</label> <input type="password" id="password" name="password"
						placeholder="<%=messages.getProperty("login.password.placeholder", "비밀번호를 입력하세요")%>">


				</div>



				<div class="remember-row">


					<input type="checkbox" id="saveId"> <label for="saveId">

						<%=messages.getProperty("login.save.id", "아이디 저장")%>

					</label>


				</div>



				<p id="loginMsg"
					style="color: #e45b68; font-size: 13px; text-align: center; margin: 0; min-height: 16px;">
				</p>



				<button type="submit" class="login-submit">

					<%=messages.getProperty("login.button", "로그인")%>

				</button>


			</form>



			<div class="find-guide">


				<a href="${pageContext.request.contextPath}/users/findemail.do?lang=<%=lang%>"> <%=messages.getProperty("login.find.email", "이메일 찾기")%>

				</a> <span class="divider"> | </span> <a href="${pageContext.request.contextPath}/users/findpassword.do?lang=<%=lang%>"> <%=messages.getProperty("login.find.password", "비밀번호 찾기")%>

				</a>


			</div>



			<div class="signup-guide">


				<%=messages.getProperty("login.signup.question", "아직 회원이 아니신가요?")%>


				<a
					href="${pageContext.request.contextPath}/users/signupview.do?lang=<%= lang %>">

					<%=messages.getProperty("login.signup", "회원가입")%>

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



	<footer class="footer">

		<p>© 2026 Travel Route. All rights reserved.</p>

	</footer>



	<script>
	function changeLanguage(lang) {

        const url = new URL(window.location.href);

        url.searchParams.set('lang', lang);

        window.location.href = url.toString();
    }

	$(function() {

	    var savedEmail = getCookie('savedEmail');

	    if (savedEmail !== '') {

	        $('#email').val(savedEmail);

	        $('#saveId').prop('checked', true);
	    }

	    $('#loginForm').on('submit', function() {

	        var email = $('#email').val();

	        if ($('#saveId').is(':checked')) {

	            setCookie('savedEmail', email, 30);

	        } else {

	            setCookie('savedEmail', '', -1);
	        }
	    });

	    

	    function setCookie(name, value, days) {

	        var date = new Date();

	        date.setTime(
	            date.getTime() + (days * 24 * 60 * 60 * 1000)
	        );

	        document.cookie =
	            name + '=' + encodeURIComponent(value)
	            + '; expires=' + date.toUTCString()
	            + '; path=/';
	    }

	    function getCookie(name) {

	        var value = document.cookie.match(
	            '(^|;) ?' + name + '=([^;]*)(;|$)'
	        );

	        return value ? decodeURIComponent(value[2]) : '';
	    }

	});
	</script>


</body>

</html>