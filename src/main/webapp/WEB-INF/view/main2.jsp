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
                    <li><a href="/edit">시작하기</a></li>
                    <li><a href="#">내 포트폴리오</a></li>
                    <li><a href="#">내 전략</a></li>
                    <li><a href="#">모의테스트</a></li>
                    <li><a href="#">백테스트</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <div class="contents">
        <section class="main-visual">
            <img src="img/jal.png" width="100%" style="background: #0E8C8D">
            <img src="img/hanada.png" class="overlay-image" style="width: 600px; height: 350px;">
        </section>
        <section class="main-visual2"
                 style="width: 100%; height: 550px; background: #F6FAF6; display: flex; justify-content: center; align-items: center; position: relative; ">
            <div class="vd -active">
                <div class="video-wrapper" style="filter: brightness(0.7);">
                    <video id="brand-video" muted="" playsinline="" loop="" autoplay=""
                           poster="img/brand_stock_poster.jpg" height="550">
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
        <section class="main-visual3" style="width: 100%; height: 550px; background: #FFFFFF">

            <div class="card-list">
                <div class="card">Card 1</div>
                <div class="card">Card 2</div>
                <div class="card">Card 3</div>
                <div class="card">Card 4</div>
                <div class="card">Card 5</div>
                <div class="card">Card 1</div>
                <div class="card">Card 2</div>
                <div class="card">Card 3</div>
                <div class="card">Card 4</div>
                <div class="card">Card 5</div>
            </div>
        </section>
        <section class="main-visual4" style="width: 100%; height: 550px; background: #626E62">


        </section>


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
</body>
</html>