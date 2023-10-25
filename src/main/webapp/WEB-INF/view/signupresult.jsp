<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<head>
    <title>회원가입 결과</title>
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
            color: #E90061;
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
        <h2>회원가입 결과</h2>
        <c:choose>
            <c:when test="${signupSuccess}">
                <div class="message">
                    회원가입에 성공했습니다! 환영합니다!
                    <br>
                    <a href="/login">로그인 페이지로 이동</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="message">
                    회원가입에 실패했습니다.
                    <c:if test="${not empty errorMessage}">사유: ${errorMessage}</c:if>
                    <br>
                    <a href="/signup">회원가입 페이지로 돌아가기</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
