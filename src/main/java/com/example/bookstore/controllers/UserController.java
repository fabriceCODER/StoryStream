package com.example.bookstore.controllers;

import com.example.bookstore.models.User;
import com.example.bookstore.services.IUserService;
import com.example.bookstore.servicesImpl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(urlPatterns = {
    "/auth/login",
    "/auth/register",
    "/auth/logout"
})
public class UserController extends HttpServlet {
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();
        String pathInfo = request.getPathInfo();
        String lang = request.getParameter("lang");
        
        try {
            switch (servletPath) {
                case "/auth/login":
                    handleLogin(request, response);
                    break;
                case "/auth/register":
                    handleRegistration(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            System.err.println("Error in UserController.doPost: " + e.getMessage());
            e.printStackTrace();
            redirectWithLang(response, request.getContextPath() + "/login", "error=An unexpected error occurred", lang);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String lang = request.getParameter("lang");

        try {
            // Validate input
            if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                redirectWithLang(response, request.getContextPath() + "/login", "error=Please fill in all fields", lang);
                return;
            }

            // Get user from database
            User user = userService.getUserByUsername(username);

            // Check if user exists and password matches
            if (user != null && BCrypt.checkpw(password, user.getPassword())) {
                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userRole", user.getRole().toLowerCase());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("lang", lang); // Preserve language preference

                System.out.println("User logged in successfully: " + username + " with role: " + user.getRole());

                // Redirect based on role
                String redirectPath = "admin".equalsIgnoreCase(user.getRole()) ? 
                    "/admin/dashboard" : "/dashboard";
                redirectWithLang(response, request.getContextPath() + redirectPath, null, lang);
            } else {
                System.out.println("Login failed for user: " + username);
                redirectWithLang(response, request.getContextPath() + "/login", "error=Invalid username or password", lang);
            }
        } catch (Exception e) {
            System.err.println("Error in handleLogin: " + e.getMessage());
            e.printStackTrace();
            redirectWithLang(response, request.getContextPath() + "/login", "error=An error occurred during login", lang);
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String lang = request.getParameter("lang");

        try {
            // Validate input
            if (username == null || username.trim().isEmpty() || 
                password == null || password.trim().isEmpty() || 
                confirmPassword == null || confirmPassword.trim().isEmpty()) {
                redirectWithLang(response, request.getContextPath() + "/register", "error=Please fill in all fields", lang);
                return;
            }

            // Check password length
            if (password.length() < 6) {
                redirectWithLang(response, request.getContextPath() + "/register", 
                    "error=Password must be at least 6 characters long", lang);
                return;
            }

            // Check password match
            if (!password.equals(confirmPassword)) {
                redirectWithLang(response, request.getContextPath() + "/register", "error=Passwords do not match", lang);
                return;
            }

            // Check if username exists
            if (userService.getUserByUsername(username) != null) {
                redirectWithLang(response, request.getContextPath() + "/register", "error=Username already exists", lang);
                return;
            }

            // Create new user
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            User user = new User(username, hashedPassword);
            user.setRole("user"); // Set default role

            // Register user
            if (userService.registerUser(user)) {
                System.out.println("User registered successfully: " + username);
                redirectWithLang(response, request.getContextPath() + "/login", 
                    "message=Registration successful. Please login.", lang);
            } else {
                System.err.println("Failed to register user: " + username);
                redirectWithLang(response, request.getContextPath() + "/register", "error=Registration failed", lang);
            }
        } catch (Exception e) {
            System.err.println("Error in handleRegistration: " + e.getMessage());
            e.printStackTrace();
            redirectWithLang(response, request.getContextPath() + "/register", 
                "error=An error occurred during registration", lang);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();
        String lang = request.getParameter("lang");
        
        try {
            if ("/auth/logout".equals(servletPath)) {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    lang = (String) session.getAttribute("lang"); // Preserve language before invalidating session
                    session.invalidate();
                }
                redirectWithLang(response, request.getContextPath() + "/login", "message=Logged out successfully", lang);
            }
        } catch (Exception e) {
            System.err.println("Error in UserController.doGet: " + e.getMessage());
            e.printStackTrace();
            redirectWithLang(response, request.getContextPath() + "/login", "error=An unexpected error occurred", lang);
        }
    }

    private void redirectWithLang(HttpServletResponse response, String path, String queryParam, String lang) 
            throws IOException {
        StringBuilder redirectUrl = new StringBuilder(path);
        boolean hasQuery = false;

        if (lang != null && !lang.trim().isEmpty()) {
            redirectUrl.append("?lang=").append(lang);
            hasQuery = true;
        }

        if (queryParam != null && !queryParam.trim().isEmpty()) {
            redirectUrl.append(hasQuery ? "&" : "?").append(queryParam);
        }

        response.sendRedirect(redirectUrl.toString());
    }
}
