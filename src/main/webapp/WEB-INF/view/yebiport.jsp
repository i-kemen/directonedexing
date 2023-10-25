<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>

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
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div>
    <h1 id="portfolioName">제목없는 포트폴리오</h1>
    <button onclick="editPortfolioName()">제목 수정</button>
    <p>포트폴리오 생성일: <span
            id="creationDate"><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %></span>
    </p>
</div>
<div id="pieChartContainer"
     style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto; margin-top: 75px;"></div>
<button id="saveButton">저장하기</button>

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

<div class="past">
    <div id="cumulativeReturnChart" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
    <div id="monthlyReturnChart" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
    <div id="dailyMddChart" style="min-width: 310px; height: 400px; margin: 0 auto"></div>

    <!-- Sectors Pie Chart -->
    <div id="sectorPieChart" style="min-width: 310px; height: 400px; margin: 0 auto"></div>

    <!-- Industries Pie Chart -->
    <div id="industryPieChart" style="min-width: 310px; height: 400px; margin: 0 auto"></div>

    <!-- Custom Index Cumulative Return -->
    <div id="customCumulativeReturn">Custom Index Cumulative Return: <span></span></div>

    <!-- KOSPI Cumulative Return -->
    <div id="kospiCumulativeReturn">KOSPI Cumulative Return: <span></span></div>

    <!-- Custom Index MDD -->
    <div id="customMddValue">Custom Index MDD: <span></span></div>

    <!-- KOSPI MDD -->
    <div id="kospiMddValue">KOSPI MDD: <span></span></div>
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
            type: 'pie'
        },
        credits: {
            enabled: false
        },
        title: {
            text: '포트폴리오 구성'
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

            // Cumulative Return 값을 HTML 요소에 설정
            $("#customCumulativeReturn span").text(data.custom_index['Cumulative Return'].toFixed(2));
            $("#kospiCumulativeReturn span").text(data.kospi['Cumulative Return'].toFixed(2));

            // MDD 값을 HTML 요소에 설정
            $("#customMddValue span").text(data.custom_index['MDD'].toFixed(2));
            $("#kospiMddValue span").text(data.kospi['MDD'].toFixed(2));

            // 차트 그리기 함수 호출
            drawCumulativeReturnChart(data.custom_index['Cumulative Returns Data'], data.kospi['Cumulative Returns Data']);
            drawDailyMddChart(data.custom_index['Daily MDD'], data.kospi['Daily MDD']);
            drawMonthlyReturnChart(data.custom_index['Monthly Returns'], data.kospi['Monthly Returns']);
            drawSectorPieChart(data.custom_index["Tickers Sectors"]);
            drawIndustryPieChart(data.custom_index["Tickers Industries"]);
        }

        // 페이지 로드 시 Metrics 데이터 가져오기
        getMetrics();

    });

    function drawCumulativeReturnChart(customData, kospiData) {
        console.log("customData:", customData);
        console.log("kospiData:", kospiData);
        Highcharts.chart('cumulativeReturnChart', {
            title: {
                text: 'Cumulative Return Comparison'
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

    function drawMonthlyReturnChart(customData, kospiData) {
        Highcharts.chart('monthlyReturnChart', {
            title: {
                text: 'Monthly Return Comparison'
            },
            xAxis: {
                categories: Object.keys(customData)  // 월의 리스트
            },
            yAxis: {
                title: {
                    text: 'Monthly Return'
                }
            },
            series: [{
                name: 'Custom Index',
                data: Object.values(customData)
            }, {
                name: 'KOSPI',
                data: Object.values(kospiData)
            }]
        });
    }

    function drawDailyMddChart(customData, kospiData) {
        Highcharts.chart('dailyMddChart', {
            title: {
                text: 'Daily MDD Comparison'
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
                type: 'pie'
            },
            title: {
                text: 'Sector Distribution',
                align: 'left'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
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
                type: 'pie'
            },
            title: {
                text: 'Industry Distribution',
                align: 'left'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
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
                name: 'Industries',
                colorByPoint: true,
                data: processedData
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
