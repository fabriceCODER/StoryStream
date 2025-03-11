<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    // Invalidating the session to log the user out
    session.invalidate();

    // Redirecting to the login page
    response.sendRedirect("login.jsp");
%>
