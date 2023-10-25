package com.namhoon.di;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.times;
import com.namhoon.di.dto.AccountTransactionDTO;
import com.namhoon.di.mapper.AccountTransactionMapper;
import com.namhoon.di.service.AccountTransactionService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;

class AccountTransactionServiceTest {

    @Mock
    private AccountTransactionMapper transactionMapper;

    @InjectMocks
    private AccountTransactionService transactionService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void testCreateTransaction() {
        AccountTransactionDTO transactionDTO = new AccountTransactionDTO();
        transactionService.createTransaction(transactionDTO);

        verify(transactionMapper, times(1)).insertTransaction(transactionDTO);
    }

    @Test
    void testGetTransactionById() {
        Long id = 1L;
        AccountTransactionDTO transactionDTO = new AccountTransactionDTO();
        when(transactionMapper.selectTransactionById(id)).thenReturn(transactionDTO);

        AccountTransactionDTO fetched = transactionService.getTransactionById(id);
        assertEquals(transactionDTO, fetched);
    }

    @Test
    void testGetAllTransactions() {
        List<AccountTransactionDTO> transactions = Arrays.asList(new AccountTransactionDTO(), new AccountTransactionDTO());
        when(transactionMapper.selectAllTransactions()).thenReturn(transactions);

        List<AccountTransactionDTO> fetched = transactionService.getAllTransactions();
        assertEquals(transactions, fetched);
    }

    @Test
    void testUpdateTransaction() {
        AccountTransactionDTO transactionDTO = new AccountTransactionDTO();
        transactionService.updateTransaction(transactionDTO);

        verify(transactionMapper, times(1)).updateTransaction(transactionDTO);
    }

    @Test
    void testDeleteTransaction() {
        Long id = 1L;
        transactionService.deleteTransaction(id);

        verify(transactionMapper, times(1)).deleteTransaction(id);
    }
}