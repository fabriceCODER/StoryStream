<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${not empty param.lang ? param.lang : 'en'}" />
<fmt:bundle basename="messages">

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Books - Admin Dashboard</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- jQuery & Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="navbar-brand">BookStore Admin</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/books">Manage Books</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">Orders</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <aside class="col-md-3 col-lg-2 bg-light p-3">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/books">Books</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">Orders</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/users">Users</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/reports">Reports</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/settings">Settings</a></li>
                </ul>
            </aside>

            <main class="col-md-9 col-lg-10">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h2 class="card-title mb-0">Manage Books</h2>
                        <a href="${pageContext.request.contextPath}/admin/books?action=add" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add New Book
                        </a>
                    </div>
                    <div class="card-body">
                        
                        <!-- Search & Filter -->
                        <form action="${pageContext.request.contextPath}/admin/books" method="get" class="row g-3 mb-4">
                            <div class="col-md-4">
                                <input type="text" name="search" class="form-control" placeholder="Search books..." value="${param.search}">
                            </div>
                            <div class="col-md-3">
                                <select name="sort" class="form-select">
                                    <option value="">Sort by...</option>
                                    <option value="title" ${param.sort == 'title' ? 'selected' : ''}>Title</option>
                                    <option value="author" ${param.sort == 'author' ? 'selected' : ''}>Author</option>
                                    <option value="price" ${param.sort == 'price' ? 'selected' : ''}>Price</option>
                                    <option value="stock" ${param.sort == 'stock' ? 'selected' : ''}>Stock</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-search"></i> Search
                                </button>
                            </div>
                        </form>

                        <!-- Messages -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle"></i> ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle"></i> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <!-- Books Table -->
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
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
                                                <span class="badge ${book.quantity > 10 ? 'bg-success' : book.quantity > 0 ? 'bg-warning' : 'bg-danger'}">
                                                    ${book.quantity}
                                                </span>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/books?action=edit&id=${book.id}" class="btn btn-sm btn-primary">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button class="btn btn-sm btn-danger delete-btn" data-id="${book.id}">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        document.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', function () {
                const bookId = this.dataset.id;
                if (confirm('Are you sure you want to delete this book?')) {
                    window.location.href = '${pageContext.request.contextPath}/admin/books?action=delete&id=' + bookId;
                }
            });
        });
    </script>

</body>
</html>
</fmt:bundle>
