package com.namhoon.di.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.namhoon.di.dto.KorTickerDTO;
import com.namhoon.di.mapper.KorTickerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;


@Service
public class KorTickerService {

    private final KorTickerMapper korTickerMapper;

    @Autowired
    public KorTickerService(KorTickerMapper korTickerMapper) {
        this.korTickerMapper = korTickerMapper;
    }

    public List<KorTickerDTO> selectKorTop() {
        return korTickerMapper.selectKor();
    }
    
    //동적 쿼리
    public List<KorTickerDTO> selectKorByCriteria(Map<String, Object> criteria) {
        return korTickerMapper.selectKorByCriteria(criteria);
    }

    public String korTopJson(List<KorTickerDTO> korTickers) {
        ObjectMapper objectMapper = new ObjectMapper();

        List<Map<String, Object>> resultList = new ArrayList<>();
        for (KorTickerDTO dto : korTickers) {
            Map<String, Object> map = new HashMap<>();
            map.put("ticker", dto.getTicker());
            map.put("stockname", dto.getStockname());  // 추가된 부분
            map.put("market", dto.getMarket());
            map.put("cap", dto.getCap());
            resultList.add(map);
        }

        try {
            return objectMapper.writeValueAsString(resultList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
        }
    }

    //수익률
    public KorTickerDTO getPriceByTickerAndDate(String ticker, Date date) {
        Map<String, Object> criteria = new HashMap<>();
        criteria.put("ticker", ticker);
        criteria.put("bday", date);
        List<KorTickerDTO> tickers = selectKorByCriteria(criteria);
        return tickers.size() > 0 ? tickers.get(0) : null;
    }

}
