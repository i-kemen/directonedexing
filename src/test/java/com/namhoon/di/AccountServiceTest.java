package com.namhoon.di;

import com.namhoon.di.dto.AccountDTO;
import com.namhoon.di.service.AccountService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Transactional
public class AccountServiceTest {

    @Autowired
    private AccountService accountService;

    private AccountDTO testAccount;

    @BeforeEach
    public void setUp() {
        testAccount = new AccountDTO();
        testAccount.setId("testUser");
        testAccount.setAccountType("SAVINGS");
        testAccount.setDeposit(BigDecimal.ZERO);
        testAccount.setAccountNumber(accountService.generateUniqueAccountNumber());
    }

    @Test
    public void testCreateAccount() {
        accountService.createAccount(testAccount);

        AccountDTO fetchedAccount = accountService.getAccountByNumber(testAccount.getAccountNumber());
        assertThat(fetchedAccount).isNotNull();
        assertThat(fetchedAccount.getId()).isEqualTo("testUser");
        assertThat(fetchedAccount.getAccountType()).isEqualTo("SAVINGS");
    }

    @Test
    public void testDepositMoney() {
        BigDecimal depositAmount = new BigDecimal("1000.00");
        accountService.createAccount(testAccount);
        accountService.depositMoney(testAccount.getAccountNumber(), testAccount.getAccountType(), depositAmount);

        AccountDTO updatedAccount = accountService.getAccountByNumber(testAccount.getAccountNumber());
        assertThat(updatedAccount).isNotNull();
        assertThat(updatedAccount.getDeposit()).isEqualByComparingTo(depositAmount);
    }

    // Similarly, you can write tests for other methods such as `withdrawMoney`, `listAccountsByUserId`, etc.
}
