package com.namhoon.di.dto;

import lombok.Data;

import java.util.List;

@Data
public class PortfolioCompositeDTO {
    private PortfolioDTO portfolio;
    private List<PortfolioItemDTO> items;
}