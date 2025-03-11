package com.example.bookstore.controllers.admin;

import com.example.bookstore.dao.IUserDAO;
import com.example.bookstore.dao.IBookDAO;
import com.example.bookstore.daoImpl.UserDAOImpl;
import com.example.bookstore.daoImpl.BookDAOImpl;
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
    private final IUserDAO userDAO = new UserDAOImpl();
    private final IBookDAO bookDAO = new BookDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if admin is logged in
        if (!isAdminLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/admin/auth/login");
            return;
        }
        
        try {
            // Get dashboard statistics
            Map<String, Object> stats = getDashboardStats();
            
            // Set attributes for JSP
            for (Map.Entry<String, Object> stat : stats.entrySet()) {
                request.setAttribute(stat.getKey(), stat.getValue());
            }
            
            // Forward to dashboard page
            request.getRequestDispatcher(DASHBOARD_JSP).forward(request, response);
        } catch (Exception e) {
            System.err.println("Error loading dashboard: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/auth/login?error=admin.error.dashboard.load");
        }
    }
    
    private Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        try {
            // Get various statistics
            stats.put("totalUsers", userDAO.getTotalUsers());
            stats.put("totalBooks", bookDAO.getTotalBooks());
            stats.put("lowStockBooks", bookDAO.getLowStockBooks());
            stats.put("totalOrders", 0); // TODO: Implement OrderDAO
            stats.put("totalRevenue", 0.0); // TODO: Implement OrderDAO
            stats.put("recentOrders", List.of()); // TODO: Implement OrderDAO
            
        } catch (Exception e) {
            System.err.println("Error getting dashboard stats: " + e.getMessage());
            e.printStackTrace();
        }
        return stats;
    }
} 