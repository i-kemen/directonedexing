package com.namhoon.di.controller;

import com.namhoon.di.dto.KorTickerDTO;
import com.namhoon.di.service.KorTickerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;


@Controller
public class MainController {
    @Autowired
    private KorTickerService korTickerService;


    @GetMapping("/index")
    public String index() {
        return "index";
    }

    @GetMapping("/indexing")
    public String indexing(Model model) {
        List<KorTickerDTO> korTickers = korTickerService.selectKorTop();
        String korTickersJson = korTickerService.korTopJson(korTickers);
        model.addAttribute("korTickersJson", korTickersJson);
        return "indexing";  // JSP 페이지의 이름
    }


    @GetMapping("/indexing2")
    public String indexing2(Model model) {
        List<KorTickerDTO> korTickers = korTickerService.selectKorTop();
        String korTickersJson = korTickerService.korTopJson(korTickers);
        model.addAttribute("korTickersJson", korTickersJson);
        return "indexing2";  // JSP 페이지의 이름
    }

    @GetMapping("/agree")
    public String agree() {
        return "agree";
    }


    @GetMapping("/")
    public String hello() {
        return "main";
    }

    @GetMapping("/edit")
    public String edit(Model model) {
        List<KorTickerDTO> korTickers = korTickerService.selectKorTop();
        String korTickersJson = korTickerService.korTopJson(korTickers);
        model.addAttribute("korTickersJson", korTickersJson);
        return "edit";
    }


    @GetMapping("/test")
    public String showTestPage() {
        return "test"; // test.jsp 페이지를 반환
    }


    @GetMapping("/start2")
    public String start() {
        return "start2";
    }

    @GetMapping("/sogae")
    public String sogae() {
        return "sogae";
    }

    @GetMapping("/mypage")
    public String mypage() {
        return "mypage";
    }

    @GetMapping("/health")
    public String health() {
        return "health";
    }

    @GetMapping("/tickers")
    public String tickers() {
        return "tickers";
    }


    @GetMapping("/faq")
    public String faq() {
        return "faq";
    }


    @GetMapping("/chart")
    public String chart() {
        return "chart";
    }

    @GetMapping("/echart")
    public String echart() {
        return "echart";
    }

    @GetMapping("/backtest")
    public String getResult(Model model) {
        // Flask 애플리케이션의 URL을 호출하여 결과를 가져옴
        String flaskUrl = "http://localhost:5000"; // Flask 애플리케이션의 URL
        RestTemplate restTemplate = new RestTemplate();
        String result = restTemplate.getForObject(flaskUrl, String.class);

        // 결과를 모델에 추가하여 뷰로 전달
        model.addAttribute("flaskResult", result);

        return "result"; // 뷰 이름 (스프링 부트 템플릿 엔진에 따라 다를 수 있음)
    }


    @GetMapping("/ditest")
    public String test(Model model) {
        List<KorTickerDTO> korTickers = korTickerService.selectKorTop();
        String korTickersJson = korTickerService.korTopJson(korTickers);
        model.addAttribute("korTickersJson", korTickersJson);
        return "ditest";  // JSP 페이지의 이름
    }

    @GetMapping("/port")
    public String portView() {
        return "port";
    }

    @PostMapping("/port")
    public String handlePortForm(@RequestParam String jsonData, Model model) {
        // jsonData 처리 코드
        model.addAttribute("jsonData", jsonData);
        return "port";  // port.jsp 뷰 이름을 반환
    }


//    @GetMapping("/backtest")
//    public String getResult(Model model) {
//        // Flask 애플리케이션의 URL을 호출하여 JSON 결과를 가져옴
//        String flaskUrl = "http://localhost:5000"; // Flask 애플리케이션의 URL
//        RestTemplate restTemplate = new RestTemplate();
//        ResponseEntity<String> responseEntity = restTemplate.getForEntity(flaskUrl, String.class);
//
//        // Flask 애플리케이션에서 JSON 데이터를 받아옴
//        if (responseEntity.getStatusCode() == HttpStatus.OK) {
//            String resultJson = responseEntity.getBody();
//
//            // JSON 데이터를 모델에 추가하여 뷰로 전달
//            model.addAttribute("flaskResult", resultJson);
//
//            return "result"; // 뷰 이름 (스프링 부트 템플릿 엔진에 따라 다를 수 있음)
//        } else {
//            // HTTP 요청이 실패한 경우에 대한 처리를 여기에 추가
//            return "error"; // 예를 들어, 에러 페이지를 보여줄 수 있음
//        }
//    }

}
