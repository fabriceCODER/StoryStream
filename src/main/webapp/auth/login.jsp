<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <fmt:setLocale value="${param.lang != null ? param.lang : 'en'}" />
            <fmt:setBundle basename="messages" />

            <c:set var="title" value="Login" scope="request" />
            <%@ include file="/WEB-INF/includes/header.jsp" %>

                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card shadow">
                            <div class="card-body">
                                <h2 class="text-center mb-4">
                                    <i class="fas fa-sign-in-alt"></i>
                                    <fmt:message key="login.title" />
                                </h2>

                                <!-- Language Selection -->
                                <form method="get" action="${pageContext.request.contextPath}/login" class="mb-4">
                                    <div class="form-group">
                                        <label for="lang" class="form-label">
                                            <i class="fas fa-globe"></i>
                                            <fmt:message key="login.language" />
                                        </label>
                                        <select name="lang" id="lang" class="form-select" onchange="this.form.submit()">
                                            <option value="en" ${param.lang=='en' ? 'selected' : '' }>English</option>
                                            <option value="es" ${param.lang=='es' ? 'selected' : '' }>Español</option>
                                            <option value="fr" ${param.lang=='fr' ? 'selected' : '' }>Français</option>
                                            <option value="rw" ${param.lang=='rw' ? 'selected' : '' }>Kinyarwanda
                                            </option>
                                            <option value="sw" ${param.lang=='sw' ? 'selected' : '' }>Kiswahili</option>
                                        </select>
                                    </div>
                                </form>

                                <!-- Login Form -->
                                <form action="${pageContext.request.contextPath}/auth/login" method="post">
                                    <div class="form-group mb-3">
                                        <label for="username" class="form-label">
                                            <i class="fas fa-user"></i>
                                            <fmt:message key="login.username" />
                                        </label>
                                        <input type="text" name="username" id="username" class="form-control" required>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label for="password" class="form-label">
                                            <i class="fas fa-lock"></i>
                                            <fmt:message key="login.password" />
                                        </label>
                                        <input type="password" name="password" id="password" class="form-control"
                                            required>
                                    </div>

                                    <div class="d-flex justify-content-between align-items-center">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-sign-in-alt"></i>
                                            <fmt:message key="login.submit" />
                                        </button>
                                        <a href="${pageContext.request.contextPath}/register" class="btn btn-link">
                                            <i class="fas fa-user-plus"></i>
                                            <fmt:message key="login.register" />
                                        </a>
                                    </div>
                                </form>

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

                <%@ include file="/WEB-INF/includes/footer.jsp" %>