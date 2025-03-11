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
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
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
                                <h2 class="card-title">Edit Book</h2>
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">
                                        <i class="fas fa-exclamation-circle"></i> ${error}
                                    </div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/admin/books" method="post"
                                    class="admin-form needs-validation" novalidate>
                                    <input type="hidden" name="action" value="edit">
                                    <input type="hidden" name="id" value="${book.id}">

                                    <div class="form-group">
                                        <label for="title" class="form-label">Title</label>
                                        <input type="text" id="title" name="title" class="form-control"
                                            value="${book.title}" required pattern="[A-Za-z0-9\s\-.,!?()]+"
                                            title="Title can only contain letters, numbers, spaces, and basic punctuation">
                                        <div class="invalid-feedback">
                                            Please enter a valid title
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="author" class="form-label">Author</label>
                                        <input type="text" id="author" name="author" class="form-control"
                                            value="${book.author}" required pattern="[A-Za-z\s\-.,]+"
                                            title="Author name can only contain letters, spaces, hyphens, and basic punctuation">
                                        <div class="invalid-feedback">
                                            Please enter a valid author name
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="price" class="form-label">Price</label>
                                        <div class="input-group">
                                            <span class="input-group-text">$</span>
                                            <input type="number" id="price" name="price" step="0.01"
                                                class="form-control" value="${book.price}" required min="0"
                                                max="9999.99">
                                        </div>
                                        <div class="invalid-feedback">
                                            Please enter a valid price between $0 and $9999.99
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="quantity" class="form-label">Quantity in Stock</label>
                                        <input type="number" id="quantity" name="quantity" class="form-control"
                                            value="${book.quantity}" required min="0" max="9999">
                                        <div class="invalid-feedback">
                                            Please enter a valid quantity between 0 and 9999
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea id="description" name="description" class="form-control" rows="4"
                                            maxlength="1000">${book.description}</textarea>
                                        <small class="form-text text-muted">
                                            Maximum 1000 characters
                                        </small>
                                    </div>

                                    <div class="admin-actions">
                                        <a href="${pageContext.request.contextPath}/admin/books"
                                            class="btn btn-secondary">
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

                <script>
                    // Form validation
                    (function () {
                        'use strict'
                        var forms = document.querySelectorAll('.needs-validation')
                        Array.prototype.slice.call(forms).forEach(function (form) {
                            form.addEventListener('submit', function (event) {
                                if (!form.checkValidity()) {
                                    event.preventDefault()
                                    event.stopPropagation()
                                }
                                form.classList.add('was-validated')
                            }, false)
                        })
                    })()
                </script>
            </body>

            </html>