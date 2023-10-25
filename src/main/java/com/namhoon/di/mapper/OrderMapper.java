package com.namhoon.di.mapper;

import com.namhoon.di.dto.OrderDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrderMapper {
    void insertOrder(OrderDTO order);

    OrderDTO selectOrderById(Long orderId);

    List<OrderDTO> selectAllOrders();

    void updateOrder(OrderDTO order);

    void deleteOrder(Long orderId);
}
