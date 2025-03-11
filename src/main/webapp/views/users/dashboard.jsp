<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Dashboard - BookStore</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user.css">
        </head>

        <body>
            <nav class="navbar user-navbar">
                <div class="container">
                    <a href="${pageContext.request.contextPath}/user/dashboard" class="navbar-brand">BookStore</a>
                    <div class="nav-links">
                        <a href="${pageContext.request.contextPath}/user/dashboard" class="active">Home</a>
                        <a href="${pageContext.request.contextPath}/books">Browse Books</a>
                        <a href="${pageContext.request.contextPath}/cart">Cart</a>
                        <a href="${pageContext.request.contextPath}/user/orders">My Orders</a>
                        <a href="${pageContext.request.contextPath}/user/profile">Profile</a>
                        <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
                    </div>
                </div>
            </nav>

            <div class="user-dashboard">
                <div class="container">
                    <div class="welcome-banner">
                        <h1>Welcome back, ${user.username}!</h1>
                        <p>Discover new books, track your orders, and manage your profile all in one place.</p>
                    </div>

                    <div class="grid">
                        <div class="card">
                            <div class="card-header">
                                <h2 class="card-title">Recent Orders</h2>
                            </div>
                            <div class="order-items">
                                <c:forEach items="${recentOrders}" var="order">
                                    <div class="order-card">
                                        <div class="order-header">
                                            <span class="order-number">#${order.id}</span>
                                            <span class="order-date">${order.date}</span>
                                        </div>
                                        <div class="order-total">Total: $${order.total}</div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty recentOrders}">
                                    <p class="text-center">No recent orders</p>
                                </c:if>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-header">
                                <h2 class="card-title">Recommended Books</h2>
                            </div>
                            <div class="book-browse-grid">
                                <c:forEach items="${recommendedBooks}" var="book">
                                    <div class="book-item">
                                        <img src="${book.imageUrl}" alt="${book.title}" class="book-item-image">
                                        <div class="book-item-details">
                                            <h3 class="book-item-title">${book.title}</h3>
                                            <p class="book-item-author">by ${book.author}</p>
                                            <p class="book-item-price">$${book.price}</p>
                                            <button class="add-to-cart-btn" onclick="addToCart(${book.id})">Add to
                                                Cart</button>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty recommendedBooks}">
                                    <p class="text-center">No recommendations available</p>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <div class="card mt-2">
                        <div class="card-header">
                            <h2 class="card-title">Your Reading List</h2>
                        </div>
                        <div class="book-browse-grid">
                            <c:forEach items="${readingList}" var="book">
                                <div class="book-item">
                                    <img src="${book.imageUrl}" alt="${book.title}" class="book-item-image">
                                    <div class="book-item-details">
                                        <h3 class="book-item-title">${book.title}</h3>
                                        <p class="book-item-author">by ${book.author}</p>
                                        <p class="book-item-price">$${book.price}</p>
                                        <button class="add-to-cart-btn" onclick="addToCart(${book.id})">Add to
                                            Cart</button>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty readingList}">
                                <p class="text-center">Your reading list is empty</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                function addToCart(bookId) {
                    fetch('${pageContext.request.contextPath}/cart', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'bookId=' + bookId
                    })
                        .then(response => {
                            if (response.ok) {
                                alert('Book added to cart successfully!');
                            } else {
                                alert('Failed to add book to cart');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('An error occurred while adding the book to cart');
                        });
                }
            </script>
        </body>

        </html>