<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!Doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.4.0/kakao.min.js"
            integrity="sha384-mXVrIX2T/Kszp6Z0aEWaA8Nm7J6/ZeWXbL8UpGRjKwWe56Srd/iyNmWMBhcItAjH"
            crossorigin="anonymous"></script>
    <script>
        Kakao.init('803d17852f25c4a01c476818dce24472'); // 카카오 SDK 초기화
    </script>
    <style>

        body {
            margin: 0;
            padding: 0;

        }

        .wrap {
            display: flex;
            flex-direction: column;
            width: 100%; /* 변경된 부분 */
            max-width: 1440px; /* 추가된 부분 */
            margin: 75px auto 0; /* 변경된 부분 */
            box-sizing: border-box;
            padding: 0 1rem;
            justify-content: center;
            align-items: center;
        }

        .main-visual {
            position: relative;
            height: 550px;
            width: 977px;
            margin-bottom: -50px;
        }

        .image-container {
            position: relative;
        }

        .overlay-image {
            position: absolute;
            top: 10%;
            left: 20%; /* 변경: 왼쪽에 겹치도록 설정 */
            z-index: 1;
        }


        .main-visual img {
            max-width: 100%;
            height: auto;
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

        .slide-show {
            position: relative;
        }

        .slide {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            opacity: 0;
            transition: opacity 0.5s;
        }

        .slide.active {
            opacity: 1;
        }

    </style>
</head>
<body>
<div class="wrap">
    <%@ include file="header.jsp" %>
    <div class="contents">
        <section class="main-visual">
            <div class="slide-show">
                <!-- 기존 이미지 세트 -->
                <div class="slide active">
                    <img src="img/jal.png" width="100%" style="background: #0E8C8D; height: 500px !important;">
                    <img src="img/hanada.png" class="overlay-image" style="width: 600px; height: 350px;">
                </div>
                <div class="slide">
                    <img src="img/mainhana4.jpg" width="100%">
                </div>
                <!-- 새로운 이미지 세트 추가 -->
                <div class="slide">
                    <img src="img/mainhana1.jpg" width="100%">
                </div>
                <div class="slide">
                    <img src="img/mainhana2.jpg" width="100%">
                </div>
                <div class="slide">
                    <img src="img/mainahana3.jpg" width="100%">
                </div>
            </div>
        </section>
        <section class="main-visual2"
                 style="width: 100%; height: 550px; background: #ffffff; display: flex; justify-content: center; align-items: center; position: relative; ">
            <div class="vd -active">
                <div class="video-wrapper" style="filter: brightness(0.7);">
                    <video id="brand-video" muted="" playsinline="" loop="" autoplay=""
                           poster="img/brand_stock_poster.jpg" height="550" width="100%">
                        <source src="img/brand_stock_bg.mp4" type="video/mp4">
                    </video>
                </div>
            </div>
            <div class="contents" style="position: absolute; z-index: 2; text-align: center; color: #FFFFFF; top: -5%;">
                <h1 class="title"
                    style="display: block; padding: 80px 0 30px; font-size: 37px; line-height: 46px; letter-spacing: -1.73px; font-weight: 700; font-family:'하나2.0 B'">
                    누구나 쉬운 인덱싱<br>하나 다이렉트원덱싱</h1>
                <p class="txt"
                   style="font-size: 14px; line-height: 21px; opacity: .7; letter-spacing: -0.65px; font-family: '하나2.0 B'">
                    원큐스탁은
                    개인마다 다른 투자 습관을 만족시키기 위한<br>컨텐츠 커스터마이징을 제공합니다.</p>
                <p class="txt"
                   style="font-size: 14px; line-height: 21px; opacity: .7; letter-spacing: -0.65px; font-family: '하나2.0 B'">
                    국내뿐만
                    아니라 해외주식도 원큐스탁에서<br>쉽게 시작해 보세요.</p>
            </div>
        </section>
    </div>
    <%@ include file="footer.jsp" %>
</div>

</body>
</html>