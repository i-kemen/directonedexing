package com.namhoon.di;

import com.namhoon.di.dto.PortfolioDTO;
import com.namhoon.di.dto.PortfolioItemDTO;
import com.namhoon.di.mapper.PortfolioMapper;
import com.namhoon.di.service.PortfolioService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

class PortfolioServiceTest {

    @Mock
    private PortfolioMapper portfolioMapper;

    @InjectMocks
    private PortfolioService portfolioService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void savePortfolioAndItemsTest() {
        PortfolioDTO portfolioDTO = new PortfolioDTO();
        List<PortfolioItemDTO> items = Arrays.asList(new PortfolioItemDTO(), new PortfolioItemDTO());

        portfolioService.savePortfolioAndItems(portfolioDTO, items);

        verify(portfolioMapper, times(1)).insertPortfolio(portfolioDTO);
        verify(portfolioMapper, times(items.size())).insertPortfolioItem(any(PortfolioItemDTO.class));
    }

    @Test
    void saveTest() {
        PortfolioDTO portfolioDTO = new PortfolioDTO();
        portfolioService.save(portfolioDTO);
        verify(portfolioMapper, times(1)).insertPortfolio(portfolioDTO);
    }

    @Test
    void saveItemsTest() {
        List<PortfolioItemDTO> items = Arrays.asList(new PortfolioItemDTO(), new PortfolioItemDTO());
        portfolioService.saveItems(items);
        verify(portfolioMapper, times(items.size())).insertPortfolioItem(any(PortfolioItemDTO.class));
    }

    @Test
    void findByIdTest() {
        Long id = 1L;
        PortfolioDTO mockPortfolio = new PortfolioDTO();
        when(portfolioMapper.findPortfolioById(id)).thenReturn(mockPortfolio);

        PortfolioDTO resultPortfolio = portfolioService.findById(id);

        assertEquals(mockPortfolio, resultPortfolio);
        verify(portfolioMapper, times(1)).findPortfolioById(id);
    }

    @Test
    void findAllByUserIdTest() {
        String userId = "testUser";
        List<PortfolioDTO> mockList = Collections.singletonList(new PortfolioDTO());
        when(portfolioMapper.findPortfoliosByUserId(userId)).thenReturn(mockList);

        List<PortfolioDTO> resultList = portfolioService.findAllByUserId(userId);

        assertEquals(mockList.size(), resultList.size());
        verify(portfolioMapper, times(1)).findPortfoliosByUserId(userId);
    }

    @Test
    void findItemsByPortfolioIdTest() {
        Long id = 1L;
        List<PortfolioItemDTO> mockList = Collections.singletonList(new PortfolioItemDTO());
        when(portfolioMapper.findItemsByPortfolioId(id)).thenReturn(mockList);

        List<PortfolioItemDTO> resultList = portfolioService.findItemsByPortfolioId(id);

        assertEquals(mockList.size(), resultList.size());
        verify(portfolioMapper, times(1)).findItemsByPortfolioId(id);
    }
}
