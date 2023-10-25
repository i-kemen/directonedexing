package com.namhoon.di.service;

import com.namhoon.di.dto.HoldingDTO;
import com.namhoon.di.mapper.HoldingMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import java.util.Collections;
import java.util.List;
import static org.mockito.Mockito.*;

class HoldingServiceTest {

    @Mock
    private HoldingMapper holdingMapper;

    @InjectMocks
    private HoldingService holdingService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void createHoldingTest() {
        HoldingDTO holding = new HoldingDTO();
        holdingService.createHolding(holding);
        verify(holdingMapper, times(1)).insertHolding(holding);
    }

    @Test
    void getHoldingByIdTest() {
        Long id = 1L;
        holdingService.getHoldingById(id);
        verify(holdingMapper, times(1)).selectHoldingById(id);
    }

    @Test
    void getAllHoldingsTest() {
        holdingService.getAllHoldings();
        verify(holdingMapper, times(1)).selectAllHoldings();
    }

    @Test
    void updateHoldingTest() {
        HoldingDTO holding = new HoldingDTO();
        holdingService.updateHolding(holding);
        verify(holdingMapper, times(1)).updateHolding(holding);
    }

    @Test
    void deleteHoldingTest() {
        Long id = 1L;
        holdingService.deleteHolding(id);
        verify(holdingMapper, times(1)).deleteHolding(id);
    }

    @Test
    void getHoldingsByUserIdTest() {
        String userId = "testUserId";
        when(holdingMapper.selectHoldingsByUserId(userId)).thenReturn(Collections.singletonList(new HoldingDTO()));
        List<HoldingDTO> holdings = holdingService.getHoldingsByUserId(userId);
        assert !holdings.isEmpty();
        verify(holdingMapper, times(1)).selectHoldingsByUserId(userId);
    }
}
