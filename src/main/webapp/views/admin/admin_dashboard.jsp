<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - BookStore</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- FontAwesome (for icons) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>

<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="navbar-brand">
                <i class="fas fa-book"></i> BookStore Admin
            </a>
            <div class="navbar-nav ms-auto">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link active">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/books" class="nav-link">Manage Books</a>
                <a href="${pageContext.request.contextPath}/admin/orders" class="nav-link">Orders</a>
                <a href="${pageContext.request.contextPath}/auth/logout" class="nav-link text-danger">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-3">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block bg-dark sidebar text-white p-3">
                <h4 class="text-center mb-3">Admin Panel</h4>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active text-white" href="${pageContext.request.contextPath}/admin/dashboard">
                            <i class="fas fa-chart-line"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/books">
                            <i class="fas fa-book"></i> Books
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/orders">
                            <i class="fas fa-shopping-cart"></i> Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/users">
                            <i class="fas fa-users"></i> Users
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/reports">
                            <i class="fas fa-file-alt"></i> Reports
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/settings">
                            <i class="fas fa-cog"></i> Settings
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Main Content -->
            <main class="col-md-9 col-lg-10 px-md-4">
                <h1 class="mt-3">Dashboard</h1>

                <!-- Dashboard Stats -->
                <div class="row g-3 mt-3">
                    <div class="col-md-3">
                        <div class="card bg-primary text-white shadow">
                            <div class="card-body">
                                <h4>150</h4>
                                <p>Total Books</p>
                                <i class="fas fa-book fa-2x"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-warning text-white shadow">
                            <div class="card-body">
                                <h4>45</h4>
                                <p>Orders Today</p>
                                <i class="fas fa-shopping-cart fa-2x"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-success text-white shadow">
                            <div class="card-body">
                                <h4>$2,450</h4>
                                <p>Revenue Today</p>
                                <i class="fas fa-dollar-sign fa-2x"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-info text-white shadow">
                            <div class="card-body">
                                <h4>1,250</h4>
                                <p>Total Users</p>
                                <i class="fas fa-users fa-2x"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Books -->
                <div class="card mt-4">
                    <div class="card-header bg-primary text-white">
                        <h5><i class="fas fa-book"></i> Recent Books</h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-striped">
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
                                                class="btn btn-primary btn-sm">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/books?action=delete&id=${book.id}"
                                                class="btn btn-danger btn-sm">
                                                <i class="fas fa-trash"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Recent Orders -->
                <div class="card mt-4">
                    <div class="card-header bg-success text-white">
                        <h5><i class="fas fa-shopping-cart"></i> Recent Orders</h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-striped">
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
                                <c:forEach items="${recentOrders}" var="order">
                                    <tr>
                                        <td>#${order.id}</td>
                                        <td>${order.customerName}</td>
                                        <td>${order.date}</td>
                                        <td>$${order.total}</td>
                                        <td><span class="badge bg-warning">${order.status}</span></td>
                                        <td>
                                            <a href="#" class="btn btn-primary btn-sm">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

            </main>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
