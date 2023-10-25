package com.namhoon.di;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.namhoon.di.controller.PortfolioController;
import com.namhoon.di.dto.PortfolioCompositeDTO;
import com.namhoon.di.dto.PortfolioDTO;
import com.namhoon.di.dto.PortfolioItemDTO;
import com.namhoon.di.service.PortfolioService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.Arrays;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class PortfolioControllerTest {

    @Mock
    private PortfolioService portfolioService;

    @InjectMocks
    private PortfolioController portfolioController;

    private MockMvc mockMvc;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(portfolioController).build();
    }

    @Test
    public void testSavePortfolio() throws Exception {
        PortfolioDTO portfolio = new PortfolioDTO();
        portfolio.setPortfolioName("Test Portfolio");
        portfolio.setId("testUser");

        PortfolioItemDTO item = new PortfolioItemDTO();
        item.setStockname("Test Stock");
        item.setTicker("TS");
        item.setMarket("Test Market");
        item.setWeight(100.0);

        PortfolioCompositeDTO compositeDTO = new PortfolioCompositeDTO();
        compositeDTO.setPortfolio(portfolio);
        compositeDTO.setItems(Arrays.asList(item));

        mockMvc.perform(post("/savePortfolio")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(compositeDTO)))
                .andExpect(status().isOk());
    }
}
