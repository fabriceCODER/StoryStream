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
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet(urlPatterns = {
    "/auth/login",
    "/auth/register",
    "/auth/logout",
    "/user/*"
})
public class UserController extends HttpServlet {
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        try {
            if (servletPath.startsWith("/auth")) {
                handleAuthRequest(request, response);
            } else if (servletPath.startsWith("/user")) {
                handleUserRequest(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error in UserController.doPost: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login?error=An unexpected error occurred");
        }
    }

    private void handleAuthRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if (path.endsWith("/login")) {
            handleLogin(request, response);
        } else if (path.endsWith("/register")) {
            handleRegistration(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String lang = request.getParameter("lang");

        try {
            // Validate input
            if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/login?error=Please fill in all fields" + 
                    (lang != null ? "&lang=" + lang : ""));
                return;
            }

            // Get user from database
            User user = userService.getUserByUsername(username);

            // Check if user exists and password matches
            if (user != null && BCrypt.checkpw(password, user.getPassword())) {
                // Create session
                HttpSession session = request.getSession(true); // Create new session if none exists
                session.setAttribute("user", user);
                session.setAttribute("userRole", user.getRole().toLowerCase());
                session.setAttribute("username", user.getUsername());
                if (lang != null) {
                    session.setAttribute("lang", lang);
                }

                System.out.println("User logged in successfully: " + username + " with role: " + user.getRole());

                // Redirect based on role
                String redirectUrl = request.getContextPath() + 
                    ("admin".equalsIgnoreCase(user.getRole()) ? "/admin/dashboard" : "/dashboard");
                if (lang != null) {
                    redirectUrl += "?lang=" + lang;
                }
                response.sendRedirect(redirectUrl);
            } else {
                System.out.println("Login failed for user: " + username);
                response.sendRedirect(request.getContextPath() + "/login?error=Invalid username or password" + 
                    (lang != null ? "&lang=" + lang : ""));
            }
        } catch (Exception e) {
            System.err.println("Error in handleLogin: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login?error=An error occurred during login" + 
                (lang != null ? "&lang=" + lang : ""));
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
                response.sendRedirect(request.getContextPath() + "/register?error=Please fill in all fields" + 
                    (lang != null ? "&lang=" + lang : ""));
                return;
            }

            // Check password length
            if (password.length() < 6) {
                response.sendRedirect(request.getContextPath() + "/register?error=Password must be at least 6 characters long" + 
                    (lang != null ? "&lang=" + lang : ""));
                return;
            }

            // Check password match
            if (!password.equals(confirmPassword)) {
                response.sendRedirect(request.getContextPath() + "/register?error=Passwords do not match" + 
                    (lang != null ? "&lang=" + lang : ""));
                return;
            }

            // Check if username exists
            if (userService.getUserByUsername(username) != null) {
                response.sendRedirect(request.getContextPath() + "/register?error=Username already exists" + 
                    (lang != null ? "&lang=" + lang : ""));
                return;
            }

            // Create new user
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            User user = new User(username, hashedPassword);
            user.setRole("user"); // Set default role

            // Register user and auto-login
            if (userService.registerUser(user)) {
                // Create session for auto-login
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                session.setAttribute("userRole", user.getRole().toLowerCase());
                session.setAttribute("username", user.getUsername());
                if (lang != null) {
                    session.setAttribute("lang", lang);
                }

                System.out.println("User registered and logged in successfully: " + username);
                response.sendRedirect(request.getContextPath() + "/dashboard" + 
                    (lang != null ? "?lang=" + lang : ""));
            } else {
                System.err.println("Failed to register user: " + username);
                response.sendRedirect(request.getContextPath() + "/register?error=Registration failed" + 
                    (lang != null ? "&lang=" + lang : ""));
            }
        } catch (Exception e) {
            System.err.println("Error in handleRegistration: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/register?error=An error occurred during registration" + 
                (lang != null ? "&lang=" + lang : ""));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        try {
            if ("/auth/logout".equals(servletPath)) {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                response.sendRedirect(request.getContextPath() + "/login?message=Logged out successfully");
            } else if (servletPath.startsWith("/user")) {
                handleUserGetRequest(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error in UserController.doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login?error=An unexpected error occurred");
        }
    }

    private void handleUserGetRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            request.getRequestDispatcher("/views/users/profile.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleUserRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            request.getRequestDispatcher("/views/users/profile.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
