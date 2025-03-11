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
                <title>Manage Books - Admin Dashboard</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            </head>

            <body>
                <nav class="navbar admin-navbar">
                    <div class="container">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="navbar-brand">BookStore
                            Admin</a>
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
                                <h2 class="card-title">Manage Books</h2>
                                <a href="${pageContext.request.contextPath}/admin/books?action=add"
                                    class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Add New Book
                                </a>
                            </div>

                            <div class="card-body">
                                <!-- Search and Filter Section -->
                                <div class="search-filter mb-4">
                                    <form action="${pageContext.request.contextPath}/admin/books" method="get"
                                        class="row g-3">
                                        <div class="col-md-4">
                                            <input type="text" name="search" class="form-control"
                                                placeholder="Search books..." value="${param.search}">
                                        </div>
                                        <div class="col-md-3">
                                            <select name="sort" class="form-select">
                                                <option value="">Sort by...</option>
                                                <option value="title" ${param.sort=='title' ? 'selected' : '' }>Title
                                                </option>
                                                <option value="author" ${param.sort=='author' ? 'selected' : '' }>Author
                                                </option>
                                                <option value="price" ${param.sort=='price' ? 'selected' : '' }>Price
                                                </option>
                                                <option value="stock" ${param.sort=='stock' ? 'selected' : '' }>Stock
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <button type="submit" class="btn btn-primary w-100">
                                                <i class="fas fa-search"></i> Search
                                            </button>
                                        </div>
                                    </form>
                                </div>

                                <!-- Messages -->
                                <c:if test="${not empty message}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fas fa-check-circle"></i> ${message}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <i class="fas fa-exclamation-circle"></i> ${error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <!-- Books Table -->
                                <div class="table-responsive">
                                    <table class="table admin-table">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Title</th>
                                                <th>Author</th>
                                                <th>Price</th>
                                                <th>Stock</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${books}" var="book">
                                                <tr>
                                                    <td>${book.id}</td>
                                                    <td>${book.title}</td>
                                                    <td>${book.author}</td>
                                                    <td>$${book.price}</td>
                                                    <td>
                                                        <span
                                                            class="badge ${book.quantity > 10 ? 'bg-success' : book.quantity > 0 ? 'bg-warning' : 'bg-danger'}">
                                                            ${book.quantity}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="admin-actions">
                                                            <a href="${pageContext.request.contextPath}/admin/books?action=edit&id=${book.id}"
                                                                class="btn btn-primary btn-sm" title="Edit">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <button onclick="confirmDelete(${book.id})"
                                                                class="btn btn-danger btn-sm" title="Delete">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <c:if test="${not empty totalPages && totalPages > 1}">
                                    <nav aria-label="Page navigation" class="mt-4">
                                        <ul class="pagination justify-content-center">
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link"
                                                        href="?page=${i}${not empty param.search ? '&search='.concat(param.search) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}">
                                                        ${i}
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </nav>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <script>
                    function confirmDelete(bookId) {
                        if (confirm('Are you sure you want to delete this book? This action cannot be undone.')) {
                            window.location.href = '${pageContext.request.contextPath}/admin/books?action=delete&id=' + bookId;
                        }
                    }

                    // Auto-dismiss alerts after 5 seconds
                    document.addEventListener('DOMContentLoaded', function () {
                        setTimeout(function () {
                            const alerts = document.querySelectorAll('.alert');
                            alerts.forEach(function (alert) {
                                const bsAlert = new bootstrap.Alert(alert);
                                bsAlert.close();
                            });
                        }, 5000);
                    });
                </script>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>