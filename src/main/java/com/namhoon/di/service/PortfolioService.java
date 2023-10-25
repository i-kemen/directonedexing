package com.namhoon.di.service;

import com.namhoon.di.dto.PortfolioDTO;
import com.namhoon.di.dto.PortfolioItemDTO;
import com.namhoon.di.mapper.PortfolioMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PortfolioService {
    @Autowired
    private PortfolioMapper portfolioMapper;

    @Transactional
    public void savePortfolioAndItems(PortfolioDTO portfolioDTO, List<PortfolioItemDTO> items) {
        // portfolios 테이블에 데이터를 먼저 저장합니다.
        portfolioMapper.insertPortfolio(portfolioDTO);

        // portfolioDTO에서 portfolio_id를 가져옵니다.
        Long portfolioId = portfolioDTO.getPortfolioId();

        for (PortfolioItemDTO item : items) {
            item.setPortfolioId(portfolioId); // portfolio_id를 각 아이템에 설정합니다.
            portfolioMapper.insertPortfolioItem(item); // 그리고 각 아이템을 portfolio_items 테이블에 저장합니다.
        }
    }


    @Transactional
    public void save(PortfolioDTO portfolioDTO) {
        portfolioMapper.insertPortfolio(portfolioDTO);
    }

    @Transactional
    public void saveItems(List<PortfolioItemDTO> items) {
        for (PortfolioItemDTO item : items) {
            portfolioMapper.insertPortfolioItem(item);
        }
    }

    public PortfolioDTO findById(Long portfolioId) {
        return portfolioMapper.findPortfolioById(portfolioId);
    }

    public List<PortfolioDTO> findAllByUserId(String userId) {
        return portfolioMapper.findPortfoliosByUserId(userId);
    }

    public List<PortfolioItemDTO> findItemsByPortfolioId(Long portfolioId) {
        return portfolioMapper.findItemsByPortfolioId(portfolioId);
    }

}
