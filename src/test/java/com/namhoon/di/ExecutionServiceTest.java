package com.namhoon.di.service;

import com.namhoon.di.dto.ExecutionDTO;
import com.namhoon.di.mapper.ExecutionMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.times;

class ExecutionServiceTest {

    @Mock
    private ExecutionMapper executionMapper;

    @InjectMocks
    private ExecutionService executionService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void testCreateExecution() {
        ExecutionDTO execution = new ExecutionDTO();
        executionService.createExecution(execution);

        verify(executionMapper, times(1)).insertExecution(execution);
    }

    @Test
    void testGetExecutionById() {
        Long id = 1L;
        ExecutionDTO execution = new ExecutionDTO();
        when(executionMapper.selectExecutionById(id)).thenReturn(execution);

        ExecutionDTO fetched = executionService.getExecutionById(id);
        assertEquals(execution, fetched);
    }

    @Test
    void testGetAllExecutions() {
        List<ExecutionDTO> executions = Arrays.asList(new ExecutionDTO(), new ExecutionDTO());
        when(executionMapper.selectAllExecutions()).thenReturn(executions);

        List<ExecutionDTO> fetched = executionService.getAllExecutions();
        assertEquals(executions, fetched);
    }

    @Test
    void testUpdateExecution() {
        ExecutionDTO execution = new ExecutionDTO();
        executionService.updateExecution(execution);

        verify(executionMapper, times(1)).updateExecution(execution);
    }

    @Test
    void testDeleteExecution() {
        Long id = 1L;
        executionService.deleteExecution(id);

        verify(executionMapper, times(1)).deleteExecution(id);
    }
}
