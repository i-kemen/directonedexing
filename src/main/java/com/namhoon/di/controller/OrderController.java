package com.namhoon.di.controller;

import com.namhoon.di.dto.AccountTransactionDTO;
import com.namhoon.di.dto.OrderDTO;
import com.namhoon.di.service.AccountService;
import com.namhoon.di.service.AccountTransactionService;
import com.namhoon.di.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RequestMapping("/orders")
@RestController

public class OrderController {

    @Autowired
    private OrderService orderService;


    @Autowired
    private AccountService accountService;

    @Autowired
    private AccountTransactionService transactionService;

    @PostMapping
    public ResponseEntity<Map<String, Object>> createOrder(@RequestBody OrderDTO order) {
        Map<String, Object> response = new HashMap<>();

        try {
            orderService.createOrder(order);

            // 계좌 거래를 처리
            BigDecimal transactionAmount = BigDecimal.valueOf(order.getPrice() * order.getQuantity());
            if (order.getOrderType() == 1) { // 1이 매수를 의미
                accountService.withdrawMoney(order.getAccountNumber(), order.getAccountType(), transactionAmount);
            } else if (order.getOrderType() == 2) { // 2가 매도를 의미
                accountService.depositMoney(order.getAccountNumber(), order.getAccountType(), transactionAmount);
            }

            // AccountTransactionDTO 객체 생성 및 저장
            AccountTransactionDTO transactionDTO = new AccountTransactionDTO();
            transactionDTO.setAccountNumber(order.getAccountNumber());
            transactionDTO.setAccountType(order.getAccountType());
            transactionDTO.setTransactionType(order.getOrderType());
            transactionDTO.setAmount(transactionAmount);
            transactionService.createTransaction(transactionDTO);
            System.out.println("Transaction ID after creation: " + transactionDTO.getTransactionId());


            order.setTransactionId(transactionDTO.getTransactionId()); // order에 transactionId 설정
            orderService.updateOrder(order);

            response.put("success", true);
            return new ResponseEntity<>(response, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();  // 이 부분 추가
            response.put("success", false);
            response.put("errorMessage", e.getMessage());  // 실제 예외 메시지 반환
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @GetMapping("/{orderId}")
    public OrderDTO getOrderById(@PathVariable Long orderId) {
        return orderService.getOrderById(orderId);
    }

    @GetMapping
    public List<OrderDTO> getAllOrders() {
        return orderService.getAllOrders();
    }


    @PutMapping("/{orderId}")
    public void updateOrder(@PathVariable Long orderId, @RequestBody OrderDTO order) {
        order.setOrderId(orderId); // Setting ID from path variable
        orderService.updateOrder(order);
    }

    @DeleteMapping("/{orderId}")
    public void deleteOrder(@PathVariable Long orderId) {
        orderService.deleteOrder(orderId);
    }
}
