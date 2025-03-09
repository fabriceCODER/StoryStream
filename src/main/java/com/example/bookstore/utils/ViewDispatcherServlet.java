package com.example.bookstore.utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {
    "/login",
    "/register",
    "/dashboard",
    "/admin/dashboard",
    "/books/*",
    "/cart/*",
    "/profile"
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
            case "/login":
                jspPage = "/auth/login.jsp";
                break;
            case "/register":
                jspPage = "/auth/register.jsp";
                break;
            case "/dashboard":
                jspPage = "/views/users/dashboard.jsp";
                break;
            case "/admin/dashboard":
                jspPage = "/views/admin/admin_dashboard.jsp";
                break;
            case "/profile":
                jspPage = "/views/users/profile.jsp";
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
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