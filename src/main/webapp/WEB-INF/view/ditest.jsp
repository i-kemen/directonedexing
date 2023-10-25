<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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

    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<figure class="highcharts-figure">
    <div id="container"></div>
    <p class="highcharts-description">
    </p>
</figure>
<form id="dataForm" action="/port" method="post">
    <input type="hidden" id="jsonData" name="jsonData">
    <button type="submit">이 전략으로 투자하기</button>
</form>
<img id="chartImage" src="/api/getChart" alt="Chart Image">
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

    setInterval(function () {
        var imageUrl = "/api/getChart";
        var imageElement = document.getElementById("chartImage");

        // 캐시를 피하기 위해 타임스탬프를 추가
        imageElement.src = imageUrl + "?t=" + new Date().getTime();
    }, 1000); // 1초마다 이미지를 새로 고침

    //json으로 변환 후, port.jsp에 데이터 전달
    document.getElementById('dataForm').addEventListener('submit', function(event) {
        var json = generateJsonFromTable();

        // json 데이터의 각 항목을 수정
        json = json.map(function(item) {
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
    });

</script>

</body>

</html>
