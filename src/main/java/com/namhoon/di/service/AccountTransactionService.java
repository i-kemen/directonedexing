package com.namhoon.di.service;

import com.namhoon.di.dto.AccountDTO;
import com.namhoon.di.dto.AccountTransactionDTO;
import com.namhoon.di.mapper.AccountMapper;
import com.namhoon.di.mapper.AccountTransactionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@Transactional
public class AccountTransactionService {

    @Autowired
    private AccountTransactionMapper transactionMapper;

    public void createTransaction(AccountTransactionDTO transactionDTO) {
        transactionMapper.insertTransaction(transactionDTO);

        System.out.println("Generated Transaction ID: " + transactionDTO.getTransactionId());
    }

    public AccountTransactionDTO getTransactionById(Long transactionId) {
        return transactionMapper.selectTransactionById(transactionId);
    }

    public List<AccountTransactionDTO> getAllTransactions() {
        return transactionMapper.selectAllTransactions();
    }

    public void updateTransaction(AccountTransactionDTO transactionDTO) {
        transactionMapper.updateTransaction(transactionDTO);
    }

    public void deleteTransaction(Long transactionId) {
        transactionMapper.deleteTransaction(transactionId);
    }
}