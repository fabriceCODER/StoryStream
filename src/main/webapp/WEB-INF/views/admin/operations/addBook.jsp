<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Add Book - Admin Dashboard</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        </head>

        <body>
            <nav class="navbar admin-navbar">
                <div class="container">
                    <a href="${pageContext.request.contextPath}/admin/admin_dashboard" class="navbar-brand">BookStore
                        Admin</a>
                    <div class="nav-links">
                        <a href="${pageContext.request.contextPath}/admin/admin_dashboard">Dashboard</a>
                        <a href="${pageContext.request.contextPath}/admin/manage_book" class="active">Manage Books</a>
                        <a href="${pageContext.request.contextPath}/admin/orders">Orders</a>
                        <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
                    </div>
                </div>
            </nav>

            <div class="admin-sidebar">
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/admin/admin_dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/manage_book" class="active">Books</a></li>
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
                            <h2 class="card-title">Add New Book</h2>
                        </div>

                        <form class="admin-form" action="${pageContext.request.contextPath}/admin/books" method="post">
                            <input type="hidden" name="action" value="add">

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">
                                    ${error}
                                </div>
                            </c:if>

                            <div class="form-group">
                                <label for="title" class="form-label">Title</label>
                                <input type="text" id="title" name="title" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label for="author" class="form-label">Author</label>
                                <input type="text" id="author" name="author" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label for="price" class="form-label">Price</label>
                                <input type="number" id="price" name="price" step="0.01" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label for="quantity" class="form-label">Quantity in Stock</label>
                                <input type="number" id="quantity" name="quantity" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label for="description" class="form-label">Description</label>
                                <textarea id="description" name="description" class="form-control" rows="4"></textarea>
                            </div>

                            <div class="admin-actions">
                                <a href="${pageContext.request.contextPath}/admin/books"
                                    class="btn btn-secondary">Cancel</a>
                                <button type="submit" class="btn btn-primary">Add Book</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </body>

        </html>