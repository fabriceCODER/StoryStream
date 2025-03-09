<%@ page contentType="text/html;charset=UTF-8" language="java" %>
     <%@ taglib prefix="c" uri="jakarta.tags.core" %>
          <!DOCTYPE html>
          <html lang="en">

          <head>
               <meta charset="UTF-8">
               <meta name="viewport" content="width=device-width, initial-scale=1.0">
               <title>${param.title} - Online Bookstore</title>
               <!-- Bootstrap CSS -->
               <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
               <!-- Custom CSS -->
               <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
               <!-- Font Awesome -->
               <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
          </head>

          <body>
               <!-- Navigation -->
               <nav class="navbar navbar-expand-lg">
                    <div class="container">
                         <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                              <i class="fas fa-book"></i> Online Bookstore
                         </a>

                         <c:if test="${not empty sessionScope.user}">
                              <div class="navbar-nav ms-auto">
                                   <span class="nav-item nav-link">
                                        Welcome, ${sessionScope.username}!
                                   </span>
                                   <a class="nav-link" href="${pageContext.request.contextPath}/auth/logout">
                                        <i class="fas fa-sign-out-alt"></i> Logout
                                   </a>
                              </div>
                         </c:if>
                    </div>
               </nav>

               <!-- Main Content Container -->
               <div class="container mt-4">