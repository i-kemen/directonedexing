package com.namhoon.di.controller;

import com.namhoon.di.dto.ExecutionDTO;
import com.namhoon.di.dto.HoldingDTO;
import com.namhoon.di.service.ExecutionService;
import com.namhoon.di.service.HoldingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/holdings")
@RestController
public class HoldingController {

    @Autowired
    private HoldingService holdingService;

    @PostMapping
    public ResponseEntity<Map<String, Object>> createHolding(@RequestBody HoldingDTO holding) {
        Map<String, Object> response = new HashMap<>();

        try {
            holdingService.createHolding(holding);
            response.put("success", true);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            response.put("success", false);
            response.put("errorMessage", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/{holdingId}")
    public HoldingDTO getHoldingById(@PathVariable Long holdingId) {
        return holdingService.getHoldingById(holdingId);
    }

    @GetMapping
    public List<HoldingDTO> getAllHoldings() {
        return holdingService.getAllHoldings();
    }

    @PutMapping("/{holdingId}")
    public void updateHolding(@PathVariable Long holdingId, @RequestBody HoldingDTO holding) {
        holding.setHoldingId(holdingId); // Setting ID from path variable
        holdingService.updateHolding(holding);
    }

    @DeleteMapping("/{holdingId}")
    public void deleteHolding(@PathVariable Long holdingId) {
        holdingService.deleteHolding(holdingId);
    }

    @GetMapping("/user/{id}")
    public List<HoldingDTO> getHoldingsByUserId(@PathVariable String id) {
        return holdingService.getHoldingsByUserId(id);
    }
}
