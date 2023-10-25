package com.namhoon.di;

import com.namhoon.di.dto.KorTickerDTO;
import com.namhoon.di.mapper.KorTickerMapper;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class DiApplicationTests {

    @Autowired
    private KorTickerMapper korTickerMapper;

    @Test
    void contextLoads() {
    }

    @Test
    public void selectKorTopTest() {
        List<KorTickerDTO> results = korTickerMapper.selectKor();

        assertThat(results).isNotNull();
        assertThat(results.size()).isLessThanOrEqualTo(50);
    }

}



