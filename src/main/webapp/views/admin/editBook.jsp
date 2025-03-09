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

    // Retrieve book details by ID
    int bookId = Integer.parseInt(request.getParameter("id"));
    IBookService bookService = new BookServiceImpl();
    Book book = bookService.getBookById(bookId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Book</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Edit Book</h2>
    <form action="updateBookServlet" method="post">
        <input type="hidden" name="id" value="<%= book.getId() %>">

        <div class="mb-3">
            <label class="form-label">Title:</label>
            <input type="text" name="title" class="form-control" value="<%= book.getTitle() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Author:</label>
            <input type="text" name="author" class="form-control" value="<%= book.getAuthor() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Price:</label>
            <input type="number" step="0.01" name="price" class="form-control" value="<%= book.getPrice() %>" required>
        </div>

        <button type="submit" class="btn btn-primary">Update Book</button>
        <a href="manage_books.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
