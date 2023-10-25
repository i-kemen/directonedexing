<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <title>로그인</title>
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

        .login-container {
            margin-top: 80px;
            height: 900px;
            background-color: #FFFFFF;
            border-radius: 15px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            padding: 50px;
            width: 500px;
        }

        h2 {
            font-weight: 700;
            font-size: 24px;
            color: #E90061;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 15px;
            color: #555;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        input[type="checkbox"] {
            margin-right: 10px;
        }

        .agree {
            margin-top: 15px;
            margin-bottom: 15px;
        }

        button {
            display: block;
            width: 100%;
            padding: 10px 15px;
            background-color: #04BE9E;
            border: none;
            border-radius: 5px;
            color: #FFF;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0E8C8D;
        }

        .validation-message {
            height: 20px; /* Reserve space for the message */
            color: red;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<!-- Display success message if present -->
<c:if test="${not empty successMessage}">
    <div class="alert alert-success">
            ${successMessage}
    </div>
</c:if>

<!-- Display error message if present -->
<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger">
            ${errorMessage}
    </div>
</c:if>
<div class="login-container"> <!-- 클래스 이름을 signup-container에서 login-container로 변경했습니다. -->
    <h2>로그인</h2>
    <form action="/loginProcess" method="post"> <!-- 로그인 처리 URL을 예시로 '/loginProcess'로 설정했습니다. -->
        <label for="id">아이디<br>
            <input type="text" id="id" name="id">
            <br><br>
        </label>
        <label for="password">비밀번호<br>
            <input type="password" id="password" name="password">
            <br><br>
        </label>
        <button type="submit">로그인</button>
    </form>
</div>

<%@ include file="footer.jsp" %>
</body>
<script>
    // Check if successMessage exists
    var successMessageDiv = document.getElementById('successMessage');
    if (successMessageDiv) {
        setTimeout(function () {
            successMessageDiv.style.display = 'none'; // hide the message
            window.location.href = '/login'; // redirect to the login page
        }, 5000); // 5 seconds
    }

    // Check if errorMessage exists
    var errorMessageDiv = document.getElementById('errorMessage');
    if (errorMessageDiv) {
        setTimeout(function () {
            errorMessageDiv.style.display = 'none'; // hide the message
            // Optional: You can add another redirect here if you wish
        }, 5000); // 5 seconds
    }
</script>
</html>
