package com.namhoon.di.mapper;

import com.namhoon.di.dto.ExecutionDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ExecutionMapper {
    void insertExecution(ExecutionDTO execution);
    ExecutionDTO selectExecutionById(Long executionId);
    List<ExecutionDTO> selectAllExecutions();
    void updateExecution(ExecutionDTO execution);
    void deleteExecution(Long executionId);

}
