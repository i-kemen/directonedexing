package com.namhoon.di.controller;

import com.namhoon.di.dto.HoldingDTO;
import com.namhoon.di.dto.KorTickerDTO;
import com.namhoon.di.service.HoldingService;
import com.namhoon.di.service.KorTickerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;
import java.sql.Date;

@RestController
@RequestMapping("/api")
public class TickerAPIController {

    @Autowired
    private KorTickerService korTickerService;

    @Autowired
    private HoldingService holdingService;

    private final Path chartStoragePath = Paths.get("src/main/resources/static/chart");
    private List<Map<String, Object>> modifiedJsonList;

    private Map<String, Object> receivedMetrics;


    @PostMapping("/saveModifiedTickers")
    public ResponseEntity<String> saveModifiedTickers(@RequestBody List<Map<String, Object>> tickers) {
        this.modifiedJsonList = tickers;
        return ResponseEntity.ok("데이터를 받았습니다.");
    }

    @GetMapping("/getModifiedTickers")
    public List<Map<String, Object>> getModifiedTickers() {
        return modifiedJsonList;
    }

    // This will hold the image in memory
    private byte[] chartImageData;

    @PostMapping("/receiveChart")
    public ResponseEntity<String> receiveChart(@RequestParam("chart") MultipartFile chartImage) {
        try {
            // Store the received chart image in memory
            chartImageData = chartImage.getBytes();
            return ResponseEntity.ok("Chart received successfully!");
        } catch (Exception e) {
            e.printStackTrace();  // This will print the error stack trace to your console or logs
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to process chart: " + e.getMessage());
        }
    }

    @GetMapping(value = "/getChart", produces = MediaType.IMAGE_PNG_VALUE)
    public byte[] getChart() {
        return chartImageData;
    }

    //
    @PostMapping("/receiveMetrics")
    public ResponseEntity<String> receiveMetrics(@RequestBody Map<String, Object> metrics) {
        System.out.println("Received metrics: " + metrics);
        this.receivedMetrics = metrics;
        return ResponseEntity.ok("Metrics received successfully!");
    }

    @GetMapping("/getMetrics")
    public Map<String, Object> getMetrics() {
        System.out.println("Returning metrics: " + receivedMetrics);  // 로깅 추가
        return receivedMetrics;
    }

    @PostMapping("/getDataByCriteria")
    public List<KorTickerDTO> getDataByCriteria(@RequestBody Map<String, Object> criteria) {
        return korTickerService.selectKorByCriteria(criteria);
    }

    //수익률
//    @GetMapping("/getHoldingReturn/{id}")
//    public ResponseEntity<List<Map<String, Object>>> getHoldingReturn(@PathVariable String id) {
//        LocalDateTime now = LocalDateTime.now();
//        Date targetDate;
//
//        // 현재 시간이 오후 6시 이전이라면 전날 날짜를 대상으로 합니다.
//        if (now.toLocalTime().isBefore(LocalTime.of(18, 0))) {
//            targetDate = java.sql.Date.valueOf(now.minusDays(1).toLocalDate());
//        } else {
//            // 오후 6시 이후라면 현재 날짜를 대상으로 합니다.
//            targetDate = java.sql.Date.valueOf(now.toLocalDate());
//        }
//
//        // 사용자의 보유 주식 정보 가져오기
//        List<HoldingDTO> holdings = holdingService.getHoldingsByUserId(id);
//
//        List<Map<String, Object>> results = new ArrayList<>();
//        for (HoldingDTO holding : holdings) {
//            KorTickerDTO tickerForDate = korTickerService.getPriceByTickerAndDate(holding.getTicker(), targetDate);
//            if (tickerForDate != null) {
//                Double purchasePrice = holding.getAvgPrice();
//                Float priceForDate = tickerForDate.getClosing();
//                Double returnRate = ((priceForDate - purchasePrice) / purchasePrice) * 100;
//
//                Map<String, Object> map = new HashMap<>();
//                map.put("ticker", holding.getTicker());
//                map.put("stockname", holding.getStockname());
//                map.put("purchasePrice", purchasePrice);
//                map.put("priceForDate", priceForDate);
//                map.put("returnRate", returnRate);
//                results.add(map);
//            }
//        }
//
//        return ResponseEntity.ok(results);
//    }

    //테스트용 9/14
    @GetMapping("/getHoldingReturn/{id}")
    public ResponseEntity<List<Map<String, Object>>> getHoldingReturnTest(@PathVariable String id) {
        // 사용자의 보유 주식 정보 가져오기

        // 테스트용으로 날짜를 고정합니다.
        List<HoldingDTO> holdings = holdingService.getHoldingsByUserId(id);

        // 테스트용으로 날짜를 고정합니다.
        LocalDate localDate = LocalDate.of(2023, 9, 14);
        Date testDate = Date.valueOf(localDate);

        List<Map<String, Object>> results = new ArrayList<>();
        for (HoldingDTO holding : holdings) {
            KorTickerDTO tickerForDate = korTickerService.getPriceByTickerAndDate(holding.getTicker(), testDate);
            if (tickerForDate != null) {
                Double purchasePrice = holding.getAvgPrice();
                Float priceForDate = tickerForDate.getClosing();
                Double returnRate = ((priceForDate - purchasePrice) / purchasePrice) * 100;

                Map<String, Object> map = new HashMap<>();
                map.put("ticker", holding.getTicker());
                map.put("stockname", holding.getStockname());
                map.put("purchasePrice", purchasePrice);
                map.put("priceForDate", priceForDate);
                map.put("returnRate", returnRate);
                results.add(map);
            }
        }
        return ResponseEntity.ok(results);
    }


}


