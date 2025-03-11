package com.example.bookstore.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("")
public class HomeServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // If user is logged in, redirect to appropriate dashboard
        if (session != null && session.getAttribute("user") != null) {
            String userRole = (String) session.getAttribute("userRole");
            if ("admin".equalsIgnoreCase(userRole)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/user/dashboard");
            }
            return;
        }
        
        // If not logged in, show the home page
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
} 