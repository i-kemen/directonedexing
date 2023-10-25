<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        ul.stepper {
            list-style-type: none;
            padding: 0;
            overflow: hidden;
        }

        li.step {
            float: left;
            width: 33.33%;
            padding: 12px;
            text-align: center;
            background-color: #e9ecef;
            border-right: 1px solid #ccc;
        }

        li.step.active {
            background-color: #04BE9E;
            color: white;
        }

        li.step:last-child {
            border-right: none;
        }


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

        .signup-container {
            margin-top: 20px;
            width: 1140px;
            height: 1200px;
            background-color: #FFFFFF;
            border-radius: 15px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            padding: 50px;
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
            width: 200px;
        }

        button:hover {
            background-color: #009B84;
        }

        .validation-message {
            height: 20px; /* Reserve space for the message */
            color: red;
            margin-top: 5px;
        }

        .signup-wrap {
            margin-top: 80px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;

        }

        .input-with-button {
            display: flex;
            align-items: center;
        }

        .input-field { /* 모든 입력 필드에 동일한 가로 길이를 적용하기 위한 스타일 */
            width: 250px !important; /* 원하는 길이로 조정 */
        }

        .submit-btn { /* '가입하기' 버튼을 가운데 정렬하기 위한 스타일 */
            display: block;
            margin: auto;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="signup-wrap">
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-12">
                <ul class="stepper">
                    <li class="step">약관 동의</li>
                    <li class="step active">회원가입</li>
                    <li class="step">회원가입 결과</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="signup-container">
        <h2>회원가입을 위해 정보를 입력해주세요.</h2>
        <form action="/signup" method="post">
            <label for="id">* 아이디</label>
            <div class="input-with-button">
                <input class="input-field" type="text" id="id" name="id">
                <button type="button" id="checkIdBtn">중복 확인</button>
            </div>
            <div class="validation-message" data-for="id"></div>
            <br>

            <label for="name">* 이름</label>
            <input class="input-field" type="text" id="name" name="name">
            <div class="validation-message" data-for="name"></div>
            <br><br>

            <label for="password">* 비밀번호</label>
            <input class="input-field" type="password" id="password" name="password">
            <div class="validation-message" data-for="password"></div>
            <br><br>

            <label for="email">* 이메일</label>
            <input class="input-field" type="text" id="email" name="email">
            <div class="validation-message" data-for="email"></div>
            <br>

            <label for="phoneNumber">* 전화번호</label>
            <div class="input-with-button">
                <input class="input-field" type="text" id="phoneNumber" name="phoneNumber">
                                <button type="button" id="requestSMSBtn">인증번호 요청</button>
            </div>
            <div class="validation-message" data-for="phoneNumber"></div>
            <br>

            <label for="phoneCodeInput">* 인증번호</label>
            <div class="input-with-button">
                <input class="input-field" type="text" id="phoneCodeInput" name="phoneCodeInput">
                <button type="button" id="verifySMSBtn">인증 확인</button>
            </div>
            <div class="validation-message" data-for="phoneCodeInput"></div>
            <br>
            <input type="checkbox" class="agree">&nbsp 이용약관 개인정보 수집 및 정보이용에 동의합니다.
            <hr>
            <button type="submit" class="submit-btn">가입하기</button>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    function validateForm() {
        var id = document.getElementById("id").value;
        var email = document.getElementById("email").value;
        var phoneNumber = document.getElementById("phoneNumber").value;
        var agree = document.querySelector(".agree");

        // 아이디 유효성 검사
        if (id.length < 5) {
            alert("아이디는 5자 이상이어야 합니다.");
            return false;
        }

        // 이메일 유효성 검사
        var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        if (!emailPattern.test(email)) {
            alert("올바른 이메일 주소를 입력하세요.");
            return false;
        }

        // 전화번호 유효성 검사
        var phonePattern = /^\d{10,11}$/;  // 10~11자리 숫자
        if (!phonePattern.test(phoneNumber)) {
            alert("올바른 전화번호를 입력하세요.");
            return false;
        }

        // 약관 동의 검사
        if (!agree.checked) {
            alert("이용약관에 동의해주세요.");
            return false;
        }

        return true;
    }

    // 아이디 입력란에 대한 유효성 검사 메시지 표시
    $("#id").on("focus", function () {
        var validationMessage = "아이디는 5자 이상이어야 합니다.";
        displayValidationMessage(this, validationMessage);
    });

    // 이메일 입력란에 대한 유효성 검사 메시지 표시
    $("#email").on("focus", function () {
        var validationMessage = "올바른 이메일 주소를 입력하세요.";
        displayValidationMessage(this, validationMessage);
    });

    // 전화번호 입력란에 대한 유효성 검사 메시지 표시
    $("#phoneNumber").on("focus", function () {
        var validationMessage = "올바른 전화번호를 입력하세요. (10~11자리 숫자)";
        displayValidationMessage(this, validationMessage);
    });

    // 유효성 검사 메시지 표시 함수
    // 유효성 검사 메시지 표시 함수
    function displayValidationMessage(element, message) {
        var inputId = $(element).attr("id");
        var messageElement = $(".validation-message[data-for='" + inputId + "']");
        messageElement.text(message).css('color', 'red');
    }

    // 아이디 입력란에 대한 유효성 검사 메시지 표시
    $("#id").on("focus", function () {
        var validationMessage = "아이디는 5자 이상이어야 합니다.";
        displayValidationMessage(this, validationMessage);
    });

    // 이메일 입력란에 대한 유효성 검사 메시지 표시
    $("#email").on("focus", function () {
        var validationMessage = "올바른 이메일 주소를 입력하세요.";
        displayValidationMessage(this, validationMessage);
    });

    // 전화번호 입력란에 대한 유효성 검사 메시지 표시
    $("#phoneNumber").on("focus", function () {
        var validationMessage = "올바른 전화번호를 입력하세요. (10~11자리 숫자)";
        displayValidationMessage(this, validationMessage);
    });


    // 인증번호 요청
    $("#requestSMSBtn").on("click", function () {
        var phoneNumber = $("#phoneNumber").val();
        $.post("/send-verification", {phoneNumber: phoneNumber}, function (response) {
            alert("인증번호가 발송되었습니다.");
        }).fail(function () {
            alert("인증번호 발송 실패");
        });
    });

    // 인증번호 확인
    $("#verifySMSBtn").on("click", function () {
        var phoneCodeInput = $("#phoneCodeInput").val();
        $.ajax({
            url: '/sms',
            type: 'POST',
            data: {phoneCodeInput: phoneCodeInput},
            success: function (data) {
                alert("인증번호 확인 성공!");
                $("#smsResult").text("인증 성공");
            },
            error: function (xhr, status, error) {
                alert("인증번호가 올바르지 않습니다.");
                $("#smsResult").text("인증 실패");
            }
        });
    });

    //아이디 중복
    $("#checkIdBtn").on("click", function () {
        var userId = $("#id").val();
        $.ajax({
            url: "/checkId",  // 서버에 중복 확인 요청을 보낼 URL
            type: "GET",
            data: {id: userId},
            success: function (response) {
                if (response === "duplicated") {  // 수정된 부분
                    alert("아이디가 이미 사용 중입니다.");
                } else {
                    alert("사용 가능한 아이디입니다.");
                }
            },
            error: function (xhr, status, error) {
                alert("서버와 통신 중 오류가 발생했습니다.");
            }
        });
    });
</script>
</body>
</html>
