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
                <title>Browse Books - BookStore</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            </head>

            <body>
                <nav class="navbar user-navbar">
                    <div class="container">
                        <a href="${pageContext.request.contextPath}/user/dashboard" class="navbar-brand">BookStore</a>
                        <div class="nav-links">
                            <a href="${pageContext.request.contextPath}/user/dashboard">Home</a>
                            <a href="${pageContext.request.contextPath}/books" class="active">Browse Books</a>
                            <a href="${pageContext.request.contextPath}/cart">Cart</a>
                            <a href="${pageContext.request.contextPath}/user/orders">My Orders</a>
                            <a href="${pageContext.request.contextPath}/user/profile">Profile</a>
                            <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
                        </div>
                    </div>
                </nav>

                <div class="container mt-4">
                    <div class="row">
                        <!-- Search and Filter Section -->
                        <div class="col-md-3">
                            <div class="card">
                                <div class="card-header">
                                    <h4><i class="fas fa-filter"></i> Filters</h4>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/books" method="get">
                                        <div class="mb-3">
                                            <label class="form-label">Search</label>
                                            <input type="text" name="search" class="form-control"
                                                placeholder="Search books..." value="${param.search}">
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Sort By</label>
                                            <select name="sort" class="form-select">
                                                <option value="title" ${param.sort=='title' ? 'selected' : '' }>Title
                                                </option>
                                                <option value="author" ${param.sort=='author' ? 'selected' : '' }>Author
                                                </option>
                                                <option value="price_asc" ${param.sort=='price_asc' ? 'selected' : '' }>
                                                    Price: Low to High</option>
                                                <option value="price_desc" ${param.sort=='price_desc' ? 'selected' : ''
                                                    }>Price: High to Low</option>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Price Range</label>
                                            <div class="d-flex gap-2">
                                                <input type="number" name="minPrice" class="form-control"
                                                    placeholder="Min" value="${param.minPrice}" min="0">
                                                <input type="number" name="maxPrice" class="form-control"
                                                    placeholder="Max" value="${param.maxPrice}" min="0">
                                            </div>
                                        </div>

                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="fas fa-search"></i> Apply Filters
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Books Grid -->
                        <div class="col-md-9">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h4><i class="fas fa-books"></i> Available Books</h4>
                                    <div class="view-options">
                                        <button class="btn btn-outline-secondary btn-sm" onclick="toggleView('grid')">
                                            <i class="fas fa-grid-2"></i>
                                        </button>
                                        <button class="btn btn-outline-secondary btn-sm" onclick="toggleView('list')">
                                            <i class="fas fa-list"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="book-grid" id="booksContainer">
                                        <c:forEach var="book" items="${books}">
                                            <div class="book-card">
                                                <img src="${not empty book.imageUrl ? book.imageUrl : pageContext.request.contextPath + '/images/default-book.jpg'}"
                                                    alt="${book.title}" class="book-card-image">
                                                <div class="book-card-content">
                                                    <h5 class="book-card-title">${book.title}</h5>
                                                    <p class="book-card-author">by ${book.author}</p>
                                                    <p class="book-card-price">$${book.price}</p>
                                                    <div class="book-card-actions">
                                                        <button onclick="addToCart(${book.id})"
                                                            class="btn btn-primary btn-sm">
                                                            <i class="fas fa-cart-plus"></i> Add to Cart
                                                        </button>
                                                        <button onclick="viewDetails(${book.id})"
                                                            class="btn btn-outline-secondary btn-sm">
                                                            <i class="fas fa-info-circle"></i> Details
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <!-- No Books Message -->
                                    <c:if test="${empty books}">
                                        <div class="text-center py-5">
                                            <i class="fas fa-books fa-3x text-muted"></i>
                                            <p class="mt-3">No books found matching your criteria</p>
                                        </div>
                                    </c:if>

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
                </div>

                <!-- Toast for notifications -->
                <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
                    <div id="toast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                        <div class="toast-header">
                            <i class="fas fa-info-circle me-2"></i>
                            <strong class="me-auto">Notification</strong>
                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <div class="toast-body"></div>
                    </div>
                </div>

                <script>
                    // Add to Cart functionality
                    function addToCart(bookId) {
                        fetch('${pageContext.request.contextPath}/cart/add', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'bookId=' + bookId
                        })
                            .then(response => response.json())
                            .then(data => {
                                showToast(data.success ? 'success' : 'error', data.message);
                            })
                            .catch(error => {
                                showToast('error', 'Failed to add book to cart');
                            });
                    }

                    // View Details functionality
                    function viewDetails(bookId) {
                        window.location.href = '${pageContext.request.contextPath}/books/' + bookId;
                    }

                    // Toggle View functionality
                    function toggleView(viewType) {
                        const container = document.getElementById('booksContainer');
                        container.className = viewType === 'grid' ? 'book-grid' : 'book-list';
                    }

                    // Toast functionality
                    function showToast(type, message) {
                        const toast = document.getElementById('toast');
                        const toastBody = toast.querySelector('.toast-body');
                        toastBody.textContent = message;
                        toast.className = `toast ${type === 'success' ? 'bg-success' : 'bg-danger'} text-white`;
                        const bsToast = new bootstrap.Toast(toast);
                        bsToast.show();
                    }
                </script>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>