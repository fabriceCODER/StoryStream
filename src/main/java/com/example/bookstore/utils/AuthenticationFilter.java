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
            "/auth/login.jsp",
            "/auth/register.jsp",
            "/auth/login",
            "/auth/register",
            "/home.jsp",
            "/index.jsp"
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

        // Get the request URI without the context path
        String requestPath = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        // Debug logging
        System.out.println("Request URI: " + httpRequest.getRequestURI());
        System.out.println("Context Path: " + httpRequest.getContextPath());
        System.out.println("Request Path: " + requestPath);

        // Check if it's a public resource
        if (isPublicResource(requestPath)) {
            System.out.println("Allowing public resource: " + requestPath);
            chain.doFilter(request, response);
            return;
        }

        // Check for authentication
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = session != null && session.getAttribute("user") != null;

        if (!isLoggedIn) {
            System.out.println("User not logged in, redirecting to login page");
            // Store the requested URL in session for redirect after login
            if (!requestPath.contains("login") && !requestPath.contains("register")) {
                session = httpRequest.getSession(true);
                session.setAttribute("redirectUrl", requestPath);
            }
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/auth/login.jsp");
            return;
        }

        // User is logged in, continue with the filter chain
        System.out.println("User is logged in, continuing filter chain");
        chain.doFilter(request, response);
    }

    private boolean isPublicResource(String path) {
        // Check if the path matches any public path
        boolean isPublic = PUBLIC_PATHS.stream().anyMatch(path::startsWith) ||
                          PUBLIC_PATHS.stream().anyMatch(publicPath -> path.endsWith(publicPath));

        System.out.println("Checking path: " + path + " isPublic: " + isPublic);

        return isPublic;
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
} 