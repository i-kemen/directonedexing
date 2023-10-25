<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<title>WebSocket Test Page</title>
<!-- crypto-js.min.js 들어갈자리, for use aes256 decode -->
<!-- <script src="C:\cryptojs\crypto-js.min.js"></script> -->
<script src="../../../resources/static/js/crypto-js.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<%--카카오톡--%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<script>
    Kakao.init('803d17852f25c4a01c476818dce24472'); // 카카오 SDK 초기화
</script>
<!-- 화면분할을 위한 div 처리 -->
<style>
    /*표 꾸미기*/
    @import 'https://fonts.googleapis.com/css?family=Open+Sans:600,700';

    * {
        font-family: 'Open Sans', sans-serif;
    }

    #stockTable {
        min-width: 300px;
        max-width: 100%;
        border-collapse: collapse;
    }

    #stockTable th {
        border-top: none;
        background: #428bca;
        color: #fff;
    }

    #stockTable tr {
        border-top: 1px solid #ddd;
        border-bottom: 1px solid #ddd;
        background-color: #f5f9fc;
    }

    #stockTable tr:nth-child(odd):not(:first-child) {
        background-color: #ebf3f9;
    }

    #stockTable th {
        display: table-cell;
        padding: .25em .5em;
        text-align: center; /* 텍스트 가운데 정렬 추가 */
    }

    #stockTable td {
        display: table-cell;
        padding: .25em .5em;
        text-align: center; /* 텍스트 가운데 정렬 추가 */
    }


    #stockTable td:nth-child(4) {
        width: 90px; /* 원하는 너비로 설정 */
    }
    /* 두 번째 열의 너비를 늘리기 */
    #stockTable td:nth-child(5) {
        width: 150px; /* 원하는 너비로 설정 */
    }



    @media screen and (max-width: 601px) {
        #stockTable th {
            display: none;
        }

        #stockTable td {
            display: block;
        }

        #stockTable td:first-child {
            margin-top: .5em;
        }

        #stockTable td:last-child {
            margin-bottom: .5em;
        }

        #stockTable td:before {
            content: attr(data-th) ": ";
            font-weight: bold;
            width: 120px;
            display: inline-block;
            color: #000;
        }
    }




    /*        페이지*/
    #pagination {
        text-align: center;
        margin-top: 20px;
    }

    #pagination button {
        margin: 0 5px;
        background-color: #0B9B97;
        color: white;
        border: none;
        border-radius: 20px;
    }

    .past {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    div.row {
        width: 100%;
        display: flex;
        border: 1px solid #003458;
    }

    div.left {
        width: 300px;
        box-sizing: border-box;
        /*
        background: #FFF5EE;
        */
        font-size: 12px;
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: space-between;
    }

    /* 공통 테이블 스타일 */
    .myTable {
        border-collapse: collapse;
        width: 400px;
        height: 600px;
        font-family: 'Open Sans', sans-serif; /* 폰트 추가 */
        margin: 20px 0;
        min-width: 300px;
        max-width: 100%;
        background-color: #f5f9fc; /* 색상 추가 */
    }

    .myTable th {
        border-top: none;
        background-color: #428bca; /* 변경된 배경색 */
        color: #fff; /* 변경된 글자색 */
        border: 1px solid black;
        padding: 8px;
        text-align: center; /* 텍스트 가운데 정렬 추가 */
        font-size: 14px;
        font-weight: bold;
    }

    .myTable td {
        border: 1px solid black;
        padding: 8px;
        text-align: center; /* 텍스트 가운데 정렬 추가 */
        font-size: 14px;
    }

    .myTable tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .myTable tr:hover {
        background-color: #ddd;
    }

    .myTable tr:nth-child(odd):not(:first-child) {
        background-color: #ebf3f9;
    }

    .buy {
        color: red;
    }

    .sell {
        color: blue;
    }

    @media screen and (max-width: 601px) {
        .myTable th {
            display: none;
        }

        .myTable td {
            display: block;
        }

        .myTable td:first-child {
            margin-top: .5em;
        }

        .myTable td:last-child {
            margin-bottom: .5em;
        }

        .myTable td:before {
            content: attr(data-th) ": ";
            font-weight: bold;
            width: 120px;
            display: inline-block;
            color: #000;
        }
    }


    .tabs {
        display: flex;
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    .tab-link {
        padding: 10px 15px;
        border: 1px solid #ccc;
        cursor: pointer;
        flex-grow: 1;
        text-align: center;
    }

    .tab-link.active {
        background-color: #ddd;
    }

    .tab-content {
        display: flex;
        flex-direction: column;
        align-items: start;
        display: none;
    }

    .tab-content-item {
        margin-bottom: 10px;
    }

    .tab-content.active {
        display: block;
    }

    /* 기본 폰트 및 패딩 설정 */
    .index-right {
        font-family: 'Arial', sans-serif;
        padding: 20px;
        padding-top: 40px;
    }

    /* 주식 정보 영역 */
    #stock-info {
        background-color: #f6f8fa;
        padding: 10px;
        border-radius: 5px;
        margin-bottom: 20px;
    }

    #stock-info h3, #stock-info h4, #stock-info p {
        margin: 10px 0;
    }

    #stock-info span {
        font-weight: bold;
    }

    /* 탭 메뉴 */
    .tabs {
        list-style-type: none;
        padding: 0;
        display: flex;
        margin-bottom: 20px;
    }

    .tab-link {
        padding: 10px 20px;
        background-color: #ddd;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .tab-link.active {
        background-color: #428bca;
        color: white;
    }

    .tab-link:hover {
        background-color: #bbb;
    }

    /* 탭 컨텐츠 */
    .tab-content {
        display: none;
        background-color: #f6f8fa;
        padding: 20px;
        border-radius: 5px;
        margin-bottom: 20px;
    }

    .tab-content.active {
        display: block;
    }

    .tab-content-item {
        margin-bottom: 10px;
    }

    /* 계좌 정보 */
    #account-details {
        background-color: #eef1f5;
        padding: 15px;
        border-radius: 5px;
        font-size: 14px;
    }

    #account-details p {
        margin: 10px 0;
    }

    #account-details span {
        font-weight: bold;
    }


    .table-header{
        height: 20px;

    }
</style>
<script>
    /** button action 시 stockcode 저장 전역변수 */
    var stockcode1 = "";
    var stockcode2 = "";
    var htsid = "";
    //var stockcode4="";

    /* appkey 입력 변수 */
    var g_app_key = "PSvRt9CaHUXBGh3UXCXL0DtUlKOFzzIltpoh";

    /* 개인용 appsecret 입력 변수 */
    var g_appsecret = "Z77UNBioxDkNHE2j7m6W5V8GCUDRgy0FjKi1iThdNgZVG3csVkOQC1RBZknvNKu63h0RBDayA0djOgx8wtVcpgAIhqifsTZvQrGEn5UC0qa+Kj2La9oLKk2TztQatPfKo/pNVQSxah8NHUeT8ETG07umxulItvsxTZ4eMX4AqQyUr5NATsU=";

    /* 법인용 personalseckey 입력 변수 */
    var g_personalseckey = "nKVixJKIVll+Ro8PTPHDVssdCX5Y2zA5fsjhclkjBBgHiHYmNoc3aq36pj61GKMqD2XmEExcXd6siqzJM6w0CmkY9UUwSmmFItBjhQh5EdufRZhCRq80Ld0LeMXqTxUZpcOgkghjp26oDQm4SpSIPzY5LH3ObQH0DTgCPjdS8aNzs88KkUk=";	// 테스트 후 삭제

    var ping = 0;
    var pingpong = 0;	// pingpong count

    /** AES256 DECODE IV, KEY 선언*****/
    var encryptkey = '';
    var iv = '';

    /*** Start    unicode replace step ********************************************************/
    var escapable = /[\x00-\x1f\ud800-\udfff\u200c\u2028-\u202f\u2060-\u206f\ufff0-\uffff]/g;

    function filterUnicode(quoted) {
        escapable.lastIndex = 0;
        if (!escapable.test(quoted)) return quoted;

        return quoted.replace(escapable, function (a) {
            return '';
        });
    }

    /** End of unicode replace step ********************************************************/

    /** start of aes256Decode function **********************/
    function aes256Decode(secretKey, Iv, data) {
        console.log("");
        console.log("[aes256Decode] : [start]");
        console.log("[Key]  : " + secretKey);
        console.log("[Iv]   : " + Iv);
        console.log("[Data] : " + data);

        const cipher = CryptoJS.AES.decrypt(data, CryptoJS.enc.Utf8.parse(secretKey), {
            iv: CryptoJS.enc.Utf8.parse(Iv),
            padding: CryptoJS.pad.Pkcs7,
            mode: CryptoJS.mode.CBC
        });

        aes256DecodeData = cipher.toString(CryptoJS.enc.Utf8);
        console.log("[aes256Decode] : [decode]");
        console.log("[data] : " + aes256DecodeData);
        console.log("");
        return aes256DecodeData;
    };
    /** end of aes256Decode function **********************/

        // output log print

    var log = function (s, f) {
            //console.log(s);
            if (document.readyState !== "complete") {
                log.buffer.push(s);
            } else {
                if (f == 1) {
                    document.getElementById("output").style.fontSize = "12px";
                    document.getElementById("output").innerHTML += (s + "\n");
                } else if (f == 2) {
                    document.getElementById("output_1").style.fontSize = "12px";
                    document.getElementById("output_1").innerHTML += (s + "\n");
                }
            }
        }
    log.buffer = [];

    // output1 log print, color blue, red
    var log1 = function (a, s) {
        console.log(s);
        if (document.readyState !== "complete") {
            log1.buffer.push(s);
        } else {
            document.getElementById("output1").style.fontSize = "12px";
            if (a == "02") {
                document.getElementById("output1").style.color = "red";
            } else if (a == "01") {
                document.getElementById("output1").style.color = "blue";
            }
            document.getElementById("output1").innerHTML += (s + "\n");
        }
    }
    log1.buffer = [];

    var log2 = function (s, f) {
        console.log(s);
        if (document.readyState !== "complete") {
            log2.buffer.push(s);
        } else {
            if (f == 1) {
                document.getElementById("output2").style.fontSize = "12px";
                document.getElementById("output2").innerHTML += (s + "\n");
            } else if (f == 2) {
                document.getElementById("output2_1").style.fontSize = "12px";
                document.getElementById("output2_1").innerHTML += (s + "\n");
            }
        }
    }
    log2.buffer = [];

    var log3 = function (s) {
        console.log(s);
        if (document.readyState !== "complete") {
            log3.buffer.push(s);
        } else {
            document.getElementById("output3").style.fontSize = "12px";
            document.getElementById("output3").innerHTML += (s + "\n");
        }
    }
    log3.buffer = [];

    // ws 접속용 websocket
    try {
        url = "ws://ops.koreainvestment.com:21000";
        //url = "ws://ops.koreainvestment.com:31000";		//모의투자

        w = new WebSocket(url);
    } catch (e) {
        log(e);
    }


    // websocket standby
    w.onopen = function () {
        log3("[Connection OK]");
        log3("[OPS(WebSocket) Test Ready.]");
    }

    // websocket close
    w.onclose = function (e) {
        log3("[CONNECTION CLOSED]");
    }
    w.onmessage = function (e) {
        // unicode 처리
        var recvdata = filterUnicode(e.data);
        console.log(e.data);

        // 첫데이터가 0이나 1일경우 수신된 실시간 데이터 이므로 다음 단계를 통해 처리한다.
        if (recvdata[0] == 0 || recvdata[0] == 1) {
            var strArray = recvdata.split('|');	// 구분자로 문자열 자르기

            var trid = strArray[1];		// Tr ID
            var bodydata = (strArray[3]);	// 수신받은 데이터 중 실시간데이터 부분
            if (trid == "H0STASP0") {
                // bodydata를 이용해 테이블 업데이트
                updateTableWithReceivedData(bodydata);
                strResult = bodydata.split('^');
                updateTableWithReceivedData(strResult);
                updatePrice();  // 여기에서 호출
                console.log("strResult updated:", strResult);
            }

            if (trid == "H0STCNT0") {
                console.log(bodydata);
            }

            {
                /** 암호화된 데이터 처리 Step **/
                if (strArray[0] == 1) {
                    // aes256Decode function 을 사용해 key, iv, 암호화데이터를 넘겨 decode를 한다
                    var decodedata = aes256Decode(encryptkey, iv, bodydata);

                    if (trid == "H0STCNI0" || trid == "H0STCNI9")	// 주식체결통보, 모의투자체결통보 step
                    {
                        var i = 0;
                        var objectlist = "고 객 I D        ,계 좌 번 호      ,주 문 번 호      ,원주문 번 호     ,매도매수 구분    ,정 정 구 분      ,주 문 종 류      ,주 문 조 건      ,주식단축종목코드 ,체 결 수 량      ,체 결 단 가      ,주식체결 시간    ,거 부 여 부      ,체 결 여 부      ,접 수 여 부      ,지 점 번 호      ,주 문 수 량      ,계  좌  명       ,체결  종목명     ,신 용 구 분      ,신용 대출일자    ,체결종목명40     ,주 문 가 격      ";
                        var arrObject = objectlist.split(',');	// 메뉴리스트를 ','으로 잘라서 array 에 할당 한다.
                        var strResult = decodedata.split('^');	// result data 의 구분자가 '^'이므로 해당 값으로 split 한다.
                        document.getElementById("output1").innerHTML = ("");	// output1 screen clear
                        console.log(strResult[4]);
                        log1(strResult[4], "");
                        log1(strResult[4], "");
                        log1(strResult[4], "====================================");
                        for (i = 0; i < strResult.length; i++) {
                            log1(strResult[4], arrObject[i] + "[" + strResult[i] + "]");
                        }
                    }
                } else if (strArray[0] == 0) {	// 암호화 미처리 step
                    if (trid == "H0STASP0") {
                        var strResult = bodydata.split('^');
                        var screenflag = 0;
                        if (stockcode1 == strResult[0]) {
                            screenflag = 1;
                            document.getElementById("output").innerHTML = ("");	// screen clear
                        } else if (stockcode2 == strResult[0]) {
                            screenflag = 2;
                            document.getElementById("output_1").innerHTML = ("");	// screen clear
                        }
                        let tableContent = "<table>";

                        tableContent += "<tr><td>" + strResult[12] + "</td><td>" + strResult[32] + "</td></tr>";
                        tableContent += "<tr><td>" + strResult[11] + "</td><td>" + strResult[31] + "</td></tr>";

                        tableContent += "</table>";

                        log(tableContent, screenflag);


                        log("유가증권 단축 종목코드  [" + strResult[0] + "]", screenflag);
                        log("영업 시간[" + strResult[1] + "]" + "시간 구분 코드[" + strResult[2] + "]", screenflag);
                        log("====================================", screenflag);
                        log("매도호가10[" + strResult[12] + "]" + "     잔량10[" + strResult[32] + "]", screenflag);
                        log("매도호가09[" + strResult[11] + "]" + "     잔량09[" + strResult[31] + "]", screenflag);
                        log("매도호가08[" + strResult[10] + "]" + "     잔량08[" + strResult[30] + "]", screenflag);
                        log("매도호가07[" + strResult[9] + "]" + "     잔량07[" + strResult[29] + "]", screenflag);
                        log("매도호가06[" + strResult[8] + "]" + "     잔량06[" + strResult[28] + "]", screenflag);
                        log("매도호가05[" + strResult[7] + "]" + "     잔량05[" + strResult[27] + "]", screenflag);
                        log("매도호가04[" + strResult[6] + "]" + "     잔량04[" + strResult[26] + "]", screenflag);
                        log("매도호가03[" + strResult[5] + "]" + "     잔량03[" + strResult[25] + "]", screenflag);
                        log("매도호가02[" + strResult[4] + "]" + "     잔량02[" + strResult[24] + "]", screenflag);
                        log("매도호가01[" + strResult[3] + "]" + "     잔량01[" + strResult[23] + "]", screenflag);
                        log("------------------------------------", screenflag);
                        log("매수호가01[" + strResult[13] + "]" + "     잔량01[" + strResult[33] + "]", screenflag);
                        log("매수호가02[" + strResult[14] + "]" + "     잔량02[" + strResult[34] + "]", screenflag);
                        log("매수호가03[" + strResult[15] + "]" + "     잔량03[" + strResult[35] + "]", screenflag);
                        log("매수호가04[" + strResult[16] + "]" + "     잔량04[" + strResult[36] + "]", screenflag);
                        log("매수호가05[" + strResult[17] + "]" + "     잔량05[" + strResult[37] + "]", screenflag);
                        log("매수호가06[" + strResult[18] + "]" + "     잔량06[" + strResult[38] + "]", screenflag);
                        log("매수호가07[" + strResult[19] + "]" + "     잔량07[" + strResult[39] + "]", screenflag);
                        log("매수호가08[" + strResult[20] + "]" + "     잔량08[" + strResult[40] + "]", screenflag);
                        log("매수호가09[" + strResult[21] + "]" + "     잔량09[" + strResult[41] + "]", screenflag);
                        log("매수호가10[" + strResult[22] + "]" + "     잔량10[" + strResult[42] + "]", screenflag);
                        log("====================================", screenflag);
                        log("총매도호가 잔량       [" + strResult[43] + "]", screenflag);
                        log("총매도호가잔량증감    [" + strResult[54] + "]", screenflag);
                        log("총매수호가 잔량       [" + strResult[44] + "]", screenflag);
                        log("총매수호가잔량증감    [" + strResult[55] + "]", screenflag);
                        log("시간외 총매도호가 잔량[" + strResult[45] + "]", screenflag);
                        log("시간외 총매도호가증감 [" + strResult[56] + "]", screenflag);
                        log("시간외 총매수호가 잔량[" + strResult[46] + "]", screenflag);
                        log("시간외 총매수호가증감 [" + strResult[57] + "]", screenflag);
                        log("예상체결가            [" + strResult[47] + "]", screenflag);
                        log("예상체결량            [" + strResult[48] + "]", screenflag);
                        log("예상거래량            [" + strResult[49] + "]", screenflag);
                        log("예상체결 대비         [" + strResult[50] + "]", screenflag);
                        log("부호                  [" + strResult[51] + "]", screenflag);
                        log("예상체결 전일대비율   [" + strResult[52] + "]", screenflag);
                        log("누적거래량            [" + strResult[53] + "]", screenflag);
                        log("주식매매 구분코드     [" + strResult[58] + "]", screenflag);
                    } else if (trid == "H0STCNT0") {	//주식체결가
                        // 주식 체결가 값이름
                        var objectlist = "유가증권단축종목코드       ,주식체결시간               ,주식현재가                 ,전일대비부호               ,전일대비                   ,전일대비율                 ,가중평균주식가격           ,주식시가                   ,주식최고가                 ,주식최저가                 ,매도호가1                  ,매수호가1                  ,체결거래량                 ,누적거래량                 ,누적거래대금               ,매도체결건수               ,매수체결건수               ,순매수 체결건수            ,체결강도                   ,총 매도수량                ,총 매수수량                ,체결구분                   ,매수비율                   ,전일 거래량대비등락율      ,시가시간                   ,시가대비 구분              ,시가대비                   ,최고가 시간                ,고가대비구분               ,고가대비                   ,최저가시간                 ,저가대비구분               ,저가대비                   ,영업일자                   ,신 장운영 구분코드         ,거래정지 여부              ,매도호가잔량               ,매수호가잔량               ,총 매도호가잔량            ,총 매수호가잔량            ,거래량 회전율              ,전일 동시간 누적거래량     ,전일 동시간 누적거래량 비율,시간구분코드               ,임의종료구분코드           ,정적VI발동기준가           ";
                        var strResult = bodydata.split('^');		// 주식체결가 구분값으로 분할해서 array 처리
                        var objectarray = objectlist.split(',');	// objectlist를 구분값으러 분할해서 array처리, 항목명

                        // 어느쪽에 업데이트해야할지 종목코드로 판단한다.
                        if (stockcode1 == strResult[0]) {
                            screenflag = 1;
                            document.getElementById("output2").innerHTML = ("");	// screen clear
                        } else if (stockcode2 == strResult[0]) {
                            screenflag = 2;
                            document.getElementById("output2_1").innerHTML = ("");	// screen clear
                        }

                        var tot_loop_cnt = strArray[2];		// 주식 체결  건수
                        var k = 1;		// 현재 표시 번호
                        log2("주식 체결 건수             [" + "00" + k + "/" + tot_loop_cnt + "]", screenflag);		// 주식체결건수가 있어 모든데이터 활용시 분할해서 처리 필요
                        log2("", screenflag);	// line feed
                        log2("====================================", screenflag);
                        var array_count = strResult.length;			// array 의 총 갯수
                        console.log("array count:" + array_count);
                        var nloopcount = array_count / tot_loop_cnt;	// 1회당 총 출력 개수
                        console.log("objectarray.length:" + objectarray.length);
                        var i = 0;
                        var j = 0;

                        // 체결건수가 1건 이상일 경우도 처리하도록 한다.
                        for (i = 0; i < array_count; i++) {
                            // 항목갯수가 데이터의 1셋트 이므로 출력되는 데이터가 초과되면 데이터 1세트 출력 완료처리.
                            if (j == objectarray.length) {
                                if (stockcode1 == strResult[0]) {
                                    document.getElementById("output2").innerHTML = ("");	// screen clear
                                } else if (stockcode2 == strResult[0]) {
                                    document.getElementById("output2_1").innerHTML = ("");	// screen clear
                                }
                                k += 1;
                                log2("주식 체결 건수             [" + "00" + k + "/" + tot_loop_cnt + "]", screenflag);
                                log2("", screenflag);
                                log2("====================================", screenflag);
                                j = 0;
                            }

                            log2(objectarray[j] + "[" + strResult[i] + "]", screenflag);
                            j++;
                        }
                    }
                }
            }
        } else {
            // 첫데이터가 암호화 구분값이 아닌 데이터는 요청에 대한 응답데이터 이거나 heartbeat 데이터
            console.log("[RECV] < " + "[" + recvdata.length + "] " + recvdata);
            const json = e.data;

            try {
                var obj = JSON.parse(json);
                var trid = obj.header.tr_id;
                var encyn = obj.header.encrypt;
            } catch (e) {
                log3(" ERROR : [" + e + "]");
            }

            // key, iv set step, 들어온 데이터가 parsing 후 trid를 참조하여 전달받은 keyt, iv 값을 사용하기 위한처리, 체결통보의 경우에만 암호화 처리를 하므로 해당 trid만 처리하도록 한다.
            if (trid == 'H0STCNI0' || trid == 'H0STCNI9') {
                var rt_cd = obj.body.rt_cd;
                if (rt_cd == '1') {
                    log3("[RECV] : 주식체결통보 등록요청 실패하였습니다. MSG[" + obj.body.msg1 + "]");
                    alert("주식체결통보 등록초과 입니다.");
                } else {
                    try {
                        encryptkey = obj.body.output.key;
                        iv = obj.body.output.iv;
                        log3("[RECV] : 주식체결통보등록요청 성공하였습니다. (수신KEY [" + encryptkey + "]" + " 수신IV [" + iv + "] )");
                        log3("       : 체결통보 수신시 수신KEY와 수신IV를 참고로 데이터 복호화 처리함.");
                    } catch (e) {
                        log3(" ERROR : [" + e + "]");
                    }
                }
            } else if (trid == "PINGPONG") {		// pingpong step
                ping += 1;
                //pingpong+=1;
                console.log("pingpong [" + pingpong + "]");
                /** pingpond 횟수가 5회 넘어가면 화면 reload 및 console clear 처리를 한다 */
                if (pingpong == 5) {
                    //console.clear();
                    pingpong = 0;
                    //location.reload();
                    document.getElementById("output3").innerHTML = ("");
                }
                log3("[RECV] < " + "[" + recvdata.length + "]" + recvdata + "[" + ping + "]");

                // 수신받은 pingpong 데이터를 send 하기위해 변수에 저장
                var result = e.data;
                /** pingpong send stop **/
                w.send(result);
                log3("[SEND] > " + "[" + result.length + "] " + result);
                pingpong += 1;
            } else if (trid == "H0STCNT0") {	//성공실패 메세지 처리를 한다.
                var rt_cd = obj.body.rt_cd;
                if (obj.body.msg1.includes("UNSUBSCRIBE"))	// 실패일경우 msg영역에 해당 메세지가 존재하므로 구분
                {
                    if (obj.body.msg1.includes("SUCCESS"))
                        log3("[RECV] : 주식체결 등록요청해지 성공하였습니다.");
                    else if (obj.body.msg1.includes("ERROR"))
                        log3("[RECV] : 주식체결 등록요청해지 실패하였습니다. [" + obj.body.msg1 + "]");
                } else if (rt_cd == '1') {
                    log3("[RECV] : 주식체결 등록요청 실패하하였습니다. MSG[" + obj.body.msg1 + "]");
                    alert("주식체결 등록초과 입니다.");
                } else {
                    log3("[RECV] : 주식체결 등록요청 성공하였습니다.");
                }
            } else if (trid == "H0STASP0") {
                var rt_cd = obj.body.rt_cd;
                if (obj.body.msg1.includes("UNSUBSCRIBE")) {
                    if (obj.body.msg1.includes("SUCCESS"))
                        log3("[RECV] : 주식호가 등록요청해지 성공하였습니다.");
                    else if (rt_cd == '1')
                        log3("[RECV] : 주식호가 등록요청해지 실패하였습니다. [" + obj.body.msg1 + "]");
                } else if (obj.body.msg1.includes("MAX SUBSCRIBE OVER")) {
                    log3("[RECV] : 주식호가 등록요청 실패하하였습니다. MSG[" + obj.body.msg1 + "]");
                    alert("주식호가 등록초과 입니다.");
                } else {
                    log3("[RECV] : 주식호가 등록요청 성공하였습니다.");
                }
            }
            document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
        }
    }


    window.onload = function () {
        // 주식호가 등록 버튼 처리
        document.getElementById("hokaregButton1").onclick = function () {
            // "inputMessage1" textbox 에서 종목코드를 넘겨받아 주식호가 등록을 위한 json 데이터를 조립한다.
            var stockcode_tmp = document.getElementById("inputMessage1").value;

            stockcode1 = stockcode_tmp;
            // 주식호가 등록용 json 데이터를 만드는 부분
            var result = '{"header": {"authoriztion":"","appkey":"' + g_app_key + '","appsecret":"' + g_appsecret + '","personalseckey":"' + g_personalseckey + '","custtype":"P","tr_type":"1","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STASP0","tr_key":"' + stockcode1 + '"}}}';

            // top align 의 info 영역에 처리결과를 출력한다.
            log3("[SEND] : 주식호가1등록요청");
            console.log("[SEND] > [" + result.length + "] " + result);
            try {
                // 만들어진 json 데이터를 websocket으로 전송한다.
                w.send(result);
            } catch (e) {
                log3(e);
            }

            // info 영역에 스크롤을 맨 아래쪽으로 옮긴다.
            document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
        }

        // 주식호가 등록해제1 버튼 처리
        document.getElementById("hokaderegButton1").onclick = function () {
            // textbox 에서 종목코드를 가져온다.
            stockcode1 = document.getElementById("inputMessage1").value;
            // 전송 데이터를 생성하는 부분.
            var result = '{"header": {"authoriztion":"","appkey":"' + g_app_key + '","appsecret":"' + g_appsecret + '","personalseckey":"' + g_personalseckey + '","custtype":"P","tr_type":"2","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STASP0","tr_key":"' + stockcode1 + '"}}}';

            stockcode1 = ""
            // info 영역에 처리결과를 출력한다.
            log3("[SEND] : 주식호가1등록해지요청");
            console.log("[SEND] > [" + result.length + "] " + result);
            try {
                // 완성된 json 데이터를 연결된 websocket 세션으로 전송한다.
                w.send(result);
            } catch (e) {
                log3(e);
            }
            // info 영역에 스크롤을 맨 아래쪽으로 옮긴다.
            document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
        }

        // 주식호가 등록2 버튼 처리
        document.getElementById("hokaregButton2").onclick = function () {
            var stockcode_tmp = document.getElementById("inputMessage2").value;
            if (stockcode_tmp == stockcode2 || stockcode_tmp == stockcode1) {
                alert("이미 등록된 종목코드 입니다.");
            } else {
                stockcode2 = stockcode_tmp;
                //var result = '{"header": {"authoriztion":"","appkey":"wl1mBQKsyN3qc5/PTz5uzZTstE5QBphf8T9inn2Y4SVL1IbqweI/cJWYm0ebQJ3f","appsecret":"s8w9coyUrF/4NjCrj2LKI5jPCqpXRbyC4L1ayKaDxRLILyZDd8e81BDxQOtTlWq4F23HFN838PZ2IHxbv2CkAA0mZ6JZDiAp1WGGG/JAdx5VtbiXFe3GDPL/2rWraUXvmWpX1qsgLgoQRlD9nxirn4DihMdJJKMo2Kp55/cqncfkJEt5ECk=","personalseckey":"s8w9coyUrF/4NjCrj2LKI5jPCqpXRbyC4L1ayKaDxRLILyZDd8e81BDxQOtTlWq4F23HFN838PZ2IHxbv2CkAA0mZ6JZDiAp1WGGG/JAdx5VtbiXFe3GDPL/2rWraUXvmWpX1qsgLgoQRlD9nxirn4DihMdJJKMo2Kp55/cqncfkJEt5ECk=","custtype":"P","tr_type":"1","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STASP0","tr_key":"005930"}}}';
                var result = '{"header": {"authoriztion":"","appkey":"' + g_app_key + '","appsecret":"' + g_appsecret + '","personalseckey":"' + g_personalseckey + '","custtype":"P","tr_type":"1","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STASP0","tr_key":"' + stockcode2 + '"}}}';

                log3("[SEND] : 주식호가2등록요청");
                console.log("[SEND] > [" + result.length + "] " + result);
                try {
                    w.send(result);
                } catch (e) {
                    log3(e);
                }
            }
            document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
        }

        // 주식호가 등록해제2 버튼 처리
        document.getElementById("hokaderegButton2").onclick = function () {
            stockcode2 = document.getElementById("inputMessage2").value;
            var result = '{"header": {"authoriztion":"","appkey":"' + g_app_key + '","appsecret":"' + g_appsecret + '","personalseckey":"' + g_personalseckey + '","custtype":"P","tr_type":"2","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STASP0","tr_key":"' + stockcode2 + '"}}}';

            stockcode2 = ""
            log3("[SEND] : 주식호가2등록해지요청");
            console.log("[SEND] > [" + result.length + "] " + result);
            try {
                w.send(result);
            } catch (e) {
                log3(e);
            }
            document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
        }


        // 주식체결1 등록 버튼 처리
        document.getElementById("bidregButton1").onclick = function () {
            // textbox 에서 종목코드를 가져온다.
            stockcode1 = document.getElementById("inputMessage1").value;
            // 전송할 json 데이터를 완성하는 부분
            var result = '{"header":{"authoriztion":"","appkey":"' + g_app_key + '","appsecret":"' + g_appsecret + '","personalseckey":"' + g_personalseckey + '","custtype":"P","tr_type":"1","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STCNT0","tr_key":"' + stockcode1 + '"}}}';

            // info 영역에 처리결과 출력
            log3("[SEND] : 주식체결등록요청");
            console.log("[SEND] > [" + result.length + "] " + result);
            try {
                // 완성된 json을 연결된 세션으로 전송한다.
                w.send(result);
            } catch (e) {
                log3(e);
            }
            // info 영역에 스크롤을 맨 아래로 이동한다.
            document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
        }

        // 주식체결1 등록해제 버튼 처리
        document.getElementById("bidderegButton1").onclick = function () {
            // textbox 에서 종목코드를 가져온다.
            stockcode1 = document.getElementById("inputMessage1").value;
            // 전송할 json 을 완성하는 부분
            var result = '{"header":{"authoriztion":"","appkey":"' + g_app_key + '","appsecret":"' + g_appsecret + '","personalseckey":"' + g_personalseckey + '","custtype":"P","tr_type":"2","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STCNT0","tr_key":"' + stockcode1 + '"}}}';

            // info 영역에 처리결과 출력.
            log3("[SEND] : 주식체결등록해지요청");
            stockcode1 = "";
            console.log("[SEND] > [" + result.length + "] " + result);
            try {
                // 완성된 json을 연결된 세션으로 전송한다.
                w.send(result);
            } catch (e) {
                log3(e);
            }
            // info 영역에 스크롤을 맨 아래로 이동한다.
            document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
        }

        // 주식체결2 등록 버튼 처리
        document.getElementById("bidregButton2").onclick = function () {
            stockcode2 = document.getElementById("inputMessage2").value;
            var result = '{"header":{"authoriztion":"","appkey":"' + g_app_key + '","appsecret":"' + g_appsecret + '","personalseckey":"' + g_personalseckey + '","custtype":"P","tr_type":"1","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STCNT0","tr_key":"' + stockcode2 + '"}}}';

            log3("[SEND] : 주식체결등록요청");
            console.log("[SEND] > [" + result.length + "] " + result);
            try {
                w.send(result);
            } catch (e) {
                log3(e);
            }
            document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
        }

        // 주식체결2 등록해제 버튼 처리
        document.getElementById("bidderegButton2").onclick = function () {
            stockcode2 = document.getElementById("inputMessage2").value;
            var result = '{"header":{"authoriztion":"","appkey":"' + g_app_key + '","appsecret":"' + g_appsecret + '","personalseckey":"' + g_personalseckey + '","custtype":"P","tr_type":"2","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STCNT0","tr_key":"' + stockcode2 + '"}}}';


            log3("[SEND] : 주식체결등록해지요청");
            console.log("[SEND] > [" + result.length + "] " + result);
            stockcode2 = "";
            try {
                w.send(result);
            } catch (e) {
                log3(e);
            }
            document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
        }

        // 주식체결통보 등록 버튼 처리
        document.getElementById("bidalamButton").onclick = function () {
            // textbox 에서 종목코드를 가져온다.
            htsid = document.getElementById("inputMessage_id").value;
            // 전송할 json 데이터를 완성한다.
            var result = '{"header": {"authoriztion":"","appkey":"' + g_app_key + '","appsecret":"' + g_appsecret + '","personalseckey":"' + g_personalseckey + '","custtype":"P","tr_type":"1","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STCNI0","tr_key":"' + htsid + '"}}}';

            // info 영역에 처리결과를 출력한다.
            log3("[SEND] : HTSID[" + htsid + "] 주식체결통보등록요청");
            console.log("[SEND] > [" + result.length + "] " + result);
            try {
                // 완성된 json을 연결된 세션으로 전송한다.
                w.send(result);
            } catch (e) {
                log3(e);
            }
            // info 영역에 스크롤을 맨 아래로 이동한다.
            document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
        }

        // 주식체결통보 등록해제 버튼 처리
        document.getElementById("xbidalamButton").onclick = function () {
            // textbox 에서 종목코드를 가져온다.
            htsid = document.getElementById("inputMessage_id").value;

            // 전송할 json 데이터를 완성한다.
            var result = '{"header": {"authoriztion":"","appkey":"' + g_app_key + '","appsecret":"' + g_appsecret + '","personalseckey":"' + g_personalseckey + '","custtype":"P","tr_type":"2","content-type":"utf-8"},"body": {"input": {"tr_id":"H0STCNI0","tr_key":"' + htsid + '"}}}';

            // info 영역에 처리결과를 출력한다.
            log3("[SEND] : HTSID[" + htsid + "] 주식체결등록통보해지요청");
            htsid = '';
            console.log("[SEND] > [" + result.length + "] " + result);
            try {
                // 완성된 json을 연결된 세션으로 전송한다.
                w.send(result);
            } catch (e) {
                log3(e);
            }
            // info 영역에 스크롤을 맨 아래로 이동한다.
            document.getElementById("output3").scrollTop = document.getElementById("output3").scrollHeight;
        }

        // 웹소켓 연결 해제 버튼 처리
        document.getElementById("closeButton").onclick = function () {
            w.close();
        }

        // 에러 메세지 처리
        w.onerror = function (e) {
            log3(e);
        }
    }

    function updateTableWithReceivedData(strResult) {
        const tableArea = document.getElementById("outputTableArea");

        let tableHTML =
            "<table class='myTable'>" +
            "<tr>" +
            "<th>호가</th>" +
            "<th>가격</th>" +
            "<th>잔량</th>" +
            "<th>수량</th>" +
            "</tr>" +
            // "<tr><td>유가증권 단축 종목코드</td><td>" + strResult[0] + "</td></tr>" +
            // "<tr><td>영업 시간</td><td>" + strResult[1] + "</td></tr>" +
            // "<tr><td>시간 구분 코드</td><td>" + strResult[2] + "</td></tr>" +
            "<tr><td class='sell'>매도호가10</td><td>" + strResult[12] + "</td><td>잔량10</td><td>" + strResult[32] + "</td></tr>" +
            "<tr><td class='sell'>매도호가09</td><td>" + strResult[11] + "</td><td>잔량09</td><td>" + strResult[31] + "</td></tr>" +
            "<tr><td class='sell'>매도호가08</td><td>" + strResult[10] + "</td><td>잔량08</td><td>" + strResult[30] + "</td></tr>" +
            "<tr><td class='sell'>매도호가07</td><td>" + strResult[9] + "</td><td>잔량07</td><td>" + strResult[29] + "</td></tr>" +
            "<tr><td class='sell'>매도호가06</td><td>" + strResult[8] + "</td><td>잔량06</td><td>" + strResult[28] + "</td></tr>" +
            "<tr><td class='sell'>매도호가05</td><td>" + strResult[7] + "</td><td>잔량05</td><td>" + strResult[27] + "</td></tr>" +
            "<tr><td class='sell'>매도호가04</td><td>" + strResult[6] + "</td><td>잔량04</td><td>" + strResult[26] + "</td></tr>" +
            "<tr><td class='sell'>매도호가03</td><td>" + strResult[5] + "</td><td>잔량03</td><td>" + strResult[25] + "</td></tr>" +
            "<tr><td class='sell'>매도호가02</td><td>" + strResult[4] + "</td><td>잔량02</td><td>" + strResult[24] + "</td></tr>" +
            "<tr><td class='sell'>매도호가01</td><td id='sell-price-value'>" + strResult[3] + "</td><td>잔량01</td><td>" + strResult[23] + "</td></tr>" +
            "<tr><td class='buy'>매수호가01</td><td id='buy-price-value'>" + strResult[13] + "</td><td>잔량01</td><td>" + strResult[33] + "</td></tr>" +
            "<tr><td class='buy'>매수호가02</td><td >" + strResult[14] + "</td><td>잔량02</td><td>" + strResult[34] + "</td></tr>" +
            "<tr><td class='buy'>매수호가03</td><td>" + strResult[15] + "</td><td>잔량03</td><td>" + strResult[35] + "</td></tr>" +
            "<tr><td class='buy'>매수호가04</td><td>" + strResult[16] + "</td><td>잔량04</td><td>" + strResult[36] + "</td></tr>" +
            "<tr><td class='buy'>매수호가05</td><td>" + strResult[17] + "</td><td>잔량05</td><td>" + strResult[37] + "</td></tr>" +
            "<tr><td class='buy'>매수호가06</td><td>" + strResult[18] + "</td><td>잔량06</td><td>" + strResult[38] + "</td></tr>" +
            "<tr><td class='buy'>매수호가07</td><td>" + strResult[19] + "</td><td>잔량07</td><td>" + strResult[39] + "</td></tr>" +
            "<tr><td class='buy'>매수호가08</td><td>" + strResult[20] + "</td><td>잔량08</td><td>" + strResult[40] + "</td></tr>" +
            "<tr><td class='buy'>매수호가09</td><td>" + strResult[21] + "</td><td>잔량09</td><td>" + strResult[41] + "</td></tr>" +
            "<tr><td class='buy'>매수호가10</td><td>" + strResult[22] + "</td><td>잔량10</td><td>" + strResult[42] + "</td></tr>" +
            // "<tr><td>총매도호가 잔량</td><td>" + strResult[43] + "</td></tr>" +
            // "<tr><td>총매도호가잔량증감</td><td>" + strResult[54] + "</td></tr>" +
            // "<tr><td>총매수호가 잔량</td><td>" + strResult[44] + "</td></tr>" +
            // "<tr><td>총매수호가잔량증감</td><td>" + strResult[55] + "</td></tr>" +
            // "<tr><td>시간외 총매도호가 잔량</td><td>" + strResult[45] + "</td></tr>" +
            // "<tr><td>시간외 총매도호가증감</td><td>" + strResult[56] + "</td></tr>" +
            // "<tr><td>시간외 총매수호가 잔량</td><td>" + strResult[46] + "</td></tr>" +
            // "<tr><td>시간외 총매수호가증감</td><td>" + strResult[57] + "</td></tr>" +
            // "<tr><td>예상체결가</td><td>" + strResult[47] + "</td></tr>" +
            // "<tr><td>예상체결량</td><td>" + strResult[48] + "</td></tr>" +
            // "<tr><td>예상거래량</td><td>" + strResult[49] + "</td></tr>" +
            // "<tr><td>예상체결 대비</td><td>" + strResult[50] + "</td></tr>" +
            // "<tr><td>부호</td><td>" + strResult[51] + "</td></tr>" +
            // "<tr><td>예상체결 전일대비율</td><td>" + strResult[52] + "</td></tr>" +
            // "<tr><td>누적거래량</td><td>" + strResult[53] + "</td></tr>" +
            // "<tr><td>주식매매 구분코드</td><td>" + strResult[58] + "</td></tr>" +
            "</table>";

        tableArea.innerHTML = tableHTML;
    }

</script>
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
        justify-content: center;
        width: 1440px;
        overflow-y: auto;
        flex-direction: column;
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

    .contents-top {
        display: flex;
        flex-direction: row;
        width: 1440px;
    }

    .contents-middle {
        display: flex;
        width: 1440px;
        height: 600px;
    }

    .index-left {
        width: 700px;
        height: 800px;
        overflow-y: auto; /* 스크롤 설정 */
        /*border: 1px solid black;*/
    }

    .index-middle {
        width: 480px;
        height: 800px;
        overflow-y: auto; /* 스크롤 설정 */
        /*border: 1px solid black;*/
    }

    .index-right {
        width: 480px;

        overflow-y: auto; /* 스크롤 설정 */
        /*border: 1px solid black;*/
    }

    /*.index-left {*/
    /*    margin-right: 20px; !* 오른쪽 여백 추가 *!*/
    /*}*/

    .market, .industry, .jogun, .suljeong, .rebal, .result, .nobuy {
        height: 80px;
        background-color: #ccc; /* 회색으로 설정 */
        border-radius: 20px;
        display: flex;
        align-items: center; /* 텍스트를 중앙에 위치 */
        padding-left: 15px; /* 텍스트에 약간의 패딩 추가 */
    }

    .market {
        flex-direction: row;
        justify-content: space-between;
    }

    .md-mobile-picker-header {
        font-size: 14px;
    }

    input.md-mobile-picker-input {
        color: initial;
        width: 100%;
        padding: 10px;
        margin: 6px 0 12px 0;
        border: 1px solid #ccc;
        border-radius: 0;
        font-family: arial, verdana, sans-serif;
        font-size: 14px;
        box-sizing: border-box;
        -webkit-appearance: none;
    }


    /*modal*/
    .modal {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%); /* Center the modal */
        background-color: #ffffff; /* Modal background color */
        border-radius: 8px; /* Optional: Rounded corners */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Optional: Shadow for a bit of depth */
        overflow: auto; /* Enables scroll if the content is larger than the modal */
        align-items: center;
        justify-content: center;
        z-index: 1;
        width: 600px;
        height: 400px;
    }

    .modal-content {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        font-family: "하나2.0 B";
        font-size: 15px;
    }

    #modal-stock-info {
        font-size: 20px;
        color: #0B9B97;
    }

    #modal-buy-total {
        font-size: 20px;
        color: #E90061;
    }

    #result-stock-info {
        font-size: 20px;
        color: #0B9B97;
    }

    #result-buy-total {
        font-size: 20px;
        color: #E90061;
    }


    .modal-button {
        width: 400px;
        display: flex;
        flex-direction: row;
        justify-content: space-evenly;
        align-items: center;
    }


    .button1 {
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
    }

    .button1:hover {
        background-color: #009B84; /* 다른 버튼의 hover 시 배경색 변경 */
    }

    .button2 {
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
        text-decoration: none;
    }

    .button2:hover {
        background-color: #AAAAAA; /* 다른 버튼의 hover 시 배경색 변경 */
    }

    /* 매수일 때의 스타일 */
    .tab-link[data-tab="tab-buy"].active {
        background-color: red;
        color: white;
    }

    /* 매도일 때의 스타일 */
    .tab-link[data-tab="tab-sell"].active {
        background-color: blue;
        color: white;
    }

</style>


<!-- 화면분할을 위한 div 처리 -->
<!-- output3, command box -->
<div style="background-color:#EEEEEE">
    <pre id="output3" style="width: 100%; height: 10%; overflow: auto; display: none"></pre>
</div>


<%@ include file="header.jsp" %>
<div class="wrap">
    <div class="contents-header">
        <div>
            실시간 차트
        </div>
        <div class="header-button">
            <a href="/portfolios" class="indexing-button">다른 포트폴리오</a>
            <a href="/jamoon" class="portfolio-button">
                <img src="img/graphanimation.gif">
                자문계약 맺기
            </a>
        </div>
    </div>
    <div class="contents">
        <div class="contents-top">
            <div class="index-left">
                <div class="left">
                    <input type="text" id="inputMessage1" style="width: 100px; height: 20px" placeholder="코드 입력">
                    <img id="hokaregButton1" src="img/search.png" alt="주식호가"
                         style="width: 20px; height: 20px; cursor: pointer;">
                    <br>
                </div>
                <button id="hokaderegButton1" style="width: 100px; height: 20px; font-size: 12px; display: none;">주식호가해제</button>
                <div>
                    <table id="stockTable" border="1">
                        <thead>
                        <tr>
                            <th>포트폴리오</th>
                            <th>아이템 번호</th>
                            <th>시장</th>
                            <th>종목코드</th>
                            <th>종목명</th>
                            <th>비중</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${items}">
                            <tr data-ticker="${item.ticker}">
                                <td data-th="포트폴리오 번호" data-type="portfolioId">${item.portfolioId}</td>
                                <td data-th="아이템 번호" data-type="itemId">${item.itemId}</td>
                                <td data-th="시장" data-type="market">${item.market}</td>
                                <td data-th="종목코드" data-type="ticker">${item.ticker}</td>
                                <td data-th="종목명" data-type="stockname">${item.stockname}</td>
                                <td data-th="비중" data-type="weight">${item.weight}%</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div id="pagination">
                        <button onclick="changePage(-1)">이전</button>
                        <span id="currentPage">1</span> / <span id="totalPages"></span>
                        <button onclick="changePage(1)">다음</button>
                    </div>
                </div>
            </div>
            <div class="index-middle">
                <div class="table-header"></div>
                <div id="outputTableArea"></div>
            </div>
            <div class="index-right">
                <!-- Stock Info -->
                <div id="stock-info">
                    <h3>시장: <span id="stock-market"></span></h3>
                    <h4>종목코드: <span id="stock-ticker"></span></h4>
                    <p>종목명: <span id="stock-name"></span></p>

                </div>

                <!-- Tabs -->
                <ul class="tabs">
                    <li class="tab-link active" data-tab="tab-buy">매수</li>
                    <li class="tab-link" data-tab="tab-sell">매도</li>
                </ul>

                <!-- Tab Contents -->
                <div id="tab-buy" class="tab-content active">
                    <div class="tab-content-item">
                        <label>단가: <input type="number" id="buy-price" readonly></label>
                    </div>
                    <div class="tab-content-item">
                        <label>수량: <input type="number" id="buy-quantity"></label>
                    </div>
                    <div class="tab-content-item">
                        <p>총 금액: <span id="buy-total"></span></p>
                    </div>
                    <div class="tab-content-item">
                        <button class= "button1" onclick="preBuyStock()" style="background-color: #E90061; font-size: 14px">구매</button>
                    </div>
                </div>

                <div id="tab-sell" class="tab-content">
                    <div class="tab-content-item">
                        <label>단가: <input type="number" id="sell-price" readonly></label>
                    </div>
                    <div class="tab-content-item">
                        <label>수량: <input type="number" id="sell-quantity"></label>
                    </div>
                    <div class="tab-content-item">
                        <p>총 금액: <span id="sell-total"></span></p>
                    </div>
                    <div class="tab-content-item">
                        <button onclick="preSellStock()">매도</button>
                    </div>
                </div>

                <!-- Accounts Table -->
                <h2>나의 계좌</h2>

                <!-- Account Dropdown -->
                <select id="account-selection" onchange="showAccountDetails()">
                    <!-- Account options will be populated here -->
                </select>

                <!-- Account Details Section -->
                <div id="account-details">
                    <p><strong>계좌명: </strong><span id="detail-accountName"></span></p>
                    <p><strong>잔액: </strong><span id="detail-deposit"></span></p>
                </div>
            </div>
            <!-- .index-right 바로 밑에 추가 -->
            <div id="confirmModal" class="modal">
                <div class="modal-content">
                    <div id="modal-stock-info">
                        <h3>시장: <span id="modal-stock-market"></span></h3>
                        <h4>종목코드: <span id="modal-stock-ticker"></span></h4>
                        <p>종목명: <span id="modal-stock-name"></span></p>
                    </div>
                    <div id="modal-buy-content">
                        <div class="tab-content-item">
                            <label>단가: <span id="modal-buy-price"></span></label>
                        </div>
                        <div class="tab-content-item">
                            <label>수량: <span id="modal-buy-quantity"></span></label>
                        </div>
                        <div class="tab-content-item">
                            <p>총 금액: <span id="modal-buy-total"></span></p>
                        </div>
                    </div>
                    <p id="confirmMessage"></p>
                    <div class="modal-button">
                        <button class="button1" onclick="processOrder()">예</button>
                        <button class="button2" onclick="closeModal()">아니오</button>
                    </div>
                </div>
            </div>
            <!-- .index-right 바로 밑에 추가 -->
            <div id="resultModal" class="modal">
                <div class="modal-content">
                    <div id="result-stock-info">
                        <h3>시장: <span id="result-stock-market"></span></h3>
                        <h4>종목코드: <span id="result-stock-ticker"></span></h4>
                        <p>종목명: <span id="result-stock-name"></span></p>
                    </div>
                    <div id="result-buy-content">
                        <div class="tab-content-item">
                            <label>단가: <span id="result-buy-price"></span></label>
                        </div>
                        <div class="tab-content-item">
                            <label>수량: <span id="result-buy-quantity"></span></label>
                        </div>
                        <div class="tab-content-item">
                            <p>총 금액: <span id="result-buy-total"></span></p>
                        </div>
                    </div>
                    <p>처리 되었습니다.</p>
                    <div class="modal-button">
                        <button class="button2" onclick
                                ="closeResultModal()">닫기
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="contents-middle">
            <!-- TradingView Widget BEGIN -->
            <div class="tradingview-widget-container">
                <div id="tradingview_3b078"></div>
                <div class="tradingview-widget-copyright"><a href="https://kr.tradingview.com/"
                                                             rel="noopener nofollow" target="_blank">
                    <%--                        <span class="blue-text">트레이딩뷰에서 모든 시장 추적</span>--%>
                </a></div>
                <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
                <script type="text/javascript">
                    new TradingView.widget(
                        {
                            "width": 1400,
                            "height": 610,
                            "symbol": "005930",
                            "interval": "D",
                            "timezone": "Etc/UTC",
                            "theme": "light",
                            "style": "1",
                            "locale": "kr",
                            "enable_publishing": false,
                            "allow_symbol_change": true,
                            "container_id": "tradingview_3b078"
                        }
                    );
                </script>
            </div>
            <!-- TradingView Widget END -->
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>


<script>
    let price;
    let quantity;
    let market;
    let ticker;
    let stockname;
    let currentUserId = '<%= request.getSession().getAttribute("userId") %>';

    function getSessionUserId() {
        console.log("Current Session UserId:", currentUserId);
        return currentUserId;
    }

    document.addEventListener('DOMContentLoaded', function () {
        const userId = getSessionUserId();
        if (userId) {
            fetchAccountInfoByUserId(userId);
        } else {
            console.error("No userId found in session.");
        }
    });

    function getSelectedAccountId() {
        const selectedAccount = document.getElementById("account-selection").value;
        if (selectedAccount) {
            const accountData = JSON.parse(selectedAccount);
            return accountData.id; // 또는 accountData.accountId 등 계좌 ID를 나타내는 필드명
        }
        return null;
    }

    window.addEventListener('load', function () {
        const inputField = document.getElementById('inputMessage1');

        // 페이지가 로딩될 때 inputMessage1에 005930 설정 및 hokaregButton1 클릭 이벤트 수행
        inputField.value = "005930";
        document.getElementById("hokaregButton1").click();

        // 각 행을 클릭할 때의 이벤트
        document.querySelectorAll('tr[data-ticker]').forEach(function (row) {
            row.addEventListener('click', function () {
                // 현재 활성화된 ticker 가져오기
                const currentTicker = inputField.value;

                // 현재 ticker로 deregister
                inputField.value = currentTicker;
                document.getElementById("hokaderegButton1").click();

                // 새로운 ticker 값으로 inputField 업데이트
                const newTicker = this.getAttribute('data-ticker');
                inputField.value = newTicker;

                // 새 ticker로 register
                document.getElementById("hokaregButton1").click();

                // TradingView 위젯 로드
                loadTradingViewWidget(newTicker);
            });
        });
    });


    document.getElementById('inputMessage1').addEventListener('keyup', function (event) {
        if (event.key === 'Enter' || event.keyCode === 13) {
            const symbolValue = event.target.value;
            console.log(`검색어: ${symbolValue}`);

            // TradingView 위젯 갱신
            loadTradingViewWidget(symbolValue);
        }
    });

    function loadTradingViewWidget(symbolValue) {
        // 기존 위젯을 제거
        const container = document.getElementById('tradingview_3b078');
        container.innerHTML = '';

        new TradingView.widget(
            {
                "width": 980,
                "height": 610,
                "symbol": symbolValue,
                "interval": "D",
                "timezone": "Etc/UTC",
                "theme": "light",
                "style": "1",
                "locale": "kr",
                "enable_publishing": false,
                "allow_symbol_change": true,
                "container_id": "tradingview_3b078"
            }
        );
    }

    // 초기 로딩 시 기본 값으로 위젯 로드
    loadTradingViewWidget("005930");
    // 매수매도 부분
    // 전역 변수로 portfolioId와 itemId 선언

    let portfolioId;
    let itemId;

    //단가 업데이트
    function updatePrice() {
        const buyPriceInput = document.getElementById("buy-price");
        const sellPriceInput = document.getElementById("sell-price");
        const sellPriceValueElem = document.getElementById("sell-price-value");
        const buyPriceValueElem = document.getElementById("buy-price-value");

        if (sellPriceValueElem && buyPriceValueElem) {
            const sellPriceValue = sellPriceValueElem.innerText;
            const buyPriceValue = buyPriceValueElem.innerText;

            buyPriceInput.value = buyPriceValue;
            sellPriceInput.value = sellPriceValue;
        }
    }

    // 행을 클릭했을 때
    document.querySelector("table").addEventListener("click", function (e) {
        if (e.target.tagName === "TD") {
            const row = e.target.parentNode;
            document.getElementById("stock-market").innerText = row.querySelector("[data-type='market']").innerText;
            document.getElementById("stock-ticker").innerText = row.querySelector("[data-type='ticker']").innerText;
            document.getElementById("stock-name").innerText = row.querySelector("[data-type='stockname']").innerText;

            // 여기에 portfolio_id와 item_id를 가져오는 코드를 추가
            portfolioId = row.querySelector("[data-type='portfolioId']").innerText;
            itemId = row.querySelector("[data-type='itemId']").innerText;

            updatePrice();  // 여기에서 호출
        }
    });

    //탭 기능
    const tabLinks = document.querySelectorAll(".tab-link");
    const tabContents = document.querySelectorAll(".tab-content");

    tabLinks.forEach(function (tab) {
        tab.addEventListener("click", function () {
            const targetTab = this.getAttribute("data-tab");

            // 모든 탭의 active 상태를 제거
            tabLinks.forEach(function (innerTab) {
                innerTab.classList.remove("active");
            });
            tabContents.forEach(function (content) {
                content.classList.remove("active");
            });

            // 선택한 탭과 내용에 active 클래스 추가
            this.classList.add("active");
            document.getElementById(targetTab).classList.add("active");

            const buyPriceInput = document.getElementById("buy-price");
            const sellPriceInput = document.getElementById("sell-price");

            // outputTableArea에서 값을 가져옵니다.
            const sellPriceValueElem = document.getElementById("sell-price-value");
            const buyPriceValueElem = document.getElementById("buy-price-value");

            if (sellPriceValueElem && buyPriceValueElem) {
                const sellPriceValue = sellPriceValueElem.innerText;
                const buyPriceValue = buyPriceValueElem.innerText;

                if (targetTab === "tab-buy") {
                    buyPriceInput.value = buyPriceValue;
                } else if (targetTab === "tab-sell") {
                    sellPriceInput.value = sellPriceValue;
                }
            }
        });
    });

    // // 매수매도 부분
    // // 행을 클릭했을 때
    // // 전역 변수로 portfolioId와 itemId 선언
    // let portfolioId;
    // let itemId;
    //
    // //탭 기능
    // const tabLinks = document.querySelectorAll(".tab-link");
    // const tabContents = document.querySelectorAll(".tab-content");
    //
    // tabLinks.forEach(function (tab) {
    //     tab.addEventListener("click", function () {
    //         const targetTab = this.getAttribute("data-tab");
    //
    //         // 모든 탭의 active 상태를 제거
    //         tabLinks.forEach(function (innerTab) {
    //             innerTab.classList.remove("active");
    //         });
    //         tabContents.forEach(function (content) {
    //             content.classList.remove("active");
    //         });
    //
    //         // 선택한 탭과 내용에 active     클래스 추가
    //         this.classList.add("active");
    //         document.getElementById(targetTab).classList.add("active");
    //     });
    // });


    // document.addEventListener('DOMContentLoaded', function () {
    //     const rows = document.querySelectorAll("#outputTableArea table tr");
    //
    //     rows.forEach(row => {
    //         row.addEventListener('click', function () {
    //             const tickerCell = row.querySelector("[data-type='ticker']");
    //             console.log(rows);
    //
    //             if (tickerCell) {
    //                 const tickerValue = tickerCell.textContent;
    //
    //                 // 웹소켓에서 값을 가져오는 코드 (이 부분은 웹소켓 구현에 따라 다를 수 있습니다)
    //                 // 여기서는 가정으로 strResult 배열을 사용합니다.
    //                 document.getElementById("buy-price").value = document.getElementById("sell-buy-value");
    //                 document.getElementById("sell-price").value = document.getElementById("sell-price-value");
    //             }
    //         });
    //     });
    // });


    document.getElementById('buy-quantity').addEventListener('input', function () {
        calculateTotal('buy');
    });

    document.getElementById('sell-quantity').addEventListener('input', function () {
        calculateTotal('sell');
    });


    function calculateTotal(type) {
        const priceElement = document.getElementById(type + "-price");
        const quantityElement = document.getElementById(type + "-quantity");

        if (!priceElement || !quantityElement) {
            console.error('Element not found:', type);
            return;
        }

        const price = Number(priceElement.value);
        const quantity = Number(quantityElement.value);
        const total = price * quantity;
        document.getElementById(type + "-total").innerText = total.toLocaleString();
    }


    //계좌 시발

    function fetchAccountInfoByUserId(userId) {
        $.ajax({
            url: `/user/${userId}`,
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                console.log("Fetched accounts:", data);

                const accountDropdown = $("#account-selection");
                accountDropdown.empty();

                data.forEach(account => {
                    let option = $("<option></option>").attr("value", JSON.stringify(account)).text(account.accountNumber);
                    accountDropdown.append(option);
                });

                // 첫 번째 계좌의 상세 정보를 로드
                if (data && data.length > 0) {
                    showAccountDetails(data[0]);
                }
            },
            error: function (error) {
                console.error("Error fetching account data:", error);
            }
        });
    }

    function showAccountDetails() {
        const selectedOption = $("#account-selection option:selected");
        const account = JSON.parse(selectedOption.val());

        $("#detail-accountName").text(account.accountName || 'N/A');
        $("#detail-deposit").text(formatNumberWithCommas(account.deposit) || 'N/A');
    }

    function formatNumberWithCommas(x) {
        if (typeof x === 'undefined' || x === null) return '';
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }


    // document.addEventListener('DOMContentLoaded', function () {
    //     fetchAccountInfoByUserId("hana1");
    // });


    //주문

    // 주문 데이터 생성 함수
    function generateOrderData(type) {
        price = parseFloat(document.getElementById(type + "-price").value);
        quantity = parseInt(document.getElementById(type + "-quantity").value);
        market = document.getElementById("stock-market").innerText;
        ticker = document.getElementById("stock-ticker").innerText;
        stockname = document.getElementById("stock-name").innerText;

        let orderTypeValue;
        if (type === "buy") {
            orderTypeValue = 1;
        } else if (type === "sell") {
            orderTypeValue = 2;
        } else {
            console.error('Unknown order type:', type);
            return;
        }

        // 선택된 계좌의 정보를 가져오는 함수
        function getSelectedAccountInfo() {
            const selectedOption = $("#account-selection option:selected");
            return JSON.parse(selectedOption.val());
        }

        const accountInfo = getSelectedAccountInfo();

        return {
            id: getSessionUserId(), // 현재 로그인한 사용자의 ID
            accountId: accountInfo.id,
            accountNumber: accountInfo.accountNumber,
            accountType: accountInfo.accountType,
            orderType: orderTypeValue,
            price: price,
            quantity: quantity,
            market: market,
            ticker: ticker,
            stockname: stockname,
            orderDate: new Date(),  // 현재 날짜 및 시간으로 설정
            portfolioId: portfolioId,
            itemId: itemId,
        };
    }


    // 주문 체결 함수
    function executeOrder(orderData) {
        const executionData = {
            ...orderData,  // 주문 데이터를 기반으로 체결 데이터 생성
            executedPrice: orderData.price,  // 체결 가격은 주문 가격으로 설정
            executedDate: new Date(),  // 체결 날짜는 현재 날짜로 설정
        };

        // 체결 데이터 저장
        $.ajax({
            url: '/executions',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(executionData),
            success: function (response) {
                console.log('주문 체결 완료:', response);

                // 체결 성공 후 보유 주식 데이터 저장
                createHolding(executionData);
            },
            error: function (error) {
                console.error('주문 체결 실패:', error);
            }
        });
    }

    // 보유 주식 데이터 저장 함수
    function createHolding(executionData) {
        const holdingData = {
            ...executionData,  // 체결 데이터를 기반으로 보유 주식 데이터 생성
            avgPrice: executionData.executedPrice,  // 평균 가격은 체결 가격으로 설정
            lastOrderDate: executionData.executedDate,  // 마지막 주문 날짜는 체결 날짜로 설정
        };

        $.ajax({
            url: '/holdings',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(holdingData),
            success: function (response) {
                console.log('보유 주식 데이터 저장 완료:', response);
            },
            error: function (error) {
                console.error('보유 주식 데이터 저장 실패:', error);
            }
        });
    }

    // 주문을 등록하고 즉시 체결 함수 호출
    function placeOrder(orderData) {
        $.ajax({
            url: '/orders',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(orderData),
            success: function (response) {
                console.log('주문 등록 완료:', response);
                orderData.orderId = response.orderId;  // 서버에서 반환된 orderId를 orderData에 추가
                executeOrder(orderData);  // 전체 orderData를 executeOrder 함수로 전달
            },
            error: function (error) {
                console.error('주문 등록 실패:', error);
            }
        });
    }


    // 매수 함수
    function buyStock() {
        const orderData = generateOrderData('buy');
        placeOrder(orderData);
    }

    // 매도 함수
    function sellStock() {
        const orderData = generateOrderData('sell');
        placeOrder(orderData);
    }


    // 모달창 열기
    function openModal(isBuy) {
        document.getElementById("modal-stock-market").innerText = document.getElementById("stock-market").innerText;
        document.getElementById("modal-stock-ticker").innerText = document.getElementById("stock-ticker").innerText;
        document.getElementById("modal-stock-name").innerText = document.getElementById("stock-name").innerText;
        document.getElementById("modal-buy-price").innerText = document.getElementById(isBuy ? "buy-price" : "sell-price").value;
        document.getElementById("modal-buy-quantity").innerText = document.getElementById(isBuy ? "buy-quantity" : "sell-quantity").value;
        document.getElementById("modal-buy-total").innerText = document.getElementById(isBuy ? "buy-total" : "sell-total").innerText;
        document.getElementById("confirmMessage").innerText = isBuy ? "정말 구매하시겠습니까?" : "정말 판매하시겠습니까?";

        // 구매나 판매의 함수를 저장하여 processOrder에서 처리하도록 함
        window.orderFunction = isBuy ? buyStock : sellStock;

        document.getElementById("confirmModal").style.display = "block";
    }

    // 모달창 닫기
    function closeModal() {
        document.getElementById("confirmModal").style.display = "none";
    }


    // X 버튼을 눌렀을 때 모달 닫기
    document.getElementsByClassName("close")[0].onclick = function () {
        closeModal();
    }

    // 매수 버튼 이벤트 변경
    function preBuyStock() {
        openModal(true);
    }

    // 매도 버튼 이벤트 변경
    function preSellStock() {
        openModal(false);
    }


    // 결과 모달창 열기
    function openResultModal(isBuy) {
        document.getElementById("result-stock-market").innerText = document.getElementById("stock-market").innerText;
        document.getElementById("result-stock-ticker").innerText = document.getElementById("stock-ticker").innerText;
        document.getElementById("result-stock-name").innerText = document.getElementById("stock-name").innerText;
        document.getElementById("result-buy-price").innerText = document.getElementById(isBuy ? "buy-price" : "sell-price").value;
        document.getElementById("result-buy-quantity").innerText = document.getElementById(isBuy ? "buy-quantity" : "sell-quantity").value;
        document.getElementById("result-buy-total").innerText = document.getElementById(isBuy ? "buy-total" : "sell-total").innerText;

        document.getElementById("resultModal").style.display = "block";
    }

    // 결과 모달창 닫기
    function closeResultModal() {
        document.getElementById("resultModal").style.display = "none";
    }


    // 주문 처리 시 결과 모달 표시
    function processOrder() {
        window.orderFunction();  // 구매나 판매 함수 실행
        closeModal();  // 확인 모달 닫기
        const isBuy = window.orderFunction === buyStock;
        openResultModal(isBuy);  // 결과 모달 열기

        // 만약 구매가 성공적으로 이루어졌다면 카카오톡 메시지를 전송
        if (isBuy) {
            const orderData = generateOrderData('buy');
            console.log(orderData);
            sendKakaoMessage(orderData);
        }
    }

    function sendKakaoMessage(orderData) {
        const description = "시장: " + orderData.market + "종목코드: " + orderData.ticker + "종목명: " + orderData.stockname + "단가: " + orderData.price + "원" + "수량: " + orderData.quantity + "총 금액: " + orderData.price * orderData.quantity + "원";
        console.log(description);  // 여기서 출력해보기
        Kakao.Link.sendDefault({
            objectType: 'feed',
            content: {
                title: '구매 결과',
                description : "시장: " + orderData.market + " 종목코드: " + orderData.ticker + " 종목명: " + orderData.stockname + "\n단가: " + orderData.price + "원" + " 수량: " + orderData.quantity + "총 금액: " + orderData.price * orderData.quantity + "원",
                // description: "시장: " + orderData.market + "&nbsp;종목코드: " + orderData.ticker + "&nbsp; 종목명: " + orderData.stockname + "\n단가: " + orderData.price + "원" + "&nbsp;수량: " + orderData.quantity + "총 금액: " + orderData.price * orderData.quantity + "원",
                imageUrl: 'https://cdn.newswatch.kr/news/photo/202306/63720_59179_131.jpg',
                link: {
                    mobileWebUrl: 'http://localhost:8080',
                    webUrl: 'http://localhost:8080',
                    androidExecParams: 'test',
                },
            },
        });
    }


    //페이지네이션
    var rowsPerPage = 10; // 한 페이지당 보여줄 행의 수
    var currentPage = 1;

    function updateTableDisplay() {
        var table = document.getElementById("stockTable");
        var rows = table.querySelectorAll("tbody tr");
        var totalPages = Math.ceil(rows.length / rowsPerPage);
        document.getElementById("totalPages").textContent = totalPages;

        for (var i = 0; i < rows.length; i++) {
            if (i < (currentPage - 1) * rowsPerPage || i >= currentPage * rowsPerPage) {
                rows[i].style.display = "none";
            } else {
                rows[i].style.display = "";
            }
        }

        document.getElementById("currentPage").textContent = currentPage;
    }

    function changePage(delta) {
        var table = document.getElementById("stockTable");
        var rows = table.querySelectorAll("tbody tr");
        var totalPages = Math.ceil(rows.length / rowsPerPage);
        currentPage += delta;

        if (currentPage < 1) {
            currentPage = 1;
        } else if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        updateTableDisplay();
    }

    window.onload = function () {
        updateTableDisplay();
        console.log("Script loaded")
    };

</script>
