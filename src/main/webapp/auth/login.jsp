<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<fmt:setLocale value="${param.lang != null ? param.lang : 'en'}" />
<fmt:setBundle basename="messages" />

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="login.title" /></title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h2 class="text-center mb-4"><fmt:message key="login.title" /></h2>

                    <!-- Language Selection -->
                    <form method="get" action="login.jsp" class="mb-4">
                        <div class="form-group">
                            <label for="lang" class="form-label"><fmt:message key="login.language" /></label>
                            <select name="lang" id="lang" class="form-select" onchange="this.form.submit()">
                                <option value="en" ${param.lang == 'en' ? 'selected' : ''}>English</option>
                                <option value="es" ${param.lang == 'es' ? 'selected' : ''}>Español</option>
                                <option value="fr" ${param.lang == 'fr' ? 'selected' : ''}>Français</option>
                                <option value="rw" ${param.lang == 'rw' ? 'selected' : ''}>Kinyarwanda</option>
                                <option value="sw" ${param.lang == 'sw' ? 'selected' : ''}>Kiswahili</option>
                            </select>
                        </div>
                    </form>

                    <!-- Login Form -->
                    <form action="UserController" method="post">
                        <input type="hidden" name="action" value="login">

                        <div class="form-group mb-3">
                            <label for="username" class="form-label"><fmt:message key="login.username" /></label>
                            <input type="text" name="username" id="username" class="form-control" required>
                        </div>

                        <div class="form-group mb-3">
                            <label for="password" class="form-label"><fmt:message key="login.password" /></label>
                            <input type="password" name="password" id="password" class="form-control" required>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <button type="submit" class="btn btn-primary"><fmt:message key="login.submit" /></button>
                        </div>
                    </form>

                    <!-- Error Message -->
                    <c:if test="${param.error != null}">
                        <div class="alert alert-danger mt-3" role="alert">
                            <fmt:message key="login.error" />
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
