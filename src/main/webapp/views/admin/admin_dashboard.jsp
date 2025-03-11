<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin Dashboard - BookStore</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        </head>

        <body>
            <nav class="navbar admin-navbar">
                <div class="container">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="navbar-brand">BookStore
                        Admin</a>
                    <div class="nav-links">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a>
                        <a href="${pageContext.request.contextPath}/admin/books">Manage Books</a>
                        <a href="${pageContext.request.contextPath}/admin/orders">Orders</a>
                        <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
                    </div>
                </div>
            </nav>

            <div class="admin-sidebar">
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/books">Books</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/orders">Orders</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/users">Users</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports">Reports</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/settings">Settings</a></li>
                </ul>
            </div>

            <div class="admin-content">
                <div class="container">
                    <h1 class="mb-2">Dashboard</h1>

                    <div class="dashboard-stats">
                        <div class="stat-card">
                            <h3>150</h3>
                            <p>Total Books</p>
                        </div>
                        <div class="stat-card">
                            <h3>45</h3>
                            <p>Orders Today</p>
                        </div>
                        <div class="stat-card">
                            <h3>$2,450</h3>
                            <p>Revenue Today</p>
                        </div>
                        <div class="stat-card">
                            <h3>1,250</h3>
                            <p>Total Users</p>
                        </div>
                    </div>

                    <div class="card mb-2">
                        <div class="card-header">
                            <h2 class="card-title">Recent Books</h2>
                        </div>
                        <table class="table admin-table">
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Author</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${recentBooks}" var="book">
                                    <tr>
                                        <td>${book.title}</td>
                                        <td>${book.author}</td>
                                        <td>$${book.price}</td>
                                        <td>${book.quantity}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/books?action=edit&id=${book.id}"
                                                class="btn btn-primary">Edit</a>
                                            <a href="${pageContext.request.contextPath}/admin/books?action=delete&id=${book.id}"
                                                class="btn btn-danger">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="card">
                        <div class="card-header">
                            <h2 class="card-title">Recent Orders</h2>
                        </div>
                        <table class="table admin-table">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Customer</th>
                                    <th>Date</th>
                                    <th>Total</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>#12345</td>
                                    <td>John Doe</td>
                                    <td>2024-03-10</td>
                                    <td>$99.99</td>
                                    <td><span class="order-status status-pending">Pending</span></td>
                                    <td>
                                        <a href="#" class="btn btn-primary">View</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>#12344</td>
                                    <td>Jane Smith</td>
                                    <td>2024-03-10</td>
                                    <td>$149.99</td>
                                    <td><span class="order-status status-processing">Processing</span></td>
                                    <td>
                                        <a href="#" class="btn btn-primary">View</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>#12343</td>
                                    <td>Bob Wilson</td>
                                    <td>2024-03-09</td>
                                    <td>$79.99</td>
                                    <td><span class="order-status status-completed">Completed</span></td>
                                    <td>
                                        <a href="#" class="btn btn-primary">View</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </body>

        </html>