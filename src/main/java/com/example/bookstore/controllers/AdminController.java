package com.example.bookstore.controllers;

import com.example.bookstore.models.Book;
import com.example.bookstore.services.IBookService;
import com.example.bookstore.servicesImpl.BookServiceImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    private IBookService bookService;

    @Override
    public void init() {
        bookService = new BookServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("manage_books".equals(action)) {
            manageBooks(request, response);
        } else {
            response.sendRedirect("admin_dashboard.jsp");
        }
    }

    private void manageBooks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Book> books = bookService.getAllBooks();
        request.setAttribute("books", books);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/admin/manage_books.jsp");
        dispatcher.forward(request, response);
    }
}
