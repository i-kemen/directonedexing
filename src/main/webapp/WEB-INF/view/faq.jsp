<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>

    <style>
        .FaqVisual {
            display: flex;
            align-items: center;
            overflow: auto;
            justify-content: space-between;
            background-color: #0E8C8D;
        }

        .FaqVisual .textArea {
            font-size: 30px;
            font-weight: 700;
            font-family: "하나2.0 B";
            color: #F8F5F9;
        }

        .FaqVisual .ico {

        }

        /*아코디언 토글*/
        .accordion {
            background-color: white;
            color: #444;
            cursor: pointer;
            padding: 18px;
            width: 100%;
            height: 50px;
            border: none;
            text-align: left;
            outline: none;
            font-size: 25px;
            transition: 0.4s;
            font-family: "하나2.0 M";
            font-weight: 700;
            color: #E90061;
        }


        .active, .accordion:hover {
            background-color: white;
        }

        .accordion:after {
            content: url("img/btn_arrow.png");
            font-size: 13px;
            color: #777;
            float: right;
            margin-left: 5px;

        }

        .active:after {
            content: url("img/btn_arrowTop.png");

        }

        .panel {
            padding: 0 18px;
            background-color: #FAFBFC;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.2s ease-out;
            font-size: 15px;
            font-family: "하나2.0 R";
            font-weight: 700;
        }

        .faqType {
            top: 27px;
            left: 0;
            color: #5177BC;
        }

    </style>

</head>
<body>
<div>
    <div class="FaqVisual">
        <div class="textArea">
            하나 증권 다이렉트ONE덱싱<br>
            <strong>자주 묻는 질문을<br>모아봤어요!</strong>
        </div>
        <span class="ico"><img src="img/qna.png"></span>
    </div>

    <button class="accordion"><span class="faqType">Q</span> 다이렉트인덱싱이란?</button>
    <div class="panel">
        <span class="faqType">A</span>
        초개인화 시대에 맞추어 고객 스스로 맞춤형 지수(포트폴리오)를 편리하게 구축 및 편집할 수 있도록 사전에 만들어진 테마, 업종, 대가들의 투자 전략을 제공하는 금융투자 엔진입니다.
    </div>

    <button class="accordion"><span class="faqType">Q</span> Quant(퀀트) 투자란?</button>
    <div class="panel">
        <span class="faqType">A</span>
        퀀트 투자란 Quantitative(정량적)와 Analyst(분석가)의 합성어로 재무 데이터, 가격 및 수급 데이터 등에 기반한 계량적 모델을 활용하여 투자자산의 미래 가치를 분석하여 투자하는
        기법입니다.<br>
        &nbsp;&nbsp;&nbsp;퀀트 투자는 과거의 수익률 패턴이나 기업의 재무제표와 같은 정형화된 데이터 뿐만 아니라, 소셜 미디어 등의 비정형화된 데이터까지 계량적으로 활용할 수 있어 Qualitative(정성적) 리서치 기법
        대비 구체적인 투자기준을 제시한다는 장점이 있습니다.
    </div>
    <button class="accordion"><span class="faqType">Q</span> 팩터가 뭔가요?</button>
    <div class="panel">
        <span class="faqType">A</span>
        팩터는 주식 시장에서 투자 수익률에 영향을 미치는 PER, PBR, EPS 등과 같은 투자 기준입니다.<br>
        &nbsp;&nbsp;&nbsp;팩터 스타일이란 가치, 성장, 이익의 질, 배당 등과 같이 개별 팩터를 유사한 스타일로 모아둔 투자기준을 의미합니다. 이를 활용하여 투자 전략을 구성하거나 포트폴리오를 최적화할 수 있습니다.
    </div>
    <button class="accordion"><span class="faqType">Q</span> 프리셋(Pre-set)은 무엇인가요?</button>
    <div class="panel">
        <span class="faqType">A</span>
        프리셋(Pre-set)은 최초 제시된 전략 그대로의 포트폴리오를 의미합니다. 프리셋(Pre-set) 투자를 진행하시면 제시된 포트폴리오를 그대로 내 투자에 적용하실 수 있습니다.
    </div>
    <button class="accordion"><span class="faqType">Q</span> 편집 방법에 따라 무엇이 다른가요?</button>
    <div class="panel">
        <span class="faqType">A</span>
        개인들의 투자 지식에 따라 사전에 만들어진 포트폴리오를 그대로 투자하는 ‘프리셋(Pre-set) 투자’, 투자 기준 팩터 스타일(가치, 성장, 배당 등 9개)을 가미한 ‘간편 투자’, 계량분석
        전문가들이 사용하는 투자기준을 적용한 전문가 수준의 ‘프로(Pro) 투자’<br>&nbsp;&nbsp;&nbsp;(백여개의 다양한 개별 투자 기준 다중 선택) 3가지 중 하나를 선택하여 본인의 투자 지식에 맞는 눈높이 투자가 가능합니다.
    </div>
    <button class="accordion"><span class="faqType">Q</span> 리밸런싱이 뭔가요?</button>
    <div class="panel">
        <span class="faqType">A</span>
        리밸런싱은 사전에 고객이 설정한 투자 기준에 따라 시장의 변화에 맞추어 포트폴리오의 구성 종목 비중을 재조정하는 것을 의미합니다.<br>
        &nbsp;&nbsp;&nbsp;기존 운용 포트폴리오를 변경하고자 하는 포트폴리오의 구성 종목과 비교하여 매수 매도가 발생하는 것을 의미하여 이를 통해 포트폴리오의 리스크와 예상 수익률을 효과적으로 관리할 수 있습니다.
    </div>

    <button class="accordion"><span class="faqType">Q</span> 다이렉트인덱싱 문의 및 상담은 어떻게 하나요?</button>
    <div class="panel">
        <span class="faqType">A</span>
        프라임케어실(02-785-5000)로 연락해주시면 문의사항에 대한 답변과 자세한 상담을 받으실 수 있습니다.
    </div>


    <script>
        var acc = document.getElementsByClassName("accordion");
        var i;

        for (i = 0; i < acc.length; i++) {
            acc[i].addEventListener("click", function () {
                this.classList.toggle("active");
                var panel = this.nextElementSibling;
                if (panel.style.maxHeight) {
                    panel.style.maxHeight = null;
                } else {
                    panel.style.maxHeight = panel.scrollHeight + "px";
                }
            });
        }
    </script>


</div>

</body>
</html>

