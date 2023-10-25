<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<div>
    <h1>자문 계약</h1>
    <div>
        1단계 전략확인
    </div>
    <h2>상품 정보</h2>

    <table class="table">
        <thead>
        <tr>
            <th scope="col">프론트</th>
            <th scope="col">백엔드</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th scope="row">상품명</th>
            <td></td>
        </tr>
        <tr>
            <th scope="row">위험등급</th>
            <td></td>
        </tr>
        <tr>
            <th scope="row">투자대상 상품</th>
            <td></td>
        </tr>
        <tr>
            <th scope="row">자문계좌 유형</th>
            <td></td>
        </tr>

        <tr>
            <th scope="row">자문사</th>
            <td></td>
        </tr>
        <tr>
            <th scope="row">자문역</th>
            <td></td>
        </tr>
        <tr>
            <th scope="row">자문사연락처</th>
            <td>02-785-5000</td>
        </tr>
        <tr>
            <th scope="row">자문기간</th>
            <td></td>
        </tr>
        <tr>
            <th scope="row">최저 가입 금액</th>
            <td></td>
        </tr>
        <tr>
            <th scope="row">수수료부과 기준</th>
            <td>계좌 평가 금액</td>
        </tr>
        <tr>
            <th scope="row">수수료 징수주기</th>
            <td>분기</td>
        </tr>
        <tr>
            <th scope="row">자문수수료</th>
            <td>연 0.5% (분기단위 후취)</td>
        </tr>
        </tbody>
    </table>
</div>
<div class="proposal">
    <h4>더 자세한 설명이 필요하신가요?</h4>
    <button onclick="openProposal()">투자 제안서</button>
</div>
<div>
    <h4>알려드립니다.</h4>
    <div>
        <p>· 투자자는 이 금융투자상품 등에 대하여당사로부터 충분한 설명을 받을 권리가 있으며, 투자 전 계약서 및 설명서 등을 반드시 읽어보시기 바랍니다.</p>
        <p>· 이 금융투자상품은 예금자 보호법에 따라 예금보험공사가 보호하지 않습니다.</p>
        <p>· 이 금융투자상품은 &lt;자산가격 변동&gt;, &lt;환율 변동&gt;, &lt;신용 등급 하락&gt; 등에 따라 투자원금의 손실(일부 또는 전액)이 발생할 수 있으며, 그 손실은 투자자에게 귀속됩니다.</p>
        <p>· 자문수수료는 계좌 평가금액을 기준으로 부과하므로 계좌 잔고가 증가하였을 경우, 부과되는 자문계약 수수료가 늘어날 수 있습니다.</p>
        <p>· 상품별 거래수수료는 당사에서 정한 수수료율을 따릅니다. 고객서비스 &lt; 업무안내 &lt; 수수료안내 &lt; 일반수수료 화면을 참고하시기 바랍니다.</p>
    </div>
</div>
<div>
    <button class="backtomystrategy"onclick="backToMyStrategy()">이전</button>
    <button class="mygyeja" onclick="showGyeja()">확인</button>

</div>
<script>
    function openProposal() {
        // PDF 파일의 경로 설정 (본인의 경로로 수정)
        const pdfFilePath = "Retail.pdf";

        // 새 창을 열어 PDF 파일을 보여줌
        window.open(pdfFilePath, "_blank");
    }

    function backToMyStrategy(){
        window.location.href ="Mystrategy.html"
    }

    function showGyeja() {

    }
</script>
</body>
</html>