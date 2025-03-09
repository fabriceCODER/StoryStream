package com.example.bookstore.utils;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
        "/auth/login", "/auth/register", "/auth/login.jsp", "/auth/register.jsp",
        "/assets/", "/home.jsp", "/error.jsp"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestPath = httpRequest.getServletPath();
        
        // Allow access to public resources
        if (isPublicResource(requestPath)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = session != null && session.getAttribute("user") != null;
        
        if (!isLoggedIn) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/auth/login.jsp?error=Please login to continue");
            return;
        }

        // User is logged in, continue with the filter chain
        chain.doFilter(request, response);
    }

    private boolean isPublicResource(String path) {
        return PUBLIC_PATHS.stream().anyMatch(path::startsWith) ||
               path.matches(".*\\.(css|js|png|jpg|jpeg|gif|ico)$");
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
} 