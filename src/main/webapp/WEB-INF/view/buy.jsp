<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Indexing</title>
  <title>Title</title>

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

  </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="wrap">
  <div class="contents-header">
    <div>
      김남훈님의 포트폴리오
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
    <div class="index-left">
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
    <div class="index-right">

    </div>
  </div>
</div>
<div id="market-modal" class="modal">
  <div class="modal-header market-header">
    <div class="modal-header1">
      투자 방법을 선택하세요.
    </div>
    <div class="button-wrap">
      <button class="button1">선택완료</button>
      <button class="button2">다음</button>
    </div>
  </div>
  <div class="market-modal-body">
    <div class="market-body-header">
    </div>
    <div class="market-content">
      <div style="display: flex; width:550px; flex-direction: row; justify-content: space-between; margin-bottom: 50px">
        <div class="index-card" id="index-card1" style="width:250px; height: 100px; display: flex; flex-direction: column; font-family: '하나2.0 R'; font-size: 15px;
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
            내 포트폴리오를 하나 증권의 전문가와 <br>
            함께 투자해보세요.
          </div>
        </div>
        <div class="index-card" id="index-card2" style="width:250px; height: 100px; display: flex; flex-direction: column;  font-family: '하나2.0 R'; font-size: 15px;
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
            실시간 차트를 보며 <br>
            투자해보세요.
          </div>
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
  document.getElementById('dataForm').addEventListener('click', function (e) {
    e.preventDefault(); // form 제출을 막습니다.
    openModal();
  });

  function openModal() {
    document.getElementById('market-modal').style.display = 'block';
  }

  function closeModal() {
    document.getElementById('market-modal').style.display = 'none';
  }


</script>
</body>
</html>
