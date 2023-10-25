package com.namhoon.di.dto;

import lombok.Data;

import java.util.Date;

@Data
public class PortfolioDTO {
    private Long portfolioId;
    private String portfolioName;
    private String id;  // 사용자 ID
    private Date createdDate;
}
