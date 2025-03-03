<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<fmt:setLocale value="${param.lang != null ? param.lang : 'en'}" />
<fmt:setBundle basename="messages" />

<html>
<head>
    <meta charset="UTF-8">
    <title><fmt:message key="login.title" /></title>
</head>
<body>

<!-- Language Selection -->
<form method="get" action="login.jsp">
    <select name="lang" onchange="this.form.submit()">
        <option value="en" ${param.lang == 'en' ? 'selected' : ''}>English</option>
        <option value="es" ${param.lang == 'es' ? 'selected' : ''}>Español</option>
        <option value="fr" ${param.lang == 'fr' ? 'selected' : ''}>Français</option>
        <option value="rw" ${param.lang == 'rw' ? 'selected' : ''}>Kinyarwanda</option>
        <option value="sw" ${param.lang == 'sw' ? 'selected' : ''}>Kiswahili</option>
    </select>
</form>

<h2><fmt:message key="login.title" /></h2>
<form action="UserController" method="post">
    <input type="hidden" name="action" value="login">

    <label><fmt:message key="login.username" /></label>
    <input type="text" name="username" required>

    <label><fmt:message key="login.password" /></label>
    <input type="password" name="password" required>

    <button type="submit"><fmt:message key="login.submit" /></button>
</form>

<c:if test="${param.error != null}">
    <p style="color: red;"><fmt:message key="login.error" /></p>
</c:if>

</body>
</html>
