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
    "/auth/logout",
    "/user/*"
})
public class UserController extends HttpServlet {
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();
        
        if (servletPath.startsWith("/auth")) {
            handleAuthRequest(request, response);
        } else if (servletPath.startsWith("/user")) {
            handleUserRequest(request, response);
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

        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?error=Please fill in all fields");
            return;
        }

        User user = userService.getUserByUsername(username);

        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userRole", user.getRole());

            // Check for redirect URL in session
            String redirectUrl = (String) session.getAttribute("redirectUrl");
            if (redirectUrl != null) {
                session.removeAttribute("redirectUrl");
                response.sendRedirect(request.getContextPath() + redirectUrl);
            } else {
                if ("admin".equals(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/views/admin/admin_dashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/views/users/dashboard.jsp");
                }
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?error=Invalid credentials");
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (username == null || username.isEmpty() || password == null || password.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/auth/register.jsp?error=Please fill in all fields");
            return;
        }

        if (!password.equals(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + "/auth/register.jsp?error=Passwords do not match");
            return;
        }

        if (userService.getUserByUsername(username) != null) {
            response.sendRedirect(request.getContextPath() + "/auth/register.jsp?error=Username already exists");
            return;
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        User user = new User(username, hashedPassword);
        user.setRole("user");
        userService.registerUser(user);
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp?message=Registration successful");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();
        
        if ("/auth/logout".equals(servletPath)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?message=Logged out successfully");
        } else if (servletPath.startsWith("/user")) {
            handleUserGetRequest(request, response);
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
