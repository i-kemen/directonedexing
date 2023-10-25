package com.namhoon.di.controller;

import com.namhoon.di.dto.AccountDTO;
import com.namhoon.di.dto.AccountTransactionDTO;
import com.namhoon.di.dto.UserDTO;
import com.namhoon.di.service.AccountService;
import com.namhoon.di.service.AccountTransactionService;
import com.namhoon.di.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RequestMapping("/accounttransactions")
@Controller
public class AccountTransactionController {

    @Autowired
    private AccountTransactionService transactionService;

    @PostMapping
    public void createTransaction(@RequestBody AccountTransactionDTO transactionDTO) {
        transactionService.createTransaction(transactionDTO);
    }

    @GetMapping("/{transactionId}")
    public AccountTransactionDTO getTransactionById(@PathVariable Long transactionId) {
        return transactionService.getTransactionById(transactionId);
    }

    @GetMapping
    public List<AccountTransactionDTO> getAllTransactions() {
        return transactionService.getAllTransactions();
    }

    @PutMapping("/{transactionId}")
    public void updateTransaction(@PathVariable Long transactionId, @RequestBody AccountTransactionDTO transactionDTO) {
        transactionDTO.setTransactionId(transactionId); // Setting ID from path variable
        transactionService.updateTransaction(transactionDTO);
    }

    @DeleteMapping("/{transactionId}")
    public void deleteTransaction(@PathVariable Long transactionId) {
        transactionService.deleteTransaction(transactionId);
    }


}

