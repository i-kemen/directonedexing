package com.namhoon.di.controller;

import com.namhoon.di.dto.PortfolioCompositeDTO;
import com.namhoon.di.dto.PortfolioDTO;
import com.namhoon.di.dto.PortfolioItemDTO;
import com.namhoon.di.dto.UserDTO;
import com.namhoon.di.service.PortfolioService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class PortfolioController {
    @Autowired
    private PortfolioService portfolioService;

    @PostMapping("/createPortfolio")
    public ResponseEntity<String> createPortfolio(@RequestParam String portfolioName, HttpServletRequest request) {
        try {
            String currentUserId = (String) request.getSession().getAttribute("userId");

            PortfolioDTO portfolioDTO = new PortfolioDTO();
            portfolioDTO.setPortfolioName(portfolioName);
            portfolioDTO.setId(currentUserId);

            portfolioService.save(portfolioDTO);

            return new ResponseEntity<>("포트폴리오가 생성되었습니다.", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/savePortfolio")
    public ResponseEntity<String> savePortfolio(@RequestBody PortfolioCompositeDTO compositeDTO, HttpServletRequest request) {
        try {
            String currentUserId = (String) request.getSession().getAttribute("userId");
            compositeDTO.getPortfolio().setId(currentUserId);

            // 위에서 제안한 메서드를 사용해 포트폴리오와 아이템 정보를 한 번에 저장
            portfolioService.savePortfolioAndItems(compositeDTO.getPortfolio(), compositeDTO.getItems());

            return new ResponseEntity<>("저장 성공", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/portfolios")
    public ModelAndView getUserPortfolios(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("portfolios"); // "portfolios"는 이전에 제공한 JSP view의 이름입니다.

        // 로그인한 유저 확인
        UserDTO currentUser = (UserDTO) request.getSession().getAttribute("user");
        if (currentUser == null) {
            mav.setViewName("login"); // 로그인 페이지로 리다이렉트
            return mav;
        }

        String currentUserId = currentUser.getId();
        System.out.println("Current User ID: " + currentUserId);  // 로깅 추가

        // 유저의 포트폴리오 목록을 데이터베이스에서 가져옵니다.
        List<PortfolioDTO> userPortfolios = portfolioService.findAllByUserId(currentUserId);
        mav.addObject("portfolios", userPortfolios);

        return mav;
    }


    @GetMapping("/portfolioItems")
    public ModelAndView getPortfolioItems(@RequestParam Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("portfolioItems");

        // Ensure the user is logged in
        String currentUserId = (String) request.getSession().getAttribute("userId");
        if (currentUserId == null) {
            mav.setViewName("login"); // Redirect to login or another appropriate view
            return mav;
        }

        // Fetch portfolio items from the database
        List<PortfolioItemDTO> items = portfolioService.findItemsByPortfolioId(id);
        mav.addObject("items", items);

        return mav;
    }

    @PostMapping("/jamoon")
    public ModelAndView jamoonPage(@RequestParam Long id,
                                   HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("jamoon");

        // Ensure the user is logged in
        String currentUserId = (String) request.getSession().getAttribute("userId");
        if (currentUserId == null) {
            mav.setViewName("login");
            return mav;
        }

        // Fetch portfolio items from the database
        List<PortfolioItemDTO> items = portfolioService.findItemsByPortfolioId(id);
        mav.addObject("items", items);

        // 여기에 다른 로직 추가 ...

        return mav;
    }


//    @GetMapping("/realtime")
//    public String realtime() {
//        return "realtime";
//    }

    @PostMapping("/realtime")
    public ModelAndView realtimePage(@RequestParam Long id,
                                     HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("realtime");

        // Ensure the user is logged in
        String currentUserId = (String) request.getSession().getAttribute("userId");
        if (currentUserId == null) {
            mav.setViewName("login");
            return mav;
        }

        // Fetch portfolio items from the database
        List<PortfolioItemDTO> items = portfolioService.findItemsByPortfolioId(id);
        mav.addObject("items", items);

        // 여기에 다른 로직 추가 ...

        return mav;
    }


}
