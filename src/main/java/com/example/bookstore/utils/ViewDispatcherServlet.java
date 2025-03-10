package com.example.bookstore.utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {
    "/",
    "/login",
    "/register",
    "/dashboard",
    "/admin/dashboard",
    "/books/*",
    "/cart/*",
    "/profile",
    "/error/*"
})
public class ViewDispatcherServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String path = request.getServletPath();
            String jspPage;
            String lang = request.getParameter("lang");
            HttpSession session = request.getSession(false);

            // If no language parameter but session exists, use session language
            if (lang == null && session != null) {
                lang = (String) session.getAttribute("lang");
            }
            
            // If still no language, default to English
            if (lang == null) {
                lang = "en";
            }

            // Store language in session if we have one
            if (session != null) {
                session.setAttribute("lang", lang);
            }

            // Check if the path requires authentication
            boolean requiresAuth = !path.equals("/login") && !path.equals("/register") && !path.equals("/");
            
            // Check if user is authenticated for protected paths
            if (requiresAuth) {
                if (session == null || session.getAttribute("user") == null) {
                    // Save the requested URL for redirect after login
                    if (session == null) {
                        session = request.getSession(true);
                    }
                    session.setAttribute("redirectUrl", path + (lang != null ? "?lang=" + lang : ""));
                    response.sendRedirect(request.getContextPath() + "/login?lang=" + lang);
                    return;
                }

                // Check admin access for admin paths
                if (path.startsWith("/admin/")) {
                    String userRole = (String) session.getAttribute("userRole");
                    if (!"admin".equalsIgnoreCase(userRole)) {
                        response.sendRedirect(request.getContextPath() + "/dashboard?error=Access denied&lang=" + lang);
                        return;
                    }
                }
            }

            // Map URLs to JSP pages
            switch (path) {
                case "/":
                    response.sendRedirect(request.getContextPath() + "/login?lang=" + lang);
                    return;
                case "/login":
                    // Redirect to dashboard if already logged in
                    if (session != null && session.getAttribute("user") != null) {
                        String userRole = (String) session.getAttribute("userRole");
                        String redirectPath = "admin".equalsIgnoreCase(userRole) ? "/admin/dashboard" : "/dashboard";
                        response.sendRedirect(request.getContextPath() + redirectPath + "?lang=" + lang);
                        return;
                    }
                    jspPage = "/auth/login.jsp";
                    break;
                case "/register":
                    // Redirect to dashboard if already logged in
                    if (session != null && session.getAttribute("user") != null) {
                        String userRole = (String) session.getAttribute("userRole");
                        String redirectPath = "admin".equalsIgnoreCase(userRole) ? "/admin/dashboard" : "/dashboard";
                        response.sendRedirect(request.getContextPath() + redirectPath + "?lang=" + lang);
                        return;
                    }
                    jspPage = "/auth/register.jsp";
                    break;
                case "/dashboard":
                    String userRole = (String) session.getAttribute("userRole");
                    if ("admin".equalsIgnoreCase(userRole)) {
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard?lang=" + lang);
                        return;
                    }
                    jspPage = "/views/users/dashboard.jsp";
                    break;
                case "/admin/dashboard":
                    jspPage = "/views/admin/dashboard.jsp";
                    break;
                case "/profile":
                    jspPage = "/views/users/profile.jsp";
                    break;
                case "/error/404":
                    jspPage = "/WEB-INF/views/errors/404.jsp";
                    break;
                case "/error/500":
                    jspPage = "/WEB-INF/views/errors/500.jsp";
                    break;
                default:
                    if (path.startsWith("/books/")) {
                        jspPage = "/views/books/browse.jsp";
                    } else if (path.startsWith("/cart/")) {
                        jspPage = "/views/cart/cart.jsp";
                    } else {
                        response.sendRedirect(request.getContextPath() + "/error.jsp");
                        return;
                    }
            }

            // Set language attribute for JSP
            request.setAttribute("lang", lang);
            
            // Forward to JSP
            try {
                request.getRequestDispatcher(jspPage).forward(request, response);
            } catch (Exception e) {
                System.err.println("Error forwarding to JSP: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/error.jsp");
            }
        } catch (Exception e) {
            System.err.println("Error in ViewDispatcherServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 