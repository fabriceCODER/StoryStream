package com.example.bookstore.controllers.admin;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public abstract class BaseAdminController extends HttpServlet {
    
    protected boolean isAdminLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null 
            && session.getAttribute("user") != null 
            && "admin".equalsIgnoreCase((String) session.getAttribute("userRole"));
    }
    
    protected String getLanguage(HttpServletRequest request) {
        String lang = request.getParameter("lang");
        return lang != null ? lang : "en";
    }
    
    protected void setRedirectUrl(HttpServletRequest request, String url) {
        HttpSession session = request.getSession(true);
        session.setAttribute("redirectUrl", url);
    }
    
    protected String getRedirectUrl(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String url = (String) session.getAttribute("redirectUrl");
            session.removeAttribute("redirectUrl");
            return url;
        }
        return null;
    }
} 