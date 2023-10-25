<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Indexing</title>
    <title>Title</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <%--    하이차트--%>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/heatmap.js"></script>
    <script src="https://code.highcharts.com/modules/treemap.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
    <script src="https://code.highcharts.com/modules/data.js"></script>
    <script src="https://code.highcharts.com/modules/drilldown.js"></script>

    <style>

        /*하이차트*/
        .highcharts-figure,
        .highcharts-data-table table {
            min-width: 320px;
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

        input[type="number"] {
            min-width: 50px;
        }

        /*본문*/

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
            flex-direction: column;
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


        .market, .industry, .jogun, .suljeong, .rebal, .result, .nobuy {
            height: 80px;
            background-color: #ccc; /* 회색으로 설정 */
            border-radius: 20px;
            display: flex;
            align-items: center; /* 텍스트를 중앙에 위치 */
            padding-left: 15px; /* 텍스트에 약간의 패딩 추가 */
        }

        .market {
            flex-direction: row;
            justify-content: space-between;
        }

        .md-mobile-picker-header {
            font-size: 14px;
        }

        input.md-mobile-picker-input {
            color: initial;
            width: 100%;
            padding: 10px;
            margin: 6px 0 12px 0;
            border: 1px solid #ccc;
            border-radius: 0;
            font-family: arial, verdana, sans-serif;
            font-size: 14px;
            box-sizing: border-box;
            -webkit-appearance: none;
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

        .index-top {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 1440px;
        }

        .top-header {
            display: flex;
            flex-direction: row;
            justify-content: space-evenly;
            align-items: center;
            margin-bottom: 50px;
            margin-top: 50px;
            font-family: "하나2.0 M";
            font-size: 30px;
            font-weight: 700;
            color: #0E8C8D;
            width: 1440px;
            height: 60px;
        }

        .top-header > p {
            color: #7f73eb;
            font-size: 20px;
        }

        .edit {
            box-sizing: border-box;
            padding: 10px 20px;
            color: white;
            background-color: #E90061; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            font-size: 15px;
            width: 100px;
            text-decoration: none;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .top-main {
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }

        .top-left {
            width: 800px;
        }

        .top-right {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
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

        .past {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .cumulative {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
            width: 1200px;
        }

        .cumulative-right {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 300px;
        }


        .mdd {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
            width: 1200px;
        }

        .mdd-right {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 300px;
        }

        .si {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
            width: 1200px;
        }

        .box1, .box2 {
            width: 200px;
            height: 200px;
            background-color: #fffbfa;
            border-radius: 10px;
            display: flex;
            align-items: center; /* 텍스트를 중앙에 위치 */
            padding-left: 15px; /* 텍스트에 약간의 패딩 추가 */
            padding-right: 15px; /* 텍스트에 약간의 패딩 추가 */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            font-family: "하나2.0 M";
            font-size: 30px;
            font-weight: 700;
            color: #7f73eb;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .box2 {
            color: black;
        }

        .etc {
            display: flex;
            flex-direction: row;
            justify-content: space-evenly;
            align-items: center;
            width: 1200px;
        }

        .box3 {
            width: 300px;
            height: 300px;
            background-color: #fffbfa;
            border-radius: 10px;
            display: flex;
            align-items: center; /* 텍스트를 중앙에 위치 */
            padding-left: 15px; /* 텍스트에 약간의 패딩 추가 */
            padding-right: 15px; /* 텍스트에 약간의 패딩 추가 */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            font-family: "하나2.0 M";
            font-size: 30px;
            font-weight: 700;
            color: #7cb5ec;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .box3 > h3 {
            color: #E90061;
        }

    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="wrap">
    <div class="contents-header">
        <div>
            1013 김남훈 포트폴리오
        </div>
        <div class="header-button">
            <a href="/portfolios" class="indexing-button">다른 포트폴리오</a>
            <a href="#" class="portfolio-button">
                <img src="img/graphanimation.gif">
                이 전략으로 투자하기
            </a>
        </div>
    </div>
    <div class="contents">
        <div class="index-top">
            <div class="top-header">
                <%--                <h1 id="portfolioName">제목없는 포트폴리오</h1>--%>
                <%--                <p>포트폴리오 생성일: <span--%>
                <%--                        id="creationDate"><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %></span>--%>
                <%--                </p>--%>
                <%--                <button class="edit" onclick="editPortfolioName()">제목 수정</button>--%>
            </div>
            <div class="top-main">
                <div class="top-left">
                    <div id="pieChartContainer"></div>
                    <%--                    <button id="saveButton">저장하기</button>--%>
                </div>
                <div class="top-right">
                    <table id="stockTable" border="1" style="width: 600px; margin: 20px auto;">
                        <thead>
                        <tr>
                            <th>종목명</th>
                            <th>종목코드</th>
                            <th>시장</th>
                            <th>비중</th>
                        </tr>
                        </thead>
                        <tbody id="stockList">
                        <c:forEach var="item" items="${items}">
                            <tr>
                                <td>${item.stockname}</td>
                                <td>${item.ticker}</td>
                                <td>${item.market}</td>
                                <td>${item.weight}%</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div id="pagination">
                        <button onclick="changePage(-1)">이전</button>
                        <span id="currentPage">1</span> / <span id="totalPages"></span>
                        <button onclick="changePage(1)">다음</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="index-middle">
            <div class="top-header">

                <h1>백테스팅 결과</h1>
            </div>
            <div class="past">
                <div class="cumulative">
                    <div id="cumulativeReturnChart"></div>
                    <div class="cumulative-right">
                        <div class="box1">
                            <!-- Custom Index Cumulative Return -->
                            <div id="customCumulativeReturn">
                                내 투자 <br>
                                <span></span>
                            </div>
                            <p></p>
                            <div id="diffCumulativeReturn" style="font-size: 20px">KOSPI 대비 <span></span></div>
                        </div>
                        <div class="box2">
                            <!-- KOSPI Cumulative Return -->
                            <div id="kospiCumulativeReturn">KOSPI
                                <br><span></span></div>
                        </div>
                    </div>
                </div>

                <div class="mdd">
                    <div id="dailyMddChart"></div>
                    <div class="mdd-right">
                        <div class="box1">
                            <!-- Custom Index MDD -->
                            <div id="customMddValue">
                                내 투자 <br>
                                <span></span>
                            </div>
                            <P></P>
                            <div id="diffMdd" style="font-size: 20px">KOSPI 대비 <span></span></div>
                        </div>
                        <div class="box2">
                            <!-- KOSPI MDD -->
                            <div id="kospiMddValue">KOSPI
                                <br><span></span></div>
                        </div>
                    </div>
                </div>
                <div class="si">
                    <!-- Sectors Pie Chart -->
                    <div id="sectorPieChart"></div>
                    <!-- Industries Pie Chart -->
                    <div id="industryPieChart"></div>
                </div>
                <div class="etc">
                    <div class="box3">
                        <h3>샤프지수</h3>
                        <!-- Sectors Pie Chart -->
                        <div id="customSharpeRatio">내 투자 : <span></span></div>
                        <!-- Industries Pie Chart -->
                        <div id="kospiSharpeRatio" style="color: black">KOSPI : <span></span></div>
                        <div class="sharp" id="sharpBarChart" style="width:100%; height:200px;"></div>
                    </div>

                    <div class="box3">
                        <h3>연율화 수익률</h3>
                        <!-- Sectors Pie Chart -->
                        <div id="customAnnualizedReturn">내 투자 : <span></span></div>
                        <!-- Industries Pie Chart -->
                        <div id="kospiAnnualizedReturn" style="color : black">KOSPI : <span></span></div>
                        <div class="annual" id="annualBarChart" style="width:100%; height:200px;"></div>
                    </div>

                    <div class="box3">
                        <h3>연율화 변동성</h3>
                        <!-- Sectors Pie Chart -->
                        <div id="customVolatility">내 투자 : <span></span></div>
                        <!-- Industries Pie Chart -->
                        <div id="kospiVolatility" style="color: black">KOSPI : <span></span></div>
                        <div class="volatility" id="volatilityBarChart" style="width:100%; height:200px;"></div>
                    </div>

                </div>

            </div>
        </div>
    </div>
    <div class="index-left" style="display: none;">
        <div>
            <table border="1">
                <thead>
                <tr>
                    <th>Market</th>
                    <th>Ticker</th>
                    <th>Stock Name</th>
                    <th>Weight</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${items}">
                    <tr>
                        <td>${item.market}</td>
                        <td>${item.ticker}</td>
                        <td>${item.stockname}</td>
                        <td>${item.weight}%</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</div>

<form id="postDataForm" method="post" action="">
    <input type="hidden" name="jsonData" id="jsonDataInput">
</form>
<div id="market-modal" class="modal">
    <div class="modal-header market-header">
        <div class="modal-header1">
            투자 방법을 선택하세요.
        </div>
        <div class="button-wrap">
            <button class="button1" onclick="submitForm()">선택완료</button>
            <button class="button2">다음</button>
        </div>
    </div>
    <div class="market-modal-body">
        <div class="market-body-header">
        </div>
        <div class="market-content">
            <div style="display: flex; width:550px; flex-direction: row; justify-content: space-between; margin-bottom: 50px">
                <div class="index-card" id="index-card1" onclick="selectCard('index-card1')" style="width:250px; height: 100px; display: flex; flex-direction: column; font-family: '하나2.0 R'; font-size: 15px;
                                    justify-content: space-around">
                    <div style="display: flex; flex-direction: row; justify-content: space-around">
                        <div class="card-title"
                             style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
                            자문 계약 맺기
                        </div>
                        <div style="width:25px; height: 25px; background-color: #CF3540; color: white; display: flex; justify-content: center; align-items: center; border-radius: 5px; font-weight: 700;">
                            KR
                        </div>
                    </div>
                    <div style="margin-left: 20px">
                        내 포트폴리오를 하나 증권의 <br>전문가와
                        함께 투자해보세요.
                    </div>
                </div>

                <div class="index-card" id="index-card2" onclick="selectCard('index-card2')" style="width:250px; height: 100px; display: flex; flex-direction: column;  font-family: '하나2.0 R'; font-size: 15px;
                                    justify-content: space-around">
                    <div style="display: flex; flex-direction: row; justify-content: space-around">
                        <div class="card-title"
                             style="font-size: 15px; font-family: '하나2.0 M'; font-weight : 700;">
                            직접 거래 하기
                        </div>
                        <div style="width:25px; height: 25px; background-color: #CF3540; color: white; display: flex; justify-content: center; align-items: center; border-radius: 5px; font-weight: 700;">
                            KR
                        </div>
                    </div>
                    <div style="margin-left: 20px">
                        내 포트폴리오를 실시간 차트를 <br>보며
                        투자해보세요.
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- JSON 데이터를 담을 hidden input 필드 추가 -->
    <input type="hidden" id="jsonData" name="jsonData" value="">
</div>
<%@ include file="footer.jsp" %>

<script>
    //이전 페이지
    function goToPortfolioItems(portfolioId) {
        window.location.href = "/portfolioItems?id=" + portfolioId;
    }

    //모달 팝업
    document.querySelector('.portfolio-button').addEventListener('click', function (e) {
        e.preventDefault(); // 기본 앵커 태그의 동작을 막습니다.
        openModal();
    });

    function openModal() {
        document.getElementById('market-modal').style.display = 'block';
    }

    function closeModal() {
        document.getElementById('market-modal').style.display = 'none';
    }

    var selectedPath;  // 사용자가 선택한 카드에 따른 경로 저장

    function selectCard(target) {
        var currentId = new URL(window.location.href).searchParams.get("id");

        // 모든 index-card에서 active 클래스 제거
        var cards = document.querySelectorAll('.index-card');
        cards.forEach(function (card) {
            card.classList.remove('active');
        });

        // 선택된 카드에 active 클래스 추가
        var selectedCard = document.getElementById(target);
        selectedCard.classList.add('active');

        switch (target) {
            case 'index-card1':
                selectedPath = '/jamoon?id=' + currentId;
                break;
            case 'index-card2':
                selectedPath = '/realtime?id=' + currentId;
                break;
        }
    }

    function submitForm() {
        if (selectedPath) {
            // 폼의 action 속성을 selectedPath로 설정
            document.getElementById('postDataForm').action = selectedPath;

            // jsonData 값을 hidden input에 설정
            document.getElementById('jsonDataInput').value = createJsonData();

            // 폼 제출
            document.getElementById('postDataForm').submit();
        }
    }

    function createJsonData() {
        var items = [];
        <c:forEach var="item" items="${items}">
        items.push({
            market: "${item.market}",
            ticker: "${item.ticker}",
            stockname: "${item.stockname}",
            weight: "${item.weight}"
        });
        </c:forEach>
        return JSON.stringify(items);
    }

    var jsonData = createJsonData();

    // JSON 데이터를 JavaScript 객체로 파싱
    var chartData = JSON.parse(jsonData);

    // 데이터를 pie chart 형식에 맞게 변환
    var pieData = chartData.map(function (item) {
        return {
            name: item.stockname,
            y: parseFloat(item.weight.replace('%', ''))
        };
    });
    Highcharts.chart('pieChartContainer', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie',
            width: 800,  // 원하는 너비 값으로 설정 (예: 800 픽셀)
            height: 600  // 원하는 높이 값으로 설정 (예: 600 픽셀)
        },
        title: {
            text: '포트폴리오 구성',
            style: {
                color: 'black',            // 글씨 색상
                fontSize: '30px',        // 글씨 크기
                fontFamily: '하나2.0 B',
                fontWeight: '700'// 폰트 지정
            }
        },
        credits: {
            enabled: false
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        accessibility: {
            point: {
                valueSuffix: '%'
            }
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            name: '비중',
            colorByPoint: true,
            data: pieData
        }]
    });


    //python

    $(document).ready(function () {

        // Metrics 데이터 가져오기
        function getMetrics() {
            console.log("getMetrics function called!");
            $.ajax({
                url: '/api/getMetrics',
                method: 'GET',
                success: handleMetricsData,
                error: function (error) {
                    alert("Error fetching metrics: " + error.responseText);
                }
            });
        }

        // Metrics 데이터 처리
        function handleMetricsData(data) {
            console.log("Received data:", data);

            // Cumulative Return 값을 퍼센트로 변환하여 HTML 요소에 설정
            let customCumulativeReturnPercentage = (data.custom_index['Cumulative Return'] * 100).toFixed(2);
            let kospiCumulativeReturnPercentage = (data.kospi['Cumulative Return'] * 100).toFixed(2);

            $("#customCumulativeReturn span").text(customCumulativeReturnPercentage + '%');
            $("#kospiCumulativeReturn span").text(kospiCumulativeReturnPercentage + '%');

// Cumulative Return 차이 계산 및 표시
            let diffCumulativeReturn = (customCumulativeReturnPercentage - kospiCumulativeReturnPercentage).toFixed(2);
            $("#diffCumulativeReturn span").text(diffCumulativeReturn + '%');


// MDD 값을 퍼센트로 변환하여 HTML 요소에 설정
            let customMddPercentage = (data.custom_index['MDD'] * 100).toFixed(2);
            let kospiMddPercentage = (data.kospi['MDD'] * 100).toFixed(2);

            $("#customMddValue span").text(customMddPercentage + '%');
            $("#kospiMddValue span").text(kospiMddPercentage + '%');

// MDD 차이 계산 및 표시
            let diffMdd = (customMddPercentage - kospiMddPercentage).toFixed(2);
            $("#diffMdd span").text(diffMdd + '%');


            // Custom Index 값 설정
            $("#customAnnualizedReturn span").text((data.custom_index['Annualized Return'] * 100).toFixed(2) + '%');
            $("#customVolatility span").text((data.custom_index['Volatility'] * 100).toFixed(2) + '%');
            $("#customSharpeRatio span").text(data.custom_index['Sharpe Ratio'].toFixed(2));

// KOSPI 값 설정
            $("#kospiAnnualizedReturn span").text((data.kospi['Annualized Return'] * 100).toFixed(2) + '%');
            $("#kospiVolatility span").text((data.kospi['Volatility'] * 100).toFixed(2) + '%');
            $("#kospiSharpeRatio span").text(data.kospi['Sharpe Ratio'].toFixed(2));


            // 차트 그리기 함수 호출
            drawCumulativeReturnChart(data.custom_index['Cumulative Returns Data'], data.kospi['Cumulative Returns Data']);
            drawDailyMddChart(data.custom_index['Daily MDD'], data.kospi['Daily MDD']);
            // drawMonthlyReturnChart(data.custom_index['Monthly Returns'], data.kospi['Monthly Returns']);
            drawSectorPieChart(data.custom_index["Tickers Sectors"]);
            drawIndustryPieChart(data.custom_index["Tickers Industries"]);
            localStorage.setItem('metricsData', JSON.stringify(data));
            drawBarCharts(data.custom_index, data.kospi);
        }

        // 페이지 로드 시 Metrics 데이터 가져오기
        getMetrics();

    });

    function drawCumulativeReturnChart(customData, kospiData) {
        console.log("customData:", customData);
        console.log("kospiData:", kospiData);
        Highcharts.chart('cumulativeReturnChart', {
            chart: {
                width: 800,  // 원하는 너비 값으로 설정 (예: 800 픽셀)
                height: 600  // 원하는 높이 값으로 설정 (예: 600 픽셀)
            },
            title: {
                text: '누적수익률',
                style: {
                    color: 'black',            // 글씨 색상
                    fontSize: '30px',        // 글씨 크기
                    fontFamily: '하나2.0 B',
                    fontWeight: '700'// 폰트 지정
                }
            }, credits: {
                enabled: false
            },
            xAxis: {
                type: 'datetime'
            },
            yAxis: {
                title: {
                    text: 'Cumulative Return'
                }
            },
            series: [{
                name: '내 투자',
                data: customData.map(function (point) {
                    return [new Date(point[0]).getTime(), point[1]];
                })
            }, {
                name: 'KOSPI',
                data: kospiData.map(function (point) {
                    return [new Date(point[0]).getTime(), point[1]];
                })
            }]
        });
    }

    function drawDailyMddChart(customData, kospiData) {
        Highcharts.chart('dailyMddChart', {
            chart: {
                width: 800,  // 원하는 너비 값으로 설정 (예: 800 픽셀)
                height: 600  // 원하는 높이 값으로 설정 (예: 600 픽셀)
            },
            title: {
                text: '최대 손실(MDD)',
                style: {
                    color: 'black',            // 글씨 색상
                    fontSize: '30px',        // 글씨 크기
                    fontFamily: '하나2.0 B',
                    fontWeight: '700'// 폰트 지정
                }
            }, credits: {
                enabled: false
            },
            xAxis: {
                type: 'datetime'
            },
            yAxis: {
                title: {
                    text: 'MDD'
                }
            },
            series: [{
                name: 'Custom Index',
                data: customData.map(function (point) {
                    return [new Date(point[0]).getTime(), point[1]];
                })
            }, {
                name: 'KOSPI',
                data: kospiData.map(function (point) {
                    return [new Date(point[0]).getTime(), point[1]];
                })
            }]
        });
    }

    //섹터

    function drawSectorPieChart(sectors) {
        let sectorCounts = {};

        for (let ticker in sectors) {
            let sector = sectors[ticker];
            if (sector === 'N/A') continue;  // 'N/A' 값을 무시
            sectorCounts[sector] = (sectorCounts[sector] || 0) + 1; // 섹터별 카운트 증가
        }

        let processedData = [];
        for (let sector in sectorCounts) {
            processedData.push({
                name: sector,
                y: sectorCounts[sector]
            });
        }

        console.log("Sector Counts:", sectorCounts);
        console.log("Processed Data for Pie Chart:", processedData);

        Highcharts.chart('sectorPieChart', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie', width: 600,  // 원하는 너비 값으로 설정 (예: 800 픽셀)
                height: 600  // 원하는 높이 값으로 설정 (예: 600 픽셀)
            },
            title: {
                text: '섹터 분포',
                style: {
                    color: 'black',            // 글씨 색상
                    fontSize: '30px',        // 글씨 크기
                    fontFamily: '하나2.0 B',
                    fontWeight: '700'// 폰트 지정
                }
            }, credits: {
                enabled: false
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    size: '60%',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                    }
                }
            },
            series: [{
                name: 'Sectors',
                colorByPoint: true,
                data: processedData
            }]
        });
    }

    function drawIndustryPieChart(industries) {
        let industryCounts = {};

        for (let ticker in industries) {
            let industry = industries[ticker];
            if (industry === 'N/A') continue;  // 'N/A' 값을 무시
            industryCounts[industry] = (industryCounts[industry] || 0) + 1; // 산업별 카운트 증가
        }

        let processedData = [];
        for (let industry in industryCounts) {
            processedData.push({
                name: industry,
                y: industryCounts[industry]
            });
        }

        console.log("Industry Counts:", industryCounts);
        console.log("Processed Data for Pie Chart:", processedData);

        Highcharts.chart('industryPieChart', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie', width: 600,  // 원하는 너비 값으로 설정 (예: 800 픽셀)
                height: 600  // 원하는 높이 값으로 설정 (예: 600 픽셀)
            },
            title: {
                text: '산업 분포',
                style: {
                    color: 'black',            // 글씨 색상
                    fontSize: '30px',        // 글씨 크기
                    fontFamily: '하나2.0 B',
                    fontWeight: '700'// 폰트 지정
                }
            }, credits: {
                enabled: false
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    size: '60%',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                    }
                }
            },
            series: [{
                name: 'Industries',
                colorByPoint: true,
                data: processedData
            }]
        });
    }

    function drawBarCharts(customMetrics, kospiMetrics) {

        // 공통 옵션 정의
        const commonOptions = {
            chart: {
                type: 'bar',
                backgroundColor: null // 배경 투명하게
            },
            title: {
                text: null  // 제목 숨김
            },
            xAxis: {
                visible: false,  // x축 숨김
            },
            yAxis: {
                visible: false,  // y축 숨김
            },
            legend: {
                enabled: true
            },
            credits: {
                enabled: false
            }
        };

        // Sharpe Ratio 비교
        Highcharts.chart('sharpBarChart', {
            ...commonOptions,
            series: [{
                name: '내 투자',
                data: [customMetrics['Sharpe Ratio']],
                color: '#7cb5ec'  // 색상 지정 (이 부분은 원하는 색상으로 변경 가능)
            }, {
                name: 'KOSPI',
                data: [kospiMetrics['Sharpe Ratio']],
                color: '#434348'  // 색상 지정 (이 부분은 원하는 색상으로 변경 가능)
            }]
        });

        // Annualized Return 비교
        Highcharts.chart('annualBarChart', {
            ...commonOptions,
            series: [{
                name: '내 투자',
                data: [customMetrics['Annualized Return']],
                color: '#7cb5ec'  // 색상 지정
            }, {
                name: 'KOSPI',
                data: [kospiMetrics['Annualized Return']],
                color: '#434348'  // 색상 지정
            }]
        });

        // Volatility 비교
        Highcharts.chart('volatilityBarChart', {
            ...commonOptions,
            series: [{
                name: '내 투자',
                data: [customMetrics['Volatility']],
                color: '#7cb5ec'  // 색상 지정
            }, {
                name: 'KOSPI',
                data: [kospiMetrics['Volatility']],
                color: '#434348'  // 색상 지정
            }]
        });
    }

    let currentPortfolioName = "제목없는 포트폴리오";  // 페이지 로드 시 기본 값

    function editPortfolioName() {
        var newName = prompt("새로운 포트폴리오 이름을 입력하세요:", document.getElementById("portfolioName").innerText);
        if (newName) {
            document.getElementById("portfolioName").innerText = newName;
            currentPortfolioName = newName;
            // AJAX를 사용하여 서버에 새로운 포트폴리오 이름을 업데이트할 수 있습니다.
        }
    }


    //페이지네이션
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
