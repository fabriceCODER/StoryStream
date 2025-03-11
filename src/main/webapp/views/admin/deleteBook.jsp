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
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="navbar-brand">BookStore Admin</a>
            <div class="navbar-nav ms-auto">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/books" class="nav-link active">Manage Books</a>
                <a href="${pageContext.request.contextPath}/admin/orders" class="nav-link">Orders</a>
                <a href="${pageContext.request.contextPath}/auth/logout" class="nav-link text-danger">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="list-group">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item list-group-item-action">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/admin/books" class="list-group-item list-group-item-action active">Books</a>
                    <a href="${pageContext.request.contextPath}/admin/orders" class="list-group-item list-group-item-action">Orders</a>
                    <a href="${pageContext.request.contextPath}/admin/users" class="list-group-item list-group-item-action">Users</a>
                    <a href="${pageContext.request.contextPath}/admin/reports" class="list-group-item list-group-item-action">Reports</a>
                    <a href="${pageContext.request.contextPath}/admin/settings" class="list-group-item list-group-item-action">Settings</a>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9">
                <div class="card shadow">
                    <div class="card-header bg-danger text-white">
                        <h4 class="mb-0"><i class="fas fa-trash-alt"></i> Confirm Delete</h4>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle"></i> Are you sure you want to delete the following book?
                        </div>

                        <ul class="list-group mb-3">
                            <li class="list-group-item"><strong>Title:</strong> ${book.title}</li>
                            <li class="list-group-item"><strong>Author:</strong> ${book.author}</li>
                            <li class="list-group-item"><strong>Price:</strong> $${book.price}</li>
                            <li class="list-group-item"><strong>Stock:</strong> ${book.quantity}</li>
                        </ul>

                        <form action="${pageContext.request.contextPath}/admin/books" method="post">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="${book.id}">

                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-danger">
                                    <i class="fas fa-trash"></i> Delete Book
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (for better UI behavior) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

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
