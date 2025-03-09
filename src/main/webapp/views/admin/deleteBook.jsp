<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.bookstore.models.Book" %>
<%@ page import="com.example.bookstore.services.IBookService" %>
<%@ page import="com.example.bookstore.servicesImpl.BookServiceImpl" %>
<%@ page session="true" %>

<%
  // Ensure admin access
  String role = (String) session.getAttribute("role");
  if (role == null || !role.equals("admin")) {
    response.sendRedirect("login.jsp");
    return;
  }

  int bookId = Integer.parseInt(request.getParameter("id"));
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Delete Book</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
  <h2 class="text-center text-danger">Confirm Delete</h2>
  <p class="text-center">Are you sure you want to delete this book?</p>

  <form action="deleteBook" method="post">
    <input type="hidden" name="id" value="<%= bookId %>">
    <button type="submit" class="btn btn-danger">Yes, Delete</button>
    <a href="manage_books.jsp" class="btn btn-secondary">Cancel</a>
  </form>
</div>
</body>
</html>
