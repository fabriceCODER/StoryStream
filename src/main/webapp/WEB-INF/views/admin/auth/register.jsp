<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
     <%@ taglib prefix="c" uri="jakarta.tags.core" %>
          <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

               <fmt:setLocale value="${not empty param.lang ? param.lang : 'en'}" />
               <fmt:setBundle basename="messages" />

               <c:set var="title" value="Admin Registration" scope="request" />
               <%@ include file="/WEB-INF/includes/header.jsp" %>

                    <div class="container mt-5">
                         <div class="row justify-content-center">
                              <div class="col-md-6">
                                   <div class="card shadow">
                                        <div class="card-body">
                                             <h2 class="text-center mb-4">
                                                  <i class="fas fa-user-shield"></i>
                                                  <fmt:message key="admin.register.title" />
                                             </h2>

                                             <!-- Language Selection -->
                                             <div class="text-center mb-4">
                                                  <div class="btn-group">
                                                       <a href="?lang=en${not empty param.error ? '&error='.concat(param.error) : ''}"
                                                            class="btn btn-outline-secondary ${param.lang == 'en' || empty param.lang ? 'active' : ''}">
                                                            <i class="fas fa-flag"></i> English
                                                       </a>
                                                       <a href="?lang=rw${not empty param.error ? '&error='.concat(param.error) : ''}"
                                                            class="btn btn-outline-secondary ${param.lang == 'rw' ? 'active' : ''}">
                                                            <i class="fas fa-flag"></i> Kinyarwanda
                                                       </a>
                                                       <a href="?lang=sw${not empty param.error ? '&error='.concat(param.error) : ''}"
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

                                             <!-- Registration Form -->
                                             <form action="${pageContext.request.contextPath}/admin/auth/register"
                                                  method="post" class="needs-validation" novalidate>
                                                  <input type="hidden" name="lang"
                                                       value="${not empty param.lang ? param.lang : 'en'}">

                                                  <!-- Username -->
                                                  <div class="form-group mb-3">
                                                       <label for="username" class="form-label">
                                                            <i class="fas fa-user"></i>
                                                            <fmt:message key="admin.register.username.label" />
                                                       </label>
                                                       <input type="text" name="username" id="username"
                                                            class="form-control" required
                                                            placeholder="<fmt:message key='admin.register.username.placeholder' />">
                                                       <div class="invalid-feedback">
                                                            <fmt:message key="admin.register.username.required" />
                                                       </div>
                                                  </div>

                                                  <!-- Email -->
                                                  <div class="form-group mb-3">
                                                       <label for="email" class="form-label">
                                                            <i class="fas fa-envelope"></i>
                                                            <fmt:message key="admin.register.email.label" />
                                                       </label>
                                                       <input type="email" name="email" id="email" class="form-control"
                                                            required
                                                            placeholder="<fmt:message key='admin.register.email.placeholder' />">
                                                       <div class="invalid-feedback">
                                                            <fmt:message key="admin.register.email.required" />
                                                       </div>
                                                  </div>

                                                  <!-- Password -->
                                                  <div class="form-group mb-3">
                                                       <label for="password" class="form-label">
                                                            <i class="fas fa-lock"></i>
                                                            <fmt:message key="admin.register.password.label" />
                                                       </label>
                                                       <input type="password" name="password" id="password"
                                                            class="form-control" required
                                                            placeholder="<fmt:message key='admin.register.password.placeholder' />">
                                                       <div class="invalid-feedback">
                                                            <fmt:message key="admin.register.password.required" />
                                                       </div>
                                                  </div>

                                                  <!-- Confirm Password -->
                                                  <div class="form-group mb-3">
                                                       <label for="confirmPassword" class="form-label">
                                                            <i class="fas fa-lock"></i>
                                                            <fmt:message key="admin.register.confirmPassword.label" />
                                                       </label>
                                                       <input type="password" name="confirmPassword"
                                                            id="confirmPassword" class="form-control" required
                                                            placeholder="<fmt:message key='admin.register.confirmPassword.placeholder' />">
                                                       <div class="invalid-feedback">
                                                            <fmt:message
                                                                 key="admin.register.confirmPassword.required" />
                                                       </div>
                                                  </div>

                                                  <!-- Admin Code -->
                                                  <div class="form-group mb-3">
                                                       <label for="adminCode" class="form-label">
                                                            <i class="fas fa-key"></i>
                                                            <fmt:message key="admin.register.code.label" />
                                                       </label>
                                                       <input type="text" name="adminCode" id="adminCode"
                                                            class="form-control" required
                                                            placeholder="<fmt:message key='admin.register.code.placeholder' />">
                                                       <div class="invalid-feedback">
                                                            <fmt:message key="admin.register.code.required" />
                                                       </div>
                                                       <small class="form-text text-muted">
                                                            <i class="fas fa-info-circle"></i>
                                                            <fmt:message key="admin.register.code.hint" />
                                                       </small>
                                                  </div>

                                                  <!-- Submit Button -->
                                                  <div class="d-grid gap-2">
                                                       <button type="submit" class="btn btn-primary">
                                                            <i class="fas fa-user-plus"></i>
                                                            <fmt:message key="admin.register.submit" />
                                                       </button>
                                                  </div>
                                             </form>

                                             <!-- Login Link -->
                                             <div class="text-center mt-3">
                                                  <p>
                                                       <fmt:message key="admin.register.login.prompt" />
                                                       <a
                                                            href="${pageContext.request.contextPath}/admin/auth/login?lang=${not empty param.lang ? param.lang : 'en'}">
                                                            <fmt:message key="admin.register.login.link" />
                                                       </a>
                                                  </p>
                                             </div>
                                        </div>
                                   </div>
                              </div>
                         </div>
                    </div>

                    <%@ include file="/WEB-INF/includes/footer.jsp" %>