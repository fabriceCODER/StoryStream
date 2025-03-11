package com.example.bookstore.controllers.admin;

import com.example.bookstore.dao.IUserDAO;
import com.example.bookstore.dao.IBookDAO;
import com.example.bookstore.models.Book;
import com.example.bookstore.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends BaseAdminController {
    
    private static final String DASHBOARD_JSP = "/WEB-INF/views/admin/dashboard.jsp";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get statistics
            Map<String, Object> stats = getDashboardStats();
            
            // Set attributes for JSP
            for (Map.Entry<String, Object> stat : stats.entrySet()) {
                request.setAttribute(stat.getKey(), stat.getValue());
            }
            
            // Get any success/error messages from the session
            String message = (String) request.getSession().getAttribute("dashboardMessage");
            String error = (String) request.getSession().getAttribute("dashboardError");
            
            if (message != null) {
                request.setAttribute("message", message);
                request.getSession().removeAttribute("dashboardMessage");
            }
            if (error != null) {
                request.setAttribute("error", error);
                request.getSession().removeAttribute("dashboardError");
            }
            
            // Forward to dashboard JSP
            request.getRequestDispatcher(DASHBOARD_JSP).forward(request, response);
            
        } catch (Exception e) {
            // Log the error
            System.err.println("Error loading admin dashboard: " + e.getMessage());
            e.printStackTrace();
            
            // Set error message and forward
            request.setAttribute("error", "admin.error.dashboard.load");
            request.getRequestDispatcher(DASHBOARD_JSP).forward(request, response);
        }
    }
    
    private Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        try {
            IUserDAO userDAO = new IUserDAO() {
                @Override
                public User loginUser(String username, String password) {
                    return null;
                }

                @Override
                public boolean registerUser(User user) {
                    return false;
                }

                @Override
                public User getUserById(int id) {
                    return null;
                }

                @Override
                public User getUserByUsername(String username) {
                    return null;
                }

                @Override
                public User authenticate(String username, String password) {
                    return null;
                }

                @Override
                public User findByUsername(String username) {
                    return null;
                }

                @Override
                public void save(User user) {

                }

                @Override
                public long getTotalUsers() {
                    return 0;
                }
            };
            IBookDAO bookDAO = new IBookDAO() {
                @Override
                public List<Book> getAllBooks() {
                    return List.of();
                }

                @Override
                public Book getBookById(int id) {
                    return null;
                }

                @Override
                public boolean addBook(Book book) {
                    return false;
                }

                @Override
                public boolean updateBook(Book book) {
                    return false;
                }

                @Override
                public boolean deleteBook(int id) {
                    return false;
                }

                @Override
                public List<Book> getRecentBooks(int limit) {
                    return List.of();
                }

                @Override
                public Object getTotalBooks() {
                    return null;
                }

                @Override
                public Object getLowStockBooks() {
                    return null;
                }
            };

            
            // Get various statistics
            stats.put("totalUsers", userDAO.getTotalUsers());
            stats.put("totalBooks", bookDAO.getTotalBooks());
            stats.put("lowStockBooks", bookDAO.getLowStockBooks());

            
        } catch (Exception e) {
            System.err.println("Error getting dashboard stats: " + e.getMessage());
            e.printStackTrace();
        }
        return stats;
    }
} 