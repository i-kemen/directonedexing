package com.namhoon.di.mapper;

import com.namhoon.di.dto.ExecutionDTO;
import com.namhoon.di.dto.HoldingDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface HoldingMapper {
    void insertHolding(HoldingDTO holding);

    HoldingDTO selectHoldingById(Long holdingId);

    List<HoldingDTO> selectAllHoldings();

    void updateHolding(HoldingDTO holding);

    void deleteHolding(Long holdingId);

    List<HoldingDTO> selectHoldingsByUserId(String id);

}
