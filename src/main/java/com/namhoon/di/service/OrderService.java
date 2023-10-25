package com.namhoon.di.service;

import com.namhoon.di.dto.OrderDTO;
import com.namhoon.di.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {
    @Autowired
    private OrderMapper orderMapper;

    public void createOrder(OrderDTO order) {
        orderMapper.insertOrder(order);
    }

    public OrderDTO getOrderById(Long orderId) {
        return orderMapper.selectOrderById(orderId);
    }

    public List<OrderDTO> getAllOrders() {
        return orderMapper.selectAllOrders();
    }

    public void updateOrder(OrderDTO order) {
        orderMapper.updateOrder(order);
    }

    public void deleteOrder(Long orderId) {
        orderMapper.deleteOrder(orderId);
    }



}
