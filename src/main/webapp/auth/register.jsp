<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${not empty param.lang ? param.lang : 'en'}" />
<fmt:setBundle basename="messages" />

<c:set var="title" value="Admin Register" scope="request" />
<%@ include file="/WEB-INF/includes/header.jsp" %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-body">
                    <h2 class="text-center mb-4">
                        <i class="fas fa-user-plus"></i>
                        <fmt:message key="admin.register.title" />
                    </h2>

                    <!-- Admin Registration Form -->
                    <form action="${pageContext.request.contextPath}/auth/register" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="lang" value="${not empty param.lang ? param.lang : 'en'}">

                        <!-- Admin Username -->
                        <div class="form-group mb-3">
                            <label for="username" class="form-label">
                                <i class="fas fa-user"></i>
                                <fmt:message key="admin.register.username" />
                            </label>
                            <input type="text" name="username" id="username" class="form-control" required pattern="[a-zA-Z0-9_]{3,20}">
                            <div class="invalid-feedback">
                                <fmt:message key="admin.register.username.required" />
                            </div>
                            <small class="form-text text-muted">
                                <i class="fas fa-info-circle"></i>
                                <fmt:message key="admin.register.username.hint" />
                            </small>
                        </div>

                        <!-- Admin Email -->
                        <div class="form-group mb-3">
                            <label for="email" class="form-label">
                                <i class="fas fa-envelope"></i>
                                <fmt:message key="admin.register.email.label" />
                            </label>
                            <input type="email" name="email" id="email" class="form-control" required placeholder="<fmt:message key='admin.register.email.placeholder' />">
                            <div class="invalid-feedback">
                                <fmt:message key="admin.register.email.required" />
                            </div>
                            <small class="form-text text-muted">
                                <i class="fas fa-info-circle"></i>
                                <fmt:message key="admin.register.email.hint" />
                            </small>
                        </div>

                        <!-- Admin Password -->
                        <div class="form-group mb-3">
                            <label for="password" class="form-label">
                                <i class="fas fa-lock"></i>
                                <fmt:message key="admin.register.password.label" />
                            </label>
                            <input type="password" name="password" id="password" class="form-control" required minlength="8" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$" placeholder="<fmt:message key='admin.register.password.placeholder' />">
                            <div class="invalid-feedback">
                                <fmt:message key="admin.register.password.required" />
                            </div>
                            <small class="form-text text-muted">
                                <i class="fas fa-info-circle"></i>
                                <fmt:message key="admin.register.password.hint" />
                            </small>
                        </div>

                        <!-- Admin Confirm Password -->
                        <div class="form-group mb-3">
                            <label for="confirmPassword" class="form-label">
                                <i class="fas fa-lock"></i>
                                <fmt:message key="admin.register.confirmPassword.label" />
                            </label>
                            <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" required placeholder="<fmt:message key='admin.register.confirmPassword.placeholder' />">
                            <div class="invalid-feedback">
                                <fmt:message key="admin.register.confirmPassword.required" />
                            </div>
                            <small class="form-text text-muted">
                                <i class="fas fa-info-circle"></i>
                                <fmt:message key="admin.register.confirmPassword.hint" />
                            </small>
                        </div>

                        <!-- Admin Admin Code -->
                        <div class="form-group mb-3">
                            <label for="adminCode" class="form-label">
                                <i class="fas fa-key"></i>
                                <fmt:message key="admin.register.adminCode.label" />
                            </label>
                            <input type="text" name="adminCode" id="adminCode" class="form-control" required>
                            <div class="invalid-feedback">
                                <fmt:message key="admin.register.adminCode.required" />
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-user-plus"></i>
                                <fmt:message key="admin.register.submit" />
                            </button>
                            <a href="${pageContext.request.contextPath}/auth/login?lang=${not empty param.lang ? param.lang : 'en'}" class="btn btn-link">
                                <i class="fas fa-sign-in-alt"></i>
                                <fmt:message key="admin.register.login" />
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

    // Password confirmation validation with translated message
    document.getElementById('confirmPassword').addEventListener('input', function () {
        var password = document.getElementById('password').value;
        var confirmPassword = this.value;

        if (password !== confirmPassword) {
            this.setCustomValidity(document.querySelector('[data-password-mismatch]').getAttribute('data-message'));
        } else {
            this.setCustomValidity('');
        }
    });
</script>

<!-- Hidden element for password mismatch message translation -->
<div hidden data-password-mismatch data-message="<fmt:message key='admin.register.password.mismatch' />"></div>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
