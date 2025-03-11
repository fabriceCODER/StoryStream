<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>BookStore - Welcome</title>
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Font Awesome -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <style>
                .hero {
                    background: linear-gradient(135deg, #6B73FF 0%, #000DFF 100%);
                    color: white;
                    padding: 4rem 0;
                    margin-bottom: 2rem;
                }

                .feature-card {
                    border: none;
                    border-radius: 15px;
                    transition: transform 0.3s;
                }

                .feature-card:hover {
                    transform: translateY(-5px);
                }

                .feature-icon {
                    font-size: 2.5rem;
                    margin-bottom: 1rem;
                    color: #000DFF;
                }
            </style>
        </head>

        <body>
            <!-- Navigation -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                <div class="container">
                    <a class="navbar-brand" href="#">
                        <i class="fas fa-book-reader me-2"></i>BookStore
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <c:choose>
                                <c:when test="${empty sessionScope.user}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/auth/login">
                                            <i class="fas fa-sign-in-alt me-1"></i>Login
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/auth/register">
                                            <i class="fas fa-user-plus me-1"></i>Register
                                        </a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/user/dashboard">
                                            <i class="fas fa-home me-1"></i>Dashboard
                                        </a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- Hero Section -->
            <section class="hero">
                <div class="container text-center">
                    <h1 class="display-4 mb-4">Welcome to BookStore</h1>
                    <p class="lead mb-4">Discover your next favorite book from our vast collection</p>
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <div class="d-grid gap-2 d-md-block">
                                <a href="${pageContext.request.contextPath}/auth/login"
                                    class="btn btn-light btn-lg me-2">
                                    <i class="fas fa-sign-in-alt me-2"></i>Login
                                </a>
                                <a href="${pageContext.request.contextPath}/auth/register"
                                    class="btn btn-outline-light btn-lg">
                                    <i class="fas fa-user-plus me-2"></i>Register
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-light btn-lg">
                                <i class="fas fa-home me-2"></i>Go to Dashboard
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

            <!-- Features Section -->
            <section class="container py-5">
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="card feature-card shadow-sm">
                            <div class="card-body text-center">
                                <i class="fas fa-book feature-icon"></i>
                                <h3 class="h5">Vast Collection</h3>
                                <p class="text-muted">Browse through thousands of books across various genres</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card feature-card shadow-sm">
                            <div class="card-body text-center">
                                <i class="fas fa-truck feature-icon"></i>
                                <h3 class="h5">Fast Delivery</h3>
                                <p class="text-muted">Get your favorite books delivered right to your doorstep</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card feature-card shadow-sm">
                            <div class="card-body text-center">
                                <i class="fas fa-user-shield feature-icon"></i>
                                <h3 class="h5">Secure Shopping</h3>
                                <p class="text-muted">Shop with confidence with our secure payment system</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>