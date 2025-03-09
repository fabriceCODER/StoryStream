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

@WebServlet("/user")
public class UserController extends HttpServlet {
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Handling login action
        if ("login".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Basic validations for empty fields
            if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
                response.sendRedirect("login.jsp?error=Please fill in all fields");
                return;
            }

            // Fetch user from the service layer
            User user = userService.getUserByUsername(username);

            // Check if user exists and password matches
            if (user != null && BCrypt.checkpw(password, user.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("admin_dashboard.jsp");  // Redirect to dashboard after successful login
            } else {
                response.sendRedirect("login.jsp?error=Invalid credentials");
            }
        }

        // Handling registration action
        else if ("register".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            // Validate fields
            if (username == null || username.isEmpty() || password == null || password.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) {
                response.sendRedirect("register.jsp?error=Please fill in all fields");
                return;
            }

            // Check if passwords match
            if (!password.equals(confirmPassword)) {
                response.sendRedirect("register.jsp?error=Passwords do not match");
                return;
            }

            // Hash the password before saving
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            // Create user object and register it
            User user = new User(username, hashedPassword);
            userService.registerUser(user);
            response.sendRedirect("login.jsp");  // Redirect to login page after successful registration
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Handling logout action
        if ("logout".equals(action)) {
            HttpSession session = request.getSession();
            session.invalidate();  // Invalidate session to log out the user
            response.sendRedirect("login.jsp?message=Logged out successfully");  // Redirect to login page with success message
        }
    }
}
