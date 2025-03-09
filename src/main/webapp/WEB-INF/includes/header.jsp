<%@ page contentType="text/html;charset=UTF-8" language="java" %>
     <%@ taglib prefix="c" uri="jakarta.tags.core" %>
          <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
               <!DOCTYPE html>
               <html lang="${param.lang != null ? param.lang : 'en'}">

               <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>${title} - Online BookStore</title>

                    <!-- Bootstrap CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                         rel="stylesheet">

                    <!-- Font Awesome -->
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                         rel="stylesheet">

                    <!-- Custom CSS -->
                    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet">

                    <!-- Bootstrap JavaScript and dependencies -->
                    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
                         defer></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" defer></script>
               </head>

               <body>
                    <!-- Navigation bar for authenticated users -->
                    <c:if test="${not empty sessionScope.user}">
                         <nav class="navbar navbar-expand-lg navbar-light">
                              <div class="container">
                                   <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
                                        <i class="fas fa-book"></i> BookStore
                                   </a>
                                   <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#navbarNav">
                                        <span class="navbar-toggler-icon"></span>
                                   </button>
                                   <div class="collapse navbar-collapse" id="navbarNav">
                                        <ul class="navbar-nav me-auto">
                                             <li class="nav-item">
                                                  <a class="nav-link"
                                                       href="${pageContext.request.contextPath}/books/browse">
                                                       <i class="fas fa-search"></i> Browse Books
                                                  </a>
                                             </li>
                                             <li class="nav-item">
                                                  <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                                       <i class="fas fa-shopping-cart"></i> Cart
                                                  </a>
                                             </li>
                                             <c:if test="${sessionScope.userRole == 'admin'}">
                                                  <li class="nav-item">
                                                       <a class="nav-link"
                                                            href="${pageContext.request.contextPath}/admin/dashboard">
                                                            <i class="fas fa-cog"></i> Admin Panel
                                                       </a>
                                                  </li>
                                             </c:if>
                                        </ul>
                                        <ul class="navbar-nav">
                                             <li class="nav-item">
                                                  <a class="nav-link" href="${pageContext.request.contextPath}/profile">
                                                       <i class="fas fa-user"></i> ${sessionScope.username}
                                                  </a>
                                             </li>
                                             <li class="nav-item">
                                                  <a class="nav-link"
                                                       href="${pageContext.request.contextPath}/auth/logout">
                                                       <i class="fas fa-sign-out-alt"></i> Logout
                                                  </a>
                                             </li>
                                        </ul>
                                   </div>
                              </div>
                         </nav>
                    </c:if>

                    <main class="container mt-4">