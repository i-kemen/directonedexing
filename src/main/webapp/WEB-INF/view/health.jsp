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
            flex-direction: column;
            justify-content: center;
            width: 1440px;
            align-items: center;
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

        .article {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            width: 1440px;
        }

        .author {
            margin-left: 100px;
            width: 200px;
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
            font-family: "하나2.0 M";
            color: #6ea8fe;
            font-weight: 700;
        }

        .content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 1000px;
            font-family: "하나2.0 M";
            font-size: 20px;
        }

        .content-top {
            margin-top: 50px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 1000px;
            font-family: "하나2.0 M";
            font-size: 20px;
        }

        .content-top > strong {
            font-size: 30px;
            color: #0B9B97;
        }

        .content-middle {
            margin-top: 50px;
            display: flex;
            flex-direction: column;
            /*align-items: center;*/
            justify-content: center;
            width: 1000px;
            font-family: "하나2.0 M";
            font-size: 20px;
        }

        .content-middle > h3 {
            color: #E90061;
            font-size: 30px;
        }

    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="wrap">
    <div class="contents-header">
        <div>
            다이렉트 원덱싱 스토리
        </div>
        <div class="header-button">
            <a href="/start2" class="indexing-button">다른 전략 선택</a>
            <form id="dataForm" action="/port" method="post" class="portfolio-button"
                  onclick="redirectToIndexing(event);">
                <input type="hidden" id="jsonData" name="jsonData">
                <img src="img/graphanimation.gif">
                이 전략으로 투자하기
            </form>
        </div>
    </div>
    <div class="contents">
        <div class="article">
            <h2>Case 1. 헬스케어 산업에 '성장' 조건을 더해 수익률과 리스크 개선하기</h2>
            <div class="board_summary">
                <div class="author">
                    <div class="date">2023-10-10</div>
                    <div class="hit-count">조회수 1,557</div>
                </div>
            </div>
        </div>

        <div class="content">
            <div class="content-top">
                <strong>&lt;다이렉트 원덱싱 솔루션, 활용법&gt;</strong>
                <p>투자기준 만들기 가이드 영상</p>
                <iframe width="560" height="315" src="https://www.youtube.com/embed/_ubHqSz87BI?si=OcYZ9kAxi-bWj_VH"
                        title="YouTube video player" frameborder="0"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        allowfullscreen></iframe>
            </div>

            <div class="content-middle">
                <h3>하이리스크-하이리턴의 대표적인 산업, '헬스케어'</h3>

                <p>생명연장과 건강유지에 필수적인 산업인 헬스케어 산업의 시장규모는 현재 약 <span style="background-color: #FFFF00; font-weight: 700; ">1,400조원</span>으로,
                    반도체(약 500조원)의 3배 가까운 규모에 달하는데요. 앞으로도 성장을 이어나갈
                    것으로 기대되는 대표 산업 중 하나로 꼽힙니다.</p>

                <p>이렇게 성장이 기대됨에도 투자는 매우 어려운 산업 중 하나가 바로 헬스케어 산업입니다. 헬스케어 산업은 대표적인 <span
                        style=" font-weight: 700;background-color: #c5fffc;">하이리스크-하이리턴(High risk-High return)</span>
                    산업이기 때문이죠.</p>

                <p>헬스케어 산업의 가장 중요한 ‘신약’을 개발하는 데는 기간도, 돈도 많이 듭니다. 보통 하나의 신약이 개발되기까지 10여년에 걸쳐, 수천억에서 많게는 조단위 투자가 이뤄지는데요.
                    그럼에도 성공확률은 <span style="background-color: #FFFF00; font-weight: 700;">10% 미만</span>에 불과합니다.</p>

                <p>이렇게 확률이 낮지만, 만약 신약 개발에 성공한다면 막대한 부가가치를 창출할 수 있습니다. 세계에서 가장 많은 매출을 기록하는 미국 애브비의 자가면역질환 치료제 ‘휴미라’는
                    2020년 매출이 약 23조원(198억 3200만달러)으로, 국내 제약산업 전체 시장 규모와 맞먹는 수준이죠.</p>

                <p>확률은 낮지만 성공하면 ‘대박’인 덕에, 주식 수익률도 높습니다. 마켓워치에 따르면 1986년 이후 헬스케어 부문은 기술주 부문에 이어 두 번째로 높은 수익 성장률을 기록했는데요.
                    하지만 이런 기업을 개인투자자가 찾기란 매우 어렵죠. 오히려 덜컥 투자했다가 낭패를 보는 경우가 더 많습니다.</p>

                <h3>헬스케어 산업에서 수익률을 누릴 수 있는 방법은?</h3>

                <p>잘만 투자하면 ‘대박’이 나는 헬스케어 산업, 수익률은 누리고 실패 위험을 줄이는 방법은 없을까요?</p>
                <p><span style="background-color: #FFFF00; font-weight: 700; ">하나증권 다이렉트 원덱싱</span>을 활용하면, 가능해집니다.</p>

                <p>헬스케어 산업은 특히  미국이 주도하고 있는데요. 세계은행 추정치에 따르면 미국은 GDP의 16.89%, 인당 10,000달러 이상을 헬스케어 분야에 지출합니다. 세계 제약시장의 40% 이상을 미국이 차지하고 있죠. 제약조사 전문기관인 EvaluatePharma에 따르면, 글로벌 30대 제약기업 가운데 Pfizer, Merck & Co., Johnson & Johnson, AbbVie, Gilead Sciences, Amgen이 상위 10위 안에 드는 등 세계 제약시장에서 미국이 행사하는 영향력도 절대적입니다.</p>

                <p>즉 헬스케어 산업을 주도하는 ‘미국’에 투자하면, 성공 확률이 높아질 수 있다고 추측 할 수 있습니다. 다이렉트원덱싱에서는 지수(US 500)과 산업(헬스케어)를 선택해 원하는 포트폴리오를 구성 할 수 있습니다.</p>


            </div>
        </div>
    </div>
</div>
</div>
</div>

<%@ include file="footer.jsp" %>

<script>

    function redirectToIndexing(event) {
        event.preventDefault(); // 기본 제출 동작을 막습니다.
        window.location.href = "/indexing"; // '/indexing' 페이지로 이동합니다.
    }
</script>
</body>
</html>
