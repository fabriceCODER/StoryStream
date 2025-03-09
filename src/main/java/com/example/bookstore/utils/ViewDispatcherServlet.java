package com.example.bookstore.utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
        String path = request.getServletPath();
        String jspPage;
        String lang = request.getParameter("lang");

        // Map URLs to JSP pages
        switch (path) {
            case "/":
                // Redirect root to login
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            case "/login":
                jspPage = "/WEB-INF/views/auth/login.jsp";
                break;
            case "/register":
                jspPage = "/WEB-INF/views/auth/register.jsp";
                break;
            case "/dashboard":
                jspPage = "/WEB-INF/views/users/dashboard.jsp";
                break;
            case "/admin/dashboard":
                jspPage = "/WEB-INF/views/admin/dashboard.jsp";
                break;
            case "/profile":
                jspPage = "/WEB-INF/views/users/profile.jsp";
                break;
            case "/error/404":
                jspPage = "/WEB-INF/views/errors/404.jsp";
                break;
            case "/error/500":
                jspPage = "/WEB-INF/views/errors/500.jsp";
                break;
            default:
                if (path.startsWith("/books/")) {
                    jspPage = "/WEB-INF/views/books/browse.jsp";
                } else if (path.startsWith("/cart/")) {
                    jspPage = "/WEB-INF/views/cart/cart.jsp";
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
        }

        // Preserve language parameter if present
        if (lang != null && !lang.trim().isEmpty()) {
            request.setAttribute("lang", lang);
        }

        // Forward the request to the appropriate JSP
        request.getRequestDispatcher(jspPage).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 