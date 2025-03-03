package com.example.bookstore.models;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<Book> books;
    private double totalPrice;

    public Cart() {
        this.books = new ArrayList<>();
        this.totalPrice = 0.0;
    }

    public List<Book> getBooks() {
        return books;
    }

    public void addBook(Book book) {
        this.books.add(book);
        this.totalPrice += book.getPrice();
    }

    public void removeBook(Book book) {
        this.books.remove(book);
        this.totalPrice -= book.getPrice();
    }

    public void clearCart() {
        this.books.clear();
        this.totalPrice = 0.0;
    }

    public double getTotalPrice() {
        return totalPrice;
    }
}
