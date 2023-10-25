package com.namhoon.di.dto;

import lombok.Data;

import java.util.Date;
import java.math.BigDecimal;

@Data
public class AccountTransactionDTO {
    private Long transactionId;
    private Long accountNumber;
    private String accountType;
    private Integer transactionType;
    private BigDecimal amount;
    private Date transactionDate;
}
