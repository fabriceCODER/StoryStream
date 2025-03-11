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
                <title>Shopping Cart - BookStore</title>
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
                            <a href="${pageContext.request.contextPath}/books">Browse Books</a>
                            <a href="${pageContext.request.contextPath}/cart" class="active">Cart</a>
                            <a href="${pageContext.request.contextPath}/user/orders">My Orders</a>
                            <a href="${pageContext.request.contextPath}/user/profile">Profile</a>
                            <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
                        </div>
                    </div>
                </nav>

                <div class="container mt-4">
                    <div class="card">
                        <div class="card-header">
                            <h2 class="card-title">
                                <i class="fas fa-shopping-cart"></i> Shopping Cart
                            </h2>
                        </div>
                        <div class="card-body">
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

                            <c:choose>
                                <c:when test="${empty cart.items}">
                                    <div class="text-center py-5">
                                        <i class="fas fa-shopping-cart fa-3x text-muted"></i>
                                        <p class="mt-3">Your cart is empty</p>
                                        <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">
                                            <i class="fas fa-book"></i> Browse Books
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Book</th>
                                                    <th>Price</th>
                                                    <th>Quantity</th>
                                                    <th>Total</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${cart.items}" var="item">
                                                    <tr>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <img src="${not empty item.book.imageUrl ? item.book.imageUrl : pageContext.request.contextPath + '/images/default-book.jpg'}"
                                                                    alt="${item.book.title}"
                                                                    class="cart-item-image me-3">
                                                                <div>
                                                                    <h6 class="mb-0">${item.book.title}</h6>
                                                                    <small class="text-muted">by
                                                                        ${item.book.author}</small>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>$${item.book.price}</td>
                                                        <td>
                                                            <div class="quantity-control">
                                                                <button onclick="updateQuantity(${item.book.id}, -1)"
                                                                    class="btn btn-sm btn-outline-secondary">
                                                                    <i class="fas fa-minus"></i>
                                                                </button>
                                                                <input type="number" value="${item.quantity}" min="1"
                                                                    max="99"
                                                                    onchange="updateQuantity(${item.book.id}, this.value)"
                                                                    class="form-control form-control-sm quantity-input">
                                                                <button onclick="updateQuantity(${item.book.id}, 1)"
                                                                    class="btn btn-sm btn-outline-secondary">
                                                                    <i class="fas fa-plus"></i>
                                                                </button>
                                                            </div>
                                                        </td>
                                                        <td>$${item.totalPrice}</td>
                                                        <td>
                                                            <button onclick="removeFromCart(${item.book.id})"
                                                                class="btn btn-danger btn-sm">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="3" class="text-end"><strong>Subtotal:</strong></td>
                                                    <td>$${cart.subtotal}</td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" class="text-end"><strong>Tax (10%):</strong></td>
                                                    <td>$${cart.tax}</td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" class="text-end"><strong>Total:</strong></td>
                                                    <td><strong>$${cart.total}</strong></td>
                                                    <td></td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>

                                    <div class="d-flex justify-content-between align-items-center mt-4">
                                        <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left"></i> Continue Shopping
                                        </a>
                                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary">
                                            <i class="fas fa-shopping-cart"></i> Proceed to Checkout
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <script>
                    function updateQuantity(bookId, change) {
                        let url = '${pageContext.request.contextPath}/cart/update';
                        let quantity;

                        if (typeof change === 'number') {
                            const input = document.querySelector(`input[onchange*="${bookId}"]`);
                            quantity = parseInt(input.value) + change;
                            if (quantity < 1) quantity = 1;
                            if (quantity > 99) quantity = 99;
                            input.value = quantity;
                        } else {
                            quantity = parseInt(change);
                        }

                        fetch(url, {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: `bookId=${bookId}&quantity=${quantity}`
                        })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    location.reload();
                                } else {
                                    alert(data.message || 'Failed to update quantity');
                                }
                            })
                            .catch(error => {
                                console.error('Error:', error);
                                alert('An error occurred while updating the quantity');
                            });
                    }

                    function removeFromCart(bookId) {
                        if (confirm('Are you sure you want to remove this item from your cart?')) {
                            fetch('${pageContext.request.contextPath}/cart/remove', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: `bookId=${bookId}`
                            })
                                .then(response => response.json())
                                .then(data => {
                                    if (data.success) {
                                        location.reload();
                                    } else {
                                        alert(data.message || 'Failed to remove item');
                                    }
                                })
                                .catch(error => {
                                    console.error('Error:', error);
                                    alert('An error occurred while removing the item');
                                });
                        }
                    }
                </script>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>