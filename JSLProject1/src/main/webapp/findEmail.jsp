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
        "findemail.title",
        "이메일 찾기"
    ) %>
</title>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/login.css?v=2">


<style>

    /*
     * 찾은 이메일 결과 영역
     */
    .email-result {

        display: none;

        margin-top: 20px;

        padding: 18px;

        text-align: center;

        background: #fff5f7;

        border: 1px solid #f3c7cf;

        border-radius: 12px;
    }


    .email-result-title {

        margin: 0 0 8px;

        font-size: 14px;

        color: #666;
    }


    .email-result-value {

        margin: 0;

        font-size: 18px;

        font-weight: bold;

        color: #e45b68;

        word-break: break-all;
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
                    "findemail.heading",
                    "이메일 찾기"
                ) %>

            </h1>


            <p>

                <%= messages.getProperty(
                    "findemail.subtitle",
                    "가입할 때 사용한 닉네임을 입력해주세요."
                ) %>

            </p>


        </div>




        <div class="login-form">


            <div class="form-group">


                <label for="nickname">

                    <%= messages.getProperty(
                        "findemail.nickname",
                        "닉네임"
                    ) %>

                </label>


                <input type="text"
                       id="nickname"
                       name="nickname"
                       placeholder="<%= messages.getProperty(
                           "findemail.nickname.placeholder",
                           "가입한 닉네임을 입력하세요"
                       ) %>">


            </div>




            <p id="findEmailMsg"
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
                    id="findEmailBtn">

                <%= messages.getProperty(
                    "findemail.button",
                    "이메일 찾기"
                ) %>

            </button>


        </div>




        <!-- 이메일 조회 성공 결과 -->
        <div class="email-result"
             id="emailResult">


            <p class="email-result-title">

                <%= messages.getProperty(
                    "findemail.result.title",
                    "가입하신 이메일입니다."
                ) %>

            </p>


            <p class="email-result-value"
               id="foundEmail">
            </p>


        </div>




        <div class="signup-guide">


            <%= messages.getProperty(
                "findemail.login.question",
                "이메일을 찾으셨나요?"
            ) %>


            <a href="${pageContext.request.contextPath}/users/loginview.do?lang=<%= lang %>">

                <%= messages.getProperty(
                    "findemail.login",
                    "로그인"
                ) %>

            </a>


        </div>




        <div class="signup-guide">


            <%= messages.getProperty(
                "findemail.password.question",
                "비밀번호도 기억나지 않으신가요?"
            ) %>


            <a href="${pageContext.request.contextPath}/users/findpassword.do?lang=<%=lang%>">

                <%= messages.getProperty(
                    "findemail.password",
                    "비밀번호 찾기"
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
     * 이메일 찾기
     */
    $('#findEmailBtn').on(
        'click',
        function() {


            const nickname =
                $('#nickname')
                    .val()
                    .trim();


            /*
             * 기존 결과 초기화
             */
            $('#findEmailMsg').text('');

            $('#emailResult').hide();

            $('#foundEmail').text('');



            /*
             * 닉네임 미입력
             */
            if (nickname === '') {


                $('#findEmailMsg').text(
                    '<%= messages.getProperty(
                        "findemail.msg.empty",
                        "닉네임을 입력해주세요."
                    ) %>'
                );


                return;
            }




            /*
             * 이메일 찾기 AJAX
             */
            $.ajax({


                url:
                    '${pageContext.request.contextPath}/users/findEmailPro.do',


                type:
                    'post',


                data: {

                    nickname:
                        nickname

                },


                dataType:
                    'text',



                success:
                    function(result) {


                        result =
                            result.trim();



                        /*
                         * 조회 성공
                         *
                         * success|이메일
                         */
                        if (
                            result.startsWith(
                                'success|'
                            )
                        ) {


                            const email =
                                result.substring(
                                    'success|'.length
                                );


                            $('#findEmailMsg').text('');


                            $('#foundEmail').text(
                                email
                            );


                            $('#emailResult')
                                .slideDown();



                        } else if (
                            result === 'notFound'
                        ) {


                            $('#findEmailMsg').text(
                                '<%= messages.getProperty(
                                    "findemail.msg.notfound",
                                    "일치하는 닉네임을 찾을 수 없습니다."
                                ) %>'
                            );



                        } else if (
                            result === 'empty'
                        ) {


                            $('#findEmailMsg').text(
                                '<%= messages.getProperty(
                                    "findemail.msg.empty",
                                    "닉네임을 입력해주세요."
                                ) %>'
                            );



                        } else {


                            $('#findEmailMsg').text(
                                '<%= messages.getProperty(
                                    "findemail.msg.fail",
                                    "이메일 찾기에 실패했습니다."
                                ) %>'
                            );

                        }

                    },



                error:
                    function() {


                        $('#findEmailMsg').text(
                            '<%= messages.getProperty(
                                "findemail.msg.server",
                                "서버 오류가 발생했습니다."
                            ) %>'
                        );

                    }


            });


        }

    );




    /*
     * Enter 키로 이메일 찾기
     */
    $('#nickname').on(
        'keydown',
        function(event) {


            if (event.key === 'Enter') {


                event.preventDefault();


                $('#findEmailBtn')
                    .click();

            }

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