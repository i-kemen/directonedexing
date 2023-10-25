<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agree Component</title>
    <style>
        .di-wrap {
            width: 1440px;
            height: 1000px;
            /*display: flex;*/
            /*flex-direction: column;*/
            /*정중앙 배치 */
            /*position: absolute;*/
            /*top: 50%;*/
            /*left: 50%;*/
            /*transform: translate(-50%, -50%);*/
            /*가로 기준 중앙 배치 */
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }

        .di-header {
            display: flex;
            align-items: center;
            justify-content: space-between; /* 이미지와 버튼 사이의 간격을 최대화하여 배치 */
            width: 1440px;
            height: 80px
        }

        .image-1qpro {
            width: 60px; /* 원하는 너비 값으로 변경 */
            height: 66px; /* 높이를 자동으로 조정하여 비율 유지 */
        }

        .di-main-1 {
            height: 800px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background-color: #0B9B97;
            font-family: "하나2.0 B";
            font-size: 60px;
            color: white;
            text-align: center;
            align-items: center;
        }

        .start-button {
            margin-top: 50px;
            display: inline-block;
            padding: 10px 20px;
            background-color: #058782;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            /* 버튼의 크기 조정 */
            width: 200px;
            height: 50px;
            font-family: "하나2.0 B";
            font-size: 20px;
            color: #ffffff;
        }

        .start-button:hover {
            background-color: #10a8a3;
        }

        .apple-button {
            display: inline-flex;
            align-items: center;
            background-color: #333D4B;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 5px;
            font-family: "하나2.0 B";
            font-size: 15px;
            color: #ffffff;
            height: 50px;
        }

        .apple-button:hover {
            background-color: #4E5968; /* 호버 시 배경색 변경 */
        }


        .img-apple {
            width: 24px; /* 이미지의 크기 조절 */
            height: auto; /* 높이 자동으로 조정하여 비율 유지 */
            margin-right: 10px; /* 이미지와 텍스트 사이의 간격 조절 */
        }

        p {
            margin: 0;
        }

        .google-button {
            display: inline-flex;
            align-items: center;
            background-color: #333D4B;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-family: "하나2.0 B";
            font-size: 15px;
            color: #ffffff;
            height: 50px;
        }

        .google-button:hover {
            background-color: #4E5968;
        }

        .button-content {
            display: flex;
            align-items: center;
        }

        .img-google {
            width: 24px;
            height: auto;
            margin-right: 10px;
        }

        p {
            margin: 0;
        }

        /* Add your modal styles here */
        .modal {
            display: flex;
            justify-content: center;
            align-items: center;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* 배경색과 투명도 조절 */
            z-index: 1000;
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            font-family: "하나2.0 B";
            font-size: 16px;
            color: black;
            text-align: center;
            width: 900px;
            height: 400px;
        }

        .modal-content p {
            font-size: 40px; /* 원하는 크기로 조절 */
            font-weight: bold; /* 폰트를 굵게 표시 */
        }

        /* 버튼 스타일 */
        button {
            padding: 10px 20px;
            background-color: #04BE9E;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            cursor: pointer;
            margin: 5px;
            font-family: "하나2.0 M";
        }

        button:hover {
            background-color: #009B84;
        }

        /* 체크박스 스타일 */
        input[type="checkbox"] {
            margin-right: 5px;
        }

        /* 텍스트 스타일 */
        p, div {
            margin: 10px 0;
        }

        .modal-close {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
        }

        .di-main-1 p,
        .di-main-1 div {
            opacity: 0; /* 처음에는 안 보이게 설정 */
            transition: opacity 1s; /* 1초 동안 페이드인 효과 적용 */
        }

        .modal-content div {
            text-align: left; /* 왼쪽 정렬 */
        }
    </style>
</head>
<body>
<div class="di-wrap">
    <div class="di-header">
        <div class="logo">
            <a href="/"><img src="img/logo.png" alt="로고"></a>
        </div>

        <div class="buttons">

            <button class="apple-button" onclick="linkApple()">
                <img class="img-apple" src="img/applekorea.png" alt="버튼 이미지">
                <p>App Store</p>
            </button>
            <button class="google-button" onclick="linkGoogle()">
                <img class="img-google" src="img/googleplay.png" alt="버튼 이미지">
                <p>Google Play</p>
            </button>
        </div>
    </div>
    <div class="di-main">
        <div class="di-main-1">
            <p>주식 투자의 단 하나의 기준</p>
            <p>다이렉트 ONE덱싱</p>
            <div>
                <button class="start-button" onclick="handleModalOpen()">
                    지금 시작하기
                </button>
            </div>
        </div>
    </div>
    <div class="di-footer"></div>
</div>

<div id="modal" class="modal">
    <div class="modal-content">
        <!-- Modal content here -->
        <p>안 내</p>
        <p></p>
        <p></p>
        <div>1. 고객님의 투자성향에 부적합한 상품(주식)이 조회 될 수 있습니다.</div>
        <div>2. 고객님은 투자원금의 보전보다는 위험을 간매하더라도 높은 수준의 투자수익 실현을 추구하고,</div>
        <div>&nbsp;&nbsp;&nbsp;&nbsp;투자자산의 상당 부분을 위험자산에 투자할 용의가 있는 '적극투자형'의 성향을 가지고 있으며,</div>
        <div>&nbsp;&nbsp;&nbsp;&nbsp;'고위험 이하' 등급의 상품 투자가 적합합니다.</div>
        <div>3. 하나 다이렉트원덱싱은 '초고위험' 등급의 주식 상품을 포함하고 있어 투자자문계약은 '공격투자형' 이상만 가능합니다.</div>
        <div>
            <input type="checkbox" id="dontShowToday">
            <label for="dontShowToday">오늘 하루 보지 않기</label>
        </div>
        <button onclick="handleModalClose()">취소</button>
        <button onclick="toStrategy()">이해했으며 계속하겠습니다.</button>
        <div>

        </div>
    </div>
</div>

<script>

    function linkApple() {
        window.location.href = "https://apps.apple.com/kr/app/%ED%95%98%EB%82%98%EC%A6%9D%EA%B6%8C-%EC%9B%90%ED%81%90%ED%94%84%EB%A1%9C-%EA%B3%84%EC%A2%8C%EA%B0%9C%EC%84%A4%ED%8F%AC%ED%95%A8/id1506702407"
    }

    function linkGoogle() {
        window.location.href = "https://play.google.com/store/search?q=%EC%9B%90%ED%81%90%ED%94%84%EB%A1%9C&c=apps&hl=ko-KR";
    }

    function handleModalOpen() {
        var modal = document.getElementById("modal");
        modal.style.display = "block";
    }

    function handleModalClose() {
        var modal = document.getElementById("modal");
        modal.style.display = "none";

    }

    function toStrategy() {
        window.location.href = "/"
    }

    // 페이지가 로드될 때 모달 상태를 초기화하는 함수를 추가합니다.
    function resetModalStatus() {
        var modal = document.getElementById("modal");
        modal.style.display = "none";
    }

    // 페이지가 로드될 때 resetModalStatus 함수를 호출합니다.
    window.onload = resetModalStatus;

    function fadeInText() {
        const textElements = document.querySelectorAll(".di-main-1 p, .di-main-1 div");
        let delay = 0;

        textElements.forEach(element => {
            setTimeout(() => {
                element.style.opacity = "1";
            }, delay);
            delay += 1000; // 각 요소가 1초 간격으로 나타나게 설정
        });
    }

    window.onload = function () {
        resetModalStatus();
        fadeInText();
    }
</script>
</body>
</html>
