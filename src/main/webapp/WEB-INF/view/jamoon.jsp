<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Indexing</title>
    <title>Title</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.68/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.68/vfs_fonts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.10.377/pdf.min.js"></script>

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


        .index-left {
            margin-right: 20px; /* 오른쪽 여백 추가 */
            width: 800px;
            height: 800px;
            overflow-y: auto; /* 스크롤 설정 */
        }

        .index-right {
            width: 640px;
            height: 800px;
            overflow-y: auto; /* 스크롤 설정 */
            font-family: "하나2.0 B";
            font-size: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .right-header {
            font-family: "하나2.0 B";
            font-size: 40px;
            font-weight: 700;
            color: #E90061;
        }

        .bottom-header {
            font-family: "하나2.0 B";
            font-size: 40px;
            font-weight: 700;
            color: #E90061;
            text-align: center;
        }

        .proposal {
            width: 600px;
            display: flex;
            flex-direction: row;
            justify-content: space-evenly;
            align-items: center;
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


        .top-main {
            display: flex;
            flex-direction: column;
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
            width: 800px;
        }

        .cumulative-right {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 200px;
        }


        .mdd {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
            width: 800px;
        }

        .mdd-right {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 200px;
        }

        .si {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
            width: 800px;
        }

        .box1, .box2 {
            width: 150px;
            height: 150px;
            background-color: #fffbfa;
            border-radius: 10px;
            display: flex;
            align-items: center; /* 텍스트를 중앙에 위치 */
            padding-left: 15px; /* 텍스트에 약간의 패딩 추가 */
            padding-right: 15px; /* 텍스트에 약간의 패딩 추가 */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            font-family: "하나2.0 M";
            font-size: 20px;
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
            width: 800px;
        }

        .box3 {
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
            font-size: 20px;
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


        /*표*/

        :root {
            --heading-color: #43BAC0;
        }

        * {
            box-sizing: border-box;
        }

        .wrapper {
            width: 100%;
            margin: 1em auto;
            padding: 1em;
        }

        /* Table styles */
        table {
            width: 600px;
            box-shadow: 0 0 40px rgba(0, 0, 0, 0.2);
            border-collapse: collapse;
            margin: auto; /* 가로 기준 가운데 정렬을 위한 코드 */
        }

        thead {
            background-color: var(--heading-color);
            color: white;
            font-family: "하나2.0 M";
            font-size: 20px;
        }

        th, td {
            padding: 0.8em 1.2em;
            border: 1px solid #ddd;
            text-align: center;
        }

        tr:hover {
            background-color: rgba(233, 200, 147, 0.2);
        }
    </style>

</head>
<body>
<%@ include file="header.jsp" %>
<div class="wrap">
    <div class="contents-header">
        <div>
            김남훈님의 자문계약
        </div>
        <div class="header-button">
            <a href="/portfolios" class="indexing-button">다른 포트폴리오</a>
            <a href="/realtime" class="portfolio-button">
                <img src="img/graphanimation.gif">
                직접 구매하기
            </a>
        </div>
    </div>
    <div class="contents">
        <div class="index-left ">
            <div id="pieChartContainer"></div>

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
                            <div id="diffCumulativeReturn" style="font-size: 10px">KOSPI 대비 <span></span></div>
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
                            <div id="diffMdd" style="font-size: 10px">KOSPI 대비 <span></span></div>
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
        <div class="index-right">
            <div class="right-header">
                상품 정보
            </div>
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">상품항목</th>
                    <th scope="col">내용</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th scope="row">상품명</th>
                    <td>김남훈님의 자문계약</td>
                </tr>
                <tr>
                    <th scope="row">위험등급</th>
                    <td>매우 높음</td>
                </tr>
                <tr>
                    <th scope="row">투자대상 상품</th>
                    <td>나만의 인덱싱 : KOSPI TOP 50</td>
                </tr>
                <tr>
                    <th scope="row">자문계좌 유형</th>
                    <td>종합매매(국내 증권)</td>
                </tr>

                <tr>
                    <th scope="row">자문사</th>
                    <td>하나증권 프라임케어실</td>
                </tr>
                <tr>
                    <th scope="row">자문역</th>
                    <td>김남훈 애널리스트</td>
                </tr>
                <tr>
                    <th scope="row">자문사연락처</th>
                    <td>02-785-5000</td>
                </tr>
                <tr>
                    <th scope="row">자문기간</th>
                    <td>상담 후 결정</td>
                </tr>
                <tr>
                    <th scope="row">최저 가입 금액</th>
                    <td>₩1,000,000</td>
                </tr>
                <tr>
                    <th scope="row">수수료부과 기준</th>
                    <td>계좌 평가 금액</td>
                </tr>
                <tr>
                    <th scope="row">수수료 징수주기</th>
                    <td>분기</td>
                </tr>
                <tr>
                    <th scope="row">자문수수료</th>
                    <td>연 0.5% (분기단위 후취)</td>
                </tr>
                </tbody>
            </table>
            <div class="proposal">
                <h4>더 자세한 설명이 필요하신가요?</h4>
                <button class="button2" style="background-color: #0B9B97" onclick="openProposal()">투자 제안서</button>
            </div>
            <div class="right-bottom">
                <div class="bottom-header">알려드립니다.</div>
                <div>
                    <p>· 투자자는 이 금융투자상품 등에 대하여당사로부터 충분한 설명을 &nbsp;&nbsp;받을 권리가 있으며, 투자 전 계약서 및 설명서 등을 반드시 읽어
                        <br>
                        &nbsp;&nbsp;보시기 바랍니다.</p>
                    <p>· 이 금융투자상품은 예금자 보호법에 따라 예금보험공사가 보호<br>
                        &nbsp;&nbsp;하지 않습니다.</p>
                    <p>· 이 금융투자상품은 &lt;자산가격 변동&gt;, &lt;환율 변동&gt;, &lt;신용 등급 <br>
                        &nbsp;&nbsp;하락&gt; 등에 따라 투자원금의 손실(일부 또는 전액)이 발생할 수 <br>
                        &nbsp;&nbsp;있으며,
                        그 손실은 투자자에게 귀속됩니다.</p>
                    <p>· 자문수수료는 계좌 평가금액을 기준으로 부과하므로 계좌 잔고가 <br>
                        &nbsp;증가하였을 경우, 부과되는 자문계약 수수료가 늘어날 수 있습니다.</p>
                    <p>· 상품별 거래수수료는 당사에서 정한 수수료율을 따릅니다. 고객<br>
                        &nbsp;&nbsp;서비스 &lt; 업무안내 &lt; 수수료안내 &lt; 일반수수료 화면을 참고<br>
                        &nbsp;&nbsp;하시기 바랍니다.</p>
                </div>
            </div>
        </div>
    </div>
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
                width: 600,  // 원하는 너비 값으로 설정 (예: 800 픽셀)
                height: 400  // 원하는 높이 값으로 설정 (예: 600 픽셀)
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
                width: 600,  // 원하는 너비 값으로 설정 (예: 800 픽셀)
                height: 400  // 원하는 높이 값으로 설정 (예: 600 픽셀)
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
                type: 'pie',
                width: 400,  // 원하는 너비 값으로 설정 (예: 800 픽셀)
                height: 400 // 원하는 높이 값으로 설정 (예: 600 픽셀)
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
                type: 'pie', width: 400,  // 원하는 너비 값으로 설정 (예: 800 픽셀)
                height: 400  // 원하는 높이 값으로 설정 (예: 600 픽셀)
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


    let existingPdfImage; // 기존 PDF의 이미지

    const pdfjsLib = window['pdfjs-dist/build/pdf'];

    // 기존 PDF를 렌더링하고 이미지로 변환하는 함수
    async function loadExistingPdf() {
        const pdfImages = []; // 모든 PDF 페이지의 이미지를 저장할 배열

        const pdf = await pdfjsLib.getDocument('jamoon.pdf').promise;
        for (let pageNum = 1; pageNum <= pdf.numPages; pageNum++) {
            const page = await pdf.getPage(pageNum);
            const scale = 1.5;
            const viewport = page.getViewport({scale: scale});

            const canvas = document.createElement("canvas");
            const context = canvas.getContext('2d');
            canvas.height = viewport.height;
            canvas.width = viewport.width;

            const renderContext = {
                canvasContext: context,
                viewport: viewport
            };

            await page.render(renderContext).promise;
            pdfImages.push(canvas.toDataURL());
        }

        existingPdfImage = pdfImages; // 기존 PDF의 모든 페이지 이미지를 저장
    }


    async function captureElementAsImage(element, otherElement) {
        return new Promise(async resolve => {
            // // 다른 요소 숨기기
            // otherElement.style.display = 'none';
            //
            // // overflow 임시 변경
            // const originalOverflow = element.style.overflowY;
            // element.style.overflowY = 'visible';

            const dataUrl = await html2canvas(element).then(canvas => canvas.toDataURL('image/png'));

            // // overflow 원상복구 및 다른 요소 다시 보이게 하기
            // element.style.overflowY = originalOverflow;
            // otherElement.style.display = '';

            resolve(dataUrl);
        });
    }

    async function openProposal() {
        await loadExistingPdf(); // 기존 PDF 이미지 로드

        const leftElement = document.querySelector('.index-left');
        const rightElement = document.querySelector('.index-right');


        // 각각의 divs를 이미지로 캡처
        const leftImage = await captureElementAsImage(leftElement, rightElement);
        const rightImage = await captureElementAsImage(rightElement, leftElement);

        // 이미지 데이터를 pdfMake 문서 정의에 포함
        const docContent = [];
        for (let img of existingPdfImage) {
            docContent.push({image: img, width: 500, pageBreak: 'after'});
        }

        docContent.push({image: leftImage, width: 500});
        docContent.push({image: rightImage, width: 500, pageBreak: 'after'});

        const docDefinition = {
            content: docContent
        };

        // PDF 생성 및 다운로드
        pdfMake.createPdf(docDefinition).download('투자자문계약서.pdf');
    }


</script>
</body>
</html>
