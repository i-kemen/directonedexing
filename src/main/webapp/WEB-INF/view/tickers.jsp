<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tickers Management</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
    <script src="https://code.highcharts.com/modules/data.js"></script>
    <script src="https://code.highcharts.com/modules/drilldown.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>

</head>
<body>

<h3>Tickers Management</h3>

<!-- Simple form to update tickers -->
<form id="tickersForm">
    <!-- You can add inputs for tickers here -->
    <!-- Example: <input type="text" name="ticker1"> -->

    <input type="submit" value="Update Tickers">
</form>

<!-- Button to fetch and display modified tickers -->
<button onclick="getModifiedTickers()">Fetch Modified Tickers</button>
<div id="displayTickers"></div>

<!-- Button to fetch and display the chart image -->
<button onclick="getChart()">Fetch Chart</button>
<img id="chartImage" src="" alt="Chart will be displayed here" width="500">

<button onclick="getMetrics()">Fetch Metrics</button>
<div id="displayMetrics"></div>

<div id="cumulativeReturnChart" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
<div id="monthlyReturnChart" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
<div id="mddChart" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
<!-- Custom Index Cumulative Return -->
<div id="customCumulativeReturn">Custom Index Cumulative Return: <span></span></div>

<!-- KOSPI Cumulative Return -->
<div id="kospiCumulativeReturn">KOSPI Cumulative Return: <span></span></div>

<script>
    $(document).ready(function () {
        $("#tickersForm").submit(function (event) {
            event.preventDefault();  // Prevent the default form submission

            let formData = $(this).serializeArray();

            $.ajax({
                url: '/api/saveModifiedTickers',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function (response) {
                    alert(response);
                },
                error: function (error) {
                    alert("Error updating tickers: " + error.responseText);
                }
            });
        });
    });

    function getModifiedTickers() {
        $.ajax({
            url: '/api/getModifiedTickers',
            method: 'GET',
            success: function (data) {
                let tickersData = JSON.stringify(data, null, 2);
                $("#displayTickers").text(tickersData);
            },
            error: function (error) {
                alert("Error fetching modified tickers: " + error.responseText);
            }
        });
    }

    function getChart() {
        let imageUrl = "/api/getChart";
        $("#chartImage").attr("src", imageUrl);
    }

    function getMetrics() {
        console.log("getMetrics function called!");
        $.ajax({
            url: '/api/getMetrics',
            method: 'GET',
            success: function (data) {
                let metricsData = JSON.stringify(data, null, 2);
                $("#displayMetrics").text(metricsData);
                console.log("Received data from API:", data);
                // Cumulative Return 값을 HTML 요소에 설정
                $("#customCumulativeReturn span").text(data.custom_index['Cumulative Return'].toFixed(2)); // 소수점 두 자리까지 표시
                $("#kospiCumulativeReturn span").text(data.kospi['Cumulative Return'].toFixed(2));
                // 차트 그리기 함수 호출
                drawCumulativeReturnChart(data.custom_index['Cumulative Returns Data'], data.kospi['Cumulative Returns Data']);
                drawMddChart(data.custom_index['MDD'], data.kospi['MDD']);
                drawMonthlyReturnChart(data.custom_index['Monthly Returns'], data.kospi['Monthly Returns']);
            },
            error: function (error) {
                alert("Error fetching metrics: " + error.responseText);
            }
        });
    }

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

    function drawMddChart(customData, kospiData) {
        Highcharts.chart('mddChart', {
            title: {
                text: 'Maximum Drawdown (MDD) Comparison'
            },
            xAxis: {
                categories: ['Custom Index', 'KOSPI']
            },
            yAxis: {
                title: {
                    text: 'MDD'
                }
            },
            series: [{
                type: 'bar',
                name: 'MDD',
                data: [customData, kospiData]
            }]
        });
    }

</script>
</body>
</html>