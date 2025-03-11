package com.example.bookstore.controllers.admin;

import com.example.bookstore.dao.IUserDAO;
import com.example.bookstore.daoImpl.UserDAOImpl;
import com.example.bookstore.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/auth/login")
public class AdminLoginServlet extends BaseAdminController {
    
    private static final String LOGIN_JSP = "/views/admin/auth/login.jsp";
    private static final String DASHBOARD_URL = "/admin/dashboard";
    private final IUserDAO userDAO = new UserDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            String userRole = (String) session.getAttribute("userRole");
            response.sendRedirect(request.getContextPath() + 
                ("admin".equalsIgnoreCase(userRole) ? DASHBOARD_URL : "/user/dashboard"));
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
        
        // Quick validation
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            redirectWithError(request, response, "admin.error.credentials.required");
            return;
        }
        
        try {
            // Authenticate user
            User user = userDAO.authenticate(username, password);
            if (user == null) {
                redirectWithError(request, response, "admin.error.invalid.credentials");
                return;
            }

            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userRole", user.getRole().toLowerCase());
            session.setAttribute("username", user.getUsername());
            if (lang != null) session.setAttribute("lang", lang);
            
            // Redirect based on role
            String redirectUrl = getRedirectUrl(request);
            if (redirectUrl != null) {
                response.sendRedirect(request.getContextPath() + redirectUrl);
            } else {
                response.sendRedirect(request.getContextPath() + 
                    ("admin".equalsIgnoreCase(user.getRole()) ? DASHBOARD_URL : "/user/dashboard"));
            }
        } catch (Exception e) {
            System.err.println("Login error: " + e.getMessage());
            redirectWithError(request, response, "admin.error.system");
        }
    }
    
    private void redirectWithError(HttpServletRequest request, HttpServletResponse response, String errorKey) 
            throws IOException {
        response.sendRedirect(String.format("%s/admin/auth/login?error=%s&lang=%s",
                request.getContextPath(), errorKey, getLanguage(request)));
    }
} 