<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

      <fmt:setLocale value="${not empty param.lang ? param.lang : 'en'}" />
      <fmt:setBundle basename="messages" />

      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Delete Book - Admin Dashboard</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
      </head>

      <body>
        <nav class="navbar admin-navbar">
          <div class="container">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="navbar-brand">BookStore Admin</a>
            <div class="nav-links">
              <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
              <a href="${pageContext.request.contextPath}/admin/books" class="active">Manage Books</a>
              <a href="${pageContext.request.contextPath}/admin/orders">Orders</a>
              <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
            </div>
          </div>
        </nav>

        <div class="admin-sidebar">
          <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/books" class="active">Books</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders">Orders</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/users">Users</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/reports">Reports</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/settings">Settings</a></li>
          </ul>
        </div>

        <div class="admin-content">
          <div class="container">
            <div class="card">
              <div class="card-header">
                <h2 class="card-title text-danger">Confirm Delete</h2>
              </div>
              <div class="card-body">
                <div class="alert alert-warning">
                  <i class="fas fa-exclamation-triangle"></i>
                  Are you sure you want to delete the following book?
                </div>

                <div class="book-details">
                  <p><strong>Title:</strong> ${book.title}</p>
                  <p><strong>Author:</strong> ${book.author}</p>
                  <p><strong>Price:</strong> $${book.price}</p>
                  <p><strong>Stock:</strong> ${book.quantity}</p>
                </div>

                <form action="${pageContext.request.contextPath}/admin/books" method="post" class="mt-4">
                  <input type="hidden" name="action" value="delete">
                  <input type="hidden" name="id" value="${book.id}">

                  <div class="admin-actions">
                    <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-danger">
                      <i class="fas fa-trash"></i> Delete Book
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>

        <script>
          // Add confirmation before form submission
          document.querySelector('form').addEventListener('submit', function (e) {
            if (!confirm('Are you absolutely sure you want to delete this book? This action cannot be undone.')) {
              e.preventDefault();
            }
          });
        </script>
      </body>

      </html>