package com.example.bookstore.controllers;

import com.example.bookstore.models.Book;
import com.example.bookstore.services.IBookService;
import com.example.bookstore.servicesImpl.BookServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/books")
public class BookController extends HttpServlet {
    private final IBookService bookService = new BookServiceImpl();

    public BookController() throws SQLException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            List<Book> books = bookService.getAllBooks();
            request.setAttribute("books", books);
            request.getRequestDispatcher("books.jsp").forward(request, response);
        } else if (action.equals("view")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Book book = bookService.getBookById(id);
            request.setAttribute("book", book);
            request.getRequestDispatcher("viewBook.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("add")) {
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            double price = Double.parseDouble(request.getParameter("price"));

            Book book = new Book(title, author, price);
            bookService.addBook(book);
            response.sendRedirect("books");
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            bookService.deleteBook(id);
            response.sendRedirect("books");
        }
    }
}
