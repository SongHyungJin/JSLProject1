<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Properties,java.io.InputStream,java.io.InputStreamReader"%>

<%
    String headerLang = request.getParameter("lang");

    if (headerLang == null) {
        headerLang = "ko";
    }

    if (!headerLang.equals("ko")
            && !headerLang.equals("en")
            && !headerLang.equals("ja")) {
        headerLang = "ko";
    }

    Properties headerMsg = new Properties();

    String headerResourcePath =
            "/i18n/messages_" + headerLang + ".properties";

    InputStream headerIs =
            application.getResourceAsStream(headerResourcePath);

    if (headerIs != null) {
        headerMsg.load(
            new InputStreamReader(headerIs, "UTF-8")
        );

        headerIs.close();
    }

    boolean isLogin =
            (session.getAttribute("loginUser") != null);
%>


<link rel="stylesheet"
      href="<%= request.getContextPath() %>/css/header.css">


<header class="site-header">

    <div class="site-header-inner">


        <!-- 로고 -->
        <a href="<%= request.getContextPath() %>/main.do?lang=<%= headerLang %>"
           class="site-logo">

            Travel Route

        </a>


        <!-- 메뉴 -->
        <nav class="site-nav">

            <a href="<%= request.getContextPath() %>/main.do?lang=<%= headerLang %>">

                <%= headerMsg.getProperty(
                    "header.home",
                    "홈"
                ) %>

            </a>


            <a href="<%= request.getContextPath() %>/place/category.do?lang=<%= headerLang %>">

                <%= headerMsg.getProperty(
                    "header.category",
                    "카테고리"
                ) %>

            </a>


            <a href="<%= request.getContextPath() %>/route/myroute.do?lang=<%= headerLang %>">

                <%= headerMsg.getProperty(
                    "header.myroute",
                    "나의 여행루트"
                ) %>

            </a>

        </nav>


        <!-- 오른쪽 -->
        <div class="site-header-right">


            <!-- 언어 선택 -->
            <div class="language-menu">

                <a href="#"
                   onclick="changeLanguage('ko'); return false;"
                   class="<%= "ko".equals(headerLang) ? "active" : "" %>">

                    KO

                </a>


                <a href="#"
                   onclick="changeLanguage('en'); return false;"
                   class="<%= "en".equals(headerLang) ? "active" : "" %>">

                    EN

                </a>


                <a href="#"
                   onclick="changeLanguage('ja'); return false;"
                   class="<%= "ja".equals(headerLang) ? "active" : "" %>">

                    JA

                </a>

            </div>


            <% if (!isLogin) { %>

                <!-- 로그인 전 -->

                <a href="<%= request.getContextPath() %>/log/login.do?lang=<%= headerLang %>"
                   class="site-login">

                    <%= headerMsg.getProperty(
                        "header.login",
                        "로그인"
                    ) %>

                </a>


                <a href="<%= request.getContextPath() %>/log/signup.do?lang=<%= headerLang %>"
                   class="site-signup">

                    <%= headerMsg.getProperty(
                        "header.signup",
                        "회원가입"
                    ) %>

                </a>


            <% } else { %>


                <!-- 로그인 후 -->

                <a href="<%= request.getContextPath() %>/log/mypage.do?lang=<%= headerLang %>"
                   class="site-login">

                    <%= headerMsg.getProperty(
                        "header.mypage",
                        "마이페이지"
                    ) %>

                </a>


                <a href="<%= request.getContextPath() %>/log/logout.do?lang=<%= headerLang %>"
                   class="site-logout">

                    <%= headerMsg.getProperty(
                        "header.logout",
                        "로그아웃"
                    ) %>

                </a>


            <% } %>


        </div>

    </div>

</header>


<script>

function changeLanguage(lang) {

    /*
     * 현재 페이지의 전체 주소를 가져옴.
     *
     * 예:
     * /place/view.do?id=3&lang=ko
     */
    const currentUrl =
        new URL(window.location.href);


    /*
     * 기존 id, keyword, category,
     * country, region 등의 값은 그대로 두고
     * lang 값만 변경
     */
    currentUrl.searchParams.set(
        'lang',
        lang
    );


    /*
     * 변경된 주소로 이동
     */
    window.location.href =
        currentUrl.toString();
}

</script>