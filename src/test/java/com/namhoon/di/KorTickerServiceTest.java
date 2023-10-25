package com.namhoon.di.service;

import com.namhoon.di.dto.KorTickerDTO;
import com.namhoon.di.mapper.KorTickerMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class KorTickerServiceTest {

    @Mock
    private KorTickerMapper korTickerMapper;

    @InjectMocks
    private KorTickerService korTickerService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void selectKorTopTest() {
        List<KorTickerDTO> mockList = Collections.singletonList(new KorTickerDTO());
        when(korTickerMapper.selectKor()).thenReturn(mockList);

        List<KorTickerDTO> resultList = korTickerService.selectKorTop();

        assertFalse(resultList.isEmpty());
        verify(korTickerMapper, times(1)).selectKor();
    }

    @Test
    void selectKorByCriteriaTest() {
        Map<String, Object> criteria = new HashMap<>();
        List<KorTickerDTO> mockList = Collections.singletonList(new KorTickerDTO());
        when(korTickerMapper.selectKorByCriteria(criteria)).thenReturn(mockList);

        List<KorTickerDTO> resultList = korTickerService.selectKorByCriteria(criteria);

        assertFalse(resultList.isEmpty());
        verify(korTickerMapper, times(1)).selectKorByCriteria(criteria);
    }

    @Test
    void korTopJsonTest() {
        List<KorTickerDTO> korTickers = Collections.singletonList(new KorTickerDTO());
        String result = korTickerService.korTopJson(korTickers);

        assertNotNull(result);
        assertTrue(result.startsWith("["));
        assertTrue(result.endsWith("]"));
    }

    @Test
    void getPriceByTickerAndDateTest() {
        String ticker = "sampleTicker";
        Date date = new Date();
        Map<String, Object> criteria = new HashMap<>();
        criteria.put("ticker", ticker);
        criteria.put("bday", date);

        List<KorTickerDTO> mockList = Collections.singletonList(new KorTickerDTO());
        when(korTickerMapper.selectKorByCriteria(criteria)).thenReturn(mockList);

        KorTickerDTO resultDto = korTickerService.getPriceByTickerAndDate(ticker, date);

        assertNotNull(resultDto);
        verify(korTickerMapper, times(1)).selectKorByCriteria(criteria);
    }
}
