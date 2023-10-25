package com.namhoon.di.dto;

import lombok.Data;

import java.util.Date;

@Data
public class HoldingDTO {
    private Long holdingId;
    private String id;
    private Long portfolioId;
    private Long itemId;
    private Long accountNumber;
    private String accountType;
    private String market;
    private String ticker;
    private String stockname;
    private Integer quantity;
    private Double avgPrice;
    private Date lastOrderDate;
}
