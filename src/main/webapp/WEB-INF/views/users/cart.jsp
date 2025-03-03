<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<fmt:setLocale value="${param.lang != null ? param.lang : 'en'}" />
<fmt:setBundle basename="messages" />

<html>
<head>
    <title><fmt:message key="cart.title" /></title>
</head>
<body>

<h2><fmt:message key="cart.title" /></h2>

<c:if test="${empty cart}">
    <p><fmt:message key="cart.empty" /></p>
</c:if>

<table border="1">
    <tr>
        <th><fmt:message key="cart.bookName" /></th>
        <th><fmt:message key="cart.quantity" /></th>
        <th><fmt:message key="cart.price" /></th>
        <th><fmt:message key="cart.total" /></th>
        <th><fmt:message key="cart.action" /></th>
    </tr>
    <c:forEach var="item" items="${cart}">
        <tr>
            <td>${item.book.title}</td>
            <td>
                <form action="CartController" method="post">
                    <input type="hidden" name="bookId" value="${item.book.id}">
                    <input type="hidden" name="action" value="updateQuantity">
                    <input type="number" name="quantity" value="${item.quantity}" min="1">
                    <button type="submit"><fmt:message key="cart.update" /></button>
                </form>
            </td>
            <td>${item.book.price} USD</td>
            <td>${item.totalPrice} USD</td>
            <td>
                <form action="CartController" method="post">
                    <input type="hidden" name="bookId" value="${item.book.id}">
                    <input type="hidden" name="action" value="removeFromCart">
                    <button type="submit"><fmt:message key="cart.remove" /></button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

<!-- Checkout Button -->
<a href="checkout.jsp"><button><fmt:message key="cart.checkout" /></button></a>

</body>
</html>
