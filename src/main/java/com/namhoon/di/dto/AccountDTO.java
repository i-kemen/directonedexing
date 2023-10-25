package com.namhoon.di.dto;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class AccountDTO {
    private Long accountNumber;
    private String accountType;  // 계좌분류
    private String id;
    private String accountName;
    private BigDecimal deposit;
}
