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
    "/auth/admin/login",
    "/auth/admin/register",
    "/auth/logout",
    "/user/*"
})
public class UserController extends HttpServlet {
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();
        String pathInfo = request.getPathInfo();

        try {
            if (servletPath.startsWith("/auth")) {
                handleAuthGetRequest(request, response);
            } else if (servletPath.startsWith("/user")) {
                handleUserGetRequest(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error in UserController.doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        try {
            if (servletPath.startsWith("/auth")) {
                handleAuthRequest(request, response);
            } else if (servletPath.startsWith("/user")) {
                handleUserPostRequest(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error in UserController.doPost: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    private void handleAuthGetRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        String lang = request.getParameter("lang");

        if (path.endsWith("/login")) {
            request.getRequestDispatcher("/auth/admin/login.jsp").forward(request, response);
        } else if (path.endsWith("/register")) {
            request.getRequestDispatcher("/auth/admin/register.jsp").forward(request, response);
        } else if (path.endsWith("/logout")) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/auth/admin/login?message=Logged out successfully" +
                (lang != null ? "&lang=" + lang : ""));
        }
    }

    private void handleUserGetRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        User user = userService.getUserByUsername(username);
        request.setAttribute("user", user);

        if (pathInfo == null || pathInfo.equals("/")) {
            request.getRequestDispatcher("/views/users/dashboard.jsp").forward(request, response);
        } else if (pathInfo.equals("/profile")) {
            request.getRequestDispatcher("/views/users/profile.jsp").forward(request, response);
        } else if (pathInfo.equals("/orders")) {
            request.getRequestDispatcher("/views/users/orders.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
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
                response.sendRedirect(request.getContextPath() + "/auth/login?error=Please fill in all fields" + 
                    (lang != null ? "&lang=" + lang : ""));
                return;
            }

            // Get user from database
            User user = userService.getUserByUsername(username);

            // Check if user exists and password matches
            if (user != null && BCrypt.checkpw(password, user.getPassword())) {
                // Create session
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                session.setAttribute("userRole", user.getRole().toLowerCase());
                session.setAttribute("username", user.getUsername());
                if (lang != null) {
                    session.setAttribute("lang", lang);
                }

                // Check for redirect URL in session
                String redirectUrl = (String) session.getAttribute("redirectUrl");
                if (redirectUrl != null) {
                    session.removeAttribute("redirectUrl");
                    response.sendRedirect(request.getContextPath() + redirectUrl);
                } else {
                    // Default redirect based on role
                    if ("admin".equalsIgnoreCase(user.getRole())) {
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/user/dashboard");
                    }
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/auth/login?error=Invalid username or password" + 
                    (lang != null ? "&lang=" + lang : ""));
            }
        } catch (Exception e) {
            System.err.println("Error in handleLogin: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/auth/login?error=An error occurred during login" + 
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
                response.sendRedirect(request.getContextPath() + "/auth/register?error=Please fill in all fields" + 
                    (lang != null ? "&lang=" + lang : ""));
                return;
            }

            // Check password length
            if (password.length() < 6) {
                response.sendRedirect(request.getContextPath() + "/auth/register?error=Password must be at least 6 characters long" + 
                    (lang != null ? "&lang=" + lang : ""));
                return;
            }

            // Check password match
            if (!password.equals(confirmPassword)) {
                response.sendRedirect(request.getContextPath() + "/auth/register?error=Passwords do not match" + 
                    (lang != null ? "&lang=" + lang : ""));
                return;
            }

            // Check if username exists
            if (userService.getUserByUsername(username) != null) {
                response.sendRedirect(request.getContextPath() + "/auth/register?error=Username already exists" + 
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

                response.sendRedirect(request.getContextPath() + "/user/dashboard" + 
                    (lang != null ? "?lang=" + lang : ""));
            } else {
                response.sendRedirect(request.getContextPath() + "/auth/register?error=Registration failed" + 
                    (lang != null ? "&lang=" + lang : ""));
            }
        } catch (Exception e) {
            System.err.println("Error in handleRegistration: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/auth/register?error=An error occurred during registration" + 
                (lang != null ? "&lang=" + lang : ""));
        }
    }

    private void handleUserPostRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        String action = request.getParameter("action");

        if (pathInfo.equals("/profile")) {
            if ("update".equals(action)) {
                updateProfile(request, response);
            } else if ("changePassword".equals(action)) {
                changePassword(request, response);
            }
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        User user = userService.getUserByUsername(username);

        // Update user profile logic here
        // TODO: Implement profile update functionality

        response.sendRedirect(request.getContextPath() + "/user/profile?message=Profile updated successfully");
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        User user = userService.getUserByUsername(username);

        if (!BCrypt.checkpw(currentPassword, user.getPassword())) {
            response.sendRedirect(request.getContextPath() + "/user/profile?error=Current password is incorrect");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + "/user/profile?error=New passwords do not match");
            return;

        }

        // Update password logic here
        // TODO: Implement password change functionality

        response.sendRedirect(request.getContextPath() + "/user/profile?message=Password changed successfully");
    }
}
