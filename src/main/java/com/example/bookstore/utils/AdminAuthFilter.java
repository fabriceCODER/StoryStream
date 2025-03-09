package com.example.bookstore.utils;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/views/admin/*", "/admin/*"})
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // At this point, user should be authenticated due to AuthenticationFilter
        if (session == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/auth/login.jsp");
            return;
        }

        String userRole = (String) session.getAttribute("userRole");
        
        if ("admin".equals(userRole)) {
            System.out.println("Admin access granted to: " + httpRequest.getRequestURI());
            chain.doFilter(request, response);
        } else {
            System.out.println("Admin access denied to: " + httpRequest.getRequestURI());
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/home.jsp?error=Access denied. Admin rights required.");
        }
    }

    @Override
    public void destroy() {
    }
}