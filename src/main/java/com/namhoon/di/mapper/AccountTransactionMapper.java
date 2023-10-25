package com.namhoon.di.mapper;

import com.namhoon.di.dto.AccountTransactionDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AccountTransactionMapper {
    void insertTransaction(AccountTransactionDTO transactionDTO);

    AccountTransactionDTO selectTransactionById(Long transactionId);

    List<AccountTransactionDTO> selectAllTransactions();

    void updateTransaction(AccountTransactionDTO transactionDTO);

    void deleteTransaction(Long transactionId);
}
