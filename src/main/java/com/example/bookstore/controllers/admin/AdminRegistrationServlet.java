package com.example.bookstore.controllers.admin;

import com.example.bookstore.dao.IUserDAO;
import com.example.bookstore.daoImpl.UserDAOImpl;
import com.example.bookstore.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/auth/register")
public class AdminRegistrationServlet extends BaseAdminController {

    private static final String REGISTER_JSP = "/auth/register.jsp";
    private static final String LOGIN_URL = "/auth/login";
    private static final String ADMIN_CODE = "ADMIN123"; // In production, use secure storage
    private final IUserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If already logged in as admin, redirect to dashboard
        if (isAdminLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/auth/admin_dashboard");
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

        // Validate input
        if (!validateInput(username, email, password, confirmPassword, adminCode)) {
            redirectWithError(response, request.getContextPath(),
                    "admin.error.fields.required", lang);
            return;
        }

        // Validate password match
        if (!password.equals(confirmPassword)) {
            redirectWithError(response, request.getContextPath(),
                    "admin.error.password.mismatch", lang);
            return;
        }

        // Validate admin code
        if (!ADMIN_CODE.equals(adminCode)) {
            redirectWithError(response, request.getContextPath(),
                    "admin.error.invalid.code", lang);
            return;
        }

        try {
            // Check if username exists
            if (userDAO.findByUsername(username) != null) {
                redirectWithError(response, request.getContextPath(),
                        "admin.error.username.exists", lang);
                return;
            }

            // Create and save admin user
            User admin = createAdminUser(username, email, password);
            userDAO.save(admin);

            // Log successful registration
            System.out.println("Admin registration successful: " + username);

            // Redirect to login with success message
            response.sendRedirect(String.format("%s%s?message=%s&lang=%s",
                    request.getContextPath(), LOGIN_URL,
                    "admin.success.registration", lang));

        } catch (Exception e) {
            // Log the error
            System.err.println("Error during admin registration: " + e.getMessage());
            e.printStackTrace();

            // Redirect with error
            redirectWithError(response, request.getContextPath(),
                    "admin.error.system", lang);
        }
    }

    private boolean validateInput(String... inputs) {
        for (String input : inputs) {
            if (input == null || input.trim().isEmpty()) {
                return false;
            }
        }
        return true;
    }

    private User createAdminUser(String username, String email, String password) {
        User admin = new User();
        admin.setUsername(username);
        admin.setEmail(email);
        admin.setPassword(password);
        admin.setRole("admin");
        return admin;
    }

    private void redirectWithError(HttpServletResponse response, String contextPath,
                                   String errorKey, String lang) throws IOException {
        response.sendRedirect(String.format("%s/auth/register?error=%s&lang=%s",
                contextPath, errorKey, lang));
    }
}
