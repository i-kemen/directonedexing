package com.namhoon.di.mapper;

import com.namhoon.di.dto.AccountDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AccountMapper {
    void createAccount(AccountDTO account);
    List<AccountDTO> listAccountsByUserId(String userId);
    void depositMoney(AccountDTO account);
    void updateDeposit(AccountDTO account);
    AccountDTO getAccountByNumber(Long accountNumber);

}
