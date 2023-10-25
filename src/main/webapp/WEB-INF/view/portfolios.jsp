<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            width: 1440px;
            height: 800px;
            overflow-y: auto; /* 스크롤 설정 */
            display: flex;
            flex-direction: column;
            align-items: center;

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

        /*테이블*/

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
            width: 1200px;
            box-shadow: 0 0 40px rgba(0, 0, 0, 0.2);
            border-collapse: collapse;
        }

        thead {
            background-color: var(--heading-color);
            color: white;
            font-family: "하나2.0 M"; /* 폰트 설정 */
            font-size: 30px; /* 폰트 크기 */
        }

        th, td {
            padding: 0.8em 1.2em;
            border: 1px solid #ddd;
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
            김남훈님의 포트폴리오
        </div>
    </div>
    <div class="contents">
        <div class="index-left">
            <table border="1">
                <thead>
                <tr>
                    <th>생성일</th>
                    <th>이름</th>
                    <th>설정한 투자 전략</th>
                    <th>수익률</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="portfolio" items="${portfolios}">
                    <tr onclick="goToPortfolioItems(${portfolio.portfolioId})">
                        <td><fmt:formatDate value="${portfolio.createdDate}" pattern="yyyy-MM-dd"
                                            timeZone="Asia/Seoul"/></td>
                        <td>${portfolio.portfolioName}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>


<%@ include file="footer.jsp" %>

<script>
    function goToPortfolioItems(portfolioId) {
        window.location.href = "/portfolioItems?id=" + portfolioId;
    }

    function showDeletePopup(portfolioId) {
        var userResponse = confirm('삭제하시겠습니까?');
        if (userResponse) {
            deletePortfolio(portfolioId);
        }
    }
</script>
</body>
</html>
