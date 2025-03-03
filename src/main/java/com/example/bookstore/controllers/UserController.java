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

        if (action.equals("login")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Validations
            if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
                response.sendRedirect("login.jsp?error=Please fill in all fields");
                return;
            }

            User user = userService.getUserByUsername(username);

            if (user != null && BCrypt.checkpw(password, user.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=Invalid credentials");
            }
        } else if (action.equals("register")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Validations
            if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
                response.sendRedirect("register.jsp?error=Please fill in all fields");
                return;
            }

            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            User user = new User(username, hashedPassword);
            userService.registerUser(user);
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("logout")) {
            HttpSession session = request.getSession();
            session.invalidate();  // Invalidate the session
            response.sendRedirect("login.jsp?message=Logged out successfully");
        }
    }
}
