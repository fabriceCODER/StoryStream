<%@ page contentType="text/html;charset=UTF-8" language="java" %>
     <%@ taglib prefix="c" uri="jakarta.tags.core" %>
          <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
               <!DOCTYPE html>
               <html lang="en">

               <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>User Profile - BookStore</title>
                    <!-- Bootstrap CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                         rel="stylesheet">
                    <!-- Font Awesome -->
                    <link rel="stylesheet"
                         href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                    <style>
                         .profile-card {
                              border-radius: 15px;
                              box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                         }

                         .profile-header {
                              background: linear-gradient(135deg, #6B73FF 0%, #000DFF 100%);
                              color: white;
                              border-radius: 15px 15px 0 0;
                              padding: 2rem;
                         }

                         .profile-avatar {
                              width: 120px;
                              height: 120px;
                              border-radius: 60px;
                              border: 4px solid white;
                              background-color: #e9ecef;
                              display: flex;
                              align-items: center;
                              justify-content: center;
                              margin: 0 auto 1rem;
                         }

                         .profile-avatar i {
                              font-size: 3rem;
                              color: #6c757d;
                         }

                         .profile-info {
                              padding: 2rem;
                         }

                         .info-item {
                              padding: 1rem;
                              border-bottom: 1px solid #e9ecef;
                         }

                         .info-item:last-child {
                              border-bottom: none;
                         }

                         .action-buttons .btn {
                              margin: 0.5rem;
                              padding: 0.5rem 1.5rem;
                         }
                    </style>
               </head>

               <body class="bg-light">
                    <div class="container py-5">
                         <c:if test="${not empty user}">
                              <div class="row justify-content-center">
                                   <div class="col-md-8">
                                        <div class="card profile-card">
                                             <!-- Profile Header -->
                                             <div class="profile-header text-center">
                                                  <div class="profile-avatar">
                                                       <i class="fas fa-user"></i>
                                                  </div>
                                                  <h2 class="mb-0">${user.username}</h2>
                                                  <p class="text-light mb-0">
                                                       <span class="badge bg-light text-primary">${user.role}</span>
                                                  </p>
                                             </div>

                                             <!-- Profile Information -->
                                             <div class="profile-info">
                                                  <div class="info-item">
                                                       <h5 class="text-muted mb-1">
                                                            <i class="fas fa-user me-2"></i>Username
                                                       </h5>
                                                       <p class="h6 mb-0">${user.username}</p>
                                                  </div>
                                                  <div class="info-item">
                                                       <h5 class="text-muted mb-1">
                                                            <i class="fas fa-shield-alt me-2"></i>Role
                                                       </h5>
                                                       <p class="h6 mb-0">${user.role}</p>
                                                  </div>
                                                  <div class="info-item">
                                                       <h5 class="text-muted mb-1">
                                                            <i class="fas fa-envelope me-2"></i>Email
                                                       </h5>
                                                       <p class="h6 mb-0">${user.email}</p>
                                                  </div>

                                                  <!-- Action Buttons -->
                                                  <div class="text-center action-buttons mt-4">
                                                       <a href="${pageContext.request.contextPath}/dashboard"
                                                            class="btn btn-primary">
                                                            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                                                       </a>
                                                       <a href="${pageContext.request.contextPath}/books"
                                                            class="btn btn-info text-white">
                                                            <i class="fas fa-book me-2"></i>Browse Books
                                                       </a>
                                                       <a href="${pageContext.request.contextPath}/cart"
                                                            class="btn btn-success">
                                                            <i class="fas fa-shopping-cart me-2"></i>My Cart
                                                       </a>
                                                       <a href="${pageContext.request.contextPath}/auth/logout"
                                                            class="btn btn-danger">
                                                            <i class="fas fa-sign-out-alt me-2"></i>Logout
                                                       </a>
                                                  </div>
                                             </div>
                                        </div>
                                   </div>
                              </div>
                         </c:if>

                         <c:if test="${empty user}">
                              <div class="row justify-content-center">
                                   <div class="col-md-6">
                                        <div class="card text-center">
                                             <div class="card-body p-5">
                                                  <i class="fas fa-exclamation-circle text-warning display-1 mb-4"></i>
                                                  <h3>Authentication Required</h3>
                                                  <p class="lead">Please log in to view your profile.</p>
                                                  <a href="${pageContext.request.contextPath}/auth/login"
                                                       class="btn btn-primary btn-lg">
                                                       <i class="fas fa-sign-in-alt me-2"></i>Login
                                                  </a>
                                             </div>
                                        </div>
                                   </div>
                              </div>
                         </c:if>
                    </div>

                    <!-- Bootstrap JS -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
               </body>

               </html>