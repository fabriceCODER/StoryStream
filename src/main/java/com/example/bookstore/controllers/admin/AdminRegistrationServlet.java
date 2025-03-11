package com.example.bookstore.controllers.admin;

import com.example.bookstore.dao.IUserDAO;
import com.example.bookstore.daoImpl.UserDAOImpl;
import com.example.bookstore.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/auth/register")
public class AdminRegistrationServlet extends BaseAdminController {

    private static final String REGISTER_JSP = "/views/admin/auth/register.jsp";
    private static final String LOGIN_URL = "/auth/login";
    private static final String ADMIN_CODE = "ADMIN123"; // In production, use secure storage
    private final IUserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If already logged in, redirect to appropriate dashboard
        if (isAdminLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        request.getRequestDispatcher(REGISTER_JSP).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String adminCode = request.getParameter("adminCode");
        String lang = getLanguage(request);

        // Quick validation
        if (!validateInput(username, email, password, confirmPassword, adminCode)) {
            redirectWithError(request, response, "admin.error.fields.required");
            return;
        }

        // Password validation
        if (!password.equals(confirmPassword)) {
            redirectWithError(request, response, "admin.error.password.mismatch");
            return;
        }

        // Admin code validation
        if (!ADMIN_CODE.equals(adminCode)) {
            redirectWithError(request, response, "admin.error.invalid.code");
            return;
        }

        try {
            // Check username availability
            if (userDAO.findByUsername(username) != null) {
                redirectWithError(request, response, "admin.error.username.exists");
                return;
            }

            // Create and save admin user with hashed password
            User admin = new User();
            admin.setUsername(username);
            admin.setEmail(email);
            admin.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
            admin.setRole("admin");
            userDAO.save(admin);

            // Redirect to login
            response.sendRedirect(String.format("%s%s?message=%s&lang=%s",
                    request.getContextPath(), LOGIN_URL,
                    "admin.success.registration", lang));

        } catch (Exception e) {
            System.err.println("Registration error: " + e.getMessage());
            redirectWithError(request, response, "admin.error.system");
        }
    }

    private boolean validateInput(String... inputs) {
        for (String input : inputs) {
            if (input == null || input.trim().isEmpty()) return false;
        }
        return true;
    }

    private void redirectWithError(HttpServletRequest request, HttpServletResponse response, String errorKey) 
            throws IOException {
        response.sendRedirect(String.format("%s/auth/register?error=%s&lang=%s",
                request.getContextPath(), errorKey, getLanguage(request)));
    }
}
