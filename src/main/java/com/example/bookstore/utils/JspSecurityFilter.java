package com.example.bookstore.utils;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("*.jsp")
public class JspSecurityFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Get the requested URI
        String uri = httpRequest.getRequestURI();
        
        // Allow direct access only to login and register pages
        if (uri.endsWith("/auth/login.jsp") || uri.endsWith("/auth/register.jsp")) {
            chain.doFilter(request, response);
            return;
        }

        // For all other JSP files, redirect to the home page
        httpResponse.sendRedirect(httpRequest.getContextPath() + "/");
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
} 