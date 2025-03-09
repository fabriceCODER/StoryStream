<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<fmt:setLocale value="${param.lang != null ? param.lang : 'en'}" />
<fmt:setBundle basename="messages" />

<html>
<head>
    <title><fmt:message key="browse.books.title" /></title>
</head>
<body>

<!-- Language Selection -->
<form method="get" action="browse-books.jsp">
    <select name="lang" onchange="this.form.submit()">
        <option value="en" ${param.lang == 'en' ? 'selected' : ''}>English</option>
        <option value="es" ${param.lang == 'es' ? 'selected' : ''}>Español</option>
        <option value="fr" ${param.lang == 'fr' ? 'selected' : ''}>Français</option>
        <option value="rw" ${param.lang == 'rw' ? 'selected' : ''}>Kinyarwanda</option>
        <option value="sw" ${param.lang == 'sw' ? 'selected' : ''}>Kiswahili</option>
    </select>
</form>

<h2><fmt:message key="browse.books.title" /></h2>

<!-- Search Form -->
<form action="browse-books.jsp" method="get">
    <input type="text" name="search" placeholder="<fmt:message key='browse.books.search.placeholder' />">
    <button type="submit"><fmt:message key="browse.books.search" /></button>
</form>

<!-- Book List -->
<table border="1">
    <tr>
        <th><fmt:message key="browse.books.name" /></th>
        <th><fmt:message key="browse.books.author" /></th>
        <th><fmt:message key="browse.books.price" /></th>
        <th><fmt:message key="browse.books.action" /></th>
    </tr>
    <c:forEach var="book" items="${bookList}">
        <tr>
            <td>${book.title}</td>
            <td>${book.author}</td>
            <td>${book.price} USD</td>
            <td>
                <form action="CartController" method="post">
                    <input type="hidden" name="bookId" value="${book.id}">
                    <input type="hidden" name="action" value="addToCart">
                    <button type="submit"><fmt:message key="browse.books.addToCart" /></button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
