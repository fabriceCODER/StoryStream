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

@WebServlet(urlPatterns = {
    "/admin/books",
    "/admin/orders",
    "/admin/users",
    "/admin/reports",
    "/admin/settings"
})
public class AdminController extends HttpServlet {
    private IBookService bookService;

    @Override
    public void init() {
        bookService = new BookServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String servletPath = request.getServletPath();
            String action = request.getParameter("action");
            String message = request.getParameter("message");
            String error = request.getParameter("error");

            // Set any messages or errors
            if (message != null) request.setAttribute("message", message);
            if (error != null) request.setAttribute("error", error);

            // Handle books section
            if (servletPath.equals("/admin/books")) {
                if ("add".equals(action)) {
                    showAddBookForm(request, response);
                } else if ("edit".equals(action)) {
                    showEditBookForm(request, response);
                } else if ("delete".equals(action)) {
                    showDeleteConfirmation(request, response);
                } else {
                    manageBooks(request, response);
                }
                return;
            }

            // Handle orders section
            if (servletPath.equals("/admin/orders")) {
                manageOrders(request, response);
                return;
            }

            // Default to 404 if no matching path
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        } catch (Exception e) {
            System.err.println("Error in AdminController.doGet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your request");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String servletPath = request.getServletPath();
            String action = request.getParameter("action");

            if (servletPath.equals("/admin/books")) {
                if ("add".equals(action)) {
                    addBook(request, response);
                } else if ("edit".equals(action)) {
                    editBook(request, response);
                } else if ("delete".equals(action)) {
                    deleteBook(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action specified");
                }
                return;
            }

            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        } catch (NumberFormatException e) {
            System.err.println("Invalid number format: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/books?error=Invalid number format");
        } catch (Exception e) {
            System.err.println("Error in AdminController.doPost: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/books?error=An error occurred while processing your request");
        }
    }

    private void manageBooks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Book> books = bookService.getAllBooks();
            request.setAttribute("books", books);
            request.getRequestDispatcher("/views/admin/manage_books.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error managing books: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error loading books data");
            request.getRequestDispatcher("/views/admin/manage_books.jsp").forward(request, response);
        }
    }

    private void showAddBookForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/add_book.jsp").forward(request, response);
    }

    private void showEditBookForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            Book book = bookService.getBookById(bookId);
            if (book == null) {
                response.sendRedirect(request.getContextPath() + "/admin/books?error=Book not found");
                return;
            }
            request.setAttribute("book", book);
            request.getRequestDispatcher("/views/admin/edit_book.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/books?error=Invalid book ID");
        }
    }

    private void showDeleteConfirmation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            Book book = bookService.getBookById(bookId);
            if (book == null) {
                response.sendRedirect(request.getContextPath() + "/admin/books?error=Book not found");
                return;
            }
            request.setAttribute("book", book);
            request.getRequestDispatcher("/views/admin/deleteBook.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/books?error=Invalid book ID");
        }
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            if (title == null || title.trim().isEmpty() || 
                author == null || author.trim().isEmpty() || 
                description == null || description.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/books?action=add&error=All fields are required");
                return;
            }

            Book book = new Book();
            book.setTitle(title.trim());
            book.setAuthor(author.trim());
            book.setPrice(price);
            book.setDescription(description.trim());
            book.setQuantity(quantity);

            bookService.addBook(book);
            response.sendRedirect(request.getContextPath() + "/admin/books?message=Book added successfully");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/books?action=add&error=Invalid number format");
        }
    }

    private void editBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            if (title == null || title.trim().isEmpty() || 
                author == null || author.trim().isEmpty() || 
                description == null || description.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/books?action=edit&id=" + bookId + "&error=All fields are required");
                return;
            }

            Book book = new Book();
            book.setId(bookId);
            book.setTitle(title.trim());
            book.setAuthor(author.trim());
            book.setPrice(price);
            book.setDescription(description.trim());
            book.setQuantity(quantity);

            bookService.updateBook(book);
            response.sendRedirect(request.getContextPath() + "/admin/books?message=Book updated successfully");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/books?action=edit&error=Invalid number format");
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            bookService.deleteBook(bookId);
            response.sendRedirect(request.getContextPath() + "/admin/books?message=Book deleted successfully");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/books?error=Invalid book ID");
        }
    }

    private void manageOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/manage_orders.jsp").forward(request, response);
    }
}
