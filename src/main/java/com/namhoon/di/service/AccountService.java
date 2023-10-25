package com.namhoon.di.service;

import com.namhoon.di.dto.AccountDTO;
import com.namhoon.di.mapper.AccountMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@Transactional
public class AccountService {

    @Autowired
    private AccountMapper accountMapper;

    public void createAccount(AccountDTO account) {
        try {
            accountMapper.createAccount(account);

        } catch (Exception e) {
            throw new RuntimeException("계좌 생성 중 오류가 발생했습니다.", e);
        }

    }

    public List<AccountDTO> listAccountsByUserId(String userId) {
        return accountMapper.listAccountsByUserId(userId);
    }

    public void depositMoney(Long accountNumber, String accountType, BigDecimal amount) {
        AccountDTO account = new AccountDTO();
        account.setAccountNumber(accountNumber);
        account.setAccountType(accountType);  // 이 부분을 수정했습니다.
        account.setDeposit(amount);
        accountMapper.depositMoney(account);
    }

    public void withdrawMoney(Long accountNumber, String accountType, BigDecimal amount) {
        AccountDTO account = new AccountDTO();
        account.setAccountNumber(accountNumber);
        account.setAccountType(accountType);  // 이 부분도 수정했습니다.
        account.setDeposit(amount.negate());  // 출금이므로 음수로 설정
        accountMapper.updateDeposit(account);
    }

    public Long generateUniqueAccountNumber() {
        Long accountNumber;
        do {
            accountNumber = 30000000L + (long) (Math.random() * 10000000);  // 3으로 시작하는 8자리 숫자
        } while (accountExists(accountNumber));
        return accountNumber;
    }

    private boolean accountExists(Long accountNumber) {
        return accountMapper.getAccountByNumber(accountNumber) != null;
    }

    public AccountDTO getAccountByNumber(Long accountNumber) {
        return accountMapper.getAccountByNumber(accountNumber);
    }
}
