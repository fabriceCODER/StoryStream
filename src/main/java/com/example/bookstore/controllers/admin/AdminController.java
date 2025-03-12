package com.example.bookstore.controllers.admin;

import com.example.bookstore.dao.*;
import com.example.bookstore.daoImpl.*;
import com.example.bookstore.models.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {
    "/admin/dashboard",
    "/admin/operations/books/*",
    "/admin/operations/users/*",
    "/admin/operations/orders/*",
    "/admin/operations/categories/*"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class AdminController extends HttpServlet {
    private final IBookDAO bookDAO = new BookDAOImpl();
    private final IUserDAO userDAO = new UserDAOImpl();
    private final ICategoryDAO categoryDAO = new CategoryDAOImpl();
    private final IOrderDAO orderDAO = new OrderDAOImpl();

    public AdminController() throws SQLException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getServletPath();
        String action = request.getPathInfo();

        try {
            switch (path) {
                case "/admin/dashboard":
                    showDashboard(request, response);
                    break;
                case "/admin/operations/books":
                    handleBookOperations(request, response, action);
                    break;
                case "/admin/operations/users":
                    handleUserOperations(request, response, action);
                    break;
                case "/admin/operations/orders":
                    handleOrderOperations(request, response, action);
                    break;
                case "/admin/operations/categories":
                    handleCategoryOperations(request, response, action);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            }
        } catch (Exception e) {
            System.err.println("Error in AdminController: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getServletPath();
        String action = request.getPathInfo();

        try {
            switch (path) {
                case "/admin/operations/books":
                    handleBookOperations(request, response, action);
                    break;
                case "/admin/operations/users":
                    handleUserOperations(request, response, action);
                    break;
                case "/admin/operations/orders":
                    handleOrderOperations(request, response, action);
                    break;
                case "/admin/operations/categories":
                    handleCategoryOperations(request, response, action);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            }
        } catch (Exception e) {
            System.err.println("Error in AdminController: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get dashboard statistics
        request.setAttribute("totalBooks", bookDAO.getTotalBooks());
        request.setAttribute("totalUsers", userDAO.getTotalUsers());
        request.setAttribute("totalOrders", orderDAO.getTotalOrders());
        request.setAttribute("totalRevenue", orderDAO.getTotalRevenue());
        request.setAttribute("recentOrders", orderDAO.getRecentOrders(5));

        // Forward to dashboard
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }

    private void handleBookOperations(HttpServletRequest request, HttpServletResponse response, String action) 
            throws ServletException, IOException {
        try {
            if (action == null) {
                // Show books list
                List<Book> books = bookDAO.getAllBooks();
                request.setAttribute("books", books);
                request.getRequestDispatcher("/WEB-INF/views/admin/operations/books.jsp").forward(request, response);
                return;
            }

            switch (action) {
                case "/add":
                    if (request.getMethod().equals("GET")) {
                        request.getRequestDispatcher("/WEB-INF/views/admin/operations/book-form.jsp").forward(request, response);
                    } else {
                        addBook(request, response);
                    }
                    break;
                case "/edit":
                    if (request.getMethod().equals("GET")) {
                        int id = Integer.parseInt(request.getParameter("id"));
                        Book book = bookDAO.getBookById(id);
                        if (book == null) {
                            response.sendRedirect(request.getContextPath() + "/admin/operations/books?error=Book not found");
                            return;
                        }
                        request.setAttribute("book", book);
                        request.getRequestDispatcher("/WEB-INF/views/admin/operations/book-form.jsp").forward(request, response);
                    } else {
                        editBook(request, response);
                    }
                    break;
                case "/delete":
                    deleteBook(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/operations/books");
            }
        } catch (Exception e) {
            System.err.println("Error in handleBookOperations: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your request");
            List<Book> books = bookDAO.getAllBooks();
            request.setAttribute("books", books);
            request.getRequestDispatcher("/WEB-INF/views/admin/operations/books.jsp").forward(request, response);
        }
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            if (title == null || title.trim().isEmpty() || 
                author == null || author.trim().isEmpty() || 
                description == null || description.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/operations/books/add?error=All fields are required");
                return;
            }

            Book book = new Book();
            book.setTitle(title.trim());
            book.setAuthor(author.trim());
            book.setPrice(price);
            book.setDescription(description.trim());
            book.setQuantity(quantity);

            boolean success = bookDAO.addBook(book);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/operations/books?message=Book added successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/operations/books/add?error=Failed to add book");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/operations/books/add?error=Invalid number format");
        }
    }

    private void editBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
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
                response.sendRedirect(request.getContextPath() + "/admin/operations/books/edit?id=" + bookId + "&error=All fields are required");
                return;
            }

            Book book = new Book();
            book.setId(bookId);
            book.setTitle(title.trim());
            book.setAuthor(author.trim());
            book.setPrice(price);
            book.setDescription(description.trim());
            book.setQuantity(quantity);

            bookDAO.updateBook(book);
            response.sendRedirect(request.getContextPath() + "/admin/operations/books?message=Book updated successfully");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/operations/books/edit?error=Invalid number format");
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            bookDAO.deleteBook(bookId);
            response.sendRedirect(request.getContextPath() + "/admin/operations/books?message=Book deleted successfully");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/operations/books?error=Invalid book ID");
        }
    }

    private void handleUserOperations(HttpServletRequest request, HttpServletResponse response, String action) 
            throws ServletException, IOException {
        // TODO: Implement user operations
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }

    private void handleOrderOperations(HttpServletRequest request, HttpServletResponse response, String action) 
            throws ServletException, IOException {
        // TODO: Implement order operations
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }

    private void handleCategoryOperations(HttpServletRequest request, HttpServletResponse response, String action) 
            throws ServletException, IOException {
        // TODO: Implement category operations
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
} 