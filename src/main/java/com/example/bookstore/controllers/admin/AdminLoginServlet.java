package com.example.bookstore.controllers.admin;

import com.example.bookstore.dao.UserDAO;
import com.example.bookstore.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {
    "/admin/auth/login",    // Main login URL
    "/admin/login",         // Alternative URL
    "/admin"               // Root admin URL
})
public class AdminLoginServlet extends BaseAdminController {
    
    private static final String LOGIN_JSP = "/WEB-INF/views/admin/auth/login.jsp";
    private static final String DASHBOARD_URL = "/admin/dashboard";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if admin is already logged in
        if (isAdminLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + DASHBOARD_URL);
            return;
        }
        
        // Forward to login page
        request.getRequestDispatcher(LOGIN_JSP).forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String lang = getLanguage(request);
        
        // Validate input
        if (username == null || username.trim().isEmpty() 
                || password == null || password.trim().isEmpty()) {
            redirectWithError(response, request.getContextPath(), 
                    "admin.error.credentials.required", lang);
            return;
        }
        
        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.authenticate(username, password);
            
            if (user != null && "admin".equalsIgnoreCase(user.getRole())) {
                // Create session and set attributes
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userRole", "admin");
                session.setAttribute("username", user.getUsername());
                
                // Log successful login
                System.out.println("Admin login successful: " + username);
                
                // Redirect to dashboard or saved URL
                String redirectUrl = getRedirectUrl(request);
                if (redirectUrl != null && redirectUrl.startsWith("/admin/")) {
                    response.sendRedirect(request.getContextPath() + redirectUrl);
                } else {
                    response.sendRedirect(request.getContextPath() + DASHBOARD_URL);
                }
            } else {
                // Log failed login attempt
                System.out.println("Admin login failed: " + username);
                
                // Redirect with error
                redirectWithError(response, request.getContextPath(), 
                        "admin.error.invalid.credentials", lang);
            }
        } catch (Exception e) {
            // Log the error
            System.err.println("Error during admin login: " + e.getMessage());
            e.printStackTrace();
            
            // Redirect with error
            redirectWithError(response, request.getContextPath(), 
                    "admin.error.system", lang);
        }
    }
    
    private void redirectWithError(HttpServletResponse response, String contextPath, 
            String errorKey, String lang) throws IOException {
        response.sendRedirect(String.format("%s/admin/auth/login?error=%s&lang=%s",
                contextPath, errorKey, lang));
    }
} 