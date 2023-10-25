<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Indexing</title>
    <title>Title</title>


    <%--    datepicker--%>
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.8.0/css/pikaday.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.8.0/pikaday.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.js"></script>

    <%--    하이차트--%>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/heatmap.js"></script>
    <script src="https://code.highcharts.com/modules/treemap.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>

    <style>
        /*하이차트*/
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

        /*본문*/

        .wrap {
            display: flex;
            flex-direction: column;
            width: 100%; /* 변경된 부분 */
            max-width: 1440px; /* 추가된 부분 */
            margin: 75px auto 0; /* 변경된 부분 */
            box-sizing: border-box;
            padding: 0 1rem;
        }

        .contents-header {
            width: 1440px;
            max-width: 1440px; /* 추가된 부분 */
            height: 80px;
            font-family: "하나2.0 B";
            font-weight: 700;
            font-size: 50px;
            color: #E90061;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .contents {
            display: flex;
            justify-content: center;
            width: 1440px;
        }

        .header-button {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
            width: 380px;
        }

        .indexing-button {
            box-sizing: border-box;
            padding: 10px 20px;
            color: white;
            background-color: #04BE9E; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            font-size: 15px;
            width: 150px;
            text-decoration: none;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .indexing-button:hover {
            background-color: #009B84; /* 다른 버튼의 hover 시 배경색 변경 */
        }

        .portfolio-button {
            box-sizing: border-box;
            padding: 10px 20px;
            color: white;
            background-color: #603F83; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            font-size: 15px;
            width: 220px;
            text-decoration: none;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .portfolio-button:hover {
            background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
        }

        .contents-header .portfolio-button img {
            width: 30px; /* 이미지의 너비를 20px로 설정 */
            height: auto; /* 이미지의 높이는 자동으로 조정 (비율 유지) */
            vertical-align: middle; /* 이미지를 텍스트의 중앙에 정렬 */
            margin-right: 5px; /* 이미지와 텍스트 사이에 약간의 공간을 만듭니다 */
        }


        .index-left, .index-right {
            width: 700px;
            height: 800px;
            overflow-y: auto; /* 스크롤 설정 */
        }

        .index-left {
            margin-right: 20px; /* 오른쪽 여백 추가 */
        }

        .market, .industry, .jogun, .suljeong, .rebal, .result, .nobuy {
            height: 80px;
            background-color: #fffbfa;
            border-radius: 20px;
            display: flex;
            align-items: center; /* 텍스트를 중앙에 위치 */
            padding-left: 15px; /* 텍스트에 약간의 패딩 추가 */
            padding-right: 15px; /* 텍스트에 약간의 패딩 추가 */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            font-family: "하나2.0 M";
            font-size: 20px;
        }

        .market {
            flex-direction: row;
            justify-content: space-between;
        }


        /*표 꾸미기*/
        @import 'https://fonts.googleapis.com/css?family=Open+Sans:600,700';

        * {
            font-family: 'Open Sans', sans-serif;
        }

        #stockTable {
            margin: auto;
            min-width: 300px;
            max-width: 100%;
            border-collapse: collapse;
        }

        #stockTable th {
            border-top: none;
            background: #428bca;
            color: #fff;
        }

        #stockTable tr {
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            background-color: #f5f9fc;
        }

        #stockTable tr:nth-child(odd):not(:first-child) {
            background-color: #ebf3f9;
        }

        #stockTable th {
            display: table-cell;
            padding: .25em .5em;
        }

        #stockTable td {
            display: table-cell;
            padding: .25em .5em;
        }

        @media screen and (max-width: 601px) {
            #stockTable th {
                display: none;
            }

            #stockTable td {
                display: block;
            }

            #stockTable td:first-child {
                margin-top: .5em;
            }

            #stockTable td:last-child {
                margin-bottom: .5em;
            }

            #stockTable td:before {
                content: attr(data-th) ": ";
                font-weight: bold;
                width: 120px;
                display: inline-block;
                color: #000;
            }
        }


        /*modal*/
        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%); /* Center the modal */
            background-color: #ffffff; /* Modal background color */
            border-radius: 8px; /* Optional: Rounded corners */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Optional: Shadow for a bit of depth */
            overflow: auto; /* Enables scroll if the content is larger than the modal */
            align-items: center;
            justify-content: center;
            z-index: 1;
        }

        #market-modal {
            width: 800px;
            height: 60%;
        }

        #industry-modal {
            width: 800px;
            height: 60%;
        }

        #jogun-modal {
            width: 1200px;
            height: 80%;
        }

        .modal-header {
            background-color: #f7f7f7;
            padding: 1rem;
            display: flex;
            justify-content: space-between;
        }

        /* Market Modal 헤더 스타일 */
        .market-header {
            background-color: #e1e1e1; /* 예: 조금 더 진한 회색으로 변경 */
            display: flex;
            flex-direction: row;
            justify-content: space-between;
        }


        .modal-header1 {
            font-family: "하나2.0 B";
            font-weight: 700;
            font-size: 20px;
        }

        .modal-header2 {
            font-family: "하나2.0 R";
            /*font-weight: 700;*/
            font-size: 15px;
        }

        .button1 {
            padding: 10px 20px;
            color: white;
            background-color: #04BE9E; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            font-size: 15px;
            width: 150px;
            text-decoration: none;
        }

        .button1:hover {
            background-color: #009B84; /* 다른 버튼의 hover 시 배경색 변경 */
        }

        .button2 {
            padding: 10px 20px;
            color: white;
            background-color: #603F83; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            font-size: 15px;
            width: 150px;
            text-decoration: none;
        }

        .button2:hover {
            background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
        }

        .market-body-header img {
            width: auto;
            height: 20px;
            vertical-align: middle;
            margin-left: 5px;
        }

        .market-modal-body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .market-body-header {
            font-family: "하나2.0 B";
            font-weight: 700;
            font-size: 20px;
            margin-top: 50px;
            margin-bottom: 50px;
        }

        .index-card {
            width: 250px;
            height: 100px;
            display: flex;
            flex-direction: column;
            font-family: '하나2.0 R';
            font-size: 15px;
            justify-content: space-around;
            border: 1px solid gray;
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .index-card .card-title {
            font-size: 15px;
            font-family: '하나2.0 M';
            font-weight: 700;
        }

        .index-card .card-badge {
            width: 25px;
            height: 25px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 5px;
            font-weight: 700;
        }

        .index-card .card-description {
            margin-left: 20px;
        }

        .index-card:hover {
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            transform: scale(1.1);
        }

        .index-card.active {
            border-color: purple;
            background-color: rgba(128, 0, 128, 0.1); /* 연한 보라색 */
        }

        /* Additional CSS for colors */
        .index-card.kr .card-badge {
            background-color: #CF3540;
            color: white;
        }

        .index-card.us .card-badge {
            background-color: #0A3161;
            color: white;
        }


        /* Industry Modal 헤더 스타일 */
        .industry-header {
            background-color: #d8d8d8;
        }

        .modal2-checklist {
            font-family: 'Arial', sans-serif; /* 폰트 설정 */
            padding: 20px; /* 안쪽 여백 추가 */
        }

        .modal2-checklist > div {
            margin-bottom: 10px; /* 각 체크박스 그룹 사이의 간격 설정 */
        }

        .modal2-checklist input[type="checkbox"] {
            margin-right: 8px; /* 체크박스와 텍스트 사이의 간격 */
        }

        .modal2-checklist > div > div {
            margin-left: 20px; /* 하위 체크박스를 약간 들여쓰기 */
            margin-top: 5px; /* 상위 체크박스와 하위 체크박스 사이의 간격 설정 */
        }

        .industry-selected {
            background-color: #9E7DF9; /* 보라색 배경 */
            border-radius: 3px; /* 모서리 둥글게 처리 */
            padding: 2px 6px; /* 안쪽 여백 설정 */
            color: white; /* 글자 색상 흰색으로 설정 */
            margin-left: 10px; /* 산업 선택 텍스트와 간격 설정 */
            display: inline-block; /* 길이가 내용에 맞게 조절되도록 설정 */
        }

        /* Jogun Modal 헤더 스타일 */
        .jogun-body {
            display: flex;
            flex-direction: row;
            height: 80%;
        }

        .jogun-header {
            background-color: #cfcfcf; /* 예: 또 다른 진한 회색으로 변경 */
            /* 추가로 원하는 스타일을 정의하세요. */
        }

        .jogun-left, .jogun-right {
            width: 600px;
            box-sizing: border-box;
            max-height: 80%; /* 원하는 최대 높이를 설정하세요 */
            overflow-y: auto; /* 수직 스크롤 설정 */
        }

        .jogun-left-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .flex-between {
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer; /* 클릭 가능한 것처럼 보이게 커서 변경 */
        }

        .dropdown-icon {
            width: 20px; /* 이미지 크기 조절 */
            height: 20px;
            transition: transform 0.3s; /* 화살표 회전 애니메이션 추가 */
        }

        .checkbox-container {
            border: 1px solid #d8d8d8; /* 회색 테두리 */
            border-radius: 10px;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1); /* 음영 */
            padding: 10px;
            margin: 10px 0;
        }

        .checkbox-container input[type="checkbox"]:checked + div {
            border-color: #9E7DF9; /* 체크박스 클릭 시 테두리 보라색 */
        }


        .container-header {
            font-size: 20px;
            font-family: '하나2.0 B';
            font-weight: 700;
        }

        .container-body {
            font-size: 15px;
            font-family: '하나2.0 M';
        }

        .container-bottom {
            font-size: 15px;
            font-family: '하나2.0 M';
        }

        /*        페이지*/
        #pagination {
            text-align: center;
            margin-top: 20px;
        }

        #pagination button {
            margin: 0 5px;
            background-color: #0B9B97;
            color: white;
            border: none;
            border-radius: 20px;
        }

    </style>
    <link href="css/mobiscroll.javascript.min.css" rel="stylesheet"/>
    <script src="js/mobiscroll.javascript.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="wrap">
    <div class="contents-header">
        <div>
            다이렉트 인덱싱
        </div>
        <div class="header-button">
            <a href="/start2" class="indexing-button">다른 전략 선택</a>
            <form id="dataForm" action="/port" method="post" class="portfolio-button">
                <input type="hidden" id="jsonData" name="jsonData">
                <img src="img/graphanimation.gif">
                이 전략으로 투자하기
            </form>
        </div>
    </div>
    <div class="contents">
        <div class="index-left">

            <div class="market" onclick="openModal('market-modal')">투자할 시장/지수 선택
                <div class="market-selected">

                </div>
            </div>
            <div class="industry" onclick="openModal('industry-modal')">투자할 산업 선택
                <div class="industry-selected">
                </div>
            </div>
            <div class="jogun" onclick="openModal('jogun-modal')">종목 선정 조건 선택
                <div class="jogun-selected"></div>
            </div>

            <div class="suljeong">
                <label for="stockPriority">종목 우선순위:</label>
                <select id="stockPriority">
                    <option value="highMarketCap">시가총액 높은 순</option>
                    <option value="lowMarketCap">시가총액 낮은 순</option>
                    <option value="operatingProfit">영업이익률 우선</option>
                    <option value="returnOnEquity">자본수익률 우선</option>
                </select>

                <label for="investmentWeight">투자비중:</label>
                <select id="investmentWeight">
                    <option value="equalWeight">동일비중</option>
                </select>
            </div>

            <!-- rebal div -->
            <div class="rebal">
                <label for="stockCount">구성 종목수:</label>
                <input type="number" id="stockCount" min="5" max="50" value="30" oninput="validateInput()">
                <p id="error" style="color: red; display: none;">5~50 사이의 숫자를 입력하세요.</p>

                <label for="rebalancingFrequency">포트폴리오 리밸런싱 주기:</label>
                <select id="rebalancingFrequency">
                    <option value="1year">1년마다 한 번</option>
                    <option value="6months">6개월마다 한 번</option>
                    <option value="3months">3개월 마다 한 번</option>
                </select>
            </div>


            <div class="result">
                투자 성과 조회 기준 설정
                <div class="date-range">
                    시작: <input type="text" id="startDate">
                    종료: <input type="text" id="endDate">
                </div>
            </div>

            <div class="nobuy">

            </div>
        </div>
        <div class="index-right">
            <div class="right-header">
                <button>종목 리스트</button>
                <button>과거 투자 성과</button>
            </div>
            <div>
                <div class="list">
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
                    <div id="pagination">
                        <button onclick="changePage(-1)">이전</button>
                        <span id="currentPage">1</span> / <span id="totalPages"></span>
                        <button onclick="changePage(1)">다음</button>
                    </div>
                </div>
                <div class="past">
                    <img id="chartImage" src="/api/getChart" alt="Chart Image">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal definitions -->
<div id="market-modal" class="modal">
    <div class="modal-header market-header">
        <div class="modal-header1">
            투자할 시장/지수 선택
            <div class="modal-header2">
                투자할 시장 또는 지수를 선택하세요.
            </div>
        </div>
        <div class="button-wrap">
            <button class="button1">선택완료</button>
            <button class="button2">다음</button>
        </div>
    </div>
    <div class="market-modal-body">
        <div class="market-body-header">
            지수
            <img src="img/new.png">
        </div>
        <div class="market-content">
            <div style="display: flex; width:550px; flex-direction: row; justify-content: space-between; margin-bottom: 50px">
                <div class="index-card" id="index-card1" style="width:250px; height: 100px; display: flex; flex-direction: column; font-family: '하나2.0 R'; font-size: 15px;
                                    justify-content: space-around">
                    <div style="display: flex; flex-direction: row; justify-content: space-around">
                        <div class="card-title"
                             style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
                            대한민국 TOP 50
                        </div>
                        <div style="width:25px; height: 25px; background-color: #CF3540; color: white; display: flex; justify-content: center; align-items: center; border-radius: 5px; font-weight: 700;">
                            KR
                        </div>
                    </div>
                    <div style="margin-left: 20px">
                        한국 50개의 대형 기업을 대상으로 하는 지수입니다.
                    </div>
                </div>
                <div class="index-card" id="index-card2" style="width:250px; height: 100px; display: flex; flex-direction: column;  font-family: '하나2.0 R'; font-size: 15px;
                                    justify-content: space-around">
                    <div style="display: flex; flex-direction: row; justify-content: space-around">
                        <div class="card-title"
                             style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
                            대한민국 중소형주
                        </div>
                        <div style="width:25px; height: 25px; background-color: #CF3540; color: white; display: flex; justify-content: center; align-items: center; border-radius: 5px; font-weight: 700;">
                            KR
                        </div>
                    </div>
                    <div style="margin-left: 20px">
                        한국 중소형주를 대상으로 하는 지수입니다.
                    </div>
                </div>
            </div>

            <div style="display: flex; width:550px; flex-direction: row; justify-content: space-between;">
                <div class="index-card" id="index-card3" style="width:250px; height: 100px; display: flex; flex-direction: column; font-family: '하나2.0 R'; font-size: 15px;
                                    justify-content: space-around">
                    <div style="display: flex; flex-direction: row; justify-content: space-around">
                        <div class="card-title"
                             style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
                            코스닥 반도체
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
                        <div class="card-title"
                             style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
                            KOSDAQ 상장 대표 기업
                        </div>
                        <div style="width:25px; height: 25px; background-color: #CF3540; color: white; display: flex; justify-content: center; align-items: center; border-radius: 5px; font-weight: 700;">
                            KR
                        </div>
                    </div>
                    <div style="margin-left: 20px">
                        KOSDAQ 상장 대표 기업 100개를 대상으로 하는 지수입니다.
                    </div>
                </div>
            </div>
        </div>
        <!--        시장-->
        <div class="market-body-header">
            시장
        </div>
        <div class="modal1-index-main" style="height: 200px; ">
            <div style="display: flex; width:550px; flex-direction: row; justify-content: space-between;">
                <div class="index-card" id="index-card5" style="width:250px; height: 100px; display: flex; flex-direction: column; font-family: '하나2.0 R'; font-size: 15px;
                                    justify-content: space-around">
                    <div style="display: flex; flex-direction: row; justify-content: space-around">
                        <div class="card-title"
                             style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
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
                        <div class="card-title"
                             style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
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

<%--산업선택 모달--%>
<div id="industry-modal" class="modal">
    <div class="modal-header industry-header">
        <div class="modal-header1">
            투자할 산업 선택
            <div class="modal-header2">
                투자하고 싶은 산업에 체크하세요.
            </div>
        </div>
        <div class="button-wrap">
            <button class="button1">선택완료</button>
            <button class="button2">다음</button>
        </div>
    </div>
    <div class="industry-modal-body">
        <div class="modal2-checklist">
            <div>
                <input type='checkbox' id='all' name='all' value='all'/>
                전체선택(28)
            </div>
            <div>
                <input type='checkbox' id='energy' name='energy' value='energy'/>에너지
            </div>
            <div>
                <input type='checkbox' id='material' name='material' value='material'/>
                소재
            </div>
            <div>
                <input type='checkbox' id='industrialGoods' name='industrialGoods' value='industrialGoods'/>
                산업재(3)
                <div>
                    <input type='checkbox' id='capitalGoods' name='capitalGoods' value='capitalGoods'/>
                    자본재

                    <input type='checkbox' id='commercialServices' name='commercialServices'
                           value='commercialServices'/>
                    상업서비스와공급품

                    <input type='checkbox' id='transportation' name='transportation' value='transportation'/>
                    운송
                </div>
            </div>
            <div>
                <input type='checkbox' id='cyclicalConsumerGoods' name='cyclicalConsumerGoods'
                       value='cyclicalConsumerGoods'/>
                경기관련소비재(5)
                <div>
                    <input type='checkbox' id='carsAndParts' name='carsAndParts' value='carsAndParts'/>
                    자동차와부품

                    <input type='checkbox' id='durableGoods' name='durableGoods' value='durableGoods'/>
                    내구소비재와의류

                    <input type='checkbox' id='hotelsRestaurants' name='hotelsRestaurants' value='hotelsRestaurants'/>
                    호텔,레스토랑,레저등

                    <input type='checkbox' id='retail' name='retail' value='retail'/>
                    소매(유통)

                    <input type='checkbox' id='educationServices' name='educationServices' value='educationServices'/>
                    교육서비스
                </div>
            </div>
            <div>
                <input type='checkbox' id='essentialConsumerGoods' name='essentialConsumerGoods'
                       value='essentialConsumerGoods'/>
                필수소비재(3)
                <div>
                    <input type='checkbox' id='foodAndRetail' name='foodAndRetail' value='foodAndRetail'/>
                    식품과기본식료품소매

                    <input type='checkbox' id='foodBeverages' name='foodBeverages' value='foodBeverages'/>
                    식품,음료,담배

                    <input type='checkbox' id='householdGoods' name='householdGoods' value='householdGoods'/>
                    가정용품과개인용품
                </div>
            </div>
            <div>
                <input type='checkbox' id='healthcare' name='healthcare' value='healthcare'/>
                건강관리(2)
                <div>
                    <input type='checkbox' id='healthcareEquipment' name='all' value='healthcareEquipment'/>
                    건강관리장비와서비스

                    <input type='checkbox' id='pharmBiotech' name='all' value='pharmBiotech'/>
                    제약과생물공학
                </div>
            </div>

            <div>
                <input type='checkbox' id='finance' name='all' value='finance'/>
                금융(5)
                <div>
                    <input type='checkbox' id='bank' name='all' value='bank'/>
                    은행

                    <input type='checkbox' id='securities' name='all' value='securities'/>
                    증권

                    <input type='checkbox' id='diversifiedFinance' name='all' value='diversifiedFinance'/>
                    다각화된금융

                    <input type='checkbox' id='insurance' name='all' value='insurance'/>
                    보험

                    <input type='checkbox' id='realEstate' name='all' value='realEstate'/>
                    부동산
                </div>
            </div>

            <div>
                <input type='checkbox' id='it' name='all' value='it'/>
                IT(5)
                <div>
                    <input type='checkbox' id='softwareServices' name='all' value='softwareServices'/>
                    소프트웨어와서비스

                    <input type='checkbox' id='techHardware' name='all' value='techHardware'/>
                    기술하드웨어와장비

                    <input type='checkbox' id='semiconductors' name='all' value='semiconductors'/>
                    반도체와반도체장비

                    <input type='checkbox' id='electronics' name='all' value='electronics'/>
                    전자와 전기제품

                    <input type='checkbox' id='display' name='all' value='display'/>
                    디스플레이
                </div>
            </div>

            <div>
                <input type='checkbox' id='comServices' name='all' value='comServices'/>
                커뮤니케이션서비스(2)
                <div>
                    <input type='checkbox' id='telecomServices' name='all' value='telecomServices'/>
                    전기통신서비스

                    <input type='checkbox' id='mediaEntertainment' name='all' value='mediaEntertainment'/>
                    미디어와엔터테인먼트
                </div>
            </div>

            <div>
                <input type='checkbox' id='utility' name='all' value='utility'/>
                유틸리티
            </div>
        </div>
    </div>
</div>

<div id="jogun-modal" class="modal">
    <div class="modal-header jogun-header">
        <div class="modal-header1">
            종목 선정 조건 선택
            <div class="modal-header2">
                아래 여러 조건들을 활용하여 조금 더 세밀하게 투자할 종목을 선정 해볼 수 있습니다.<br>
                조건을 지정하고 싶지 않다면, [조건 선택 안함] 을 체크해주세요.
            </div>
        </div>
        <div class="button-wrap">
            <button class="button1">선택완료</button>
        </div>
    </div>
    <div class="jogun-body">
        <div class="jogun-left">
            <div class="jogun-left-header">
                조건선택
                <div>
                    <img src="img/reset.png" style="height: 20px; width: 20px;">
                    초기화
                </div>
            </div>
            <div>
                <input type='checkbox' id='nojogun' name='nojogun' value='nojogun'/>
                조건 선택 안함
            </div>
            <div class="score flex-between">
                <div>
                    <img class="dropdown-icon" src="img/right.png">
                    대가들의 투자 전략
                </div>
            </div>
            <div class="dropdown-content" style="display:none;">
                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='buffet' name='buffet' value='buffet'/>
                        오마하의 현인 : 워렌 버핏 스코어
                    </div>
                    <div class="container-body">
                        <h3>상세 투자 전략</h3>
                        ROE > 15% <br>
                        장기부채/자기자본 비율 < 1 <br>
                        유동비율 > 1.5 <br>
                        FCF > 0<br>
                        PER < 17<br>
                        P/B < 1.5 <br>
                        부채비율 > 1.5<br>
                        EPS 성장률 > 10%
                    </div>
                    <div class="container-bottom">
                        <h3>전략 설명</h3>
                        이익의 질이 좋은 저평가 된 기업에 투자하는 가치투자 스타일로, <br>
                        강력한 경쟁 우위를 가진회사를 선호하며 장기적인 시각으로 투자합니다.<br>
                        스코어가 높을 수록 피터 린치 투자 스타일에 적합한 종목입니다.<br>
                        위 조건을 모두 만족하면 8점이고, 모두 만족하지 않으면 0점입니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='benjamin' name='benjamin' value='benjamin'/>
                        가치 투자의 아버지 : 벤자민 그레이엄 스코어
                    </div>
                    <div class="container-body">
                        <h3>상세 투자 전략</h3>
                        유동비율 ≥ 200%<br>
                        순유동자산 ≥ 장기부채<br>
                        EPS 연 성장률 3%<br>
                        PER ≤ 15<br>
                        PBR * PER ≤ 22<br>
                        총 부채비율 < 1<br>
                    </div>
                    <div class="container-bottom">
                        <h3>전략 설명</h3>
                        안전한 마진을 확보하고 펀더멘탈 분석에 집중하여 회사를 선정합니다. <br>
                        스코어가 높을 수록 벤저민 그레이엄 투자 스타일에 적합한 종목입니다. <br>
                        위 조건을 모두 만족하면 6점이고, 모두 만족하지 않으면 0점입니다
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='peter' name='peter' value='peter'/>
                        월가의 영웅 : 피터 린치 스코어
                    </div>
                    <div class="container-body">
                        <h3>상세 투자 전략</h3>
                        PER < 40 <br>
                        PEG < 1.8 <br>
                        재고 / 매출 < 5%<br>
                        부채비율 < 0.8<br>
                        ROE > 5%<br>
                        ROA > 1%<br>
                        배당수익률 > 3%<br>
                    </div>
                    <div class="container-bottom">
                        <h3>전략 설명</h3>
                        역사상 가장 성공한 펀드매니저라 불리는 피터 린치의 투자 전략 스타일로, <br>
                        성장성, 수익성이 강한 모델과 경쟁 우위를 가진 기업에 투자하며, 경쟁 열위에 <br>
                        해당하는 기업을 선호합니다.
                        스코어가 높을 수록 피터 린치 투자 스타일에 적합한 종목입니다. <br>
                        위 조건을 모두 만족하면 7점이고, 모두 만족하지 않으면 0점입니다
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='profit' name='profit' value='profit'/>
                        블랙 먼데이의 예언자 : 마틴 즈웨이그 이익 모멘텀 스코어
                    </div>
                    <div class="container-body">
                        <h3>상세 투자 전략</h3>
                        영업현금흐름 > 당기순이익<br>
                        순이익률 3년간 평균 값 > 0<br>
                        PSR ≤ 1.5<br>
                        최근 3년간 매출액 성장률 > 0<br>
                        최근 분기의 매출액 1년 성장률 > 직전 분기 시점 과거 1년 성장률<br>
                        이익 추정 성장률 > 주식시장 예상 평균 성장률<br>
                        어닝 서프라이즈<br>
                        매출 서프라이즈<br>
                        매출 서프라이즈 예측 추이 ≥ 0.2<br>
                        전년도 대비 이익, 전분기 대비 이익 성장률 ≥ 10%<br>
                        이익 추정치를 하향한 애널리스트들의 비율 < 30%<br>
                    </div>
                    <div class="container-bottom">
                        <h3>전략 설명</h3>
                        스코어가 높을 수록 마틴 즈웨이그 투자 스타일에 적합한 종목입니다.<br>
                        위 조건을 모두 만족하면 10점이고, 모두 만족하지 않으면 0점입니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='growth' name='growth' value='growth'/>
                        성장 모멘텀 스코어
                    </div>
                    <div class="container-body">
                        <h3>상세 투자 전략</h3>
                        시가총액 / R&D ≤ 15<br>
                        최근 3년 매출액 성장률 > 0%<br>
                        순이익 장기 성장률 > 0<br>
                        52주 신고가 대비 현재의 주가가 15% 이상 하락하지 않은 상태<br>
                        매출 서프라이즈<br>
                        초과상대강도지수(Excess RSI) ≥ 50<br>
                        매출 서프라이즈 예측 추이 ≥ 0.2<br>
                        이익 추정 성장률 > 주식시장 예상 평균 성장률<br>
                        Excess RSI가 산업 내 상위 20%<br>
                        시가 총액이 산업 내 상위 20%<br>
                        최근 12개월 수익률이 산업 내 상위 20%<br>
                        0 ≤ K 비율 ≤ 100<br>
                    </div>
                    <div class="container-bottom">
                        <h3>전략 설명</h3>
                        스코어가 높을 수록 성장 모멘텀 투자 스타일에 적합한 종목입니다.<br>
                        위 조건을 모두 만족하면 12점이고, 모두 만족하지 않으면 0점입니다.
                    </div>
                </div>
            </div>
            <%--        수익성--%>
            <div class="value flex-between">
                <div>
                    <img class="dropdown-icon" src="img/right.png">
                    가치
                </div>
            </div>
            <div class="dropdown-content" style="display:none;">
                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='pbr' name='pbr' value='pbr'/>
                        PBR : 현재 가격 / 장부가치
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        낮을수록 저평가되고 있다는 뜻입니다. <br>기업의 장부 가치와 현재 기준 시가총액을 비교한 값입니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='per' name='per' value='per'/>
                        PER : 현재 가격 / 순이익
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        낮을수록 저평가되고 있다는 뜻입니다. <br>1년간의 순이익과 현재 기준 시가총액을 비교한 값입니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='psr' name='psr' value='psr'/>
                        PSR : 현재 가격 / 매출액
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        낮을수록 저평가되고 있다는 뜻입니다. <br>1년간의 매출 규모와 현재 기준 시가총액을 비교한 값입니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='pcf' name='pcf' value='pcf'/>
                        P/CF : 현재 가격 / 현금성 이익
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        낮을수록 저평가되고 있다는 뜻입니다. <br>1년간의 현금성 이익과 현재 기준의 시가총액을 비교한 값입니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='reverseper' name='reverseper' value='reverseper'/>
                        추정이익 반영 PER 역수 (높을 수록 저평가)
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        PEG는 PER에 예상 성장률을 나눈 값입니다. PEG의 역수를 사용해서 값이 높을수록 저평가되고 있다는 뜻으로 <br>
                        성장률은 애널리스트들의 향후 12개월 추정 순이익 성장률을 사용했습니다
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='rpr' name='rpr' value='rpr'/>
                        RPR : R&D 투자 / 시가총액
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        높을수록 회사 규모 대비 기술 개발 투자를 많이 하고 있음을 뜻합니다. <br>기업의 R&D 규모와 현재 기준 시가총액을 비교한 값입니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='amount' name='amount' value='amount'/>
                        시가총액
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        현재 시장에서 기업이 인정받고 있는 시가총액입니다.
                    </div>
                </div>


                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='ev' name='ev' value='ev'/>
                        EV / EBITDA 역수 (높을수록 저평가)
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        지난 12개월 기업의 수익성 대비 시장 가치를 비교한 값입니다. <br>역수를 활용하여 높은 값일수록 저평가 되고 있음을 뜻합니다.
                    </div>
                </div>
            </div>
            <%--            효율성--%>
            <div class="efficiency flex-between">
                <div>
                    <img class="dropdown-icon" src="img/right.png">
                    효율성
                </div>
            </div>
            <div class="dropdown-content" style="display:none;">
                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='jasan' name='jasan' value='jasan'/>
                        자산 회전율
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        높을수록 자산 대비 매출이 높았다는 의미로 자산을 효율적으로 쓰고 있음을 뜻합니다. <br>
                        자산은 재무제표에서 확인되는 지표로 미래에 수익을 발생시킬 것으로 기대되는 자원을 뜻합니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='gojung' name='gojung' value='gojung'/>
                        고정자산 회전율
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        높을수록 고정 자산 대비 매출이 높았다는 의미로 고정자산을 효율적으로 쓰고 있음을 뜻합니다.<br>
                        고정 자산은 토지, 기계, 공장 등 현금화되기 어려운 자산을 뜻합니다
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='working' name='working' value='working'/>
                        운전자본 회전율
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        높을수록 운전 자본 대비 매출이 높았다는 의미로 운전자본을 효율적으로 쓰고 있음을 뜻합니다.<br> 운전 자본은 기업이 사업을 영위하는 데 필요한 자금입니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='jaego' name='jaego' value='jaego'/>
                        재고자산 회전율
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        높을수록 재고자산 대비 매출이 높았다는 의미로 재고 자산을 효율적으로 관리하고 있음을 뜻합니다. <br>
                        재고 자산은 기업이 사업을 영위하는 데 필요한 원자재, 상품, 제품 등을 의미합니다. <br>
                        효율적인 기업일수록 적은 재고 대비 높은 매출을 기록할 수 있습니다.
                    </div>
                </div>
            </div>

            <%--            수익성--%>
            <div class="profit flex-between">
                <div>
                    <img class="dropdown-icon" src="img/right.png">
                    수익성
                </div>
            </div>
            <div class="dropdown-content" style="display:none;">
                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='roe1' name='roe1' value='roe1'/>
                        ROE : 순이익 / 자본
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        높을수록 회사 자본 대비 수익성이 좋다는 뜻입니다. <br>
                        자본 대비 회사가 벌어들인 순이익을 비교합니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='roe2' name='roe2' value='roe2'/>
                        ROE : 영업이익 / 자본
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        높을수록 회사 자본 대비 수익성이 좋다는 뜻입니다. <br>
                        자본 대비 회사가 벌어들인 영업이익을 비교합니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='roa' name='roa' value='roa'/>
                        ROA : 순이익 / 자산
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        높을수록 회사 보유 자산 대비 많은 수익이 발생하고 있다는 뜻입니다.
                        <br>자산 대비 순이익을 비교한 값입니다
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='gpa' name='gpa' value='gpa'/>
                        GP/A : 매출총이익 / 자산
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        높을수록 회사 자산 대비 수익성이 좋다는 뜻입니다. <br>
                        자산 대비 매출총이익을 비교한 값입니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='maechool' name='maechool' value='maechool'/>
                        매출총이익률
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        높을수록 영업활동 수익성이 좋다는 뜻입니다. <br>
                        매출 총이익률은 매출에서 매출 원가를 제외해서 도출한 수익률로 높을수록 제품을 제조하는 데 필요한 원가가 낮다는 것을 의미합니다.
                    </div>
                </div>
            </div>

            <%--            건전성--%>
            <div class="health flex-between">
                <div>
                    <img class="dropdown-icon" src="img/right.png">
                    수익성
                </div>
            </div>
            <div class="dropdown-content" style="display:none;">
                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='debt' name='debt' value='debt'/>
                        부채 비율
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        회사 총자산 중 부채의 비중을 나타냅니다. <br>
                        같은 영업구조를 가지는 회사라도 이 수치가 높으면 전체 자본 수익률은 높아질 수 있으나 부채 리스크는 커집니다.
                    </div>
                </div>


                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='current' name='current' value='current'/>
                        유동비율
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        단기간 내 상환해야 할 것으로 보이는 채무 대비 단기간 내 현금화할 수 있는 자산을 비교한 값입니다. <br>
                        높을수록 단기 상환능력이 좋다는 것을 의미합니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='cash' name='cash' value='cash'/>
                        당좌비율
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        유동비율보다 더 보수적으로 현금 및 현금성 자산 매출채권만을 상환재원으로 보고 비교한 값입니다.
                        <br>높을수록 단기 상환능력이 좋다는 것을 의미합니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='coverage' name='coverage' value='coverage'/>
                        이자 커버리지
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        이자 비용 대비 영업이익을 비교한 값입니다. 회사의 영업활동으로 얻는 수익으로 이자를 감당할 수 있는지를 확인합니다. <br>
                        높을수록 이자를 감당할 수 있는 능력이 좋다는 것을 뜻합니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='longdebt' name='longdebt' value='longdebt'/>
                        자본 대비 장기 부채 비율
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        회사 총 자본 대비 장기 부채의 비중을 나타냅니다. <br>
                        자본 조달 자금 대비 장기로 빌리고 있는 채무 수준을 확인할 수 있습니다.
                    </div>
                </div>
            </div>


            <%--            거래량--%>
            <div class="trading flex-between">
                <div>
                    <img class="dropdown-icon" src="img/right.png">
                    수익성
                </div>
            </div>
            <div class="dropdown-content" style="display:none;">
                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='daily' name='daily' value='daily'/>
                        총 주식 수 대비 일일 거래량
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        지난 6개월간 총 주식 수 대비 일일 거래량의 평균 수치입니다. <br>
                        값이 클수록 거래량이 많다는 것을 의미합니다.
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='tv' name='tv' value='tv'/>
                        거래량 변동성
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        지난 1년간 주가 대비 거래량의 표준편차를 평균으로 나눈 수치입니다. <br>값이 클수록 거래량이 많다는 것을 의미합니다.
                    </div>
                </div>
            </div>

            <%--            통계--%>
            <div class="quant flex-between">
                <div>
                    <img class="dropdown-icon" src="img/right.png">
                    통계
                </div>
            </div>
            <div class="dropdown-content" style="display:none;">
                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='beta' name='beta' value='beta'/>
                        베타
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        개별 주식의 가격 변동성을 주식시장의 변동성과 비교한 수치입니다.<br>
                        높을수록 주식시장 대비 변동성이 높은 것을 의미합니다
                    </div>
                </div>

                <div class="checkbox-container">
                    <div class="container-header">
                        <input type='checkbox' id='alpha' name='alpha' value='alpha'/>
                        알파
                    </div>
                    <div class="container-body">
                        <h3>상세 설명</h3>
                        개별 주식의 수익 중 주식시장에 내재되어 있는 위험 보상을 제외했을 경우 확인되는 수치입니다. <br>
                        높을수록 시장 대비 높은 수익을 보이는 것을 의미합니다.
                    </div>
                </div>


            </div>


        </div>

        <div class="jogun-right">
            <div class="jogun-right-header"></div>

            <div id="graphTitle"></div>

            <button id="ratioChange">비율변경</button>
            <button id="valueChange">값변경</button>

            <canvas id="myChart" width="400" height="200"></canvas>

            <!-- 비율 변경용 바와 버튼 -->
            <input type="range" id="ratioRange" min="0" max="100" value="50">
            <div>
                <button>하위10%</button>
                <button>하위20%</button>
                <button>상위20%</button>
                <button>상위10%</button>
            </div>

            <!-- 값 변경용 바 (MIN과 MAX는 적절한 값으로 설정하세요) -->
            <input type="range" id="valueRange" min="MIN" max="MAX" value="MID">
        </div>
    </div>
</div>
</div>
<%@ include file="footer.jsp" %>

<script>

    // modal script
    document.addEventListener('DOMContentLoaded', function () {
        let modals = {
            market: document.getElementById('market-modal'),
            industry: document.getElementById('industry-modal'),
            jogun: document.getElementById('jogun-modal')
        };

        document.querySelector('.market').addEventListener('click', function () {
            modals.market.style.display = 'block';
        });

        document.querySelector('.industry').addEventListener('click', function () {
            modals.industry.style.display = 'block';
        });

        document.querySelector('.jogun').addEventListener('click', function () {
            modals.jogun.style.display = 'block';
        });

        // market-modal에서 "다음" 버튼 클릭 이벤트
        modals.market.querySelector('button:nth-child(2)').addEventListener('click', function () {
            modals.market.style.display = 'none';
            modals.industry.style.display = 'block';
        });

        // industry-modal에서 "다음" 버튼 클릭 이벤트
        modals.industry.querySelector('button:nth-child(2)').addEventListener('click', function () {
            modals.industry.style.display = 'none';
            modals.jogun.style.display = 'block';
        });

        // 각 모달의 "선택완료" 버튼 클릭 이벤트
        for (let key in modals) {
            modals[key].querySelector('button:nth-child(1)').addEventListener('click', function () {
                modals[key].style.display = 'none';
            });
        }
    });

    //인덱스 카드
    document.addEventListener('DOMContentLoaded', function () {
        let indexCards = document.querySelectorAll('.index-card');
        let marketSelected = document.querySelector('.market-selected');

        // 기본으로 5번 카드를 선택
        let defaultCard = document.getElementById('index-card5');
        defaultCard.classList.add('active');
        marketSelected.textContent = defaultCard.querySelector('.card-title').textContent;

        indexCards.forEach(function (card) {
            card.addEventListener('click', function () {
                // 모든 index-card에서 'active' 클래스 제거
                indexCards.forEach(function (innerCard) {
                    innerCard.classList.remove('active');
                });

                // 클릭된 index-card에만 'active' 클래스 추가
                this.classList.add('active');

                // 클릭된 index-card의 타이틀 가져오기
                let cardTitle = this.querySelector('.card-title').textContent;

                // market-selected의 내용을 타이틀로 변경
                marketSelected.textContent = cardTitle;
            });
        });
    });

    //체크박스 스크립트
    document.addEventListener('DOMContentLoaded', function () {
        const allCheckbox = document.querySelector('#industry-modal #all');
        const checkboxes = document.querySelectorAll('#industry-modal .modal2-checklist input[type="checkbox"]');
        const subCheckboxes = {
            'industrialGoods': ['capitalGoods', 'commercialServices', 'transportation'],
            'cyclicalConsumerGoods': ['carsAndParts', 'durableGoods', 'hotelsRestaurants', 'retail', 'educationServices'],
            'essentialConsumerGoods': ['foodAndRetail', 'foodBeverages', 'householdGoods'],
            'healthcare': ['healthcareEquipment', 'pharmBiotech'],
            'finance': ['bank', 'securities', 'diversifiedFinance', 'insurance', 'realEstate'],
            'it': ['softwareServices', 'techHardware', 'semiconductors', 'electronics', 'display'],
            'comServices': ['telecomServices', 'mediaEntertainment']
        };

        allCheckbox.addEventListener('change', function () {
            checkboxes.forEach(cb => cb.checked = allCheckbox.checked);
            updateSelectedCount();
        });

        for (let key in subCheckboxes) {
            let parentCheckbox = document.getElementById(key);
            parentCheckbox.addEventListener('change', function () {
                subCheckboxes[key].forEach(subKey => {
                    document.getElementById(subKey).checked = parentCheckbox.checked;
                });
                updateSelectedCount();
            });
        }

        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function () {
                if (isAllChecked()) {
                    allCheckbox.checked = true;
                } else {
                    allCheckbox.checked = false;
                }

                for (let key in subCheckboxes) {
                    let parentCheckbox = document.getElementById(key);
                    if (isAllSubChecked(subCheckboxes[key])) {
                        parentCheckbox.checked = true;
                    } else {
                        parentCheckbox.checked = false;
                    }
                }

                updateSelectedCount();
            });
        });

        function updateSelectedCount() {
            const checkboxes = document.querySelectorAll("#industry-modal .modal2-checklist input[type='checkbox']:checked");
            let count = checkboxes.length;

            // 상위 카테고리 제외
            if (document.querySelector("#all").checked) count--;
            if (document.querySelector("#industrialGoods").checked) count--;
            if (document.querySelector("#cyclicalConsumerGoods").checked) count--;
            if (document.querySelector("#essentialConsumerGoods").checked) count--;
            if (document.querySelector("#healthcare").checked) count--;
            if (document.querySelector("#finance").checked) count--;
            if (document.querySelector("#it").checked) count--;
            if (document.querySelector("#comServices").checked) count--;

            document.querySelector(".industry-selected").innerText = count + '개';
        }

        function isAllChecked() {
            return [...checkboxes].every(cb => cb.checked);
        }

        function isAllSubChecked(subs) {
            return subs.every(subKey => document.getElementById(subKey).checked);
        }
    });

    //조건 모달
    function openModal(modalId) {
        document.getElementById(modalId).style.display = 'block';
    }

    $(document).ready(function () {
        $('.flex-between').click(function () {
            // 화살표 이미지를 변경합니다.
            var icon = $(this).find('.dropdown-icon');
            var src = icon.attr('src') === 'img/right.png' ? 'img/down.png' : 'img/right.png';
            icon.attr('src', src);

            // 하단 div의 표시 상태를 변경합니다.
            $(this).next('.dropdown-content').slideToggle();
        });
    });


    document.addEventListener('DOMContentLoaded', function () {
        // 체크박스 관련 코드
        const nojogunCheckbox = document.querySelector('#jogun-modal #nojogun');
        const jogunCheckboxes = document.querySelectorAll('#jogun-modal .dropdown-content input[type="checkbox"]');
        const graphTitle = document.querySelector('#jogun-modal #graphTitle');
        const ratioButton = document.querySelector('#jogun-modal #ratioChange');
        const valueButton = document.querySelector('#jogun-modal #valueChange');
        const ratioRange = document.querySelector('#jogun-modal #ratioRange');
        const valueRange = document.querySelector('#jogun-modal #valueRange');
        const jogunRightDiv = document.querySelector('#jogun-modal .jogun-right');

        // 체크박스 'nojogun' 관련 처리
        nojogunCheckbox.addEventListener('change', function () {
            jogunCheckboxes.forEach(checkbox => {
                checkbox.checked = !this.checked;
            });
        });

        // 일반 체크박스 관련 처리
        jogunCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function () {
                nojogunCheckbox.checked = false;

                if (checkbox.checked) {
                    let parentTitle = checkbox.closest('.dropdown-content').previousElementSibling.innerText.trim();
                    graphTitle.innerText = `${checkbox.nextElementSibling.textContent} | ${parentTitle}`;

                    jogunRightDiv.style.display = "block";
                    ratioButton.style.display = "inline-block";
                    valueButton.style.display = "inline-block";
                    ratioRange.style.display = "none";
                    valueRange.style.display = "none";

                    // 체크박스를 클릭했을 때 기본 그래프는 '비율변경' 그래프입니다.
                    drawRatioGraph();
                }
            });
        });

        // 그래프 관련 코드
        let myChart;
        let ctx = document.querySelector('#jogun-modal #myChart').getContext('2d');

        function drawRatioGraph() {
            if (myChart) {
                myChart.destroy();
            }

            myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: [...Array(100).keys()],
                    datasets: [{
                        label: '비율 데이터',
                        data: [...Array(100).keys()].map(x => Math.exp(-Math.pow((x - 50) / 10, 2) / 2) / Math.sqrt(2 * Math.PI) / 10),
                        borderColor: 'rgb(75, 192, 192)',
                        fill: false
                    }]
                }
            });

            ratioRange.style.display = "block";
            valueRange.style.display = "none";
        }

        ratioButton.onclick = drawRatioGraph;

        valueButton.onclick = function () {
            if (myChart) {
                myChart.destroy();
            }

            myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['A', 'B', 'C', 'D', 'E'],
                    datasets: [{
                        label: '값 데이터',
                        data: [10, 15, 7, 12, 9],
                        backgroundColor: ['rgba(255, 99, 132, 0.2)', 'rgba(255, 159, 64, 0.2)', 'rgba(255, 205, 86, 0.2)', 'rgba(75, 192, 192, 0.2)', 'rgba(54, 162, 235, 0.2)']
                    }]
                }
            });

            ratioRange.style.display = "none";
            valueRange.style.display = "block";
        };

        // Range 변화에 따른 그래프 업데이트 예시 (비율 변경에만 적용하였음)
        ratioRange.addEventListener('input', function () {
            let value = this.value;
            if (myChart) {
                myChart.destroy();
            }
            myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: [...Array(100).keys()],
                    datasets: [{
                        label: '비율 데이터',
                        data: [...Array(100).keys()].map(x => Math.exp(-Math.pow((x - value) / 10, 2) / 2) / Math.sqrt(2 * Math.PI) / 10),
                        borderColor: 'rgb(75, 192, 192)',
                        fill: false
                    }]
                }
            });
        });
    });
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const listButton = document.querySelector(".right-header button:nth-child(1)");
        const pastButton = document.querySelector(".right-header button:nth-child(2)");

        const listDiv = document.querySelector(".list");
        const pastDiv = document.querySelector(".past");

        listButton.addEventListener('click', function () {
            listDiv.style.display = 'block';
            pastDiv.style.display = 'none';
        });

        pastButton.addEventListener('click', function () {
            listDiv.style.display = 'none';
            pastDiv.style.display = 'block';
        });
    });

    // 차트 그리기

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
            },
            credits: {
                enabled: false
            },
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

    // 수익률 그래프 받아옴
    jsonData.forEach(item => item.active = true);
    updateTable();
    drawTreeMap();

    setInterval(function () {
        var imageUrl = "/api/getChart";
        var imageElement = document.getElementById("chartImage");

        // 캐시를 피하기 위해 타임스탬프를 추가
        imageElement.src = imageUrl + "?t=" + new Date().getTime();
    }, 1000); // 1초마다 이미지를 새로 고침


    const dataForm = document.getElementById("dataForm");

    dataForm.addEventListener('click', function (event) {
        // json으로 변환 후, port.jsp에 데이터 전달
        var json = generateJsonFromTable();

        // json 데이터의 각 항목을 수정
        json = json.map(function (item) {
            var parts = item.ticker.split('.');
            var tickerPart = parts[0];
            var marketPart = parts[1] === "KS" ? "KOSPI" : "KOSDAQ";

            // 원래 item의 내용을 유지하면서 ticker와 market을 수정/추가
            return {
                ...item,
                ticker: tickerPart,
                market: marketPart
            };
        });

        document.getElementById('jsonData').value = JSON.stringify(json);

        // 이제 폼 제출
        dataForm.submit();
    });

    //날짜 선택
    window.onload = function () {
        var pikadayOptions = {
            format: 'YYYY-MM-DD',
            i18n: {
                previousMonth: '지난달',
                nextMonth: '다음달',
                months: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                weekdays: ['일', '월', '화', '수', '목', '금', '토'],
                weekdaysShort: ['일', '월', '화', '수', '목', '금', '토']
            }
        };

        var startDatePicker = new Pikaday({
            ...pikadayOptions,
            field: document.getElementById('startDate')
        });

        var endDatePicker = new Pikaday({
            ...pikadayOptions,
            field: document.getElementById('endDate')
        });
    };


    // 종목 개수 제한
    function validateInput() {
        const inputElement = document.getElementById('stockCount');
        const errorElement = document.getElementById('error');

        if (inputElement.value < 5 || inputElement.value > 50) {
            errorElement.style.display = 'block';
        } else {
            errorElement.style.display = 'none';
        }
    }

    //테이블 페이지네이션
    var rowsPerPage = 10;  // 한 페이지당 보여줄 행의 수
    var currentPage = 1;

    function updateTableDisplay() {
        var table = document.getElementById("stockTable");
        var rows = table.querySelectorAll("tbody tr");
        var totalPages = Math.ceil(rows.length / rowsPerPage);
        document.getElementById("totalPages").textContent = totalPages;

        for (var i = 0; i < rows.length; i++) {
            if (i < (currentPage - 1) * rowsPerPage || i >= currentPage * rowsPerPage) {
                rows[i].style.display = "none";
            } else {
                rows[i].style.display = "";
            }
        }

        document.getElementById("currentPage").textContent = currentPage;
    }

    function changePage(delta) {
        var table = document.getElementById("stockTable");
        var rows = table.querySelectorAll("tbody tr");
        var totalPages = Math.ceil(rows.length / rowsPerPage);
        currentPage += delta;

        if (currentPage < 1) {
            currentPage = 1;
        } else if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        updateTableDisplay();
    }

    window.onload = function () {
        updateTableDisplay();
    };
</script>
</body>
</html>
