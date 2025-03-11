<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
     <%@ taglib uri="jakarta.tags.core" prefix="c" %>
          <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

               <!DOCTYPE html>
               <html lang="${param.lang != null ? param.lang : 'en'}">

               <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>
                         <fmt:message key="admin.dashboard.title" /> - BookStore
                    </title>

                    <!-- Bootstrap CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                         rel="stylesheet">
                    <!-- FontAwesome -->
                    <link rel="stylesheet"
                         href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

                    <style>
                         .sidebar {
                              min-height: calc(100vh - 56px);
                         }

                         .stat-card {
                              transition: transform 0.3s;
                         }

                         .stat-card:hover {
                              transform: translateY(-5px);
                         }
                    </style>
               </head>

               <body class="bg-light">
                    <!-- Navbar -->
                    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                         <div class="container-fluid">
                              <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                                   <i class="fas fa-book-reader"></i> BookStore Admin
                              </a>
                              <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                   data-bs-target="#navbarAdmin">
                                   <span class="navbar-toggler-icon"></span>
                              </button>
                              <div class="collapse navbar-collapse" id="navbarAdmin">
                                   <ul class="navbar-nav ms-auto">
                                        <li class="nav-item">
                                             <span class="nav-link">
                                                  <i class="fas fa-user"></i> ${sessionScope.username}
                                             </span>
                                        </li>
                                        <li class="nav-item">
                                             <a class="nav-link"
                                                  href="${pageContext.request.contextPath}/admin/auth/logout">
                                                  <i class="fas fa-sign-out-alt"></i> Logout
                                             </a>
                                        </li>
                                   </ul>
                              </div>
                         </div>
                    </nav>

                    <div class="container-fluid">
                         <div class="row">
                              <!-- Sidebar -->
                              <nav class="col-md-3 col-lg-2 d-md-block bg-dark sidebar">
                                   <div class="position-sticky pt-3">
                                        <ul class="nav flex-column">
                                             <li class="nav-item">
                                                  <a class="nav-link active text-white"
                                                       href="${pageContext.request.contextPath}/admin/dashboard">
                                                       <i class="fas fa-tachometer-alt"></i> Dashboard
                                                  </a>
                                             </li>
                                             <li class="nav-item">
                                                  <a class="nav-link text-white"
                                                       href="${pageContext.request.contextPath}/admin/books">
                                                       <i class="fas fa-book"></i> Books
                                                  </a>
                                             </li>
                                             <li class="nav-item">
                                                  <a class="nav-link text-white"
                                                       href="${pageContext.request.contextPath}/admin/orders">
                                                       <i class="fas fa-shopping-cart"></i> Orders
                                                  </a>
                                             </li>
                                             <li class="nav-item">
                                                  <a class="nav-link text-white"
                                                       href="${pageContext.request.contextPath}/admin/users">
                                                       <i class="fas fa-users"></i> Users
                                                  </a>
                                             </li>
                                        </ul>
                                   </div>
                              </nav>

                              <!-- Main content -->
                              <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                                   <div
                                        class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                                        <h1>
                                             <fmt:message key="admin.dashboard.welcome" />
                                        </h1>
                                   </div>

                                   <!-- Stats Cards -->
                                   <div class="row g-4 mb-4">
                                        <div class="col-md-3">
                                             <div class="card bg-primary text-white stat-card">
                                                  <div class="card-body">
                                                       <h5 class="card-title">
                                                            <i class="fas fa-book"></i>
                                                            <fmt:message key="admin.dashboard.total.books" />
                                                       </h5>
                                                       <h2 class="card-text">${totalBooks}</h2>
                                                  </div>
                                             </div>
                                        </div>
                                        <div class="col-md-3">
                                             <div class="card bg-success text-white stat-card">
                                                  <div class="card-body">
                                                       <h5 class="card-title">
                                                            <i class="fas fa-shopping-cart"></i>
                                                            <fmt:message key="admin.dashboard.total.orders" />
                                                       </h5>
                                                       <h2 class="card-text">${totalOrders}</h2>
                                                  </div>
                                             </div>
                                        </div>
                                        <div class="col-md-3">
                                             <div class="card bg-info text-white stat-card">
                                                  <div class="card-body">
                                                       <h5 class="card-title">
                                                            <i class="fas fa-users"></i>
                                                            <fmt:message key="admin.dashboard.total.users" />
                                                       </h5>
                                                       <h2 class="card-text">${totalUsers}</h2>
                                                  </div>
                                             </div>
                                        </div>
                                        <div class="col-md-3">
                                             <div class="card bg-warning text-white stat-card">
                                                  <div class="card-body">
                                                       <h5 class="card-title">
                                                            <i class="fas fa-dollar-sign"></i>
                                                            <fmt:message key="admin.dashboard.total.revenue" />
                                                       </h5>
                                                       <h2 class="card-text">$${totalRevenue}</h2>
                                                  </div>
                                             </div>
                                        </div>
                                   </div>

                                   <!-- Recent Orders -->
                                   <div class="card mb-4">
                                        <div class="card-header">
                                             <h5><i class="fas fa-clock"></i>
                                                  <fmt:message key="admin.dashboard.recent.orders" />
                                             </h5>
                                        </div>
                                        <div class="card-body">
                                             <div class="table-responsive">
                                                  <table class="table table-striped">
                                                       <thead>
                                                            <tr>
                                                                 <th>
                                                                      <fmt:message key="admin.orders.id" />
                                                                 </th>
                                                                 <th>
                                                                      <fmt:message key="admin.orders.user" />
                                                                 </th>
                                                                 <th>
                                                                      <fmt:message key="admin.orders.date" />
                                                                 </th>
                                                                 <th>
                                                                      <fmt:message key="admin.orders.total" />
                                                                 </th>
                                                                 <th>
                                                                      <fmt:message key="admin.orders.status" />
                                                                 </th>
                                                            </tr>
                                                       </thead>
                                                       <tbody>
                                                            <c:forEach items="${recentOrders}" var="order">
                                                                 <tr>
                                                                      <td>${order.id}</td>
                                                                      <td>${order.username}</td>
                                                                      <td>${order.orderDate}</td>
                                                                      <td>$${order.total}</td>
                                                                      <td>
                                                                           <span
                                                                                class="badge bg-${order.status == 'COMPLETED' ? 'success' : 'warning'}">
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
                              </main>
                         </div>
                    </div>

                    <!-- Bootstrap JS -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
               </body>

               </html>