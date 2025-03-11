package com.example.bookstore.dao;

import com.example.bookstore.models.Order;
import java.util.List;

public interface IOrderDAO {
    List<Order> getAllOrders();
    Order getOrderById(int id);
    void addOrder(Order order);
    void updateOrder(Order order);
    void deleteOrder(int id);
    List<Order> getOrdersByUserId(int userId);
    List<Order> getRecentOrders(int limit);
    int getTotalOrders();
    double getTotalRevenue();
} 