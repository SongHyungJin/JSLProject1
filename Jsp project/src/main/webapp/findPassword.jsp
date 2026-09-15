<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>

<%
    String lang =
        request.getParameter("lang");

    if (lang == null) {
        lang = "ko";
    }

    if (!lang.equals("ko")
            && !lang.equals("en")
            && !lang.equals("ja")) {

        lang = "ko";
    }


    Properties messages =
        new Properties();


    String resourcePath =
        "/i18n/messages_"
        + lang
        + ".properties";


    InputStream is =
        application.getResourceAsStream(
            resourcePath
        );


    if (is != null) {

        messages.load(
            new InputStreamReader(
                is,
                "UTF-8"
            )
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
        "findpassword.title",
        "비밀번호 찾기"
    ) %>
</title>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/login.css?v=2">


<style>

    #passwordArea {
        display: none;
    }


    .success-message {
        color: #3b9b62 !important;
    }

</style>

</head>


<body>


<header class="header">

    <div class="header-inner">


        <h1 class="logo">

            <a href="${pageContext.request.contextPath}/main.do?lang=<%= lang %>">
                TripStamp
            </a>

        </h1>


        <a href="${pageContext.request.contextPath}/main.do?lang=<%= lang %>"
           class="back-home">

            <%= messages.getProperty(
                "common.back.main",
                "메인으로"
            ) %>

        </a>


    </div>

</header>



<main class="login-main">


    <div class="login-card">


        <div class="login-header">


            <h1>

                <%= messages.getProperty(
                    "findpassword.heading",
                    "비밀번호 찾기"
                ) %>

            </h1>


            <p>

                <%= messages.getProperty(
                    "findpassword.subtitle",
                    "가입할 때 사용한 이메일을 입력해주세요."
                ) %>

            </p>


        </div>



        <!-- 이메일 확인 영역 -->
        <div class="login-form"
             id="emailArea">


            <div class="form-group">


                <label for="email">

                    <%= messages.getProperty(
                        "findpassword.email",
                        "이메일"
                    ) %>

                </label>


                <input type="email"
                       id="email"
                       name="email"
                       placeholder="<%= messages.getProperty(
                           "findpassword.email.placeholder",
                           "가입한 이메일을 입력하세요"
                       ) %>">


            </div>



            <p id="emailMsg"
               style="
                    color:#e45b68;
                    font-size:13px;
                    text-align:center;
                    margin:0;
                    min-height:16px;
               ">
            </p>



            <button type="button"
                    class="login-submit"
                    id="checkEmailBtn">

                <%= messages.getProperty(
                    "findpassword.email.button",
                    "이메일 확인"
                ) %>

            </button>


        </div>



        <!-- 새 비밀번호 설정 영역 -->
        <div class="login-form"
             id="passwordArea">


            <div class="form-group">


                <label for="newPassword">

                    <%= messages.getProperty(
                        "findpassword.newpassword",
                        "새 비밀번호"
                    ) %>

                </label>


                <input type="password"
                       id="newPassword"
                       placeholder="<%= messages.getProperty(
                           "findpassword.newpassword.placeholder",
                           "새 비밀번호를 입력하세요"
                       ) %>">


            </div>



            <div class="form-group">


                <label for="confirmPassword">

                    <%= messages.getProperty(
                        "findpassword.confirm",
                        "새 비밀번호 확인"
                    ) %>

                </label>


                <input type="password"
                       id="confirmPassword"
                       placeholder="<%= messages.getProperty(
                           "findpassword.confirm.placeholder",
                           "새 비밀번호를 다시 입력하세요"
                       ) %>">


            </div>



            <p id="passwordMsg"
               style="
                    color:#e45b68;
                    font-size:13px;
                    text-align:center;
                    margin:0;
                    min-height:16px;
               ">
            </p>



            <button type="button"
                    class="login-submit"
                    id="changePasswordBtn">

                <%= messages.getProperty(
                    "findpassword.change.button",
                    "비밀번호 변경"
                ) %>

            </button>


        </div>



        <div class="signup-guide">


            <%= messages.getProperty(
                "findpassword.login.question",
                "비밀번호가 기억나셨나요?"
            ) %>


            <a href="${pageContext.request.contextPath}/log/login.do?lang=<%= lang %>">

                <%= messages.getProperty(
                    "findpassword.login",
                    "로그인"
                ) %>

            </a>


        </div>



        <!-- 언어 선택 -->
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



<footer class="footer">

    <p>
        © 2026 TripStamp. All rights reserved.
    </p>

</footer>



<script>


$(function() {


    /*
     * 이메일 확인
     */
    $('#checkEmailBtn').on(
        'click',
        function() {


            const email =
                $('#email')
                    .val()
                    .trim();


            $('#emailMsg')
                .removeClass(
                    'success-message'
                );


            if (email === '') {


                $('#emailMsg').text(
                    '<%= messages.getProperty(
                        "findpassword.email.empty",
                        "이메일을 입력해주세요."
                    ) %>'
                );


                return;
            }



            $.ajax({


                url:
                    '${pageContext.request.contextPath}/log/findPasswordPro.do',


                type:
                    'post',


                data: {

                    mode:
                        'checkEmail',

                    email:
                        email

                },


                dataType:
                    'text',


                success:
                    function(result) {


                        result =
                            result.trim();


                        if (result === 'success') {


                            $('#emailMsg')
                                .addClass(
                                    'success-message'
                                )
                                .text(
                                    '<%= messages.getProperty(
                                        "findpassword.email.success",
                                        "가입된 이메일입니다."
                                    ) %>'
                                );


                            $('#email').prop(
                                'readonly',
                                true
                            );


                            $('#checkEmailBtn').hide();


                            $('#passwordArea')
                                .slideDown();


                        } else if (
                            result === 'notFound'
                        ) {


                            $('#emailMsg').text(
                                '<%= messages.getProperty(
                                    "findpassword.email.notfound",
                                    "가입되지 않은 이메일입니다."
                                ) %>'
                            );


                        } else {


                            $('#emailMsg').text(
                                '<%= messages.getProperty(
                                    "findpassword.email.fail",
                                    "이메일 확인 중 오류가 발생했습니다."
                                ) %>'
                            );

                        }

                    },


                error:
                    function() {


                        $('#emailMsg').text(
                            '<%= messages.getProperty(
                                "findpassword.server",
                                "서버 오류가 발생했습니다."
                            ) %>'
                        );

                    }


            });


        }

    );



    /*
     * 비밀번호 변경
     */
    $('#changePasswordBtn').on(
        'click',
        function() {


            const email =
                $('#email')
                    .val()
                    .trim();


            const newPassword =
                $('#newPassword')
                    .val()
                    .trim();


            const confirmPassword =
                $('#confirmPassword')
                    .val()
                    .trim();



            if (newPassword === ''
                    || confirmPassword === '') {


                $('#passwordMsg').text(
                    '<%= messages.getProperty(
                        "findpassword.password.empty",
                        "새 비밀번호를 입력해주세요."
                    ) %>'
                );


                return;
            }



            if (newPassword !==
                    confirmPassword) {


                $('#passwordMsg').text(
                    '<%= messages.getProperty(
                        "findpassword.password.mismatch",
                        "비밀번호가 일치하지 않습니다."
                    ) %>'
                );


                return;
            }



            $.ajax({


                url:
                    '${pageContext.request.contextPath}/log/findPasswordPro.do',


                type:
                    'post',


                data: {

                    mode:
                        'updatePassword',

                    email:
                        email,

                    newPassword:
                        newPassword

                },


                dataType:
                    'text',


                success:
                    function(result) {


                        result =
                            result.trim();


                        if (result === 'success') {


                            alert(
                                '<%= messages.getProperty(
                                    "findpassword.change.success",
                                    "비밀번호가 변경되었습니다."
                                ) %>'
                            );


                            location.href =
                                '${pageContext.request.contextPath}'
                                + '/log/login.do?lang=<%= lang %>';


                        } else {


                            $('#passwordMsg').text(
                                '<%= messages.getProperty(
                                    "findpassword.change.fail",
                                    "비밀번호 변경에 실패했습니다."
                                ) %>'
                            );

                        }

                    },


                error:
                    function() {


                        $('#passwordMsg').text(
                            '<%= messages.getProperty(
                                "findpassword.server",
                                "서버 오류가 발생했습니다."
                            ) %>'
                        );

                    }


            });


        }

    );


});



/*
 * 언어 변경
 */
function changeLanguage(lang) {


    const url =
        new URL(
            window.location.href
        );


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