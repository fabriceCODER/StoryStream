<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
     <%@ taglib prefix="c" uri="jakarta.tags.core" %>
          <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

               <fmt:setLocale value="${not empty param.lang ? param.lang : 'en'}" />
               <fmt:setBundle basename="messages" />

               <c:set var="title" value="Register" scope="request" />

               <div class="row justify-content-center">
                    <div class="col-md-6">
                         <div class="card shadow">
                              <div class="card-body">
                                   <h2 class="text-center mb-4">
                                        <i class="fas fa-user-plus"></i>
                                        <fmt:message key="register.title" />
                                   </h2>

                                   <!-- Language Selection -->
                                   <form method="get" action="${pageContext.request.contextPath}/register" class="mb-4">
                                        <div class="form-group">
                                             <label for="lang" class="form-label">
                                                  <i class="fas fa-globe"></i>
                                                  <fmt:message key="register.language" />
                                             </label>
                                             <select name="lang" id="lang" class="form-select"
                                                  onchange="this.form.submit()">
                                                  <option value="en" ${param.lang=='en' ? 'selected' : '' }>English
                                                  </option>
                                                  <option value="es" ${param.lang=='es' ? 'selected' : '' }>Español
                                                  </option>
                                                  <option value="fr" ${param.lang=='fr' ? 'selected' : '' }>
                                                       Français</option>
                                                  <option value="rw" ${param.lang=='rw' ? 'selected' : '' }>
                                                       Kinyarwanda</option>
                                                  <option value="sw" ${param.lang=='sw' ? 'selected' : '' }>
                                                       Kiswahili</option>
                                             </select>
                                        </div>
                                   </form>

                                   <!-- Registration Form -->
                                   <form action="${pageContext.request.contextPath}/auth/register" method="post"
                                        class="needs-validation" novalidate>
                                        <input type="hidden" name="lang"
                                             value="${not empty param.lang ? param.lang : 'en'}">
                                        <div class="form-group mb-3">
                                             <label for="username" class="form-label">
                                                  <i class="fas fa-user"></i>
                                                  <fmt:message key="register.username" />
                                             </label>
                                             <input type="text" name="username" id="username" class="form-control"
                                                  required>
                                             <div class="invalid-feedback">
                                                  <fmt:message key="register.username.required" />
                                             </div>
                                        </div>

                                        <div class="form-group mb-3">
                                             <label for="password" class="form-label">
                                                  <i class="fas fa-lock"></i>
                                                  <fmt:message key="register.password" />
                                             </label>
                                             <input type="password" name="password" id="password" class="form-control"
                                                  required minlength="6"
                                                  pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$">
                                             <div class="invalid-feedback">
                                                  <fmt:message key="register.password.requirements" />
                                             </div>
                                             <small class="form-text text-muted">
                                                  <i class="fas fa-info-circle"></i>
                                                  <fmt:message key="register.password.requirements" />
                                             </small>
                                        </div>

                                        <div class="form-group mb-3">
                                             <label for="confirmPassword" class="form-label">
                                                  <i class="fas fa-lock"></i>
                                                  <fmt:message key="register.confirmPassword" />
                                             </label>
                                             <input type="password" name="confirmPassword" id="confirmPassword"
                                                  class="form-control" required>
                                             <div class="invalid-feedback">
                                                  <fmt:message key="register.confirmPassword.required" />
                                             </div>
                                        </div>

                                        <div class="d-flex justify-content-between align-items-center">
                                             <button type="submit" class="btn btn-primary">
                                                  <i class="fas fa-user-plus"></i>
                                                  <fmt:message key="register.submit" />
                                             </button>
                                             <a href="${pageContext.request.contextPath}/login${not empty param.lang ? '?lang='.concat(param.lang) : ''}"
                                                  class="btn btn-link">
                                                  <i class="fas fa-sign-in-alt"></i>
                                                  <fmt:message key="register.login" />
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

                                   // Check if passwords match
                                   var password = form.querySelector('#password')
                                   var confirmPassword = form.querySelector('#confirmPassword')
                                   if (password.value !== confirmPassword.value) {
                                        confirmPassword.setCustomValidity('Passwords do not match')
                                        event.preventDefault()
                                        event.stopPropagation()
                                   } else {
                                        confirmPassword.setCustomValidity('')
                                   }

                                   form.classList.add('was-validated')
                              }, false)
                         })
                    })()
               </script>