<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!Doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 75px;
            color: black;
            background: white;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 1000; /* 다른 요소 위에 나타나게 함 */
        }

        .header-container {
            width: 100%;       /* Set the width to 100% */
            max-width: 1440px; /* Set the maximum width to 1440px */
            margin: 0 auto;   /* Center the container on the page */
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
        }

        nav {
            position: absolute;
            left: 50%;
            transform: translateX(-60%);
            width: 1000px;
        }

        nav ul {
            list-style: none;
            display: flex;
            justify-content: space-evenly;
        }

        nav ul li {
            margin-right: 20px;
        }

        nav ul li:last-child {
            margin-right: 0;
        }

        nav ul li a {
            text-decoration: none;
            color: #333333;
            transition: color 0.3s;
            font-family: "하나2.0 M";
            font-size: 20px;
            font-weight: 700;
        }

        nav ul li a:hover {
            color: #008458;
        }


        /* 회원가입 및 로그인 버튼을 가로로 나열 */
        .user-actions {
            display: flex;
            gap: 10px;
            font-family: "하나2.0 R";
            align-items: center;
            justify-content: center;
        }

        /* 가로로 나열된 버튼을 세로로 중앙 정렬 */
        .user-actions a {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 40px;
            text-decoration: none;
            color: #333333;
            transition: color 0.3s;
            font-size: 10px;
            font-weight: 700;
        }

        .user-actions a:hover {
            color: #008458;
        }

        .greeting-text {
            font-size: 10px; /* 원하는 글자 크기로 조정 */
            /* 다른 스타일 속성들도 추가 가능 */
            font-family: "하나2.0 R"
        }

        nav ul li.active a {
            position: relative; /* pseudo-element를 위해 position 설정 */
        }

        nav ul li.active a::before {
            content: "";
            display: block;
            height: 4px;       /* 원하는 높이 (밑줄 두께) */
            width: 100%;       /* a 요소의 전체 너비만큼 적용 */
            background-color: #04BE9E;  /* 배경색 */
            position: absolute;
            bottom: -10px;         /* a 요소의 아래쪽에 위치 */
            left: 0;
        }
    </style>
</head>
<body>

<header>
    <div class="header-container">
        <div class="logo">
            <a href="/"><img src="img/logo.png" alt="로고"></a>
        </div>
        <nav>
            <ul>
                <li><a href="/sogae">다이렉트원덱싱이란?</a></li>
                <li><a href="/start2">시작하기</a></li>
                <li><a href="/portfolios">내 포트폴리오</a></li>
                <li><a href="/mypage">마이 페이지</a></li>
                <li><a href="/faq">FAQ</a></li>
            </ul>
        </nav>
        <div class="user-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.user.id}">
                    <!-- 로그인된 상태 -->
                    <span class="greeting-text">${sessionScope.user.id}님 반갑습니다.</span>
                    <a href="/logout">로그아웃</a>
                    <a href="/open">계좌개설</a>
                </c:when>
                <c:otherwise>
                    <!-- 로그인되지 않은 상태 -->
                    <a href="/agree">회원가입</a>
                    <a href="/login">로그인</a>
                    <a href="/open">계좌개설</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="progress-bar">
        <div class="progress"></div>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // 현재 페이지의 URL을 가져옵니다.
            var currentPageUrl = window.location.pathname;

            // 메뉴의 모든 링크를 가져옵니다.
            var navLinks = document.querySelectorAll('nav ul li a');

            // 링크를 순회하며 현재 페이지와 링크의 href가 일치하는지 확인합니다.
            navLinks.forEach(function (link) {
                if (link.getAttribute('href') === currentPageUrl) {
                    // 일치하면 부모 li 요소에 'active' 클래스를 추가합니다.
                    link.parentElement.classList.add('active');
                }
            });
        });

    </script>
</header>
