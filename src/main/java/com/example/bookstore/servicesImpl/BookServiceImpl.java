package com.example.bookstore.servicesImpl;

import com.example.bookstore.dao.IBookDAO;
import com.example.bookstore.daoImpl.BookDAOImpl;
import com.example.bookstore.models.Book;
import com.example.bookstore.services.IBookService;
import java.util.List;

public class BookServiceImpl implements IBookService {
    private final IBookDAO bookDAO = new BookDAOImpl();

    @Override
    public List<Book> getAllBooks() {
        return bookDAO.getAllBooks();
    }

    @Override
    public Book getBookById(int id) {
        return bookDAO.getBookById(id);
    }

    @Override
    public boolean addBook(Book book) {
        return bookDAO.addBook(book);
    }

    @Override
    public boolean updateBook(Book book) {
        return bookDAO.updateBook(book);
    }

    @Override
    public boolean deleteBook(int id) {
        return bookDAO.deleteBook(id);
    }

    @Override
    public List<Book> getRecentBooks(int limit) {
        return bookDAO.getRecentBooks(limit);
    }
}
