<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>


<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>s

    <style>

        body {
            margin: 0;
            padding: 0;

        }

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

        .wrap {
            display: flex;
            flex-direction: column;
            width: 100%;
            margin-top: 75px; /* 헤더의 높이만큼 여백 추가 */
            box-sizing: border-box;
            padding: 0 1rem;
        }

        .main-visual {
            position: relative;
        }

        .image-container {
            position: relative;
        }

        .overlay-image {
            position: absolute;
            top: 20%;
            left: 20%; /* 변경: 왼쪽에 겹치도록 설정 */
            z-index: 1;
        }


        .container {
            width: 90%;
            margin: 0 auto;
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

        .main-visual3 {
            width: 100%;
            height: 550px;
            background: #FFFFFF;
            overflow: hidden;
            position: relative;
        }

        .card-list {
            display: flex;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            animation: moveRight 15s linear infinite;
        }

        .card {
            width: 280px;
            height: 320px;
            background: #ECECEC;
            margin-right: 20px;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        @keyframes moveRight {
            0% {
                transform: translateX(-100%);
            }
            100% {
                transform: translateX(50%); /* 5 cards * (280px + 20px) */
            }
        }


        .strategy-container {
            width: 1280px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 600px;
        }

        .line1 {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
        }

        .line2 {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
        }

        .line1 > div {
            border: 1px solid #ccc;
            padding: 10px;
            width: 300px;
            height: 200px;
        }

        .line2 > div {
            border: 1px solid #ccc;
            padding: 10px;
            width: 300px;
            height: 200px;
        }

        .strategy-sidebar div {
            /*display: block;*/
            padding: 10px;
            text-decoration: none;
            color: black;
            border: 1px solid #ccc;
            margin-bottom: 5px;
            border-radius: 5px;
        }

        .strategy-sidebar div:hover {
            background-color: #f0f0f0;
        }

        .theme-top {
            background-image: url("C:/Users/NAMHOONKIM/Desktop/programming/di/src/main/resources/static/img/s1.svg");
        }

        .theme-top-top {
            height: 40px;
        }

        .theme-top-bottom {
            height: 40px;
            font-family: '하나2.0 M';
            margin-left: 10px;
        }

        .theme-bottom-top {
            height: 60px;
            display: flex;
            /*justify-content: center;*/
            align-items: center;
            margin-left: 10px;
            font-family: "하나2.0 R";
            font-size: 13px;
        }

        .theme-bottom-bottom {
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px; /* 버튼 사이 간격 조절 */
        }

        .theme-report-button {
            padding: 10px 20px;
            color: black;
            background-color: #E5E5E5;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            /*font-weight: bolder;*/
        }

        .theme-report-button:hover {
            background-color: #757575; /* hover 시 배경색 변경 */
        }

        .theme-performance-button {
            padding: 10px 20px;
            color: white;
            background-color: #332D41; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
        }

        .theme-performance-button:hover {
            background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
        }

        .sector-top {
            background-image: url("static/img/s2.svg");
        }

        .sector-top-top {
            height: 40px;
        }

        .sector-top-bottom {
            height: 40px;
            font-family: '하나2.0 M';
            margin-left: 10px;
        }

        .sector-bottom-top {
            height: 60px;
            display: flex;
            /*justify-content: center;*/
            align-items: center;
            margin-left: 10px;
            font-family: "하나2.0 R";
            font-size: 13px;
        }

        .sector-bottom-bottom {
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px; /* 버튼 사이 간격 조절 */
        }

        .sector-report-button {
            padding: 10px 20px;
            color: black;
            background-color: #E5E5E5;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            /*font-weight: bolder;*/
        }

        .sector-report-button:hover {
            background-color: #757575; /* hover 시 배경색 변경 */
        }

        .sector-performance-button {
            padding: 10px 20px;
            color: white;
            background-color: #332D41; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
        }

        .sector-performance-button:hover {
            background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
        }

        .daega-top {
            background-image: url("static/img/s3.svg");
        }

        .daega-top-top {
            height: 40px;
        }

        .daega-top-bottom {
            height: 40px;
            font-family: '하나2.0 M';
            margin-left: 10px;
        }

        .daega-bottom-top {
            height: 60px;
            display: flex;
            /*justify-content: center;*/
            align-items: center;
            margin-left: 10px;
            font-family: "하나2.0 R";
            font-size: 13px;
        }

        .daega-bottom-bottom {
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px; /* 버튼 사이 간격 조절 */
        }

        .daega-report-button {
            padding: 10px 20px;
            color: black;
            background-color: #E5E5E5;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            /*font-weight: bolder;*/
        }

        .daega-report-button:hover {
            background-color: #757575; /* hover 시 배경색 변경 */
        }

        .daega-performance-button {
            padding: 10px 20px;
            color: white;
            background-color: #332D41; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
        }

        .daega-performance-button:hover {
            background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
        }

        .mine-top {
            background-image: url("static/img/s4.png");
        }

        .mine-top-top {
            height: 40px;
        }

        .mine-top-bottom {
            height: 40px;
            font-family: '하나2.0 M';
            margin-left: 10px;
        }

        .mine-bottom-top {
            height: 60px;
            display: flex;
            /*justify-content: center;*/
            align-items: center;
            margin-left: 10px;
            font-family: "하나2.0 R";
            font-size: 13px;
        }

        .mine-bottom-bottom {
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px; /* 버튼 사이 간격 조절 */
        }

        .mine-report-button {
            padding: 10px 20px;
            color: black;
            background-color: #E5E5E5;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            /*font-weight: bolder;*/
        }

        .mine-report-button:hover {
            background-color: #757575; /* hover 시 배경색 변경 */
        }

        .mine-performance-button {
            padding: 10px 20px;
            color: white;
            background-color: #332D41; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
        }

        .mine-performance-button:hover {
            background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
        }

        .extra1-top {
            background-image: url("static/img/s5.png");
        }

        .extra1-top-top {
            height: 40px;
        }

        .extra1-top-bottom {
            height: 40px;
            font-family: '하나2.0 M';
            margin-left: 10px;
        }

        .extra1-bottom-top {
            height: 60px;
            display: flex;
            /*justify-content: center;*/
            align-items: center;
            margin-left: 10px;
            font-family: "하나2.0 R";
            font-size: 13px;
        }

        .extra1-bottom-bottom {
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px; /* 버튼 사이 간격 조절 */
        }

        .extra1-report-button {
            padding: 10px 20px;
            color: black;
            background-color: #E5E5E5;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            /*font-weight: bolder;*/
        }

        .extra1-report-button:hover {
            background-color: #757575; /* hover 시 배경색 변경 */
        }

        .extra1-performance-button {
            padding: 10px 20px;
            color: white;
            background-color: #332D41; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            width: 300px;
        }

        .extra1-performance-button:hover {
            background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
        }

        .extra2-top {
            background-image: url("static/img/s1.svg");
        }


        .extra2-top-top {
            height: 40px;
        }

        .extra2-top-bottom {
            height: 40px;
            font-family: '하나2.0 M';
            margin-left: 10px;
        }

        .extra2-bottom-top {
            height: 60px;
            display: flex;
            /*justify-content: center;*/
            align-items: center;
            margin-left: 10px;
            font-family: "하나2.0 R";
            font-size: 13px;
        }

        .extra2-bottom-bottom {
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px; /* 버튼 사이 간격 조절 */
        }

        .extra2-report-button {
            padding: 10px 20px;
            color: black;
            background-color: #E5E5E5;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            /*font-weight: bolder;*/
        }

        .extra2-report-button:hover {
            background-color: #757575; /* hover 시 배경색 변경 */
        }

        .extra2-performance-button {
            padding: 10px 20px;
            color: white;
            background-color: #332D41; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
        }

        .extra2-performance-button:hover {
            background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
        }


        /*footer*/

        footer {
            display: flex;
            flex-direction: column;

        }

    </style>
</head>
<body>
<div class="wrap">
    <header>
        <div class="container">
            <div class="logo">
                <a href="/"><img src="img/logo.png" alt="로고"></a>
            </div>

            <nav>
                <ul>
                    <li><a href="/sogae">다이렉트인덱싱</a></li>
                    <li><a href="/start">시작하기</a></li>
                    <li><a href="#">내 포트폴리오</a></li>
                    <li><a href="#">내 전략</a></li>
                    <li><a href="#">모의테스트</a></li>
                    <li><a href="#">백테스트</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <div class="contents">
        <div class="main-visual"
             style="width: 100%; height: 800px;  display: flex; flex-direction: column;  align-items: center; position: relative; ">
            <h1>전략을 선택하세요.</h1>
            <div class="strategy-container">
                <div class="line1">
                    <div class="theme">
                        <div class="theme-top">
                            <div class="theme-top-top">
                     <span class="emoji-with-circle">
  <span>🇰🇷</span>
</span>

                                <span class="emoji-with-circle">
  <span>🔥</span>
</span>
                            </div>
                            <div class="theme-top-bottom">
                                테마 성장주 집중 전략
                            </div>
                        </div>
                        <div class="theme-bottom">
                            <div class="theme-bottom-top">
                                하나 증권이 Pick한 Hot한 테마들에 투자해보세요.
                            </div>
                            <div class="theme-bottom-bottom">
                                <button class="theme-report-button" onclick="moveTheme()"> 리포트 더 보기</button>
                                <button class="theme-performance-button"> 투자 성과 확인하기</button>
                            </div>
                        </div>
                    </div>
                    <div class="sector">
                        <div class="sector-top">
                            <div class="sector-top-top">
            <span class="emoji-with-circle">
                <span>🇰🇷</span>
            </span>

                                <span class="emoji-with-circle">
                <span>🔥</span>
            </span>
                            </div>
                            <div class="sector-top-bottom">
                                섹터 성장주 집중 전략
                            </div>
                        </div>
                        <div class="sector-bottom">
                            <div class="sector-bottom-top">
                                하나 증권이 Pick한 Hot한 섹터들에 투자해보세요.
                            </div>
                            <div class="sector-bottom-bottom">
                                <button class="sector-report-button"> 리포트 더 보기</button>
                                <button class="sector-performance-button"> 투자 성과 확인하기</button>
                            </div>
                        </div>
                    </div>

                    <div class="daega">
                        <div class="daega-top">
                            <div class="daega-top-top">
            <span class="emoji-with-circle">
                <span>🇰🇷</span>
            </span>

                                <span class="emoji-with-circle">
                <span>🔥</span>
            </span>
                            </div>
                            <div class="daega-top-bottom">
                                대가 성장주 집중 전략
                            </div>
                        </div>
                        <div class="daega-bottom">
                            <div class="daega-bottom-top">
                                하나 증권이 Pick한 Hot한 대가들에 투자해보세요.
                            </div>
                            <div class="daega-bottom-bottom">
                                <button class="daega-report-button"> 리포트 더 보기</button>
                                <button class="daega-performance-button"> 투자 성과 확인하기</button>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="line2">
                    <div class="mine">
                        <div class="mine-top">
                            <div class="mine-top-top">
            <span class="emoji-with-circle">
                <span>🇰🇷</span>
            </span>

                                <span class="emoji-with-circle">
                <span>🔥</span>
            </span>
                            </div>
                            <div class="mine-top-bottom">
                                나만의 성장주 집중 전략
                            </div>
                        </div>
                        <div class="mine-bottom">
                            <div class="mine-bottom-top">
                                하나 증권이 Pick한 Hot한 항목들에 투자해보세요.
                            </div>
                            <div class="mine-bottom-bottom">
                                <button class="mine-report-button"> 리포트 더 보기</button>
                                <button class="mine-performance-button"> 투자 성과 확인하기</button>
                            </div>
                        </div>
                    </div>

                    <div class="extra1">
                        <div class="extra1-top">
                            <div class="extra1-top-top">
            <span class="emoji-with-circle">
                <span>✍️</span>
            </span>

                                <!--                                <span class="emoji-with-circle">-->
                                <!--&lt;!&ndash;                <span>🔥</span>&ndash;&gt;-->
                                <!--            </span>-->
                            </div>
                            <div class="extra1-top-bottom">
                                추가1 성장주 집중 전략
                            </div>
                        </div>
                        <div class="extra1-bottom">
                            <div class="extra1-bottom-top">
                                하나 증권이 Pick한 Hot한 추가1 항목들에 투자해보세요.
                            </div>
                            <div class="extra1-bottom-bottom">
                                <!--                                <button class="extra1-report-button"> 리포트 더 보기</button>-->
                                <button class="extra1-performance-button"> 만들어 보기</button>
                            </div>
                        </div>
                    </div>

                    <div class="extra2">
                        <div class="extra2-top">
                            <div class="extra2-top-top">
            <span class="emoji-with-circle">
                <span>🇰🇷</span>
            </span>

                                <span class="emoji-with-circle">
                <span>🔥</span>
            </span>
                            </div>
                            <div class="extra2-top-bottom">
                                추가2 성장주 집중 전략
                            </div>
                        </div>
                        <div class="extra2-bottom">
                            <div class="extra2-bottom-top">
                                하나 증권이 Pick한 Hot한 추가2 항목들에 투자해보세요.
                            </div>
                            <div class="extra2-bottom-bottom">
                                <button class="extra2-report-button"> 리포트 더 보기</button>
                                <button class="extra2-performance-button"> 투자 성과 확인하기</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>


    </div>
    <footer id="footer" style="background-color: #111111; color: white;">
        <div class="top"
             style="border-bottom: 1px solid hsla(0,0%,49%,.2); width: 100%; height: 70px; display: flex; align-items: center; ">
            <div class="inner"
                 style="display: flex; flex-direction: row; justify-content: space-between;  align-items: center; margin: 0 auto; width: 1280px;">
                <div class="link" style="font-family: '하나2.0 M'; font-size : 14px; color : #cccccc;">
                    <ul style="display: flex; list-style: none; padding: 0; justify-content: space-evenly;">
                        <li style="margin-right: 20px;">개인정보처리방침</li>
                        <li style="margin-right: 20px;">신용정보활용체제</li>
                        <li style="margin-right: 20px;">고객정보취급방침</li>
                        <li>하나맵</li>
                    </ul>
                </div>
                <div class="sns" style="margin-top: 0.3rem;">
                    <img src="img/ico-youtube.svg" style="margin-right: 5px;">
                    <img src="img/ico-instagram.svg">
                    <img src="img/ico-tictok.svg" style="margin-right: -2px;">
                    <img src="img/ico-facebook.svg">
                </div>

            </div>
        </div>

        <div class="bottom">
            <div class="inner"
                 style="color:#A0AAAA;  margin: 0 auto; width: 1280px; font-size: 14px; font-family: '하나2.0 R'; padding: 40px 0 50px;">
                <a href="/ko/main/index.do" class="logo" title="홈으로" aria-label="홈으로">
                    <img src="img/logo-w.svg" alt="하나금융그룹 로고" style="width: 140px; height:28px; ">
                </a>
                <p>
                    <span>서울특별시 중구 을지로 66</span>
                    <span>02.2002.1110</span></p>
                <p>Copyright ⓒ 2022 HANA FINANCIAL GROUP. All rights Reserved.</p>
            </div>
        </div>
    </footer>
</div>
<script>
    function moveTheme() {
        window.location.href = "Theme.html";
    }
</script>
</body>
</html>