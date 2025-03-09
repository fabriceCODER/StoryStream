<%@ page contentType="text/html;charset=UTF-8" language="java" %>
     <%@ taglib prefix="c" uri="jakarta.tags.core" %>
          <!DOCTYPE html>
          <html>

          <head>
               <title>User Profile</title>
               <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
          </head>

          <body>
               <div class="container">
                    <h1>User Profile</h1>

                    <c:if test="${not empty user}">
                         <div class="profile-info">
                              <p><strong>Username:</strong> ${user.username}</p>
                              <p><strong>Role:</strong> ${user.role}</p>
                         </div>

                         <div class="profile-actions">
                              <a href="${pageContext.request.contextPath}/views/users/dashboard.jsp"
                                   class="btn">Dashboard</a>
                              <a href="${pageContext.request.contextPath}/views/users/browse_books.jsp"
                                   class="btn">Browse Books</a>
                              <a href="${pageContext.request.contextPath}/views/users/cart.jsp" class="btn">My Cart</a>
                              <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-danger">Logout</a>
                         </div>
                    </c:if>

                    <c:if test="${empty user}">
                         <p>Please <a href="${pageContext.request.contextPath}/auth/login.jsp">login</a> to view your
                              profile.</p>
                    </c:if>
               </div>
          </body>

          </html>