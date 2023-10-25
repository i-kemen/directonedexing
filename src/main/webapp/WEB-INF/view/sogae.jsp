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

        .wrap {
            display: flex;
            flex-direction: column;
            width: 100%;       /* 변경된 부분 */
            max-width: 1440px; /* 추가된 부분 */
            margin: 75px auto 0; /* 변경된 부분 */
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
            height: 1000px;
            background: #FFFFFF;
            overflow: hidden;
            position: relative;
            font-family: "하나2.0 M";
            font-size: 70px;
            font-weight: 700;
            color : #0B9B97;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
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

    </style>
</head>
<body>
<div class="wrap">
    <%@ include file="header.jsp" %>
    <div class="contents">
        <section class="main-visual">
            <img src="img/slide1.jpg" width="100%" style="background: #0E8C8D">
        </section>
        <section class="main-visual2">
            <img src="img/slide2.png" width="100%" height="720px"style="background: #0E8C8D">
        </section>
        <section class="main-visual3" style="margin-top: 100px; margin-bottom: 100px;">
            <span>쉽게 이해하는</span>
            <span>나만의 전략 만들기</span><br>

            <iframe width="100%" height="800" src="https://www.youtube.com/embed/EyrkDZw193Q" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </section>
    </div>
    <%@ include file="footer.jsp" %>
</div>
</body>
</html>