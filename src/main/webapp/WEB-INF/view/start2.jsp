<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>전략 선택 페이지</title>
    <style>

        /*메인*/


        .strategy-main {
            width: 1440px;
            height: 1000px;
            display: flex;
            flex-direction: column;
            overflow: auto;
            margin: 0 auto; /* 위아래 마진은 0, 좌우 마진은 자동으로 설정 */
            margin-top: 80px;
        }

        .title {
            height: 100px;
            font-family: "하나2.0 B";
            font-size: 60px;
            text-align: center;
            color: #E90061;
            opacity: 0;
            animation: txtE 5s infinite;
            margin-top: 50px;
            margin-bottom: 50px;
        }

        @keyframes txtE {

            100% {
                transform: translate(0) scale(1);
                opacity: 1;
                color: #E90061;
            }
        }


        .col {
            /*width: 1440px;*/
            height: 300px;
            display: flex;
            flex-direction: row;
            justify-content: space-around;
            margin-bottom: 50px;
        }

        .card {
            width: 420px;
            height: 280px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1), 0 6px 20px rgba(0, 0, 0, 0.1);
            border-radius: 20px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: scale(1.01);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2), 0 12px 40px rgba(0, 0, 0, 0.2);
        }


        .card-top {
            width: 100%;
            height: 100px;
            position: relative; /* 추가 */
        }

        .card-top-bg-image {
            width: 420px !important;
            height: 100px;
            position: absolute;
            z-index: -1;
            left: 50%;
            transform: translateX(-50%);
            object-fit: cover; /* 이 부분 추가 */
        }


        .card-top-contents {
            width: 100%;
            height: 100%;
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .card-top-top {
            width: 100%;
            height: 60px;
            font-family: "하나2.0 M";
            font-size: 30px;
            display: flex;
            align-items: center;
            margin-left: 20px;
        }

        .card-top-bottom {
            width: 380px;
            height: 40px;
            font-family: "하나2.0 M";
            font-size: 30px;
            font-weight: 700;
            display: flex;
            margin-left: 20px;
            border-bottom: #e2e3e5 1px solid;
            align-items: center;
        }

        .card-body {
            height: 180px;
            display: flex;
            flex-direction: column;
        }

        .card-body-top {
            margin-top: 20px;
            margin-left: 30px;
            font-family: "하나2.0 B";
            font-weight: 500;
            font-size: 15px;
            height: 60px;
            height: 100px;
        }


        .threemonths {
            height: 70px;
            display: flex;
            flex-direction: row;
            align-items: center;
            font-family: "하나2.0 M";
            font-size: 17px;
            justify-content: space-between;
        }

        .profit {
            width: 110px;
            margin-left: 20px;
        }

        .profit2 {
            width: 80px;
            color: red;
            font-weight: bolder;
        }

        .byundong {
            margin-left: 20px;
            width: 110px;
        }

        .byundong2 {
            width: 80px;
            color: blue;
            font-weight: bolder;
        }

        .btn-group {
            width: 380px;
            height: 80px;
            display: flex;
            justify-content: space-around;
            align-items: center;
            margin-left: 20px;
        }

        .strategy-detail {
            padding: 10px 20px;
            color: white;
            background-color: #00857F; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            font-size: 15px;
            width: 150px;
        }

        .strategy-detail:hover {
            background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
        }

        .strategy-select {
            padding: 10px 20px;
            color: white;
            background-color: #7B9ACC; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            font-size: 15px;
            width: 150px;
        }

        .strategy-select:hover {
            background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
        }

        /* Modal styles */
        .strategy-modal {
            display: flex;
            justify-content: center;
            align-items: center;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* 배경색과 투명도 조절 */
            z-index: 1000;
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            font-family: "하나2.0 B";
            font-size: 30px;
            color: black;
            text-align: center;
            width: 900px;
            height: 600px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .button-wrap {
            width: 380px;
            height: 70px;
            display: flex;
            justify-content: space-around;
            align-items: center;
        }

        .modal-hide {
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

        }

        .modal-hide:hover {
            background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
        }

        .modal-select {
            padding: 10px 20px;
            color: white;
            background-color: #7B9ACC; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            font-size: 15px;
            width: 150px;

        }

        .modal-select:hover {
            background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .option-box {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1), 0 6px 20px rgba(0, 0, 0, 0.1);
            border-radius: 20px;
            padding: 10px;
            margin: 10px 0;
            cursor: pointer;
            width: 300px;
            height: 100px;
            transition: background-color 0.3s ease;
            font-family: "하나2.0 M";
            font-size: 15px;
        }

        .option-box:hover {
            background-color: #e2e3e5;
            color: white;
        }

        .clicked {
            color: #0B9B97;
        }

        .emoji-with-circle {
            display: inline-block; /* 인라인 블록으로 설정하여 크기 조절이 가능하게 합니다. */
            width: 30px; /* 원하는 너비로 설정 */
            height: 30px; /* 원하는 높이로 설정 */
            text-align: center; /* 이모지를 가운데로 정렬 */
            border-radius: 50%; /* 원형으로 보이게 만듭니다. */
            background-color: white; /* 흰색 배경 */
            line-height: 30px; /* 높이와 동일하게 설정하여 수직 중앙 정렬을 합니다. */
        }

        .emoji-with-circle span {
            font-size: 20px; /* 이모지 크기 설정 */
        }

        .kr-emoji span {
            font-size: 24px; /* 원하는 크기로 설정 */
        }

        .indexing-button {
            padding: 10px 20px;
            color: white;
            background-color: #603F83; /* 다른 버튼의 배경색 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* hover 효과에 애니메이션 추가 */
            font-family: "하나2.0 M";
            font-size: 15px;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            text-decoration: none;
        }

        .indexing-button:hover {
            background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
        }
    </style>

</head>
<body>
<div class="theme-wrap">
    <%@ include file="header.jsp" %>
    <div class="strategy-main">
        <div class="title">
            나만의 전략을 선택해주세요.
        </div>
        <div>
            <div>
                <div class="col">
                    <%--                    1번카드--%>
                    <div class="card">
                        <div class="card-top">
                            <img src="/img/s1.svg" alt="Theme Image" class="card-top-bg-image">
                            <div class="card-top-contents">
                                <div class="card-top-top">
<span class="emoji-with-circle kr-emoji">
    <span>🇰🇷</span>
</span>

                                    <span class="emoji-with-circle">
    <span>🔥</span>
</span>
                                    &nbsp;

                                </div>
                                <div class="card-top-bottom">
                                    헬스케어 성장 집중 전략
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="card-body-top">
                                헬스케어 산업의 특징은 성장을 지속하는 것에 있습니다. <br>
                                성장 모멘텀 스코어를 활용하여 수익률과 리스크를 동시에 <br>
                                개선한 전략입니다.
                            </div>
                            <div class="strategy-button">
                                <div class="btn-group">
                                    <button class="strategy-detail" onclick="navigateTo('/health')">전략 상세</button>
                                    <button class="strategy-select" onclick="navigateTo('/indexing')">전략 선택</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--2번카드--%>
                    <div class="card">
                        <div class="card-top">
                            <img src="/img/s2.svg" alt="Theme Image" class="card-top-bg-image">
                            <div class="card-top-contents">
                                <div class="card-top-top">
<span class="emoji-with-circle kr-emoji">
    <span>🇰🇷</span>
</span>

                                    <span class="emoji-with-circle">
    <span>🔥</span>
</span>
                                    &nbsp;

                                </div>
                                <div class="card-top-bottom">
                                    반도체 산업 수익 극대화 전략
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="card-body-top">
                                반도체 산업에 안정성으로 대표되는 배당을 기준으로<br>
                                부채비율이 적고 재무적으로 건강한 기업을 찾아 <br>
                                수익성을 극대화한 전략입니다.
                            </div>
                            <div class="strategy-button">
                                <div class="btn-group">
                                    <!--                전략 상세 버튼 누르면 해당 전략 설명 페이지로 이동-->
                                    <button class="strategy-detail" onclick="showStrategyDetails()">전략 상세</button>
                                    <!--                전략 선택 버튼 누르면 모달 팝업-->
                                    <button class="strategy-select" onclick="showModal()">전략 선택</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--3번카드--%>
                    <div class="card">
                        <div class="card-top">
                            <img src="/img/s3.svg" alt="Theme Image" class="card-top-bg-image">
                            <div class="card-top-contents">
                                <div class="card-top-top">
<span class="emoji-with-circle kr-emoji">
    <span>🇰🇷</span>
</span>

                                    <span class="emoji-with-circle">
    <span>🔥</span>
</span>
                                    &nbsp;

                                </div>
                                <div class="card-top-bottom">
                                    테크 성장주 리스크 감소 전략
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="card-body-top">
                                고밸류에이션 산업인 테크 분야에서 마틴 즈웨이그의<br>
                                이익 모멘텀 스코어를 통해, 좀 더 안정적인 기업을 찾아<br>
                                성장성을 가져가면서도 변동성을 줄이는 전략입니다.
                            </div>
                            <div class="strategy-button">
                                <div class="btn-group">
                                    <!--                전략 상세 버튼 누르면 해당 전략 설명 페이지로 이동-->
                                    <button class="strategy-detail" onclick="showStrategyDetails()">전략 상세</button>
                                    <!--                전략 선택 버튼 누르면 모달 팝업-->
                                    <button class="strategy-select" onclick="showModal()">전략 선택</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!--2번째줄-->
                <div class="col">
                    <%--                    1번카드--%>
                    <div class="card">
                        <div class="card-top">
                            <img src="/img/s4.png" alt="Theme Image" class="card-top-bg-image">
                            <div class="card-top-contents">
                                <div class="card-top-top">
<span class="emoji-with-circle kr-emoji">
    <span>🇰🇷</span>
</span>

                                    <span class="emoji-with-circle">
    <span>🔥</span>
</span>
                                    &nbsp;

                                </div>
                                <div class="card-top-bottom">
                                    KOSDAQ 실적 성장주 전략
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="card-body-top">
                                코스닥 상장 종목 중 2024년 매출전망치가 과거 5년 <br>
                                평균 대비 15% 이상 증가할 것으로 기대되는 성장주를 <br>
                                찾아 이익을 극대화한 전략입니다.
                            </div>
                            <div class="strategy-button">
                                <div class="btn-group">
                                    <!--                전략 상세 버튼 누르면 해당 전략 설명 페이지로 이동-->
                                    <button class="strategy-detail" onclick="showStrategyDetails()">전략 상세</button>
                                    <!--                전략 선택 버튼 누르면 모달 팝업-->
                                    <button class="strategy-select" onclick="showModal()">전략 선택</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--                    2번카드--%>
                    <div class="card">
                        <div class="card-top">
                            <div class="card-top-bg-image" style="background-color: #04BE9E;"></div>
                            <div class="card-top-contents">
                                <div class="card-top-top">
<span class="emoji-with-circle kr-emoji">
    <span>🇰🇷</span>
</span>

                                    <span class="emoji-with-circle">
    <span>✍️</span>
</span>
                                    &nbsp;

                                </div>
                                <div class="card-top-bottom">
                                    직접 만들기
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="card-body-top">
                                내가 원하는 투자 전략이 없나요? <br>
                                내 투자 아이디어의 성과를 실시간으로 확인해보고 <br>
                                포트폴리오로 만들어보세요.
                            </div>
                            <div class="strategy-button">
                                <div class="btn-group">
                                    <!--                전략 상세 버튼 누르면 해당 전략 설명 페이지로 이동-->
                                    <a href="/indexing" class="indexing-button">만들어 보기</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--                    3번카드--%>
                    <div class="card">
                        <div class="card-top">
                            <img src="/img/s5.png" alt="Theme Image" class="card-top-bg-image">
                            <div class="card-top-contents">
                                <div class="card-top-top">
<span class="emoji-with-circle kr-emoji">
    <span>🇰🇷</span>
</span>

                                    <span class="emoji-with-circle">
    <span>🔥</span>
</span>
                                    &nbsp;

                                </div>
                                <div class="card-top-bottom" style="font-size: 25px">
                                    피터린치 중소형주 성장 집중 전략
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="card-body-top">
                                종소형주 특징인 자금유동성 리스크를 줄이고, 건강한 성장<br>
                                지표로 매출 성장률에 집중하는 피터린치 스코어를 통해 <br>
                                대한민국 중소형주를 공략한 전략입니다.
                            </div>
                            <div class="strategy-button">
                                <div class="btn-group">
                                    <!--                전략 상세 버튼 누르면 해당 전략 설명 페이지로 이동-->
                                    <button class="strategy-detail" onclick="showStrategyDetails()">전략 상세</button>
                                    <!--                전략 선택 버튼 누르면 모달 팝업-->
                                    <button class="strategy-select" onclick="showModal()">전략 선택</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
<script>
    function navigateTo(path) {
        window.location.href = path;
    }
</script>
</body>
</html>

