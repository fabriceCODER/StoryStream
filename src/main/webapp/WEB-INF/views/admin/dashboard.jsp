<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
     <%@ taglib prefix="c" uri="jakarta.tags.core" %>
          <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

               <fmt:setLocale value="${not empty param.lang ? param.lang : 'en'}" />
               <fmt:setBundle basename="messages" />

               <!DOCTYPE html>
               <html lang="${not empty param.lang ? param.lang : 'en'}">

               <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Admin Dashboard - BookStore</title>

                    <!-- Bootstrap CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                         rel="stylesheet">
                    <!-- FontAwesome -->
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                         rel="stylesheet">
                    <!-- Custom CSS -->
                    <style>
                         .sidebar {
                              min-height: 100vh;
                              box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
                         }

                         .sidebar .nav-link {
                              color: #333;
                         }

                         .sidebar .nav-link.active {
                              color: #007bff;
                         }

                         .stat-card {
                              transition: transform 0.3s;
                         }

                         .stat-card:hover {
                              transform: translateY(-5px);
                         }
                    </style>
               </head>

               <body>
                    <!-- Top Navbar -->
                    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                         <div class="container-fluid">
                              <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                                   <i class="fas fa-book-reader"></i> BookStore Admin
                              </a>
                              <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                   data-bs-target="#navbarNav">
                                   <span class="navbar-toggler-icon"></span>
                              </button>
                              <div class="collapse navbar-collapse" id="navbarNav">
                                   <ul class="navbar-nav ms-auto">
                                        <li class="nav-item dropdown">
                                             <a class="nav-link dropdown-toggle" href="#" id="languageDropdown"
                                                  role="button" data-bs-toggle="dropdown">
                                                  <i class="fas fa-globe"></i> Language
                                             </a>
                                             <ul class="dropdown-menu dropdown-menu-end">
                                                  <li><a class="dropdown-item" href="?lang=en">English</a></li>
                                                  <li><a class="dropdown-item" href="?lang=rw">Kinyarwanda</a></li>
                                                  <li><a class="dropdown-item" href="?lang=sw">Kiswahili</a></li>
                                             </ul>
                                        </li>
                                        <li class="nav-item">
                                             <a class="nav-link"
                                                  href="${pageContext.request.contextPath}/admin/profile">
                                                  <i class="fas fa-user"></i> ${sessionScope.username}
                                             </a>
                                        </li>
                                        <li class="nav-item">
                                             <a class="nav-link text-danger"
                                                  href="${pageContext.request.contextPath}/auth/logout">
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
                              <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
                                   <div class="position-sticky pt-3">
                                        <ul class="nav flex-column">
                                             <li class="nav-item">
                                                  <a class="nav-link active"
                                                       href="${pageContext.request.contextPath}/admin/dashboard">
                                                       <i class="fas fa-tachometer-alt"></i> Dashboard
                                                  </a>
                                             </li>
                                             <li class="nav-item">
                                                  <a class="nav-link"
                                                       href="${pageContext.request.contextPath}/admin/operations/books">
                                                       <i class="fas fa-book"></i> Manage Books
                                                  </a>
                                             </li>
                                             <li class="nav-item">
                                                  <a class="nav-link"
                                                       href="${pageContext.request.contextPath}/admin/operations/orders">
                                                       <i class="fas fa-shopping-cart"></i> Manage Orders
                                                  </a>
                                             </li>
                                             <li class="nav-item">
                                                  <a class="nav-link"
                                                       href="${pageContext.request.contextPath}/admin/operations/users">
                                                       <i class="fas fa-users"></i> Manage Users
                                                  </a>
                                             </li>
                                             <li class="nav-item">
                                                  <a class="nav-link"
                                                       href="${pageContext.request.contextPath}/admin/operations/categories">
                                                       <i class="fas fa-tags"></i> Manage Categories
                                                  </a>
                                             </li>
                                             <li class="nav-item">
                                                  <a class="nav-link"
                                                       href="${pageContext.request.contextPath}/admin/operations/reports">
                                                       <i class="fas fa-chart-bar"></i> Reports
                                                  </a>
                                             </li>
                                        </ul>
                                   </div>
                              </nav>

                              <!-- Main Content -->
                              <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                                   <div
                                        class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                                        <h1><i class="fas fa-tachometer-alt"></i> Dashboard</h1>
                                   </div>

                                   <!-- Statistics Cards -->
                                   <div class="row g-4 mb-4">
                                        <div class="col-md-3">
                                             <div class="card bg-primary text-white stat-card">
                                                  <div class="card-body">
                                                       <h5 class="card-title"><i class="fas fa-book"></i> Total Books
                                                       </h5>
                                                       <h2 class="card-text">${totalBooks}</h2>
                                                  </div>
                                             </div>
                                        </div>
                                        <div class="col-md-3">
                                             <div class="card bg-success text-white stat-card">
                                                  <div class="card-body">
                                                       <h5 class="card-title"><i class="fas fa-shopping-cart"></i> Total
                                                            Orders</h5>
                                                       <h2 class="card-text">${totalOrders}</h2>
                                                  </div>
                                             </div>
                                        </div>
                                        <div class="col-md-3">
                                             <div class="card bg-info text-white stat-card">
                                                  <div class="card-body">
                                                       <h5 class="card-title"><i class="fas fa-users"></i> Total Users
                                                       </h5>
                                                       <h2 class="card-text">${totalUsers}</h2>
                                                  </div>
                                             </div>
                                        </div>
                                        <div class="col-md-3">
                                             <div class="card bg-warning text-white stat-card">
                                                  <div class="card-body">
                                                       <h5 class="card-title"><i class="fas fa-dollar-sign"></i> Total
                                                            Revenue</h5>
                                                       <h2 class="card-text">$${totalRevenue}</h2>
                                                  </div>
                                             </div>
                                        </div>
                                   </div>

                                   <!-- Quick Actions -->
                                   <div class="row mb-4">
                                        <div class="col-12">
                                             <div class="card">
                                                  <div class="card-header">
                                                       <h5><i class="fas fa-bolt"></i> Quick Actions</h5>
                                                  </div>
                                                  <div class="card-body">
                                                       <div class="row g-3">
                                                            <div class="col-md-3">
                                                                 <a href="${pageContext.request.contextPath}/admin/operations/books/add"
                                                                      class="btn btn-primary w-100">
                                                                      <i class="fas fa-plus"></i> Add New Book
                                                                 </a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                 <a href="${pageContext.request.contextPath}/admin/operations/categories/add"
                                                                      class="btn btn-success w-100">
                                                                      <i class="fas fa-folder-plus"></i> Add Category
                                                                 </a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                 <a href="${pageContext.request.contextPath}/admin/operations/orders/pending"
                                                                      class="btn btn-warning w-100">
                                                                      <i class="fas fa-clock"></i> View Pending Orders
                                                                 </a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                 <a href="${pageContext.request.contextPath}/admin/operations/reports/generate"
                                                                      class="btn btn-info w-100">
                                                                      <i class="fas fa-file-export"></i> Generate Report
                                                                 </a>
                                                            </div>
                                                       </div>
                                                  </div>
                                             </div>
                                        </div>
                                   </div>

                                   <!-- Recent Orders Table -->
                                   <div class="card mb-4">
                                        <div class="card-header">
                                             <h5><i class="fas fa-clock"></i> Recent Orders</h5>
                                        </div>
                                        <div class="card-body">
                                             <div class="table-responsive">
                                                  <table class="table table-striped table-hover">
                                                       <thead>
                                                            <tr>
                                                                 <th>Order ID</th>
                                                                 <th>Customer</th>
                                                                 <th>Date</th>
                                                                 <th>Amount</th>
                                                                 <th>Status</th>
                                                                 <th>Actions</th>
                                                            </tr>
                                                       </thead>
                                                       <tbody>
                                                            <c:forEach items="${recentOrders}" var="order">
                                                                 <tr>
                                                                      <td>#${order.id}</td>
                                                                      <td>${order.customerName}</td>
                                                                      <td>${order.orderDate}</td>
                                                                      <td>$${order.totalAmount}</td>
                                                                      <td>
                                                                           <span class="badge bg-${order.status == 'PENDING' ? 'warning' : 
                                                    order.status == 'COMPLETED' ? 'success' : 
                                                    order.status == 'CANCELLED' ? 'danger' : 'primary'}">
                                                                                ${order.status}
                                                                           </span>
                                                                      </td>
                                                                      <td>
                                                                           <a href="${pageContext.request.contextPath}/admin/operations/orders/view?id=${order.id}"
                                                                                class="btn btn-sm btn-info">
                                                                                <i class="fas fa-eye"></i>
                                                                           </a>
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

                    <!-- Bootstrap Bundle with Popper -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
               </body>

               </html>