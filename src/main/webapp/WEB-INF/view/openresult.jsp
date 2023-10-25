<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <title>계좌 개설 결과</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            font-family: "하나2.0 R";
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .result-container {
            margin-top: 50px;
            width: 600px;
            height: 300px;
            background-color: #FFFFFF;
            border-radius: 15px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
        }

        h2 {
            font-weight: 700;
            font-size: 24px;
            color: #0068FF;
            margin-bottom: 25px;
        }

        .message {
            margin-top: 15px;
            font-size: 18px;
            color: #555;
        }

        .result-wrap  {
            margin-top: 80px;
        }
    </style>
</head>

<body>
<%@ include file="header.jsp" %>
<div class="result-wrap">
    <div class="result-container">
        <h2>계좌 개설 결과</h2>
        <div class="message">
            <c:choose>
                <c:when test="${accountOpened != null && accountOpened}">
                    계좌 개설에 성공하였습니다! 감사합니다.
                    <br>
                    <!-- 계좌 세부 정보 표시 -->
                    <strong>계좌 이름:</strong> ${accountDetails.accountName} <br>
                    <strong>계좌 번호:</strong> ${accountDetails.accountNumber} <br>
                    <hr>
                    <a href="/">메인 페이지로 이동</a>
                </c:when>
                <c:otherwise>
                    계좌 개설에 실패하였습니다.
                    <c:if test="${not empty errorMessage}">사유: ${errorMessage}</c:if>
                    <br>
                    <a href="/open">계좌 개설 페이지로 돌아가기</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
<script>
    let accountOpenedFromSession = sessionStorage.getItem("accountOpened");
</script>
</body>
</html>
