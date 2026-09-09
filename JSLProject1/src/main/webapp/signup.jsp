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

    <title>
        <%= messages.getProperty(
            "signup.title",
            "회원가입"
        ) %>
    </title>

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


            <form class="signup-form"
                  id="signupForm"
                  onsubmit="return false;">


                <!-- 이메일 -->
                <div class="form-group">

                    <label for="email">
                        <%= messages.getProperty(
                            "signup.email",
                            "이메일"
                        ) %>
                    </label>


                    <div class="email-auth-row">

                        <input type="text"
                               id="email"
                               name="email"
                               placeholder="<%= messages.getProperty(
                                   "signup.email.placeholder",
                                   "이메일을 입력하세요"
                               ) %>">


                        <button type="button"
                                class="email-auth-btn"
                                id="emailAuthBtn">

                            <%= messages.getProperty(
                                "signup.email.auth",
                                "인증코드 받기"
                            ) %>

                        </button>

                    </div>


                    <!-- 인증번호 UI -->
                    <div class="verification-area"
                         id="verificationArea">


                        <div class="verification-input-wrap">

                            <input type="text"
                                   id="verificationCode"
                                   placeholder="<%= messages.getProperty(
                                       "signup.verification.placeholder",
                                       "인증번호 6자리"
                                   ) %>">

                            <span class="verification-timer"
                                  id="verificationTimer">
                                05:00
                            </span>

                        </div>


                        <button type="button"
                                class="verify-btn"
                                id="verifyBtn">

                            <%= messages.getProperty(
                                "signup.verify",
                                "확인"
                            ) %>

                        </button>

                    </div>


                    <p class="verification-message"
                       id="verificationMessage">
                    </p>

                </div>


                <!-- 비밀번호 -->
                <div class="form-group">

                    <label for="password">

                        <%= messages.getProperty(
                            "signup.password",
                            "비밀번호"
                        ) %>

                    </label>


                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="<%= messages.getProperty(
                               "signup.password.placeholder",
                               "비밀번호를 입력하세요"
                           ) %>">

                </div>


                <!-- 비밀번호 확인 -->
                <div class="form-group">

                    <label for="passwordConfirm">

                        <%= messages.getProperty(
                            "signup.password.confirm",
                            "비밀번호 확인"
                        ) %>

                    </label>


                    <input type="password"
                           id="passwordConfirm"
                           placeholder="<%= messages.getProperty(
                               "signup.password.confirm.placeholder",
                               "비밀번호를 다시 입력하세요"
                           ) %>">

                </div>


                <!-- 닉네임 -->
                <div class="form-group">

                    <label for="nickname">

                        <%= messages.getProperty(
                            "signup.nickname",
                            "닉네임"
                        ) %>

                    </label>


                    <input type="text"
                           id="nickname"
                           name="nickname"
                           placeholder="<%= messages.getProperty(
                               "signup.nickname.placeholder",
                               "닉네임을 입력하세요"
                           ) %>">

                </div>


                <p id="signupMsg"
                   style="color:#e45b68;
                          font-size:13px;
                          text-align:center;
                          margin:0 0 14px;
                          min-height:16px;">
                </p>


                <button type="button"
                        class="signup-submit"
                        id="signupBtn">

                    <%= messages.getProperty(
                        "signup.button",
                        "회원가입"
                    ) %>

                </button>


            </form>


            <div class="login-guide">

                <span>
                    <%= messages.getProperty(
                        "signup.login.question",
                        "이미 회원이신가요?"
                    ) %>
                </span>


                <a href="${pageContext.request.contextPath}/log/login.do?lang=<%= lang %>">

                    <%= messages.getProperty(
                        "signup.login",
                        "로그인"
                    ) %>

                </a>

            </div>


            <div class="language-box">

                <a href="#"
                   onclick="changeLanguage('ko'); return false;"
                   class="<%= "ko".equals(lang) ? "active" : "" %>">
                    한국어
                </a>

                <a href="#"
                   onclick="changeLanguage('en'); return false;"
                   class="<%= "en".equals(lang) ? "active" : "" %>">
                    English
                </a>

                <a href="#"
                   onclick="changeLanguage('ja'); return false;"
                   class="<%= "ja".equals(lang) ? "active" : "" %>">
                    日本語
                </a>

            </div>


        </div>

    </main>


<script>

$(function() {


    // 인증코드 UI만 표시
    $('#emailAuthBtn').on(
        'click',
        function() {

            $('#verificationArea')
                .addClass('show');

        }
    );


    // 회원가입
    $('#signupBtn').on(
        'click',
        function() {


            var email =
                $('#email').val().trim();


            var password =
                $('#password').val().trim();


            var passwordConfirm =
                $('#passwordConfirm').val().trim();


            var nickname =
                $('#nickname').val().trim();



            // 빈칸 검사
            if (
                email === ''
                ||
                password === ''
                ||
                passwordConfirm === ''
                ||
                nickname === ''
            ) {

                $('#signupMsg').text(
                    '<%= messages.getProperty(
                        "signup.msg.empty",
                        "모든 항목을 입력하세요."
                    ) %>'
                );

                return;

            }



            // 비밀번호 확인
            if (
                password !==
                passwordConfirm
            ) {

                $('#signupMsg').text(
                    '<%= messages.getProperty(
                        "signup.msg.password",
                        "비밀번호가 일치하지 않습니다."
                    ) %>'
                );

                return;

            }



            $.ajax({

                url:
                    '${pageContext.request.contextPath}/log/signuppro.do',

                type:
                    'post',

                data: {

                    nickname:
                        nickname,

                    email:
                        email,

                    password:
                        password,

                    lang:
                        '<%= lang %>'

                },

                dataType:
                    'text',


                success:
                    function(result) {


                        if (
                            result ===
                            'success'
                        ) {


                            alert(
                                '<%= messages.getProperty(
                                    "signup.alert.success",
                                    "회원가입이 완료되었습니다."
                                ) %>'
                            );


                            location.href =
                                '${pageContext.request.contextPath}/log/login.do?lang=<%= lang %>';


                        } else if (
                            result ===
                            'empty'
                        ) {


                            $('#signupMsg').text(
                                '<%= messages.getProperty(
                                    "signup.msg.empty.server",
                                    "모든 항목을 입력해야 합니다."
                                ) %>'
                            );


                        } else {


                            $('#signupMsg').text(
                                '<%= messages.getProperty(
                                    "signup.msg.fail",
                                    "회원가입에 실패했습니다. (이메일/닉네임 중복 등)"
                                ) %>'
                            );

                        }

                    },


                error:
                    function() {


                        $('#signupMsg').text(
                            '<%= messages.getProperty(
                                "signup.msg.server",
                                "서버 오류가 발생했습니다."
                            ) %>'
                        );

                    }

            });


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