<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<fmt:setLocale value="${param.lang != null ? param.lang : 'en'}" />
<fmt:setBundle basename="messages" />

<html>
<head>
    <title><fmt:message key="checkout.title" /></title>
</head>
<body>

<h2><fmt:message key="checkout.title" /></h2>

<form action="OrderController" method="post">
    <label><fmt:message key="checkout.fullname" /></label>
    <input type="text" name="fullname" required>

    <label><fmt:message key="checkout.address" /></label>
    <input type="text" name="address" required>

    <label><fmt:message key="checkout.payment" /></label>
    <select name="paymentMethod">
        <option value="credit_card"><fmt:message key="checkout.payment.creditcard" /></option>
        <option value="paypal"><fmt:message key="checkout.payment.paypal" /></option>
    </select>

    <button type="submit"><fmt:message key="checkout.placeOrder" /></button>
</form>

</body>
</html>
