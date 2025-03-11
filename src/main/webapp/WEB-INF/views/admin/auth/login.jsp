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
                                                  <i class="fas fa-user-shield"></i>
                                                  <fmt:message key="admin.login.title" />
                                             </h2>

                                             <!-- Language Selection -->
                                             <div class="text-center mb-4">
                                                  <div class="btn-group">
                                                       <a href="?lang=en${not empty param.error ? '&error='.concat(param.error) : ''}${not empty param.message ? '&message='.concat(param.message) : ''}"
                                                            class="btn btn-outline-secondary ${param.lang == 'en' || empty param.lang ? 'active' : ''}">
                                                            <i class="fas fa-flag"></i> English
                                                       </a>
                                                       <a href="?lang=rw${not empty param.error ? '&error='.concat(param.error) : ''}${not empty param.message ? '&message='.concat(param.message) : ''}"
                                                            class="btn btn-outline-secondary ${param.lang == 'rw' ? 'active' : ''}">
                                                            <i class="fas fa-flag"></i> Kinyarwanda
                                                       </a>
                                                       <a href="?lang=sw${not empty param.error ? '&error='.concat(param.error) : ''}${not empty param.message ? '&message='.concat(param.message) : ''}"
                                                            class="btn btn-outline-secondary ${param.lang == 'sw' ? 'active' : ''}">
                                                            <i class="fas fa-flag"></i> Kiswahili
                                                       </a>
                                                  </div>
                                             </div>

                                             <!-- Show error message if present -->
                                             <c:if test="${not empty param.error}">
                                                  <div class="alert alert-danger">
                                                       <i class="fas fa-exclamation-circle"></i>
                                                       <fmt:message key="${param.error}" />
                                                  </div>
                                             </c:if>

                                             <!-- Show success message if present -->
                                             <c:if test="${not empty param.message}">
                                                  <div class="alert alert-success">
                                                       <i class="fas fa-check-circle"></i>
                                                       <fmt:message key="${param.message}" />
                                                  </div>
                                             </c:if>

                                             <!-- Login Form -->
                                             <form action="${pageContext.request.contextPath}/admin/auth/login"
                                                  method="post" class="needs-validation" novalidate>
                                                  <input type="hidden" name="lang"
                                                       value="${not empty param.lang ? param.lang : 'en'}">

                                                  <!-- Username -->
                                                  <div class="form-group mb-3">
                                                       <label for="username" class="form-label">
                                                            <i class="fas fa-user"></i>
                                                            <fmt:message key="admin.login.username" />
                                                       </label>
                                                       <input type="text" name="username" id="username"
                                                            class="form-control" required
                                                            placeholder="<fmt:message key='admin.login.username.placeholder' />">
                                                       <div class="invalid-feedback">
                                                            <fmt:message key="admin.login.username.required" />
                                                       </div>
                                                  </div>

                                                  <!-- Password -->
                                                  <div class="form-group mb-3">
                                                       <label for="password" class="form-label">
                                                            <i class="fas fa-lock"></i>
                                                            <fmt:message key="admin.login.password" />
                                                       </label>
                                                       <input type="password" name="password" id="password"
                                                            class="form-control" required
                                                            placeholder="<fmt:message key='admin.login.password.placeholder' />">
                                                       <div class="invalid-feedback">
                                                            <fmt:message key="admin.login.password.required" />
                                                       </div>
                                                  </div>

                                                  <!-- Submit Button -->
                                                  <div class="d-flex justify-content-between align-items-center mb-3">
                                                       <button type="submit" class="btn btn-primary">
                                                            <i class="fas fa-sign-in-alt"></i>
                                                            <fmt:message key="admin.login.submit" />
                                                       </button>
                                                       <a href="${pageContext.request.contextPath}/admin/auth/register"
                                                            class="btn btn-link">
                                                            <i class="fas fa-user-plus"></i>
                                                            <fmt:message key="admin.login.register" />
                                                       </a>
                                                  </div>
                                             </form>

                                             <!-- Back to Home -->
                                             <div class="text-center mt-3">
                                                  <a href="${pageContext.request.contextPath}/"
                                                       class="btn btn-outline-secondary">
                                                       <i class="fas fa-home"></i> Back to Home
                                                  </a>
                                             </div>
                                        </div>
                                   </div>
                              </div>
                         </div>
                    </div>

                    <%@ include file="/WEB-INF/includes/footer.jsp" %>