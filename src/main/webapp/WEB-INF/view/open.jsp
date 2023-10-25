<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.namhoon.di.dto.UserDTO" %>

<%
    UserDTO user = (UserDTO) request.getSession().getAttribute("user");
    String currentUserName = user.getName();
    String currentUserPhoneNumber = user.getPhoneNumber();
    int accountNumberValue = 3 * 10000000 + (int) (Math.random() * 10000000);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Open Account</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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

        .open-wrap {
            margin-top: 80px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .open-container {
            margin-top: 20px;
            width: 1140px;
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

        input[type="text"] {
            width: 200px;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .input-with-button {
            display: flex;
            align-items: center;
        }

        .input-field {
            width: 250px !important;
        }

        .validation-message {
            height: 20px;
            color: red;
            margin-top: 5px;
        }

        button {
            display: block;
            width: 200px;
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
            background-color: #009B84;
        }

        .product-div {
            margin-bottom: 15px;
        }


        .open-container > div {
            margin-bottom: 1.5em;
        }

        .product-div {
            border: 1px solid black;
            padding: 10px;
            margin: 10px;
            width: 500px;
            display: flex;
            flex-direction: row;
            align-items: center;
        }

        input[type="checkbox"] {
            appearance: none;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            background-color: white;
            border: 1px solid black;
            cursor: pointer;
        }

        input[type="checkbox"]:checked {
            background-color: #E90061;
        }

        .input-group {
            display: flex;
            align-items: center; /* 세로 중앙 정렬 */
            gap: 10px; /* 요소들 사이의 간격 */
        }

        .centered-button {
            display: block;
            margin: 20px auto; /* 상하 20px 마진과 좌우 자동 마진 */
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="open-wrap">
    <div class="open-container">
        <h2>계좌 개설</h2>
        <div>
            <label>아이디</label>
            <input type="text" name="id" value="${user.id}" readonly>
        </div>
        <div>
            <label>이름</label>
            <input type="text" value="${user.name}" readonly>
        </div>
        <div>
            <label>연락처</label>
            <div class="input-group">
                <input type="text" id="phoneNumber" value="${user.phoneNumber}" readonly>
                <button type="button" id="requestSMSBtn">인증번호 요청</button>
            </div>
        </div>

        <div>
            <label for="phoneCodeInput">* 인증번호</label>
            <div class="input-group">
                <input type="text" id="phoneCodeInput" name="phoneCodeInput">
                <button type="button" id="verifySMSBtn">인증 확인</button>
            </div>
        </div>

        <div class="validation-message" data-for="phoneCodeInput"></div>
        <form action="/create" method="post" onsubmit="updateAccountDetails(event);">
            <input type="hidden" name="id" value="${user.id}">
            <div>
                <label>추천상품:</label>
                <div class="product-div">
                    <input type="checkbox" name="accountType" value="010"> 종합매매(국내/해외 주식)
                </div>
                <div class="product-div">
                    <input type="checkbox" name="accountType" value="210"> 국내파생
                </div>
                <div class="product-div">
                    <input type="checkbox" name="accountType" value="220"> 해외파생
                </div>
                <div class="product-div">
                    <input type="checkbox" name="accountType" value="260"> FX마진
                </div>
                <div class="product-div">
                    <input type="checkbox" name="accountType" value="300"> 금융상품
                </div>
            </div>
            <div>
                <label>알아두세요!</label>
                <div>
                    계좌 개설 시 증거금 100% 징수로 설정되며, 증거금은 계좌 개설 완료 후 온라인 또는 유선으로 변경 가능합니다.
                </div>
            </div>
            <div id="accountInfoContainer">
                <!-- 계좌 정보 입력 부분 -->
            </div>
            <button type="submit" class="centered-button">계좌 개설</button>
        </form>
    </div>
</div>


<%@ include file="footer.jsp" %>


<script>
    function updateAccountDetails(event) {
        event.preventDefault();

        let selectedAccountTypes = [];
        let selectedAccountLabels = [];
        let checkboxes = document.querySelectorAll("input[name='accountType']:checked");

        for (let checkbox of checkboxes) {
            selectedAccountTypes.push(checkbox.value);
            selectedAccountLabels.push(checkbox.parentNode.textContent.trim().replace(/[\n\r]+|[\s]{2,}/g, ' '));
        }

        let formData = new FormData();
        for (let i = 0; i < selectedAccountTypes.length; i++) {
            let accountType = selectedAccountTypes[i];
            let accountLabel = selectedAccountLabels[i];
            let accountName = "원큐스탁 : " + '<%= currentUserName %>' + "의 " + accountLabel;
            let generatedAccountNumber = "3" + Math.floor(10000000 + Math.random() * 90000000);

            formData.append("accountType", accountType);
            formData.append("accountName", accountName);
            formData.append("accountNumber", generatedAccountNumber);
        }

        // 서버로 데이터 전송
        fetch('/create', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                window.location.href = '/openresult';  // Just redirect without setting anything in sessionStorage.
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }


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
</script>


</body>
</html>
