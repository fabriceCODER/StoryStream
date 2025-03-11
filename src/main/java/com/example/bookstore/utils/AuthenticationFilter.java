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
        "/auth/login",
        "/auth/register",
        "/auth/login.jsp",
        "/auth/register.jsp",
        "/register",
        "/login",
        "/css/",
        "/js/",
        "/images/",
        "/error.jsp",
        "/"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestPath = httpRequest.getServletPath();
        
        // Debug logging
        System.out.println("Processing request: " + requestPath);
        
        // Check if it's a public resource
        if (isPublicResource(requestPath)) {
            System.out.println("Public resource accessed: " + requestPath);
            chain.doFilter(request, response);
            return;
        }

        // Get the session
        HttpSession session = httpRequest.getSession(false);
        
        // Check if user is authenticated
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("Unauthenticated access attempt: " + requestPath);
            // Save the requested URL for redirect after login
            if (!requestPath.contains("/auth/")) {
                session = httpRequest.getSession(true);
                String queryString = httpRequest.getQueryString();
                String redirectUrl = requestPath + (queryString != null ? "?" + queryString : "");
                session.setAttribute("redirectUrl", redirectUrl);
                System.out.println("Saved redirect URL: " + redirectUrl);
            }
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/auth/login");
            return;
        }

        // User is authenticated, continue with filter chain
        System.out.println("Authenticated access: " + requestPath);
        chain.doFilter(request, response);
    }

    private boolean isPublicResource(String path) {
        return PUBLIC_PATHS.stream().anyMatch(publicPath -> 
            path.startsWith(publicPath) || path.equals("/"));
    }

    @Override
    public void destroy() {
    }
} 