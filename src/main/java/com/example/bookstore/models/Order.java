package com.example.bookstore.models;

import java.util.Date;
import java.util.List;

public class Order {
    private int id;
    private int userId;
    private List<Book> books;
    private double totalAmount;
    private Date orderDate;
    private String status; // "PENDING", "SHIPPED", "DELIVERED"

    public Order() {}

    public Order(int id, int userId, List<Book> books, double totalAmount, Date orderDate, String status) {
        this.id = id;
        this.userId = userId;
        this.books = books;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<Book> getBooks() {
        return books;
    }

    public void setBooks(List<Book> books) {
        this.books = books;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
