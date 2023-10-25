package com.namhoon.di.dto;

import lombok.Data;

import java.util.Date;

@Data
public class OrderDTO {
    private Long orderId;
    private String id;
    private Long portfolioId;
    private Long itemId;
    private Long accountNumber;
    private String accountType;
    private String market;
    private String ticker;
    private String stockname;
    private Integer orderType;
    private Integer quantity;
    private Double price;
    private Date orderDate;
    private Integer statusCode;
    private Long transactionId;
}
