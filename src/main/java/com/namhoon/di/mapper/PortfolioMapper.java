package com.namhoon.di.mapper;

import com.namhoon.di.dto.PortfolioDTO;
import com.namhoon.di.dto.PortfolioItemDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PortfolioMapper {
    void insertPortfolio(PortfolioDTO portfolioDTO);

    void insertPortfolioItem(PortfolioItemDTO item);

    PortfolioDTO findPortfolioById(Long portfolioId);

    List<PortfolioDTO> findPortfoliosByUserId(String userId);

    List<PortfolioItemDTO> findItemsByPortfolioId(Long portfolioId);
}
