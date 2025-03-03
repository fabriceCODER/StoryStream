<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <title>Online Bookstore</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<header>
    <h1>Welcome to Online Bookstore</h1>
    <nav>
        <ul>
            <li><a href="login.jsp">Login</a></li>
            <li><a href="register.jsp">Register</a></li>
            <li><a href="browse-books.jsp">Browse Books</a></li>
            <li><a href="cart.jsp">Cart</a></li>
            <c:if test="${not empty sessionScope.user and sessionScope.user.role eq 'ADMIN'}">
                <li><a href="admin-dashboard.jsp">Admin Dashboard</a></li>
            </c:if>
            <c:if test="${not empty sessionScope.user}">
                <li><a href="logout">Logout</a></li>
            </c:if>
        </ul>
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
