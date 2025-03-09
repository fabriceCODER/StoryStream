<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <title>Online Bookstore</title>
    <link rel="stylesheet" type="text/css" href="/assets/css/index.css">
</head>
<body>
<header>
    <h1>Welcome to Online Bookstore</h1>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="index.jsp">Online Bookstore</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp">Register</a>
                </li>
                <c:if test="${not empty sessionScope.user and sessionScope.user.role eq 'ADMIN'}">
                    <li><a href="admin-dashboard.jsp">Admin Dashboard</a></li>
                </c:if>
                <c:if test="${not empty sessionScope.user}">
                    <li><a href="logout">Logout</a></li>
                </c:if>
            </ul>
        </div>
    </nav>
</header>

<main>
    <h2>Your One-Stop Shop for Books</h2>
    <p>Explore our vast collection and enjoy a seamless shopping experience.</p>

    <section>
        <h3>Top Categories</h3>
        <ul>
            <li>Fiction</li>
            <li>Non-Fiction</li>
            <li>Science & Technology</li>
            <li>Business & Economics</li>
        </ul>
    </section>
</main>

<footer>
    <p>&copy; 2025 Online Bookstore. All rights reserved.</p>
</footer>
</body>
</html>
