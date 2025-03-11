package com.example.bookstore.controllers;

import com.example.bookstore.models.Book;
import com.example.bookstore.models.Order;
import com.example.bookstore.models.User;
import com.example.bookstore.services.IBookService;
import com.example.bookstore.servicesImpl.BookServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/order")
public class OrderController extends HttpServlet {
    private final IBookService bookService = new BookServiceImpl();

    public OrderController() throws SQLException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String[] bookIds = request.getParameterValues("bookId");
        List<Book> books = new ArrayList<>();
        double totalAmount = 0;

        for (String bookId : bookIds) {
            Book book = bookService.getBookById(Integer.parseInt(bookId));
            books.add(book);
            totalAmount += book.getPrice();
        }

        Order order = new Order(0, user.getId(), books, totalAmount, new java.util.Date(), "PENDING");
        session.setAttribute("order", order);

        response.sendRedirect("orderConfirmation.jsp");
    }
}
