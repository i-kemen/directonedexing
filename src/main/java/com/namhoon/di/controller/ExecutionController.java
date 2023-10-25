package com.namhoon.di.controller;

import com.namhoon.di.dto.ExecutionDTO;
import com.namhoon.di.dto.OrderDTO;
import com.namhoon.di.service.ExecutionService;
import com.namhoon.di.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/executions")
@RestController
public class ExecutionController {

    @Autowired
    private ExecutionService executionService;

    @PostMapping
    public ResponseEntity<Map<String, Object>> createExecution(@RequestBody ExecutionDTO execution) {
        Map<String, Object> response = new HashMap<>();

        try {
            executionService.createExecution(execution);
            response.put("success", true);
            response.put("executionData", execution);  // 체결 데이터 반환
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            response.put("success", false);
            response.put("errorMessage", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @GetMapping("/{executionId}")
    public ExecutionDTO getExecutionById(@PathVariable Long executionId) {
        return executionService.getExecutionById(executionId);
    }

    @GetMapping
    public List<ExecutionDTO> getAllExecutions() {
        return executionService.getAllExecutions();
    }

    @PutMapping("/{executionId}")
    public void updateExecution(@PathVariable Long executionId, @RequestBody ExecutionDTO execution) {
        execution.setExecutionId(executionId); // Setting ID from path variable
        executionService.updateExecution(execution);
    }

    @DeleteMapping("/{executionId}")
    public void deleteExecution(@PathVariable Long executionId) {
        executionService.deleteExecution(executionId);
    }
}
