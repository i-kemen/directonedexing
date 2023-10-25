package com.namhoon.di.dto;

import lombok.Data;

import java.util.Date;

@Data
public class PortfolioItemDTO {
    private Long itemId;
    private Long portfolioId;
    private String market;       // MARKET 컬럼과 매핑됩니다.
    private String ticker;       // TICKER 컬럼과 매핑됩니다.
    private String stockname;    // stockname 컬럼과 매핑됩니다.
    private Double weight;
    private Date createdDate;
}
