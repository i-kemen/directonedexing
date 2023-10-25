<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<title>WebSocket Test Page</title>
<!-- crypto-js.min.js 들어갈자리, for use aes256 decode -->
<!-- <script src="C:\cryptojs\crypto-js.min.js"></script> -->
<script src="../../../resources/static/js/crypto-js.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
<!-- 화면분할을 위한 div 처리 -->
<style>

    #index-wrap {
        width: 100%;
        border: 1px solid #EEEEEE;
        padding: 24px;
    }

    .wrap-header {
        display: flex;
        flex-wrap: wrap;
        gap: 24px;
        margin-bottom: 24px;
    }

    .filter-section {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 12px;
    }

    .filter-section label {
        font-weight: bold;
    }

    .filter-section div {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    #index-wrap table {
        width: 100%;
        border-collapse: collapse;
    }

    #index-wrap thead {
        background-color: #10a8a3;
    }

    #index-wrap th {
        color: white;
        padding: 12px;
        text-align: center;
        cursor: pointer;
    }

    #index-wrap tbody tr:nth-of-type(odd) {
        background-color: #EEEEEE;
    }

    #index-wrap td {
        padding: 12px;
        text-align: center;
    }

    button {
        padding: 6px 12px;
        cursor: pointer;
    }

    <%--    --%>
    div.row {
        width: 100%;
        display: flex;
        border: 1px solid #003458;
    }

    div.left {
        width: 300px;
        box-sizing: border-box;
        /*
        background: #FFF5EE;
        */
        font-size: 12px;
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: space-between;
    }

    /* 공통 테이블 스타일 */
    .myTable {
        border-collapse: collapse;
        width: 400px;
        height: 600px;
    }

    .myTable th, .myTable td {
        border: 1px solid black;
        padding: 8px;
        text-align: left;
    }

    /* 매수호가 스타일 */
    .buy {
        color: red;
    }

    /* 매도호가 스타일 */
    .sell {
        color: blue;
    }

    .tabs {
        display: flex;
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    .tab-link {
        padding: 10px 15px;
        border: 1px solid #ccc;
        cursor: pointer;
        flex-grow: 1;
        text-align: center;
    }

    .tab-link.active {
        background-color: #ddd;
    }

    .tab-content {
        display: flex;
        flex-direction: column;
        align-items: start;
        display: none;
    }

    .tab-content-item {
        margin-bottom: 10px;
    }

    .tab-content.active {
        display: block;
    }

</style>

<style>

    @import 'https://fonts.googleapis.com/css?family=Open+Sans:600,700';

    * {
        font-family: 'Open Sans', sans-serif;
    }

    #domesticStockTable {
        margin: auto;
        min-width: 300px;
        max-width: 100%;
        border-collapse: collapse;
    }

    #domesticStockTable th {
        border-top: none;
        background: #428bca;
        color: #fff;
        display: table-cell;
        padding: .25em .5em;
    }

    #domesticStockTable tr {
        border-top: 1px solid #ddd;
        border-bottom: 1px solid #ddd;
        background-color: #f5f9fc;
    }

    #domesticStockTable tr:nth-child(odd):not(:first-child) {
        background-color: #ebf3f9;
    }

    #domesticStockTable td {
        display: table-cell;
        padding: .25em .5em;
    }

    @media screen and (max-width: 601px) {
        #domesticStockTable th {
            display: none;
        }

        #domesticStockTable td {
            display: block;
        }

        #domesticStockTable td:first-child {
            margin-top: .5em;
        }

        #domesticStockTable td:last-child {
            margin-bottom: .5em;
        }

        #domesticStockTable td:before {
            content: attr(data-th) ": ";
            font-weight: bold;
            width: 120px;
            display: inline-block;
            color: #000;
        }
    }


    #depositTable {
        margin: auto;
        min-width: 300px;
        max-width: 100%;
        border-collapse: collapse;
    }

    #depositTable th {
        border-top: none;
        background: #4CAF50; /* 변경된 배경색 */
        color: #fff;
        display: table-cell;
        padding: .25em .5em;
    }

    #depositTable tr {
        border-top: 1px solid #ddd;
        border-bottom: 1px solid #ddd;
        background-color: #e8f5e9; /* 변경된 배경색 */
    }

    #depositTable tr:nth-child(odd):not(:first-child) {
        background-color: #C8E6C9; /* 변경된 배경색 */
    }

    #depositTable td {
        display: table-cell;
        padding: .25em .5em;
    }

    @media screen and (max-width: 601px) {
        #depositTable th {
            display: none;
        }

        #depositTable td {
            display: block;
        }

        #depositTable td:first-child {
            margin-top: .5em;
        }

        #depositTable td:last-child {
            margin-bottom: .5em;
        }

        #depositTable td:before {
            content: attr(data-th) ": ";
            font-weight: bold;
            width: 120px;
            display: inline-block;
            color: #000;
        }
    }


    .filter-section button {
        /* 여기에 버튼에 대한 기본 스타일을 적용할 수 있습니다. */
        font-family: 'Arial', sans-serif;  /* 예시용 폰트 */
        padding: 10px 15px;
        background-color: #8d8d8d;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;  /* 부드러운 hover 효과를 위한 transition */
        border-radius: 5px;
        border : transparent;
    }

    .filter-section button:hover {
        /* hover 시에 적용될 스타일 */
        background-color: #C70055;
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
        overflow-y: auto;
        flex-direction: column;
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

    .contents-top, .contents-middle, .contents-bottom {
        display: flex;
        flex-direction: column;
        margin-top: 60px;
    }


    .index-left, .index-middle, .index-right {
        width: 480px;
        height: 600px;
        overflow-y: auto; /* 스크롤 설정 */
        font-family: "하나2.0 B";
        font-weight: 700px;
        font-size: 15px;
    }

    .index-right
    {
        margin-top: -35px;
    }

    .index-right h2 {
        font-family: '하나2.0 B';
        font-weight: 700;
        font-size: 30px;
        color: #E90061;
    }

    .index-middle{
        margin-top: -40px;
    }

    /*.index-left {*/
    /*    margin-right: 20px; !* 오른쪽 여백 추가 *!*/
    /*}*/

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


    .index-header {
        width: 1440px;
        max-width: 1440px; /* 추가된 부분 */
        height: 40px;
        font-family: "하나2.0 B";
        font-weight: 700;
        font-size: 40px;
        color: black;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .index-wrap {
        display: flex;
        flex-direction: row;
        width: 1440px;
        margin-top: 40px;
    }

    .contents

</style>


<!-- 화면분할을 위한 div 처리 -->
<!-- output3, command box -->
<div style="background-color:#EEEEEE">
    <pre id="output3" style="width: 100%; height: 10%; overflow: auto; display: none"></pre>
</div>


<%@ include file="header.jsp" %>
<div class="wrap">
    <div class="contents-header">
        <div>
            김남훈님의 마이 페이지
        </div>
        <div class="header-button">
            <a href="/portfolios" class="indexing-button">내 포트폴리오</a>
            <a href="/jamoon" class="portfolio-button">
                <img src="img/graphanimation.gif">
                원덱싱 하러가기
            </a>
        </div>
    </div>
    <div class="contents">
        <div class="contents-top">
            <div class="index-header">
                김남훈님의 총 자산
            </div>
            <div class="index-wrap">
                <div class="index-left">
                    <div style="display: flex; flex-direction: row; justify-content: center; align-items: center;
                    font-family: '하나2.0 B';
                    font-weight: 700;
                    font-size: 30px;
                    color: #E90061;">
                        <div>총 자산 합계 :</div>
                        <div id="totalAssetsDisplay"></div>
                    </div>
                    <div id="container"></div>
                </div>
                <div class="index-middle"><div id="domesticStockDiv">
                    <p style="font-family: '하나2.0 B'; font-weight: 700; font-size: 30px; color: #E90061;">국내주식: <span id="domesticStockValue"></span></p>

                    <!-- 국내주식 표 -->
                        <div class="domestic-stock-table">
                            <table id="domesticStockTable">
                                <thead>
                                <tr>
                                    <th>시장</th>
                                    <th>종목코드</th>
                                    <th>종목명</th>
                                    <th>수량</th>
                                    <th>단가</th>
                                    <th>총 금액</th>
                                </tr>
                                </thead>
                                <tbody>
                                <!-- 데이터는 JS에서 채워짐 -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="index-right">
                    <!-- Accounts Table -->
                    <h2>나의 계좌</h2>

                    <!-- Account Dropdown -->
                    <select id="account-selection" onchange="showAccountDetails()">
                        <!-- Account options will be populated here -->
                    </select>
<%--                    <div class="return">--%>
<%--                        <table id="resultTable">--%>
<%--                            <thead>--%>
<%--                            <tr>--%>
<%--                                <th>Ticker</th>--%>
<%--                                <th>Stock Name</th>--%>
<%--                                <th>Purchase Price</th>--%>
<%--                                <th>Price For Date</th>--%>
<%--                                <th>Return Rate</th>--%>
<%--                            </tr>--%>
<%--                            </thead>--%>
<%--                            <tbody>--%>
<%--                            <!-- 결과 행들이 들어갈 곳 -->--%>
<%--                            </tbody>--%>
<%--                        </table>--%>
<%--                    </div>--%>
                    <!-- Account Details Section -->
                    <div id="account-details">
                        <p style="font-family: '하나2.0 B'; font-weight: 700; font-size: 20px; color: black;"><strong>계좌명: </strong><span id="detail-accountName"></span></p>
                    </div>

                    <div id="depositDiv">
                        <p style="font-family: '하나2.0 B'; font-weight: 700; font-size: 20px; color: black;">예수금: <span id="depositValue"></span></p>

                        <!-- 예수금 표 -->
                        <div class="deposit-table">
                            <table id="depositTable">
                                <thead>
                                <tr>
                                    <th>계좌번호</th>
                                    <th>계좌명</th>
                                    <th>잔액</th>
                                </tr>
                                </thead>
                                <tbody>
                                <!-- 데이터는 JS에서 채워짐 -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="contents-middle">
            <div class="index-header">
                나의 투자내역
            </div>
            <div id="index-wrap">
                <div class="wrap-header">
                    <!-- Date Filter -->
                    <div class="filter-section">
                        <div>
                            <label><strong>기간:</strong></label>
                            <input type="date" id="startDate" value="2023-09-16">
                            <span>~</span>
                            <input type="date" id="endDate" value="2023-10-16">
                        </div>
                        <div>
                            <button onclick="setPeriod(7)">1주일</button>
                            <button onclick="setPeriod(30)">1개월</button>
                            <button onclick="setPeriod(90)">3개월</button>
                            <button onclick="setPeriod(180)">6개월</button>
                        </div>
                    </div>

                    <!-- Type Filter -->
                    <div class="filter-section">
                        <label><strong>종류</strong></label>
                        <div>
                            <button onclick="setTypeFilter('all')">전체</button>
                            <button onclick="setTypeFilter('1')">매수</button>
                            <button onclick="setTypeFilter('2')">매도</button>
                            <!-- 입금, 출금 버튼은 주어진 정보에 없어서 생략 -->
                        </div>
                    </div>

                    <!-- Stock Filter -->
                    <div class="filter-section">
                        <label><strong>종목선택</strong></label>
                        <div>
                            <input type="text" id="stockSearch" placeholder="종목명 또는 종목코드 검색">
                            <button onclick="searchStock()">검색</button>
                        </div>
                    </div>
                </div>

                <!-- Table -->
                <table id="executionTable">
                    <thead>
                    <tr>
                        <th>날짜</th>
                        <th>마켓</th>
                        <th>종목코드</th>
                        <th>종목명</th>
                        <th>주문 유형</th>
                        <th>수량</th>
                        <th>실행 가격</th>
                        <th>실행 날짜</th>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>


<script>
    function numberWithCommas(x) {
        if (x === null || x === undefined) {
            return "";
        }
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    let currentUserId = '<%= request.getSession().getAttribute("userId") %>';

    function getSessionUserId() {
        console.log("Current Session UserId:", currentUserId);
        return currentUserId;
    }

    document.addEventListener('DOMContentLoaded', function () {
        const userId = getSessionUserId();
        if (userId) {
            fetchAccountInfoByUserId(userId);
        } else {
            console.error("No userId found in session.");
        }
    });

    function getSelectedAccountId() {
        const selectedAccount = document.getElementById("account-selection").value;
        if (selectedAccount) {
            const accountData = JSON.parse(selectedAccount);
            return accountData.id; // 또는 accountData.accountId 등 계좌 ID를 나타내는 필드명
        }
        return null;
    }


    //계좌 시발

    function fetchAccountInfoByUserId(userId) {
        $.ajax({
            url: `/user/${userId}`,
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                console.log("Fetched accounts:", data);

                const accountDropdown = $("#account-selection");
                accountDropdown.empty();

                data.forEach(account => {
                    let option = $("<option></option>").attr("value", JSON.stringify(account)).text(account.accountNumber);
                    accountDropdown.append(option);
                });

                // 첫 번째 계좌의 상세 정보를 로드
                if (data && data.length > 0) {
                    showAccountDetails(data[0]);
                }
            },
            error: function (error) {
                console.error("Error fetching account data:", error);
            }
        });
    }

    function showAccountDetails() {
        const selectedOption = $("#account-selection option:selected");
        const account = JSON.parse(selectedOption.val());

        $("#detail-accountName").text(account.accountName || 'N/A');
        $("#detail-deposit").text(account.deposit || '0');
    }


    //1번 컨테이너
    // 이 함수는 당신의 데이터를 가져와서 파이 차트를 그립니다.
    function drawPieChart(accountData, holdingsData) {
        const totalDeposit = accountData.reduce((acc, account) => acc + (account.deposit || 0), 0);
        const totalStockValue = holdingsData.reduce((sum, holding) => sum + (holding.avgPrice * holding.quantity), 0);
        const totalAssets = totalDeposit + totalStockValue;
        console.log("총 자산은:", totalAssets)

        // 총 자산 합계를 div에 표시
        document.getElementById("totalAssetsDisplay").innerText = numberWithCommas(totalAssets);


        Highcharts.chart('container', {
            chart: {
                type: 'pie',
                width: 480,   // 너비 설정
                height: 500   // 높이 설정
            }, credits: {
                enabled: false
            },
            title: {
                text: '예수금 및 주식 분포',
                align: 'center'
            },

            plotOptions: {
                series: {
                    borderRadius: 5,
                    dataLabels: {
                        enabled: true,
                        format: '{point.name}: {point.y} ({point.percentage:.1f}%)'
                    }
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b><br/>'
            },
            series: [{
                name: '자산 분포',
                colorByPoint: true,
                data: [
                    {
                        name: '예수금',
                        y: totalDeposit,
                        drilldown: '예수금'
                    },
                    {
                        name: '국내주식',
                        y: totalStockValue,
                        drilldown: '국내주식'
                    }
                ]
            }],
            drilldown: {
                series: [
                    {
                        id: '예수금',
                        name: '예수금 상세',
                        data: accountData.map(account => {
                            return ['계좌번호 ' + account.accountNumber, account.deposit || 0];
                        })
                    },
                    {
                        id: '국내주식',
                        name: '국내주식 상세',
                        data: holdingsData.map(holding => {
                            return [holding.stockname, holding.avgPrice * holding.quantity];
                        })
                    }
                ]
            }
        });
    }


    function fetchAssetsAndDrawChart() {
        // 사용자의 계좌 정보 가져오기
        fetch(`/user/${userId}`)
            .then(response => response.json())
            .then(accountData => {
                console.log("예수금은:", accountData);

                // accountData 배열의 모든 항목 출력하기
                accountData.forEach((account, index) => {
                    console.log(`Account ${index + 1}:`, account);
                });

                // 모든 계좌의 deposit 합산
                let depositSum = accountData.reduce((acc, account) => acc + (account.deposit || 0), 0);

                // 사용자의 보유 주식 정보 가져오기
                return fetch(`/holdings`)
                    .then(response => response.json())
                    .then(holdingsData => {
                        console.log("Fetched Holdings Data:", holdingsData);

                        // holdingsData 배열의 모든 항목 출력하기
                        holdingsData.forEach((holding, index) => {
                            console.log(`Holding ${index + 1}:`, holding);
                        });

                        let stockValue = holdingsData.reduce((sum, holding) => sum + (holding.avgPrice * holding.quantity), 0);

                        // DOM 값 업데이트
                        document.getElementById("domesticStockValue").innerText = numberWithCommas(stockValue.toFixed(0));
                        document.getElementById("depositValue").innerText = numberWithCommas(depositSum.toFixed(0));

                        drawPieChart(accountData, holdingsData);
                    });
            })
            .catch(error => {
                console.error("Error fetching data:", error);
            });
    }


    function fillTables(accountData, holdingsData) {
        // 국내주식 테이블 데이터 채우기
        const domesticStockTable = document.getElementById('domesticStockTable').getElementsByTagName('tbody')[0];
        holdingsData.forEach(holding => {
            const newRow = domesticStockTable.insertRow();
            newRow.insertCell(0).innerText = holding.market;
            newRow.insertCell(1).innerText = holding.ticker;
            newRow.insertCell(2).innerText = holding.stockname;
            newRow.insertCell(3).innerText = numberWithCommas(holding.quantity);
            newRow.insertCell(4).innerText = numberWithCommas(holding.avgPrice);
            newRow.insertCell(5).innerText = numberWithCommas(holding.quantity * holding.avgPrice);
        });

        // 예수금 테이블 데이터 채우기
        const depositTable = document.getElementById('depositTable').getElementsByTagName('tbody')[0];
        accountData.forEach(account => {
            const newRow = depositTable.insertRow();
            newRow.insertCell(0).innerText = account.accountNumber;
            newRow.insertCell(1).innerText = account.accountName; // 계좌명 필드가 명확하지 않아서 임의로 설정
            const depositValue = account.deposit && account.deposit !== 'N/A' ? numberWithCommas(account.deposit) : '0';
            newRow.insertCell(2).innerText = depositValue;

        });
    }

    function fetchAssetsAndFillTables() {
        // 사용자의 계좌 정보 가져오기
        fetch(`/user/${userId}`)
            .then(response => response.json())
            .then(accountData => {
                // 사용자의 보유 주식 정보 가져오기
                fetch(`/holdings`)
                    .then(response => response.json())
                    .then(holdingsData => {
                        fillTables(accountData, holdingsData);
                    });
            })
            .catch(error => {
                console.error("Error fetching data:", error);
            });
    }


    //검색
    // 종목명 또는 종목코드로 거래내역을 필터링하는 함수
    function filterExecutionsByStock(executions, keyword) {
        return executions.filter(execution =>
            (execution.stockname && execution.stockname.includes(keyword)) ||
            (execution.ticker && execution.ticker.includes(keyword))
        );
    }


    function searchStock() {
        const keyword = document.getElementById('stockSearch').value;
        fetch('/executions')
            .then(response => response.json())
            .then(executions => {
                const filteredExecutions = filterExecutionsByStock(executions, keyword);
                fillExecutionTable(filteredExecutions);
            })
            .catch(error => {
                console.error("Error fetching executions:", error);
            });
    }

    //주문유형 검색
    function setTypeFilter(type) {
        fetchExecutionsAndFillTable(execution => {
            if (type === 'all') return true; // 전체일 경우 모든 거래 내역 표시
            return execution.orderType === type;
        });
    }


    function setPeriod(days) {
        const endDate = new Date(); // 현재 날짜를 종료 날짜로 설정
        const startDate = new Date();
        startDate.setDate(endDate.getDate() - days + 1); // 시작 날짜를 endDate에서 days 만큼 뺀 날짜로 설정

        document.getElementById('endDate').value = endDate.toISOString().split('T')[0];
        document.getElementById('startDate').value = startDate.toISOString().split('T')[0];

        filterExecutionsByDate();
    }

    function filterExecutionsByType(type) {
        console.log('filterExecutionsByType is called with type:', type);
        // 모든 행을 가져옴
        const rows = document.querySelectorAll('#executionTable tbody tr');

        rows.forEach(row => {
            const orderTypeCell = row.children[4]; // 5번째 열이 주문 유형 열입니다.

            // 디버깅 코드
            console.log('Order Type Cell Content:', orderTypeCell.innerText);

            let displayValue = 'table-row'; // 기본적으로 행을 표시

            // 필터링 조건
            if (type === 'all') {
                displayValue = 'table-row';
            } else if (type === '1' && orderTypeCell.innerText !== '매수') {
                displayValue = 'none';
            } else if (type === '2' && orderTypeCell.innerText !== '매도') {
                displayValue = 'none';
            }

            row.style.display = displayValue;
        });
    }


    // 거래내역 테이블

    function formatExecutedDate(isoDate) {
        // 날짜 객체를 만들고, 한국 시간대로 변환합니다.
        const date = new Date(isoDate);

        // 날짜와 시간을 한국식 형태로 포맷팅합니다.
        const formattedDate = new Intl.DateTimeFormat('ko-KR', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            timeZone: 'Asia/Seoul'
        }).format(date);

        return formattedDate;
    }


    // 주문 유형을 "매수" 또는 "매도"로 변환하는 함수
    function formatOrderType(orderType) {
        const typeAsString = String(orderType);

        switch (typeAsString) {
            case '1':
                return '매수';
            case '2':
                return '매도';
            default:
                return typeAsString; // 원본 값을 반환
        }
    }


    function fillExecutionTable(executions) {
        // 테이블 생성
        const table = document.createElement('table');
        table.id = 'executionTable';

        // 테이블 헤더 생성
        const thead = document.createElement('thead');
        const headerRow = document.createElement('tr');

        const headers = ['날짜', '마켓', '종목코드', '종목명', '주문 유형', '수량', '단가', '총 금액']; // 총 금액 헤더 추가

        headers.forEach(headerText => {
            const th = document.createElement('th');
            th.innerText = headerText;
            headerRow.appendChild(th);
        });

        thead.appendChild(headerRow);
        table.appendChild(thead);

        // 테이블 본문(body) 생성
        const tbody = document.createElement('tbody');

        executions.forEach(execution => {
            const row = document.createElement('tr');
            console.log('Executed date value:', execution.executedDate);

            const cells = [
                formatExecutedDate(execution.executedDate),
                execution.market,
                execution.ticker,
                execution.stockname,
                formatOrderType(execution.orderType),
                execution.quantity,
                numberWithCommas(execution.executedPrice),
                numberWithCommas(execution.quantity * execution.executedPrice)  // 총 금액 계산
            ];

            cells.forEach((cellValue, index) => {
                const td = document.createElement('td');
                td.innerText = cellValue;
                if (index === 4) { // 주문 유형에 따른 색상 지정
                    if (cellValue === '매수') {
                        td.style.color = 'red';
                    } else if (cellValue === '매도') {
                        td.style.color = 'blue';
                    }
                }
                row.appendChild(td);
            });

            tbody.appendChild(row);
        });

        table.appendChild(tbody);

        // 이제 테이블을 'executionTable' 요소에 추가
        const executionTable = document.getElementById('executionTable');
        executionTable.innerHTML = ''; // 기존 내용 초기화
        executionTable.appendChild(table);
    }

    function fetchExecutionsAndFillTable(filterFn) {
        fetch('/executions')
            .then(response => response.json())
            .then(executions => {
                if (filterFn) {
                    executions = executions.filter(filterFn);
                }
                executions.sort((a, b) => new Date(b.executedDate) - new Date(a.executedDate));
                fillExecutionTable(executions);
            })
            .catch(error => {
                console.error("Error fetching executions:", error);
            });
    }

    //수익률계산
    // 이 부분을 추가하여 사용자의 수익률을 가져옵니다.
    function fetchHoldingReturns() {
        const userId = getSessionUserId();
        if (!userId) {
            console.error("No userId found in session.");
            return;
        }

        fetch(`/api/getHoldingReturn/${userId}`)
            .then(response => response.json())
            .then(data => {
                const tableBody = document.getElementById('resultTable').getElementsByTagName('tbody')[0];

                // 기존의 테이블 내용을 비웁니다.
                tableBody.innerHTML = "";

                data.forEach(row => {
                    let newRow = tableBody.insertRow();
                    newRow.insertCell(0).innerText = row.ticker;
                    newRow.insertCell(1).innerText = row.stockname;
                    newRow.insertCell(2).innerText = row.purchasePrice.toFixed(2);
                    newRow.insertCell(3).innerText = row.priceForDate.toFixed(2);
                    newRow.insertCell(4).innerText = `${row.returnRate.toFixed(2)}%`;
                });
            })
            .catch(error => {
                console.error("Error fetching holding returns:", error);
            });
    }


    function initializePage() {
        fetchAssetsAndDrawChart();
        fetchAssetsAndFillTables();
        fetchExecutionsAndFillTable(); // 추가
        fetchHoldingReturns();
    }

    window.onload = initializePage;


</script>
