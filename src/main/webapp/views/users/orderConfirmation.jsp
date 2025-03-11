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
                <title>Order Confirmation - BookStore</title>
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
                            <a href="${pageContext.request.contextPath}/cart">Cart</a>
                            <a href="${pageContext.request.contextPath}/user/orders" class="active">My Orders</a>
                            <a href="${pageContext.request.contextPath}/user/profile">Profile</a>
                            <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
                        </div>
                    </div>
                </nav>

                <div class="container mt-4">
                    <div class="card">
                        <div class="card-header bg-success text-white">
                            <h2 class="card-title">
                                <i class="fas fa-check-circle"></i> Order Confirmed!
                            </h2>
                        </div>
                        <div class="card-body">
                            <div class="text-center mb-4">
                                <i class="fas fa-check-circle text-success fa-5x mb-3"></i>
                                <h3>Thank you for your order!</h3>
                                <p class="text-muted">Your order has been successfully placed and will be processed
                                    shortly.</p>
                            </div>

                            <div class="row justify-content-center">
                                <div class="col-md-8">
                                    <div class="card">
                                        <div class="card-header">
                                            <h4 class="card-title mb-0">
                                                <i class="fas fa-info-circle"></i> Order Details
                                            </h4>
                                        </div>
                                        <div class="card-body">
                                            <div class="row mb-3">
                                                <div class="col-sm-4">
                                                    <strong>Order Number:</strong>
                                                </div>
                                                <div class="col-sm-8">
                                                    ${order.orderNumber}
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <div class="col-sm-4">
                                                    <strong>Order Date:</strong>
                                                </div>
                                                <div class="col-sm-8">
                                                    <fmt:formatDate value="${order.orderDate}"
                                                        pattern="MMMM dd, yyyy HH:mm" />
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <div class="col-sm-4">
                                                    <strong>Shipping Address:</strong>
                                                </div>
                                                <div class="col-sm-8">
                                                    ${order.shippingAddress}
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <div class="col-sm-4">
                                                    <strong>Payment Method:</strong>
                                                </div>
                                                <div class="col-sm-8">
                                                    ${order.paymentMethod}
                                                </div>
                                            </div>

                                            <hr>

                                            <h5 class="mb-3">Order Summary</h5>
                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>Item</th>
                                                            <th>Quantity</th>
                                                            <th class="text-end">Price</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${order.items}" var="item">
                                                            <tr>
                                                                <td>${item.book.title}</td>
                                                                <td>${item.quantity}</td>
                                                                <td class="text-end">$${item.totalPrice}</td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                    <tfoot>
                                                        <tr>
                                                            <td colspan="2" class="text-end"><strong>Subtotal:</strong>
                                                            </td>
                                                            <td class="text-end">$${order.subtotal}</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" class="text-end"><strong>Tax (10%):</strong>
                                                            </td>
                                                            <td class="text-end">$${order.tax}</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" class="text-end"><strong>Total:</strong>
                                                            </td>
                                                            <td class="text-end"><strong>$${order.total}</strong></td>
                                                        </tr>
                                                    </tfoot>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center mt-4">
                                <a href="${pageContext.request.contextPath}/user/orders" class="btn btn-primary me-2">
                                    <i class="fas fa-list"></i> View My Orders
                                </a>
                                <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary">
                                    <i class="fas fa-book"></i> Continue Shopping
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>