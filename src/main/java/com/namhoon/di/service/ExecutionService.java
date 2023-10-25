package com.namhoon.di.service;

import com.namhoon.di.dto.ExecutionDTO;
import com.namhoon.di.mapper.ExecutionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExecutionService {
    @Autowired
    private ExecutionMapper executionMapper;

    public void createExecution(ExecutionDTO execution) {
        executionMapper.insertExecution(execution);
    }

    public ExecutionDTO getExecutionById(Long executionId) {
        return executionMapper.selectExecutionById(executionId);
    }

    public List<ExecutionDTO> getAllExecutions() {
        return executionMapper.selectAllExecutions();
    }

    public void updateExecution(ExecutionDTO execution) {
        executionMapper.updateExecution(execution);
    }

    public void deleteExecution(Long executionId) {
        executionMapper.deleteExecution(executionId);
    }
}
