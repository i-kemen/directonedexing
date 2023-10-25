<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <%--    하이차트--%>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/heatmap.js"></script>
    <script src="https://code.highcharts.com/modules/treemap.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>


    <style>
        .highcharts-figure,
        .highcharts-data-table table {
            min-width: 320px;
            max-width: 600px;
            margin: 1em auto;
        }

        .highcharts-data-table table {
            font-family: Verdana, sans-serif;
            border-collapse: collapse;
            border: 1px solid #ebebeb;
            margin: 10px auto;
            text-align: center;
            width: 100%;
            max-width: 500px;
        }

        .highcharts-data-table caption {
            padding: 1em 0;
            font-size: 1.2em;
            color: #555;
        }

        .highcharts-data-table th {
            font-weight: 600;
            padding: 0.5em;
        }

        .highcharts-data-table td,
        .highcharts-data-table th,
        .highcharts-data-table caption {
            padding: 0.5em;
        }

        .highcharts-data-table thead tr,
        .highcharts-data-table tr:nth-child(even) {
            background: #f8f8f8;
        }

        .highcharts-data-table tr:hover {
            background: #f1f7ff;
        }

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


        @keyframes moveRight {
            0% {
                transform: translateX(-100%);
            }
            100% {
                transform: translateX(50%); /* 5 cards * (280px + 20px) */
            }
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


        /*footer*/

        footer {
            display: flex;
            flex-direction: column;

        }


        /*메인*/


        .card-top-top p {
            margin-left: 20px; /* 원하는 들여쓰기 크기를 지정 */
        }


        /*본문*/

        .contents {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .indexing-wrap {
            display: flex;
            flex-direction: row;
            border: #7f73eb 1px solid;
            width: 80%;
            height: 100vh;
        }

        .index-left {
            display: flex;
            flex-direction: column;
            border: blue 1px solid;
            width: 50%;
            height: 100%;
            overflow: auto;
        }

        .index-right {
            display: flex;
            flex-direction: column;
            border: red 1px solid;
            width: 50%;
            height: 100%;
            overflow: auto;
        }

        .index-left .market,
        .index-left .industry,
        .index-left .jogun {
            display: flex;
            justify-content: space-between;
            background-color: #cccccc;
            height: 100px;
            border: black 1px solid;
            align-items: center;
        }


        .index-left .suljeong,
        .index-left .rebal,
        .index-left .whghl,
        .index-left .ansa {
            display: flex;
            justify-content: space-between;
            background-color: #cccccc;
            height: 100px;
            border: black 1px solid;
            flex-direction: column;
        }

        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;

            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }

        .modal-content {
            background: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, .3);
            position: absolute;
            overflow: hidden;
            top: 60%;
            left: 70%;
            transform: translate(-50%, -50%);
            max-width: 100%;
            width: 600px;
            height: 800px;
            animation-name: modalopen;
            animation-duration: var(--modal-duration);

        }

        /* 닫기 버튼 스타일 */
        .close {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 20px;
            cursor: pointer;
        }


        .dropdown {
            position: relative;
            display: inline-block;
            margin-right: 20px; /* 드롭다운 사이 간격 조절 */
        }

        label {
            position: absolute;
            top: -20px; /* option 위에 표시하려면 음수 값 사용 */
            left: 0;
        }

        /* select 요소 스타일링 */
        select {
            width: 200px; /* 너비 조절 */
            padding: 10px; /* 내부 여백 설정 */
            border: 1px solid #ccc; /* 테두리 스타일 설정 */
            background-color: #f2f2f2; /* 배경색 설정 */
            color: #333; /* 텍스트 색상 설정 */
        }

        /* option 요소 스타일링 */
        option {
            background-color: #fff; /* 옵션 배경색 설정 */
            color: #333; /* 옵션 텍스트 색상 설정 */
        }

        /*모달1*/
        .modal1-index {
            display: flex;
            flex-direction: column;
        }

        .modal1-index-main {
            display: flex;
            flex-direction: column;
            align-items: center;
            border: 1px solid red;
            height: 300px;
            justify-content: space-around;
        }

        .index-card {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1), 0 6px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;

        }

        .index-card:hover {
            transform: scale(1.01);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2), 0 12px 40px rgba(0, 0, 0, 0.2);
        }

        /*모달2*/
        .modal2-checklist {
            display: flex;
            flex-direction: column;
        }

        /* 모든 div 요소의 기본 스타일 */
        .modal2-checklist div {
            margin-bottom: 10px;
        }

        /* 모든 체크박스 요소의 스타일 */
        .modal2-checklist input[type='checkbox'] {
            margin-right: 5px;
        }

        /* 상위 div 요소의 스타일 */
        .modal2-checklist > div {
            font-size: 16px; /* 글씨 크기 조정 */
            font-weight: bold; /* 굵은 글씨로 설정 */
        }

        /* 중첩된 div 요소의 스타일 */
        .modal2-checklist > div > div {
            margin-left: 20px;
            font-size: 14px; /* 하위 div의 글씨 크기를 조정 (원하는 크기로 변경 가능) */
            font-weight: normal; /* 하위 div의 글씨 굵기를 정상으로 복원 */
        }


        #jongmok {
            background: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, .3);
            position: absolute;
            overflow: hidden;
            top: 60%;
            left: 70%;
            transform: translate(-50%, -50%);
            max-width: 100%;
            width: 1200px;
            height: 800px;
            animation-name: modalopen;
            animation-duration: var(--modal-duration);
        }

        .modal3-main {
            display: flex;
            flex-direction: row;
        }

        .modal3-jogun {
            border: 1px solid red;
            display: flex;
            flex-direction: column;
            width: 600px;
            height: 800px;
            overflow: auto;
        }

        .modal3-graph {
            border: 1px solid blue;
            display: flex;
            flex-direction: column;
            width: 600px;
            height: 800px;
            overflow: auto;
        }

        .jogun-header {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
        }


        .score {
            display: flex;
            flex-direction: column;
        }

        .score-header {
            display: flex;
            flex-direction: row;
            align-items: center;
        }

        .score-header > h6 {
            background-color: #cccccc;
            color: mediumpurple;
        }


        /* 초기 상태: 숨겨짐 */
        .dropdown-content {
            display: none;
            /* 다른 스타일 속성들 추가 가능 */
        }

        /* 열린 상태: 보임 */
        .dropdown-open .dropdown-content {
            display: block;
        }

        /* 아이콘의 스타일 설정 */
        .dropdown-icon {
            width: 20px;
            height: 20px;
        }
    </style>
</head>
<body>
<div class="wrap">
    <%@ include file="header.jsp" %>
    <figure class="highcharts-figure">
        <div id="container"></div>
        <p class="highcharts-description">
        </p>
    </figure>
    <table id="stockTable" border="1">
        <thead>
        <tr>
            <th>티커</th>
            <th>종목명</th>
            <th>시장</th>
            <th>비중</th>
            <th>편입</th>
        </tr>
        </thead>
        <tbody>
        <!-- JavaScript를 사용하여 행이 여기에 동적으로 삽입됩니다. -->
        </tbody>
    </table>
    <div class="contents">
        <div class="main-visual"
             style="width: 100%; height: 100px;  display: flex; flex-direction: column;  align-items: center; position: relative; ">
            <h1>다이렉트인덱싱</h1>

        </div>
        <div class=indexing-wrap>
            <div class="index-left">
                <div class="market">
                    투자할 시장/지수 선택
                    <span class="modal-trigger" data-modal-id="modal1">KOSPI
                        <span class="arrow">&#9658;</span>
                    </span>
                </div>
                <div class="industry">
                    투자할 산업 선택
                    <span class="modal-trigger" data-modal-id="modal2">0 <span class="arrow">&#9658;</span></span>
                </div>
                <div class="jogun">
                    종목 선정 조건 선택<br>

                    <span class="modal-trigger" data-modal-id="modal3">추가하기 <span class="arrow">&#9658;</span></span>
                </div>
                <div class="suljeong">
                    포트폴리오 설정
                    <div class="dropdown-wrap"
                         style="display: flex; flex-direction: row; justify-content: space-between; align-items: center;">
                        <div class="dropdown">
                            <label for="dropdown1">종목 우선순위</label>
                            <select id="dropdown1" name="dropdown1">
                                <option value="option1">시가총액 높은 순</option>
                                <option value="option2">시가총액 낮은 순</option>
                                <option value="option2">영업이익률 우선</option>
                                <option value="option3">자본수익률 우선</option>
                            </select>
                        </div>
                        <div class="dropdown">
                            <label for="dropdown2">두 번째 드롭다운:</label>
                            <select id="dropdown2" name="dropdown2">
                                <option value="optionA">동일비중</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="rebal">
                    리밸런싱 설정
                    <div class="rebal-box" style="display: flex; flex-direction: row;justify-content: space-evenly">
                        <div class="rebal-item">
                            <label for="num-of-assets">구성 종목 수:</label>
                            <input type="number" id="num-of-assets" name="num-of-assets" min="5" max="50" value="30">
                            <div id="error-message" class="error-message"></div>
                        </div>
                        <div class="rebal-item">
                            <label for="rebal-period">포트폴리오 리밸런싱 주기:</label>
                            <select id="rebal-period" name="rebal-period">
                                <option value="3months">3개월마다 한 번</option>
                                <option value="6months">6개월마다 한 번</option>
                                <option value="1year">1년마다 한 번</option>
                            </select>
                        </div>
                    </div>
                </div>


                <div class="sungga">
                    투자 성과 조회 기준 설정
                </div>
                <div class="sungga-box">
                    <div class="sungga-item">
                        <div id="calendar"></div>
                    </div>
                    <div class="sungga-item">
                        <label for="end-date">종료:</label>
                        <input type="date" id="end-date" name="end-date">
                    </div>
                    <div class="sungga-item">
                        <label for="benchmark">벤치마크:</label>
                        <select id="benchmark" name="benchmark">
                            <option value="benchmark1">벤치마크 1</option>
                            <option value="benchmark2">벤치마크 2</option>
                            <option value="benchmark3">벤치마크 3</option>
                        </select>
                    </div>
                </div>
                <div class="ansa">
                    투자하지 않을 종목

                    투자하기 싫은 종목이 있다면 편입여부 기능을 조정하여 종목 리스트에서 제외할 수 있습니다. 제외된 종목들은 투자 기준에 적합하더라도, 포트폴리오에 포함되지 않습니다.

                </div>
            </div>
            <div class="index-right">

            </div>
        </div>

    </div>
    <%@ include file="footer.jsp" %>
</div>
<!-- 모달 1 -->
<div id="modal1" class="modal">
    <div class="modal-content" style="justify-content: space-evenly">
        <div class="modal1-header"
             style="display: flex; flex-direction: row; justify-content: space-between; align-items: center; margin-top: 20px;
             border : 1px solid #0B9B97;">
            <div style="border: 1px solid #6ea8fe; font-family: '하나2.0 R'; font-size: 15px;">
                <div style="font-size: 20px; font-family: '하나2.0 B';">투자할 시장/지수 선택</div>
                투자할 시장 또는 지수를 선택하세요
            </div>
            <div style="display: flex; width : 250px; justify-content: space-evenly; align-items: center;">
                <button style="width: 100px; height:30px; font-family: '하나2.0 M'; font-size:15px; border:none; border-radius: 5px; color:white; background-color: #cccccc">
                    선택완료
                </button>
                <button id="nextModal1"
                        style="width: 50px; height:30px; font-family: '하나2.0 M'; font-size:15px; background-color:#00857E; border:none; border-radius: 5px; color : white;">
                    다음
                </button>
            </div>
        </div>
        <div class="modal1-index">
            <div class="modal1-index-header" style="font-size: 20px; font-family: '하나2.0 B'; margin-top: 30px;">지수</div>
            <div class="modal1-index-main">
                <div style="display: flex; width:550px; flex-direction: row; justify-content: space-between;">
                    <div class="index-card" id="index-card1" style="width:250px; height: 100px; display: flex; flex-direction: column; font-family: '하나2.0 R'; font-size: 15px;
                                    justify-content: space-around">
                        <div style="display: flex; flex-direction: row; justify-content: space-around">
                            <div class="card-title" style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
                                대한민국 TOP 100
                            </div>
                            <div style="width:25px; height: 25px; background-color: #CF3540; color: white; display: flex; justify-content: center; align-items: center; border-radius: 5px; font-weight: 700;">
                                KR
                            </div>
                        </div>
                        <div style="margin-left: 20px">
                            한국 100개의 대형 기업을 대상으로 하는 지수입니다.
                        </div>
                    </div>
                    <div class="index-card" id="index-card2" style="width:250px; height: 100px; display: flex; flex-direction: column;  font-family: '하나2.0 R'; font-size: 15px;
                                    justify-content: space-around">
                        <div style="display: flex; flex-direction: row; justify-content: space-around">
                            <div class="card-title" style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
                                한국시장 대표 기업
                            </div>
                            <div style="width:25px; height: 25px; background-color: #CF3540; color: white; display: flex; justify-content: center; align-items: center; border-radius: 5px; font-weight: 700;">
                                KR
                            </div>
                        </div>
                        <div style="margin-left: 20px">
                            한국 100개의 대형 기업을 대상으로 하는 지수입니다.
                        </div>
                    </div>
                </div>


                <div style="display: flex; width:550px; flex-direction: row; justify-content: space-between;">
                    <div class="index-card" id="index-card3" style="width:250px; height: 100px; display: flex; flex-direction: column; font-family: '하나2.0 R'; font-size: 15px;
                                    justify-content: space-around">
                        <div style="display: flex; flex-direction: row; justify-content: space-around">
                            <div class="card-title" style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
                                KOSPI 상장 대표 기업
                            </div>
                            <div style="width:25px; height: 25px; background-color: #CF3540; color: white; display: flex; justify-content: center; align-items: center; border-radius: 5px; font-weight: 700;">
                                KR
                            </div>
                        </div>
                        <div style="margin-left: 20px">
                            한국 100개의 대형 기업을 대상으로 하는 지수입니다.
                        </div>
                    </div>
                    <div class="index-card" id="index-card4" style="width:250px; height: 100px; display: flex; flex-direction: column; font-family: '하나2.0 R'; font-size: 15px;
                                    justify-content: space-around">
                        <div style="display: flex; flex-direction: row; justify-content: space-around">
                            <div class="card-title" style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
                                KOSDAQ 상장 대표 기업
                            </div>
                            <div style="width:25px; height: 25px; background-color: #CF3540; color: white; display: flex; justify-content: center; align-items: center; border-radius: 5px; font-weight: 700;">
                                KR
                            </div>
                        </div>
                        <div style="margin-left: 20px">
                            한국 100개의 대형 기업을 대상으로 하는 지수입니다.
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--        시장-->
        <div class="modal1-market">
            <div class="modal1-index-header" style="font-size: 20px; font-family: '하나2.0 B'; margin-top: 30px;">시장</div>
            <div class="modal1-index-main" style="height: 200px; ">
                <div style="display: flex; width:550px; flex-direction: row; justify-content: space-between;">
                    <div class="index-card" id="index-card5" style="width:250px; height: 100px; display: flex; flex-direction: column; font-family: '하나2.0 R'; font-size: 15px;
                                    justify-content: space-around">
                        <div style="display: flex; flex-direction: row; justify-content: space-around">
                            <div class="card-title" style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
                                대한민국
                            </div>
                            <div style="width:25px; height: 25px; background-color: #CF3540; color: white; display: flex; justify-content: center; align-items: center; border-radius: 5px; font-weight: 700;">
                                KR
                            </div>
                        </div>
                        <div style="margin-left: 20px">
                            대한민국 시장에 상장된 전체 기업을 대상으로 합니다.
                        </div>
                    </div>
                    <div class="index-card" id="index-card6" style="width:250px; height: 100px; display: flex; flex-direction: column;  font-family: '하나2.0 R'; font-size: 15px;
                                    justify-content: space-around">
                        <div style="display: flex; flex-direction: row; justify-content: space-around">
                            <div class="card-title" style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
                                미국
                            </div>
                            <div style="width:25px; height: 25px; background-color: #0A3161; color: white; display: flex; justify-content: center; align-items: center; border-radius: 5px; font-weight: 700;">
                                US
                            </div>
                        </div>
                        <div style="margin-left: 20px">
                            Coming soon.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 모달 2 -->
<div id="modal2" class="modal">
    <div class="modal-content" style="justify-content: space-evenly">
        <div class="modal2-header"
             style="display: flex; flex-direction: row; justify-content: space-between; align-items: center; margin-top: 20px;
             border : 1px solid #0B9B97;">
            <div style="border: 1px solid #6ea8fe; font-family: '하나2.0 R'; font-size: 15px;">
                <div style="font-size: 20px; font-family: '하나2.0 B';">투자할 산업 선택</div>
                투자하고 싶은 산업에 체크하세요.
            </div>
            <div style="display: flex; width : 250px; justify-content: space-evenly; align-items: center;">
                <button style="width: 100px; height:30px; font-family: '하나2.0 M'; font-size:15px; border:none; border-radius: 5px; color:white; background-color: #cccccc">
                    선택완료
                </button>
                <button id="nextModal2"
                        style="width: 50px; height:30px; font-family: '하나2.0 M'; font-size:15px; background-color:#00857E; border:none; border-radius: 5px; color : white;">
                    다음
                </button>
            </div>
        </div>
        <div class="modal2-checklist">
            <div>
                <input type='checkbox' name='all' value='all'/>전체선택
            </div>
            <div>
                <input type='checkbox' name='all' value='all'/>에너지
            </div>
            <div>
                <input type='checkbox' name='all' value='all'/>소재
            </div>
            <div>
                <input type='checkbox' name='all' value='all'/>산업재
                <div>
                    <input type='checkbox' name='all' value='all'/> 자본재
                    <input type='checkbox' name='all' value='all'/> 상업서비스와공급품
                    <input type='checkbox' name='all' value='all'/> 운송
                </div>
            </div>
            <div>
                <input type='checkbox' name='all' value='all'/>경기관련소비재
                <div>
                    <input type='checkbox' name='all' value='all'/> 자동차와부품
                    <input type='checkbox' name='all' value='all'/> 내구소비재와의류
                    <input type='checkbox' name='all' value='all'/> 호텔,레스토랑,레저등
                    <input type='checkbox' name='all' value='all'/> 소매(유통)
                    <input type='checkbox' name='all' value='all'/> 교육서비스
                </div>
            </div>
            <div>
                <input type='checkbox' name='all' value='all'/>필수소비재
                <div>
                    <input type='checkbox' name='all' value='all'/> 식품과기본식료품소매
                    <input type='checkbox' name='all' value='all'/> 식품,음료,담배
                    <input type='checkbox' name='all' value='all'/> 가정용품과개인용품
                </div>
            </div>
            <div>
                <input type='checkbox' name='all' value='all'/>건강관리
                <div>
                    <input type='checkbox' name='all' value='all'/> 건강관리장비와서비스
                    <input type='checkbox' name='all' value='all'/> 제약과생물공학
                </div>
            </div>
            <div>
                <input type='checkbox' name='all' value='all'/>금융
                <div>
                    <input type='checkbox' name='all' value='all'/> 은행
                    <input type='checkbox' name='all' value='all'/> 증권
                    <input type='checkbox' name='all' value='all'/> 다각화된금융
                    <input type='checkbox' name='all' value='all'/> 보험
                    <input type='checkbox' name='all' value='all'/> 부동산
                </div>
            </div>
            <div>
                <input type='checkbox' name='all' value='all'/>IT
                <div>
                    <input type='checkbox' name='all' value='all'/>소프트웨어와서비스
                    <input type='checkbox' name='all' value='all'/> 기술하드웨어와장비
                    <input type='checkbox' name='all' value='all'/> 반도체와반도체장비
                    <input type='checkbox' name='all' value='all'/> 전자와 전기제품
                    <input type='checkbox' name='all' value='all'/> 디스플레이
                </div>
            </div>
            <div>
                <input type='checkbox' name='all' value='all'/>커뮤니케이션서비스
                <div>
                    <input type='checkbox' name='all' value='all'/> 전기통신서비스
                    <input type='checkbox' name='all' value='all'/> 미디어와엔터테인먼트
                </div>
            </div>
            <div>
                <input type='checkbox' name='all' value='all'/>유틸리티
            </div>
        </div>
    </div>
</div>

<!--모달3-->
<div id="modal3" class="modal">
    <div class="modal-content" id="jongmok" style="justify-content: space-evenly">
        <div class="modal3-header"
             style="display: flex; flex-direction: row; justify-content: space-between; align-items: center; margin-top: 20px;
             border : 1px solid #0B9B97;">
            <div style="border: 1px solid #6ea8fe; font-family: '하나2.0 R'; font-size: 15px;">
                <div style="font-size: 20px; font-family: '하나2.0 B';">종목 선정 조건 선택</div>
                아래 여러 조건들을 활용하여 조금 더 세밀하게 투자할 종목을 선정 해볼 수 있습니다.<br>
                조건을 지정하고 싶지 않다면, [조건 선택 안함] 을 체크해주세요.
            </div>
            <div style="display: flex; width : 250px; justify-content: space-evenly; align-items: center;">
                <button style="width: 100px; height:30px; font-family: '하나2.0 M'; font-size:15px; border:none; border-radius: 5px; color:white; background-color: #cccccc">
                    선택완료
                </button>
            </div>
        </div>
        <div class="modal3-main">
            <div class="modal3-jogun">
                <div class="jogun-header">
                    <div style="font-size: 20px; font-family: '하나2.0 B';">종목 선정 조건 선택</div>
                    <div style="font-size: 20px; font-family: '하나2.0 B'; display: flex; flex-direction: row; justify-content: space-between; align-items: center">
                        <img src="img/reset.png" style="height: 20px; width: 20px;">
                        초기화
                    </div>
                </div>
                <div>
                    <input type='checkbox' name='all' value='all'/>조건선택안함
                </div>
                <div class="score">
                    <div class="score-header">
                        <img class="dropdown-icon" src="img/right.png" onclick="toggleDropdown(this)">
                        투자 전략 스코어
                        <h6>11</h6>
                    </div>
                    <div class="dropdown-content">
                        <div>시발년아</div>
                    </div>
                </div>
            </div>
            <div class="modal3-graph">

            </div>
        </div>
    </div>
</div>

<script>
    // 모든 modal-trigger 요소를 선택
    const modalTriggers = document.querySelectorAll(".modal-trigger");

    modalTriggers.forEach((trigger) => {
        trigger.addEventListener("click", () => {
            const modalId = trigger.getAttribute("data-modal-id");
            const modal = document.getElementById(modalId);
            modal.style.display = "block";
            document.body.style.overflow = "hidden";
        });
    });

    // 모달 바깥을 클릭하여 모달 닫기
    window.addEventListener("click", (event) => {
        modalTriggers.forEach((trigger) => {
            const modalId = trigger.getAttribute("data-modal-id");
            const modal = document.getElementById(modalId);
            if (event.target === modal) {
                modal.style.display = "none";
                document.body.style.overflow = "auto";
            }
        });
    });

    //

    // 모든 index-card 요소를 선택
    const indexCards = document.querySelectorAll(".index-card");

    // 각 index-card에 클릭 이벤트 리스너 추가
    indexCards.forEach((card, index) => {
        card.addEventListener("click", () => {
            // 해당 index-card의 card-title 요소를 선택하여 그 내용을 가져옴
            const cardTitle = card.querySelector(".card-title").textContent;

            // 모달 내의 span 엘리먼트를 선택
            const modalSpan = document.querySelector(".modal-trigger[data-modal-id='modal1']");

            // span의 텍스트를 선택한 index-card의 card-title 내용으로 변경
            modalSpan.textContent = cardTitle;

            // 모달을 닫는 등의 추가적인 작업을 할 수 있음
        });
    });


    // modal1의 "다음" 버튼 클릭 이벤트 핸들러
    document.getElementById("nextModal1").addEventListener("click", function () {
        // modal1을 닫고 modal2를 엽니다.
        document.getElementById("modal1").style.display = "none";
        document.getElementById("modal2").style.display = "block";
    });

    // modal2의 "다음" 버튼 클릭 이벤트 핸들러
    document.getElementById("nextModal2").addEventListener("click", function () {
        // modal2를 닫고 modal3을 엽니다.
        document.getElementById("modal2").style.display = "none";
        document.getElementById("modal3").style.display = "block";
    });

    function toggleDropdown(element) {
        var scoreHeader = element.parentElement;
        var dropdownContent = scoreHeader.nextElementSibling; // .dropdown-content 선택

        if (dropdownContent.style.display === "none" || dropdownContent.style.display === "") {
            // 드롭다운을 엽니다.
            dropdownContent.style.display = "block";
            element.src = "img/down.png"; // 이미지를 열린 상태로 변경
        } else {
            // 드롭다운을 닫습니다.
            dropdownContent.style.display = "none";
            element.src = "img/right.png"; // 이미지를 닫힌 상태로 변경
        }
    }

    // 입력 필드와 에러 메시지 요소를 가져옵니다.
    var numOfAssetsInput = document.getElementById("num-of-assets");
    var errorMessage = document.getElementById("error-message");

    // 입력 필드의 값이 변경될 때 이벤트 리스너를 추가합니다.
    numOfAssetsInput.addEventListener("change", function () {
        var inputValue = parseInt(numOfAssetsInput.value);

        // 입력값이 5부터 50 사이에 있는지 확인합니다.
        if (inputValue >= 5 && inputValue <= 50) {
            errorMessage.textContent = ""; // 에러 메시지를 지웁니다.
            numOfAssetsInput.style.borderColor = ""; // 입력 필드의 테두리 색상 초기화
        } else {
            // 입력값이 범위를 벗어나면 에러 메시지를 표시하고 입력 필드를 강조합니다.
            errorMessage.textContent = "5부터 50 사이의 값을 입력하세요.";
            errorMessage.style.color = "red";
            numOfAssetsInput.style.borderColor = "red";
        }
    });


    $('#demo').daterangepicker({
        "singleDatePicker": true,
        "startDate": "02/01/2005",
        "endDate": "09/08/2023"
    }, function (start, end, label) {
        console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
    });

</script>
<script>
    var jsonData = JSON.parse('${korTickersJson}');
    var tableBody = document.querySelector("#stockTable tbody");
    var chartContainer = document.getElementById('container');

    function drawTreeMap() {
        var activeData = jsonData.filter(item => item.active !== false);
        var points = [];
        activeData.forEach(function (item, index) {
            points.push({
                id: 'id_' + index,
                name: item.stockname + ' (' + item.ticker + ')',
                value: item.cap,
                market: item.market  // market 정보 추가
            });
        });

        Highcharts.chart(chartContainer, {
            series: [{
                name: 'KorTickers',
                type: 'treemap',
                layoutAlgorithm: 'squarified',
                allowDrillToNode: true,
                animationLimit: 1000,
                dataLabels: {
                    enabled: true
                },
                data: points,
                tooltip: {
                    pointFormat: '{point.name}<br>Market: {point.market}<br>Cap: {point.value}'
                }
            }],
            subtitle: {
                text: 'KorTickers Treemap. Click points to drill down.',
                align: 'left'
            },
            title: {
                text: 'KorTickers Visualization',
                align: 'left'
            }
        });
    }


    function sendModifiedDataToServer() {
        var updatedData = generateJsonFromTable();

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/api/saveModifiedTickers", true);
        xhr.setRequestHeader('Content-Type', 'application/json');

        xhr.onload = function () {
            if (xhr.status !== 200) {
                alert('Error sending data to server: ' + xhr.statusText);
            }
        };

        xhr.onerror = function () {
            alert('There was a problem with the request.');
        };

        console.log(updatedData);

        xhr.send(JSON.stringify(updatedData));
    }


    function generateJsonFromTable() {
        var table = document.querySelector("#stockTable");
        var rows = table.querySelectorAll("tbody tr");

        var newData = [];

        rows.forEach(function (row) {
            var tickerCell = row.cells[0];
            var stockNameCell = row.cells[1];
            var marketCell = row.cells[2];  // 시장 정보를 담는 셀
            var weightCell = row.cells[3];  // 비중 정보를 담는 셀
            var switchInput = row.querySelector("input[type='checkbox']");

            // ticker 접미사 추가
            var modifiedTicker = tickerCell.textContent.trim();
            if (marketCell.textContent.trim() === "KOSPI") {
                modifiedTicker += ".KS";
            } else if (marketCell.textContent.trim() === "KOSDAQ") {
                modifiedTicker += ".KQ";
            }

            var item = {
                ticker: modifiedTicker,
                stockname: stockNameCell.textContent.trim(),
                weight: weightCell.textContent.trim(),
                active: switchInput.checked
            };

            newData.push(item);
        });

        return newData;
    }

    function updateTable() {
        tableBody.innerHTML = '';
        var activeCount = jsonData.filter(item => item.active !== false).length;
        var weight = (100 / activeCount).toFixed(2) + '%';

        jsonData.forEach(function (item) {
            var row = tableBody.insertRow();

            var tickerCell = row.insertCell(0);
            tickerCell.textContent = item.ticker;

            var stockNameCell = row.insertCell(1);
            stockNameCell.textContent = item.stockname;

            var marketCell = row.insertCell(2); // 여기에 추가
            marketCell.textContent = item.market; // 여기에 추가

            var weightCell = row.insertCell(3);
            weightCell.textContent = item.active !== false ? weight : '0%';

            var inclusionCell = row.insertCell(4);
            var switchInput = document.createElement("input");
            switchInput.type = "checkbox";
            switchInput.checked = item.active !== false;
            switchInput.addEventListener('change', function () {
                item.active = this.checked;
                updateTable();
                drawTreeMap();
                sendModifiedDataToServer();
            });
            inclusionCell.appendChild(switchInput);
        });
    }

    // Initialize
    jsonData.forEach(item => item.active = true);
    updateTable();
    drawTreeMap();
</script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css"/>
</body>
</html>