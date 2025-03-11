package com.example.bookstore.services;

import com.example.bookstore.models.Book;
import java.util.List;

public interface IBookService {
    List<Book> getAllBooks();
    Book getBookById(int id);
    boolean addBook(Book book);
    boolean updateBook(Book book);
    boolean deleteBook(int id);
    List<Book> getRecentBooks(int limit);
}
