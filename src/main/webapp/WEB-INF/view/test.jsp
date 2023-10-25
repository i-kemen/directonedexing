<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Test Page</title>
</head>
<body>
<!-- id 추가 -->
<img id="chartImage" src="/api/getChart" alt="Chart Image">

<script>
    setInterval(function () {
        var imageUrl = "/api/getChart";
        var imageElement = document.getElementById("chartImage");

        // 캐시를 피하기 위해 타임스탬프를 추가
        imageElement.src = imageUrl + "?t=" + new Date().getTime();
    }, 1000); // 1초마다 이미지를 새로 고침

</script>
</body>
</html>
