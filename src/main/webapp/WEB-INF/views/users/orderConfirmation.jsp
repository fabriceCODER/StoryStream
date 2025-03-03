<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%-- Set the selected locale (Language) --%>
<fmt:setLocale value="${sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<%-- Retrieve order details from request scope --%>
<%
    String orderNumber = (String) request.getAttribute("orderNumber");
    String paymentMethod = (String) request.getAttribute("paymentMethod");
    String shippingAddress = (String) request.getAttribute("shippingAddress");
    double totalAmount = (double) request.getAttribute("totalAmount");
%>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key="order.confirmation.title"/></title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<div class="container">
    <h2><fmt:message key="order.confirmation.title"/></h2>
    <p class="success-message"><fmt:message key="order.confirmation.success"/></p>

    <table class="order-summary">
        <tr>
            <td><strong><fmt:message key="order.confirmation.orderNumber"/>:</strong></td>
            <td><%= orderNumber %></td>
        </tr>
        <tr>
            <td><strong><fmt:message key="order.confirmation.paymentMethod"/>:</strong></td>
            <td><%= paymentMethod %></td>
        </tr>
        <tr>
            <td><strong><fmt:message key="order.confirmation.shippingAddress"/>:</strong></td>
            <td><%= shippingAddress %></td>
        </tr>
        <tr>
            <td><strong><fmt:message key="order.confirmation.totalAmount"/>:</strong></td>
            <td><fmt:formatNumber value="<%= totalAmount %>" type="currency"/></td>
        </tr>
    </table>

    <p class="thank-you-message"><fmt:message key="order.confirmation.thankYou"/></p>

    <a href="browse-books.jsp" class="button"><fmt:message key="browse.books.title"/></a>
</div>
</body>
</html>
