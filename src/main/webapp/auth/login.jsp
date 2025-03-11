<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${not empty param.lang ? param.lang : 'en'}" />
<fmt:setBundle basename="messages" />

<c:set var="title" value="Admin Login" scope="request" />
<%@ include file="/WEB-INF/includes/header.jsp" %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-body">
                    <h2 class="text-center mb-4">
                        <i class="fas fa-sign-in-alt"></i>
                        <fmt:message key="admin.login.title" />
                    </h2>

                    <!-- Admin Login Form -->
                    <form action="${pageContext.request.contextPath}/auth/login" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="lang" value="${not empty param.lang ? param.lang : 'en'}">

                        <div class="form-group mb-3">
                            <label for="username" class="form-label">
                                <i class="fas fa-user"></i>
                                <fmt:message key="admin.login.username" />
                            </label>
                            <input type="text" name="username" id="username" class="form-control" required>
                            <div class="invalid-feedback">
                                <fmt:message key="admin.login.username.required" />
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <label for="password" class="form-label">
                                <i class="fas fa-lock"></i>
                                <fmt:message key="admin.login.password" />
                            </label>
                            <input type="password" name="password" id="password" class="form-control" required>
                            <div class="invalid-feedback">
                                <fmt:message key="admin.login.password.required" />
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-sign-in-alt"></i>
                                <fmt:message key="admin.login.submit" />
                            </button>
                            <a href="${pageContext.request.contextPath}/auth/register?lang=${not empty param.lang ? param.lang : 'en'}" class="btn btn-link">
                                <i class="fas fa-user-plus"></i>
                                <fmt:message key="admin.login.register" />
                            </a>
                        </div>
                    </form>

                    <!-- Language Selector -->
                    <div class="text-center mt-3">
                        <div class="btn-group">
                            <a href="?lang=en" class="btn btn-outline-secondary ${param.lang == 'en' || empty param.lang ? 'active' : ''}">English</a>
                            <a href="?lang=rw" class="btn btn-outline-secondary ${param.lang == 'rw' ? 'active' : ''}">Kinyarwanda</a>
                            <a href="?lang=sw" class="btn btn-outline-secondary ${param.lang == 'sw' ? 'active' : ''}">Kiswahili</a>
                        </div>
                    </div>

                    <!-- Messages -->
                    <c:if test="${not empty param.error}">
                        <div class="alert alert-danger mt-3" role="alert">
                            <i class="fas fa-exclamation-circle"></i> ${param.error}
                        </div>
                    </c:if>
                    <c:if test="${not empty param.message}">
                        <div class="alert alert-success mt-3" role="alert">
                            <i class="fas fa-check-circle"></i> ${param.message}
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Form validation
    (function () {
        'use strict'
        var forms = document.querySelectorAll('.needs-validation')
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>
