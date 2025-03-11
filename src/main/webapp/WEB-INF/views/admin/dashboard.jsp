<%@ page contentType="text/html;charset=UTF-8" language="java" %>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

               <fmt:setLocale value="${param.lang != null ? param.lang : 'en'}" />
               <fmt:setBundle basename="messages" />

               <!DOCTYPE html>
               <html lang="${param.lang != null ? param.lang : 'en'}">

               <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>
                         <fmt:message key="admin.dashboard.title" />
                    </title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                         rel="stylesheet">
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                         rel="stylesheet">
                    <style>
                         .stat-card {
                              transition: transform 0.2s;
                         }

                         .stat-card:hover {
                              transform: translateY(-5px);
                         }

                         .chart-container {
                              height: 300px;
                         }
                    </style>
               </head>

               <body class="bg-light">
                    <!-- Navigation -->
                    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                         <div class="container">
                              <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                                   <fmt:message key="admin.dashboard.title" />
                              </a>
                              <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                   data-bs-target="#navbarAdmin">
                                   <span class="navbar-toggler-icon"></span>
                              </button>
                              <div class="collapse navbar-collapse" id="navbarAdmin">
                                   <ul class="navbar-nav me-auto">
                                        <li class="nav-item">
                                             <a class="nav-link" href="${pageContext.request.contextPath}/admin/books">
                                                  <i class="fas fa-book"></i>
                                                  <fmt:message key="admin.nav.books" />
                                             </a>
                                        </li>
                                        <li class="nav-item">
                                             <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                                  <i class="fas fa-users"></i>
                                                  <fmt:message key="admin.nav.users" />
                                             </a>
                                        </li>
                                        <li class="nav-item">
                                             <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                                                  <i class="fas fa-shopping-cart"></i>
                                                  <fmt:message key="admin.nav.orders" />
                                             </a>
                                        </li>
                                   </ul>
                                   <div class="d-flex">
                                        <div class="dropdown me-3">
                                             <button class="btn btn-light dropdown-toggle" type="button"
                                                  id="languageDropdown" data-bs-toggle="dropdown">
                                                  <i class="fas fa-globe"></i>
                                                  <fmt:message key="language" />
                                             </button>
                                             <ul class="dropdown-menu">
                                                  <li><a class="dropdown-item" href="?lang=en">English</a></li>
                                                  <li><a class="dropdown-item" href="?lang=rw">Kinyarwanda</a></li>
                                                  <li><a class="dropdown-item" href="?lang=sw">Kiswahili</a></li>
                                             </ul>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/logout"
                                             class="btn btn-outline-light">
                                             <i class="fas fa-sign-out-alt"></i>
                                             <fmt:message key="logout" />
                                        </a>
                                   </div>
                              </div>
                         </div>
                    </nav>

                    <!-- Main Content -->
                    <div class="container my-4">
                         <!-- Messages -->
                         <c:if test="${not empty message}">
                              <div class="alert alert-success alert-dismissible fade show">
                                   <fmt:message key="${message}" />
                                   <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                              </div>
                         </c:if>
                         <c:if test="${not empty error}">
                              <div class="alert alert-danger alert-dismissible fade show">
                                   <fmt:message key="${error}" />
                                   <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                              </div>
                         </c:if>

                         <!-- Statistics Cards -->
                         <div class="row g-4 mb-4">
                              <div class="col-md-3">
                                   <div class="card stat-card bg-primary text-white h-100">
                                        <div class="card-body">
                                             <h5>
                                                  <fmt:message key="admin.stats.total.users" />
                                             </h5>
                                             <h2>${totalUsers}</h2>
                                        </div>
                                   </div>
                              </div>
                              <div class="col-md-3">
                                   <div class="card stat-card bg-success text-white h-100">
                                        <div class="card-body">
                                             <h5>
                                                  <fmt:message key="admin.stats.total.books" />
                                             </h5>
                                             <h2>${totalBooks}</h2>
                                        </div>
                                   </div>
                              </div>
                              <div class="col-md-3">
                                   <div class="card stat-card bg-info text-white h-100">
                                        <div class="card-body">
                                             <h5>
                                                  <fmt:message key="admin.stats.total.orders" />
                                             </h5>
                                             <h2>${totalOrders}</h2>
                                        </div>
                                   </div>
                              </div>
                              <div class="col-md-3">
                                   <div class="card stat-card bg-warning text-white h-100">
                                        <div class="card-body">
                                             <h5>
                                                  <fmt:message key="admin.stats.total.revenue" />
                                             </h5>
                                             <h2>$
                                                  <fmt:formatNumber value="${totalRevenue}" type="number"
                                                       pattern="#,##0.00" />
                                             </h2>
                                        </div>
                                   </div>
                              </div>
                         </div>

                         <!-- Recent Orders and Low Stock -->
                         <div class="row g-4">
                              <!-- Recent Orders -->
                              <div class="col-md-8">
                                   <div class="card h-100">
                                        <div class="card-header bg-white">
                                             <h5 class="card-title mb-0">
                                                  <i class="fas fa-clock"></i>
                                                  <fmt:message key="admin.recent.orders" />
                                             </h5>
                                        </div>
                                        <div class="card-body">
                                             <div class="table-responsive">
                                                  <table class="table table-hover">
                                                       <thead>
                                                            <tr>
                                                                 <th>
                                                                      <fmt:message key="order.id" />
                                                                 </th>
                                                                 <th>
                                                                      <fmt:message key="order.user" />
                                                                 </th>
                                                                 <th>
                                                                      <fmt:message key="order.total" />
                                                                 </th>
                                                                 <th>
                                                                      <fmt:message key="order.status" />
                                                                 </th>
                                                            </tr>
                                                       </thead>
                                                       <tbody>
                                                            <c:forEach items="${recentOrders}" var="order">
                                                                 <tr>
                                                                      <td>#${order.id}</td>
                                                                      <td>${order.username}</td>
                                                                      <td>$
                                                                           <fmt:formatNumber value="${order.total}"
                                                                                type="number" pattern="#,##0.00" />
                                                                      </td>
                                                                      <td>
                                                                           <span class="badge bg-${order.status == 'COMPLETED' ? 'success' : 
                                                    (order.status == 'PENDING' ? 'warning' : 'danger')}">
                                                                                ${order.status}
                                                                           </span>
                                                                      </td>
                                                                 </tr>
                                                            </c:forEach>
                                                       </tbody>
                                                  </table>
                                             </div>
                                        </div>
                                   </div>
                              </div>

                              <!-- Low Stock Alert -->
                              <div class="col-md-4">
                                   <div class="card h-100">
                                        <div class="card-header bg-white">
                                             <h5 class="card-title mb-0">
                                                  <i class="fas fa-exclamation-triangle text-warning"></i>
                                                  <fmt:message key="admin.low.stock" />
                                             </h5>
                                        </div>
                                        <div class="card-body">
                                             <div class="list-group">
                                                  <c:forEach items="${lowStockBooks}" var="book">
                                                       <a href="${pageContext.request.contextPath}/admin/books/edit?id=${book.id}"
                                                            class="list-group-item list-group-item-action">
                                                            <div class="d-flex w-100 justify-content-between">
                                                                 <h6 class="mb-1">${book.title}</h6>
                                                                 <small class="text-danger">${book.stock} left</small>
                                                            </div>
                                                            <small class="text-muted">ISBN: ${book.isbn}</small>
                                                       </a>
                                                  </c:forEach>
                                             </div>
                                        </div>
                                   </div>
                              </div>
                         </div>
                    </div>

                    <!-- Scripts -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
               </body>

               </html>