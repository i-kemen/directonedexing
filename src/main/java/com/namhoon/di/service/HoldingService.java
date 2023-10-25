package com.namhoon.di.service;

import com.namhoon.di.dto.HoldingDTO;
import com.namhoon.di.mapper.HoldingMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HoldingService {
    @Autowired
    private HoldingMapper holdingMapper;

    public void createHolding(HoldingDTO holding) {
        holdingMapper.insertHolding(holding);
    }

    public HoldingDTO getHoldingById(Long holdingId) {
        return holdingMapper.selectHoldingById(holdingId);
    }

    public List<HoldingDTO> getAllHoldings() {
        return holdingMapper.selectAllHoldings();
    }

    public void updateHolding(HoldingDTO holding) {
        holdingMapper.updateHolding(holding);
    }

    public void deleteHolding(Long holdingId) {
        holdingMapper.deleteHolding(holdingId);
    }


    public List<HoldingDTO> getHoldingsByUserId(String id) {
        return holdingMapper.selectHoldingsByUserId(id);
    }
}
