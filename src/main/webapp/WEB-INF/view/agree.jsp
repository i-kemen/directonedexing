<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <title>Stepper Example</title>
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

        .agree-container {
            font-family: Arial, sans-serif;
            margin: 2em;
            padding: 2em;
            border: 1px solid #e0e0e0;
            box-shadow: 2px 2px 12px #aaa;
            background-color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center; /* 이 부분을 추가 */
            height: 1200px;
        }

        .agree-container > div {
            margin-bottom: 1.5em;
        }

        .agree-container > div > div:first-child {
            font-weight: bold;
            font-size: 1.2em;
            margin-bottom: 1em;
        }

        .agree-header {
            font-family: "하나2.0 B";
            font-size: 40px;
            font-weight: 700;
            color: #E90061;        }

        .agree-container > div > div > div {
            margin-top: 1em;
            padding: 1em;
            border: 1px solid #e0e0e0;
            background-color: #f9f9f9;
        }

        button {
            padding: 10px 20px;
            background-color: #04BE9E;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
            width: 200px;
        }

        button:hover {
            background-color: #009B84;
        }

        .agree-wrap {
            margin-top: 80px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        /* 스크롤 가능한 div 스타일링 */
        .scrollable-content {
            height: 400px; /* 원하는 높이로 지정 */
            overflow-y: scroll;
            border: 1px solid #ccc;
            padding: 10px;
        }

        /* 체크박스 스타일링 */
        input[type="checkbox"] {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="agree-wrap">
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-12">
                <ul class="stepper">
                    <li class="step active">약관 동의</li>
                    <li class="step">회원가입</li>
                    <li class="step">회원가입 결과</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="agree-container">
        <div class="agree-header">약관 동의</div>
        <div>
            <div>전자금융서비스이용약관
                <div class="scrollable-content">
                    <h6>제 1조 (목적)</h6>
                    <p>이 약관은 고객이 하나증권주식회사(이하 '회사'라 한다)의 전자금융서비스(이하 ‘서비스’라 한다) 이용과 관련 하여 「전자금융거래 이용에 관한 기본약관」에서 정하지 아니한
                        세부적인 사항을 정함을 목적으로 한다.</p>
                    <h6>제 2 조 (용어의 정의)</h6>
                    <p>이 약관에서 사용하는 용어의 정의는 다음 각 호와 같다.</p>
                    <ul>
                        <li>1.서비스란 회사가 제공하는 시스템에 의해 고객이 컴퓨터, 전화기, 자동입출금기 그 밖에 전자적 방법으로 정보를 전송 하거나 처리하는 장치(이하 '전자적 장치'라
                            한다)를 이용하여 제3조제2항 각 호의 업무를 처리하는 것을 말한다.
                        </li>
                        <li>2.신청계좌란 서비스를 신청한 종합계좌를 말한다.</li>
                        <li>3.계좌비밀번호란 신청계좌의 비밀번호를 말한다.</li>
                        <li>4.사용자ID란 고객이 전자적 장치에 접속하기 위해 등록한 영문(대소문자를 구분한다. 이하 같다), 영문과 숫자의 조합을 말한다.</li>
                        <li>5.ID비밀번호란 고객이 전자적 장치에 접속하기 위해 등록한 영문, 숫자, 특수문자 중 2개 이상의 조합을 말한다.</li>
                        <li>6.인증서란 「전자서명법」 제 2 조제 6 호에 따른 인증서 서명자의 실지명의를 확인할 수 있는 것을 말한다.</li>
                        <li>7.전자서명비밀번호란 인증서 발급 시 고객이 직접 지정하는 인증서 비밀번호를 말한다.</li>
                        <li>8.부가정보란 사용자ID, ID비밀번호, 계좌비밀번호, 주민등록번호, 주소 등을 제외한 고객 본인만이 알 수 있는 2개 이상의 부수적인 정보를 말한다.</li>
                        <li>9.보안카드란 난수의 보안카드 비밀번호가 기재되어 있는 카드 또는 전자적 장치에 등록하여 보안카드 비밀번호를 생성하는 카드를 말한다.</li>
                        <li>10.보안카드 비밀번호란 보안카드에 표시된 숫자조합을 말한다.</li>
                        <li>11.OTP(One Time Password) 생성기란 OTP응답번호를 생성하는 기기를 말한다.</li>
                        <li>12.OTP응답번호란 OTP생성기를 통해 생성시키는 일회용 비밀번호를 말한다.</li>
                        <li>13.폰뱅킹 비밀번호란 고객이 폰뱅킹 거래 시 본인확인용으로 사용하는 비밀번호로서 고객이 직접 등록하여 사용하는 6자리의 숫자를 말한다.</li>
                        <li>14.생체(바이오)정보(이하 ‘바이오정보’라 한다)란 지문, 홍채, 정맥, 얼굴, 음성 등 개인을 식별할 수 있는 신체적 또는 행동적 특징에 관한 정보로 그로부터
                            가공되거나 생성된 정보를 포함한다.
                        </li>
                        <li>15.생체(바이오)인증(이하 ‘바이오인증’이라 한다)이란 고객이 서비스 이용 시 회사가 MTS를 이용하는 스마트기기에 사전에 등록해 놓은 바이오정보의 일치 여부 등을
                            인증기관을 통해 확인하는 절차를 말하며, 인증서 대신 본인인증수단으로 사용할 수 있다.
                        </li>
                        <li>16.간편인증이란 고객이 서비스 이용시 회사가 사전에 등록된 PIN번호, 패턴, 안면의 일치 여부를 확인하는 절차를 말한다.</li>
                        <li>17.PIN(Personal Identity Number)번호란 고객이 간편인증을 통한 서비스 이용을 위해 직접 등록한 6자리 숫자로 조합된 인증 비밀번호를 말하며,
                            인증서 대신 본인인증수단으로 사용할 수 있다.
                        </li>
                        <li>18.패턴이란 고객이 간편인증을 통한 서비스 이용을 위해 직접 등록한 일정한 형태나 유형을 말하며, 인증서 대신 본인인증수단으로 사용할 수 있다.</li>
                        <li>19.안면정보란 고객이 간편인증을 통한 서비스 이용을 위해 직접 등록한 얼굴을 말하며, 인증서 대신 본인인증 수단으로 사용할 수 있다.</li>
                        <li>20.빠른 이체서비스란 고객이 MTS에서 빠른 이체비밀번호를 이용하여 이체하는 서비스를 말한다.</li>
                        <li>21.빠른 이체비밀번호란 고객이 서비스 이용시 빠른 이체서비스를 이용하기 위해 MTS에서 직접 등록한 6자리 숫자를 말한다.</li>
                        <li>22.제휴회사란 회사가 증권거래계좌의 개설대행 등을 위하여 업무제휴계약을 맺은 제휴은행 등을 말한다.</li>


                    </ul>
                    <div>※ 계약서류(본 약관 포함)는 「금융소비자 보호에 관한 법률」 등에 따라 내부통제기준과 절차를 준수하여 제공되고 있습니다.</div>
                </div>
            </div>
            <div>위의 약관에 동의하시겠습니까?
                <input type="checkbox" id="agree1">
                <label for="agree1">동의함</label>
                <input type="checkbox" id="disagree1">
                <label for="disagree1">동의하지 않음</label>
            </div>
        </div>
        <div>
            <div>금융실명 확인 사항
                <div>
                    「금융실명거래 및 비밀보장에 관한 법률」제3조 제3항에 따라 누구든지 불법재산의 은닉, 자금세탁행위, 공중협박자금조달행위 및 강제 집행의 면탈, 그 밖의 탈법행위를 목적으로 타인의
                    실명으로 금융거래를 하여서는 아니되며, 이를 위반시 5년 이하의 징역 또는 5천만원 이하의 벌금에 처해질 수 있음에 대하여 충분한 설명을 들어 이해하였음을 확인합니다.
                </div>
            </div>
            <div>본인은 위 안내에 대해 금융회사로부터 내용을 제공받아 이해하였음을 확인합니다.
                <input type="checkbox" id="agree2">
                <label for="agree2">동의함</label>
                <input type="checkbox" id="disagree2">
                <label for="disagree2">동의하지 않음</label></div>
        </div>
        <a href="/signup">
            <button>확인</button>
        </a>
    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
