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
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<!-- 화면분할을 위한 div 처리 -->
<style>
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
        border: 1px solid black;
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
            <a href="/portfolios" class="indexing-button">다른 포트폴리오</a>
            <form id="dataForm" action="/buy" method="post" class="portfolio-button">
                <input type="hidden" id="jsonData" name="jsonData">
                <img src="img/graphanimation.gif">
                이 전략으로 투자하기
            </form>
        </div>
    </div>
    <div class="contents">
        <div class="contents-top">
            <div class="index-header">
                김남훈님의 총 자산
            </div>
            <div class="index-wrap">
                <div class="index-left">
                    <div style="display: flex; flex-direction: row; justify-content: center; align-items: center;">
                        <div>총 자산 합계 :</div>
                        <div id="totalAssetsDisplay" style="padding: 10px; font-weight: bold;"></div>
                    </div>
                    <div id="container"></div>
                </div>
                <div class="index-middle">
                    <div id="domesticStockDiv">
                        <p>국내주식: <span id="domesticStockValue"></span></p>
                    </div>
                    <div id="depositDiv">
                        <p>예수금: <span id="depositValue"></span></p>
                    </div>
                </div>
                <div class="index-right">
                    <!-- Accounts Table -->
                    <h2>나의 계좌</h2>

                    <!-- Account Dropdown -->
                    <select id="account-selection" onchange="showAccountDetails()">
                        <!-- Account options will be populated here -->
                    </select>

                    <!-- Account Details Section -->
                    <div id="account-details">
                        <p><strong>계좌명: </strong><span id="detail-accountName"></span></p>
                        <p><strong>잔액: </strong><span id="detail-deposit"></span></p>
                    </div>
                </div>
                <!-- .index-right 바로 밑에 추가 -->
                <div id="confirmModal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <div id="modal-stock-info">
                            <h3>시장: <span id="modal-stock-market"></span></h3>
                            <h4>종목코드: <span id="modal-stock-ticker"></span></h4>
                            <p>종목명: <span id="modal-stock-name"></span></p>
                        </div>
                        <div id="modal-buy-content">
                            <div class="tab-content-item">
                                <label>단가: <span id="modal-buy-price"></span></label>
                            </div>
                            <div class="tab-content-item">
                                <label>수량: <span id="modal-buy-quantity"></span></label>
                            </div>
                            <div class="tab-content-item">
                                <p>총 금액: <span id="modal-buy-total"></span></p>
                            </div>
                        </div>
                        <p id="confirmMessage"></p>
                        <button class="button1" onclick="processOrder()">예</button>
                        <button class="button2" onclick="closeModal()">아니오</button>
                    </div>
                </div>
                <!-- .index-right 바로 밑에 추가 -->
                <div id="resultModal" class="modal">
                    <div class="modal-content">
                        <span class="close" onclick="closeResultModal()">&times;</span>
                        <div id="result-stock-info">
                            <h3>시장: <span id="result-stock-market"></span></h3>
                            <h4>종목코드: <span id="result-stock-ticker"></span></h4>
                            <p>종목명: <span id="result-stock-name"></span></p>
                        </div>
                        <div id="result-buy-content">
                            <div class="tab-content-item">
                                <label>단가: <span id="result-buy-price"></span></label>
                            </div>
                            <div class="tab-content-item">
                                <label>수량: <span id="result-buy-quantity"></span></label>
                            </div>
                            <div class="tab-content-item">
                                <p>총 금액: <span id="result-buy-total"></span></p>
                            </div>
                        </div>
                        <p>처리 되었습니다.</p>
                        <button class="button2" onclick
                                ="closeResultModal()">닫기
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="contents-middle">
            <div class="index-header">
                나의 투자내역
            </div>
            <div class="index-wrap">
                <div class="index-left">
                </div>
                <div class="index-middle">
                </div>
                <div class="index-right">
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>


<script>

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
        $("#detail-deposit").text(account.deposit || 'N/A');
    }
    

    //1번 컨테이너
    // 이 함수는 당신의 데이터를 가져와서 파이 차트를 그립니다.
    function drawPieChart(accountData, holdingsData) {
        const totalDeposit = accountData.reduce((acc, account) => acc + (account.deposit || 0), 0);
        const totalStockValue = holdingsData.reduce((sum, holding) => sum + (holding.avgPrice * holding.quantity), 0);
        const totalAssets = totalDeposit + totalStockValue;
        console.log("총 자산은:", totalAssets)

        // 총 자산 합계를 div에 표시
        document.getElementById("totalAssetsDisplay").innerText = totalAssets;


        Highcharts.chart('container', {
            chart: {
                type: 'pie'
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
                        document.getElementById("domesticStockValue").innerText = stockValue.toFixed(0);
                        document.getElementById("depositValue").innerText = depositSum.toFixed(0);

                        drawPieChart(accountData, holdingsData);
                    });
            })
            .catch(error => {
                console.error("Error fetching data:", error);
            });
    }

    window.onload = fetchAssetsAndDrawChart;

</script>
