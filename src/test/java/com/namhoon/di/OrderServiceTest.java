package com.namhoon.di;

import com.namhoon.di.dto.OrderDTO;

import static org.junit.jupiter.api.Assertions.*;

import com.namhoon.di.mapper.OrderMapper;
import com.namhoon.di.service.OrderService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Collections;
import java.util.List;

import static org.mockito.Mockito.*;

class OrderServiceTest {

    @Mock
    private OrderMapper orderMapper;

    @InjectMocks
    private OrderService orderService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void createOrderTest() {
        OrderDTO order = new OrderDTO();
        orderService.createOrder(order);
        verify(orderMapper, times(1)).insertOrder(order);
    }

    @Test
    void getOrderByIdTest() {
        Long id = 1L;
        orderService.getOrderById(id);
        verify(orderMapper, times(1)).selectOrderById(id);
    }

    @Test
    void getAllOrdersTest() {
        List<OrderDTO> mockList = Collections.singletonList(new OrderDTO());
        when(orderMapper.selectAllOrders()).thenReturn(mockList);

        List<OrderDTO> resultList = orderService.getAllOrders();

        assertFalse(resultList.isEmpty());
        verify(orderMapper, times(1)).selectAllOrders();
    }

    @Test
    void updateOrderTest() {
        OrderDTO order = new OrderDTO();
        orderService.updateOrder(order);
        verify(orderMapper, times(1)).updateOrder(order);
    }

    @Test
    void deleteOrderTest() {
        Long id = 1L;
        orderService.deleteOrder(id);
        verify(orderMapper, times(1)).deleteOrder(id);
    }
}
