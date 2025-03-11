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
                <title>Checkout - BookStore</title>
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
                            <a href="${pageContext.request.contextPath}/user/orders">My Orders</a>
                            <a href="${pageContext.request.contextPath}/user/profile">Profile</a>
                            <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
                        </div>
                    </div>
                </nav>

                <div class="container mt-4">
                    <div class="row">
                        <!-- Order Summary -->
                        <div class="col-md-4 order-md-2 mb-4">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">
                                        <i class="fas fa-shopping-cart"></i> Order Summary
                                    </h4>
                                </div>
                                <div class="card-body">
                                    <ul class="list-group mb-3">
                                        <c:forEach items="${cart.items}" var="item">
                                            <li class="list-group-item d-flex justify-content-between lh-sm">
                                                <div>
                                                    <h6 class="my-0">${item.book.title}</h6>
                                                    <small class="text-muted">Quantity: ${item.quantity}</small>
                                                </div>
                                                <span class="text-muted">$${item.totalPrice}</span>
                                            </li>
                                        </c:forEach>
                                        <li class="list-group-item d-flex justify-content-between">
                                            <span>Subtotal</span>
                                            <strong>$${cart.subtotal}</strong>
                                        </li>
                                        <li class="list-group-item d-flex justify-content-between">
                                            <span>Tax (10%)</span>
                                            <strong>$${cart.tax}</strong>
                                        </li>
                                        <li class="list-group-item d-flex justify-content-between">
                                            <span>Total</span>
                                            <strong>$${cart.total}</strong>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Checkout Form -->
                        <div class="col-md-8 order-md-1">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">
                                        <i class="fas fa-credit-card"></i> Payment Details
                                    </h4>
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

                                    <form id="checkoutForm" action="${pageContext.request.contextPath}/order/create"
                                        method="post" class="needs-validation" novalidate>
                                        <!-- Shipping Information -->
                                        <h5 class="mb-3">Shipping Information</h5>
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label for="firstName" class="form-label">First Name</label>
                                                <input type="text" class="form-control" id="firstName" name="firstName"
                                                    required>
                                                <div class="invalid-feedback">
                                                    Valid first name is required.
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="lastName" class="form-label">Last Name</label>
                                                <input type="text" class="form-control" id="lastName" name="lastName"
                                                    required>
                                                <div class="invalid-feedback">
                                                    Valid last name is required.
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label for="email" class="form-label">Email</label>
                                                <input type="email" class="form-control" id="email" name="email"
                                                    required>
                                                <div class="invalid-feedback">
                                                    Please enter a valid email address.
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label for="address" class="form-label">Address</label>
                                                <input type="text" class="form-control" id="address" name="address"
                                                    required>
                                                <div class="invalid-feedback">
                                                    Please enter your shipping address.
                                                </div>
                                            </div>
                                            <div class="col-md-5">
                                                <label for="country" class="form-label">Country</label>
                                                <select class="form-select" id="country" name="country" required>
                                                    <option value="">Choose...</option>
                                                    <option value="US">United States</option>
                                                    <option value="CA">Canada</option>
                                                    <option value="GB">United Kingdom</option>
                                                </select>
                                                <div class="invalid-feedback">
                                                    Please select a valid country.
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <label for="state" class="form-label">State</label>
                                                <input type="text" class="form-control" id="state" name="state"
                                                    required>
                                                <div class="invalid-feedback">
                                                    Please provide a valid state.
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <label for="zip" class="form-label">ZIP Code</label>
                                                <input type="text" class="form-control" id="zip" name="zip" required>
                                                <div class="invalid-feedback">
                                                    ZIP code required.
                                                </div>
                                            </div>
                                        </div>

                                        <hr class="my-4">

                                        <!-- Payment Information -->
                                        <h5 class="mb-3">Payment Information</h5>
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label for="cardName" class="form-label">Name on Card</label>
                                                <input type="text" class="form-control" id="cardName" name="cardName"
                                                    required>
                                                <div class="invalid-feedback">
                                                    Name on card is required.
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label for="cardNumber" class="form-label">Card Number</label>
                                                <input type="text" class="form-control" id="cardNumber"
                                                    name="cardNumber" pattern="[0-9]{16}" required>
                                                <div class="invalid-feedback">
                                                    Valid card number is required (16 digits).
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <label for="expMonth" class="form-label">Expiration Month</label>
                                                <input type="text" class="form-control" id="expMonth" name="expMonth"
                                                    pattern="[0-9]{2}" placeholder="MM" required>
                                                <div class="invalid-feedback">
                                                    Expiration month required.
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <label for="expYear" class="form-label">Expiration Year</label>
                                                <input type="text" class="form-control" id="expYear" name="expYear"
                                                    pattern="[0-9]{4}" placeholder="YYYY" required>
                                                <div class="invalid-feedback">
                                                    Expiration year required.
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <label for="cvv" class="form-label">CVV</label>
                                                <input type="text" class="form-control" id="cvv" name="cvv"
                                                    pattern="[0-9]{3,4}" required>
                                                <div class="invalid-feedback">
                                                    Security code required.
                                                </div>
                                            </div>
                                        </div>

                                        <hr class="my-4">

                                        <button class="btn btn-primary btn-lg w-100" type="submit">
                                            <i class="fas fa-lock"></i> Place Order
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script>
                    // Form validation
                    (function () {
                        'use strict'
                        const forms = document.querySelectorAll('.needs-validation')
                        Array.from(forms).forEach(form => {
                            form.addEventListener('submit', event => {
                                if (!form.checkValidity()) {
                                    event.preventDefault()
                                    event.stopPropagation()
                                }
                                form.classList.add('was-validated')
                            }, false)
                        })
                    })()

                    // Card number formatting
                    document.getElementById('cardNumber').addEventListener('input', function (e) {
                        let value = this.value.replace(/\D/g, '');
                        if (value.length > 16) value = value.slice(0, 16);
                        this.value = value;
                    });

                    // CVV formatting
                    document.getElementById('cvv').addEventListener('input', function (e) {
                        let value = this.value.replace(/\D/g, '');
                        if (value.length > 4) value = value.slice(0, 4);
                        this.value = value;
                    });

                    // Expiration date formatting
                    document.getElementById('expMonth').addEventListener('input', function (e) {
                        let value = this.value.replace(/\D/g, '');
                        if (value.length > 2) value = value.slice(0, 2);
                        if (value > 12) value = '12';
                        this.value = value;
                    });

                    document.getElementById('expYear').addEventListener('input', function (e) {
                        let value = this.value.replace(/\D/g, '');
                        if (value.length > 4) value = value.slice(0, 4);
                        const currentYear = new Date().getFullYear();
                        if (value < currentYear) value = currentYear;
                        this.value = value;
                    });
                </script>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>