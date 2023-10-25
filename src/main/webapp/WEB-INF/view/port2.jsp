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
            align-items: center;
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

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover, .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }


    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="wrap">
    <div class="contents-header">
        <div>
            김남훈님의 다이렉트 원덱싱
        </div>
        <div class="header-button">
            <a href="/indexing" class="indexing-button">다른 전략 선택</a>
            <button id="saveButton" class="portfolio-button">
                <img src="img/graphanimation.gif">
                포트폴리오 저장하기
            </button>
        </div>
    </div>
    <div class="contents">
        <div class="index-top">
            <div class="top-header">
                <h1 id="portfolioName">제목없는 포트폴리오</h1>
                <p>포트폴리오 생성일: <span
                        id="creationDate"><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %></span>
                </p>
                <button class="edit" onclick="editPortfolioName()">제목 수정</button>
                <button class="edit" onclick="showOptimizationModal()">포트폴리오 최적화</button>
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
                        <tbody id="stockList"></tbody>
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
</div>

<div id="optimizationModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>포트폴리오 최적화 옵션</h2>
        <button id="maxSharpeBtn">최대 샤프 지수 포트폴리오</button>
        <button id="minVolatilityBtn">최소 분산 포트폴리오</button>
        <button id="riskParityBtn">위험 균형 포트폴리오</button>
    </div>
</div>


<%@ include file="footer.jsp" %>

<script>
    <% String jsonData = request.getParameter("jsonData"); %>
    var chartData = JSON.parse('<%= jsonData %>');

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

    var tableBody = document.getElementById("stockList");
    chartData.forEach(function (item) {
        var row = tableBody.insertRow();
        var nameCell = row.insertCell(0);
        var tickerCell = row.insertCell(1);
        var marketCell = row.insertCell(2);
        var weightCell = row.insertCell(3);

        nameCell.textContent = item.stockname;
        tickerCell.textContent = item.ticker;
        marketCell.textContent = item.market;

        // 소수점 뒤의 0 제거하고 %로 표시
        var weightValue = parseFloat(item.weight.replace('%', ''));
        weightCell.textContent = weightValue.toFixed(2) + '%';
    });

    document.getElementById("saveButton").addEventListener("click", function () {
        var cleanedChartData = chartData.map(function (item) {
            var cleanedWeight = parseFloat(item.weight.replace('%', ''));
            return {
                stockname: item.stockname,
                ticker: item.ticker,
                market: item.market,
                weight: cleanedWeight
            };
        });

        var portfolioData = {
            portfolio: {
                portfolioName: document.getElementById("portfolioName").innerText
                // 필요하다면 다른 속성들도 여기에 추가할 수 있습니다.
            },
            items: cleanedChartData
        };

        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/savePortfolio", true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.send(JSON.stringify(portfolioData));

        xhr.onload = function () {
            if (xhr.status == 200) {
                alert("저장되었습니다.");
            } else {
                alert("에러 발생: " + xhr.responseText);
            }
        };
    });


    //python

    $(document).ready(function () {

        let globalData = null;  // 전역 변수로 데이터를 저장합니다.

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

        // 선택된 옵션에 따라 데이터를 변경하고 화면을 갱신하는 함수
        function fetchOptimizedData(option) {
            if (!globalData) {
                console.error("Data is not yet loaded.");
                return;
            }

            let targetData;

            switch (option) {
                case 'option1':
                    targetData = globalData.max_sharpe;  // Assuming the Python data structure uses "max_sharpe_metrics"
                    break;
                case 'option2':
                    targetData = globalData.min_volatility; // Similarly for other options...
                    break;
                case 'option3':
                    targetData = globalData.risk_parity;
                    break;
                default:
                    targetData = globalData.custom_index; // Default case...
            }

            handleMetricsData({ custom_index: targetData, kospi: globalData.kospi });
        }

        $("#maxSharpeBtn").click(function () {
            fetchOptimizedData('option1');
        });

        $("#minVolatilityBtn").click(function () {
            fetchOptimizedData('option2');
        });

        $("#riskParityBtn").click(function () {
            fetchOptimizedData('option3');
        });


        // Metrics 데이터 처리
        function handleMetricsData(data) {
            if (!data.custom_index || !data.custom_index['Cumulative Return']) {
                console.error("Custom Index or its Cumulative Return is missing.");
                return;
            }

            if (!data.kospi || !data.kospi['Cumulative Return']) {
                console.error("KOSPI data or its Cumulative Return is missing.");
                return;
            }
            console.log("Received data:", data);
            if (!globalData) {
                globalData = data;  // 처음 데이터를 받아올 때 전역 변수에 저장합니다.
            }

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

    $(document).ready(function() {
        // 모달 닫기 버튼에 이벤트 리스너 연결
        $(".close").click(function(){
            closeOptimizationModal();
        });
    });

    // 모달을 숨기는 함수
    function closeOptimizationModal() {
        var modal = document.getElementById('optimizationModal');
        modal.style.display = "none";
    }

    // 모달을 보이게 하는 함수
    function showOptimizationModal() {
        var modal = document.getElementById('optimizationModal');
        modal.style.display = "block";
    }

    //최적화 테이블 업데이트



</script>
</body>
</html>
