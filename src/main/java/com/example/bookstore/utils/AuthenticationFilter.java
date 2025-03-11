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
        "/auth/process-login",
        "/auth/process-register",
        "/auth/logout",
        "/auth/login.jsp",
        "/auth/register.jsp",
        "/register",
        "/login",
        "/css/",
        "/js/",
        "/images/",
        "/assets/",
        "/error.jsp",
        "/home.jsp",
        "/"
    );

    private static final List<String> PROTECTED_JSP_PATHS = Arrays.asList(
        "/views/",
        "/WEB-INF/",
        "/admin/"
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
        String pathInfo = httpRequest.getPathInfo();
        String contextPath = httpRequest.getContextPath();
        
        // Combine servlet path and path info for complete path
        String fullPath = pathInfo != null ? requestPath + pathInfo : requestPath;
        
        // Debug logging
        System.out.println("Processing request: " + fullPath);
        System.out.println("Context path: " + contextPath);

        // Allow access to static resources
        if (isStaticResource(fullPath)) {
            chain.doFilter(request, response);
            return;
        }

        // Block direct access to JSP files in protected directories
        if (requestPath.endsWith(".jsp") && isProtectedJspPath(fullPath)) {
            System.out.println("Blocked direct JSP access: " + fullPath);
            httpResponse.sendRedirect(contextPath + "/");
            return;
        }
        
        // Check if it's a public resource
        if (isPublicResource(fullPath)) {
            System.out.println("Public resource accessed: " + fullPath);
            chain.doFilter(request, response);
            return;
        }

        // Get the session
        HttpSession session = httpRequest.getSession(false);
        
        // Check if user is authenticated
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("Unauthenticated access attempt: " + fullPath);
            // Save the requested URL for redirect after login
            if (!fullPath.startsWith("/auth/")) {
                session = httpRequest.getSession(true);
                String queryString = httpRequest.getQueryString();
                String redirectUrl = fullPath + (queryString != null ? "?" + queryString : "");
                session.setAttribute("redirectUrl", redirectUrl);
                System.out.println("Saved redirect URL: " + redirectUrl);
            }
            httpResponse.sendRedirect(contextPath + "/auth/login");
            return;
        }

        // Get user role
        String userRole = (String) session.getAttribute("userRole");
        
        // Check role-based access
        if (fullPath.startsWith("/admin/")) {
            if (!"admin".equalsIgnoreCase(userRole)) {
                System.out.println("Access denied to admin path: " + fullPath);
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied - Admin Only");
                return;
            }
        } else if (fullPath.startsWith("/user/")) {
            if (!"user".equalsIgnoreCase(userRole) && !"admin".equalsIgnoreCase(userRole)) {
                System.out.println("Access denied to user path: " + fullPath);
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied - User Only");
                return;
            }
        }

        // User is authenticated and authorized, continue with filter chain
        System.out.println("Authenticated access: " + fullPath + " for role: " + userRole);
        chain.doFilter(request, response);
    }

    private boolean isPublicResource(String path) {
        if (path.equals("/")) return true;
        return PUBLIC_PATHS.stream().anyMatch(publicPath -> 
            path.startsWith(publicPath));
    }

    private boolean isProtectedJspPath(String path) {
        return PROTECTED_JSP_PATHS.stream().anyMatch(protectedPath -> 
            path.startsWith(protectedPath));
    }

    private boolean isStaticResource(String path) {
        return path.startsWith("/css/") || 
               path.startsWith("/js/") || 
               path.startsWith("/images/") || 
               path.startsWith("/assets/");
    }

    @Override
    public void destroy() {
    }
} 