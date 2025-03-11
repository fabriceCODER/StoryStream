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
    <title>Edit Book - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>

<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">BookStore Admin</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/books">Manage Books</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">Orders</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
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

            <div class="col-md-9">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4>Edit Book</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-circle"></i> ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/admin/books" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="${book.id}">

                            <div class="mb-3">
                                <label for="title" class="form-label">Title</label>
                                <input type="text" id="title" name="title" class="form-control" value="${book.title}" required>
                                <div class="invalid-feedback">Please enter a valid title.</div>
                            </div>

                            <div class="mb-3">
                                <label for="author" class="form-label">Author</label>
                                <input type="text" id="author" name="author" class="form-control" value="${book.author}" required>
                                <div class="invalid-feedback">Please enter a valid author name.</div>
                            </div>

                            <div class="mb-3">
                                <label for="price" class="form-label">Price</label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" id="price" name="price" step="0.01" class="form-control" value="${book.price}" required>
                                </div>
                                <div class="invalid-feedback">Please enter a valid price.</div>
                            </div>

                            <div class="mb-3">
                                <label for="quantity" class="form-label">Quantity in Stock</label>
                                <input type="number" id="quantity" name="quantity" class="form-control" value="${book.quantity}" required>
                                <div class="invalid-feedback">Please enter a valid quantity.</div>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea id="description" name="description" class="form-control" rows="4" maxlength="1000">${book.description}</textarea>
                                <small class="form-text text-muted">Maximum 1000 characters.</small>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Update Book
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        (function () {
            'use strict';
            var forms = document.querySelectorAll('.needs-validation');
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
