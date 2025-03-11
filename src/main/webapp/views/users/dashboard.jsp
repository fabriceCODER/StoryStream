<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Dashboard - BookStore</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user.css">
            <style>
                .welcome-banner {
                    background: linear-gradient(135deg, #6B73FF 0%, #000DFF 100%);
                    color: white;
                    padding: 2rem;
                    border-radius: 10px;
                    margin-bottom: 2rem;
                }

                .book-item {
                    transition: transform 0.2s;
                    border: 1px solid #eee;
                    border-radius: 8px;
                    overflow: hidden;
                }

                .book-item:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                }

                .book-item-image {
                    width: 100%;
                    height: 200px;
                    object-fit: cover;
                }

                .book-item-details {
                    padding: 1rem;
                }

                .book-item-title {
                    font-size: 1.1rem;
                    margin-bottom: 0.5rem;
                    height: 2.4rem;
                    overflow: hidden;
                }

                .book-item-author {
                    color: #666;
                    font-size: 0.9rem;
                    margin-bottom: 0.5rem;
                }

                .book-item-price {
                    font-weight: bold;
                    color: #2c3e50;
                    margin-bottom: 1rem;
                }

                .order-card {
                    border: 1px solid #eee;
                    padding: 1rem;
                    margin-bottom: 1rem;
                    border-radius: 8px;
                    transition: transform 0.2s;
                }

                .order-card:hover {
                    transform: translateX(5px);
                    border-left: 4px solid #000DFF;
                }
            </style>
        </head>

        <body class="bg-light">
            <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                <div class="container">
                    <a href="${pageContext.request.contextPath}/user/dashboard" class="navbar-brand">
                        <i class="fas fa-book-reader me-2"></i>BookStore
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-link active">
                                    <i class="fas fa-home me-1"></i>Home
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/books" class="nav-link">
                                    <i class="fas fa-book me-1"></i>Browse Books
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/cart" class="nav-link">
                                    <i class="fas fa-shopping-cart me-1"></i>Cart
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/user/orders" class="nav-link">
                                    <i class="fas fa-list me-1"></i>My Orders
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/user/profile" class="nav-link">
                                    <i class="fas fa-user me-1"></i>Profile
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/auth/logout" class="nav-link">
                                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container py-4">
                <div class="welcome-banner shadow">
                    <h1><i class="fas fa-user-circle me-2"></i>Welcome back, ${user.username}!</h1>
                    <p class="mb-0">Discover new books, track your orders, and manage your profile all in one place.</p>
                </div>

                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm">
                            <div class="card-header bg-white">
                                <h2 class="h5 mb-0"><i class="fas fa-clock me-2"></i>Recent Orders</h2>
                            </div>
                            <div class="card-body">
                                <c:forEach items="${recentOrders}" var="order">
                                    <div class="order-card">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="text-primary">#${order.id}</span>
                                            <small class="text-muted">${order.date}</small>
                                        </div>
                                        <div class="mt-2">
                                            <strong>Total: $${order.total}</strong>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty recentOrders}">
                                    <p class="text-center text-muted">
                                        <i class="fas fa-box-open me-2"></i>No recent orders
                                    </p>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-8">
                        <div class="card h-100 shadow-sm">
                            <div class="card-header bg-white">
                                <h2 class="h5 mb-0"><i class="fas fa-star me-2"></i>Recommended Books</h2>
                            </div>
                            <div class="card-body">
                                <div class="row row-cols-1 row-cols-md-3 g-4">
                                    <c:forEach items="${recommendedBooks}" var="book">
                                        <div class="col">
                                            <div class="book-item h-100">
                                                <img src="${book.imageUrl}" alt="${book.title}" class="book-item-image">
                                                <div class="book-item-details">
                                                    <h3 class="book-item-title">${book.title}</h3>
                                                    <p class="book-item-author">by ${book.author}</p>
                                                    <p class="book-item-price">$${book.price}</p>
                                                    <button class="btn btn-primary w-100"
                                                        onclick="addToCart('${book.id}')">
                                                        <i class="fas fa-cart-plus me-1"></i>Add to Cart
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <c:if test="${empty recommendedBooks}">
                                    <p class="text-center text-muted">
                                        <i class="fas fa-books me-2"></i>No recommendations available
                                    </p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mt-4 shadow-sm">
                    <div class="card-header bg-white">
                        <h2 class="h5 mb-0"><i class="fas fa-bookmark me-2"></i>Your Reading List</h2>
                    </div>
                    <div class="card-body">
                        <div class="row row-cols-1 row-cols-md-4 g-4">
                            <c:forEach items="${readingList}" var="book">
                                <div class="col">
                                    <div class="book-item h-100">
                                        <img src="${book.imageUrl}" alt="${book.title}" class="book-item-image">
                                        <div class="book-item-details">
                                            <h3 class="book-item-title">${book.title}</h3>
                                            <p class="book-item-author">by ${book.author}</p>
                                            <p class="book-item-price">$${book.price}</p>
                                            <button class="btn btn-primary w-100" onclick="addToCart('${book.id}')">
                                                <i class="fas fa-cart-plus me-1"></i>Add to Cart
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <c:if test="${empty readingList}">
                            <p class="text-center text-muted">
                                <i class="fas fa-list me-2"></i>Your reading list is empty
                            </p>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Toast for notifications -->
            <div class="toast-container position-fixed bottom-0 end-0 p-3">
                <div id="cartToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header">
                        <i class="fas fa-shopping-cart me-2"></i>
                        <strong class="me-auto">Cart</strong>
                        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div class="toast-body"></div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                function addToCart(bookId) {
                    fetch('${pageContext.request.contextPath}/cart', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'bookId=' + bookId
                    })
                        .then(response => response.json())
                        .then(data => {
                            const toast = new bootstrap.Toast(document.getElementById('cartToast'));
                            const toastBody = document.querySelector('.toast-body');
                            if (data.success) {
                                toastBody.textContent = 'Book added to cart successfully!';
                                toastBody.parentElement.classList.add('bg-success', 'text-white');
                            } else {
                                toastBody.textContent = data.message || 'Failed to add book to cart';
                                toastBody.parentElement.classList.add('bg-danger', 'text-white');
                            }
                            toast.show();
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            const toast = new bootstrap.Toast(document.getElementById('cartToast'));
                            const toastBody = document.querySelector('.toast-body');
                            toastBody.textContent = 'An error occurred while adding the book to cart';
                            toastBody.parentElement.classList.add('bg-danger', 'text-white');
                            toast.show();
                        });
                }
            </script>
        </body>

        </html>