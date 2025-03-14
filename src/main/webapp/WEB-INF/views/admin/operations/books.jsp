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
                    <title>Manage Books - Admin Dashboard</title>

                    <!-- Bootstrap CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                         rel="stylesheet">
                    <!-- FontAwesome -->
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                         rel="stylesheet">
                    <!-- DataTables CSS -->
                    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
               </head>

               <body class="bg-light">
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
                                                  <a class="nav-link"
                                                       href="${pageContext.request.contextPath}/admin/dashboard">
                                                       <i class="fas fa-tachometer-alt"></i> Dashboard
                                                  </a>
                                             </li>
                                             <li class="nav-item">
                                                  <a class="nav-link active"
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
                                        </ul>
                                   </div>
                              </nav>

                              <!-- Main Content -->
                              <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                                   <div
                                        class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                                        <h1><i class="fas fa-book"></i> Manage Books</h1>
                                        <div class="btn-toolbar mb-2 mb-md-0">
                                             <a href="${pageContext.request.contextPath}/admin/operations/books/add"
                                                  class="btn btn-primary">
                                                  <i class="fas fa-plus"></i> Add New Book
                                             </a>
                                        </div>
                                   </div>

                                   <!-- Books Table -->
                                   <div class="card">
                                        <div class="card-body">
                                             <div class="table-responsive">
                                                  <table id="booksTable" class="table table-striped table-hover">
                                                       <thead>
                                                            <tr>
                                                                 <th>ID</th>
                                                                 <th>Image</th>
                                                                 <th>Title</th>
                                                                 <th>Author</th>
                                                                 <th>Price</th>
                                                                 <th>Stock</th>
                                                                 <th>Actions</th>
                                                            </tr>
                                                       </thead>
                                                       <tbody>
                                                            <c:forEach items="${books}" var="book">
                                                                 <tr>
                                                                      <td>${book.id}</td>
                                                                      <td>
                                                                           <c:if test="${not empty book.imageUrl}">
                                                                                <img src="${book.imageUrl}"
                                                                                     alt="${book.title}"
                                                                                     class="img-thumbnail"
                                                                                     style="max-height: 50px;">
                                                                           </c:if>
                                                                      </td>
                                                                      <td>${book.title}</td>
                                                                      <td>${book.author}</td>
                                                                      <td>$${book.price}</td>
                                                                      <td>${book.quantity}</td>
                                                                      <td>
                                                                           <div class="btn-group" role="group">
                                                                                <a href="${pageContext.request.contextPath}/admin/operations/books/edit?id=${book.id}"
                                                                                     class="btn btn-sm btn-primary">
                                                                                     <i class="fas fa-edit"></i>
                                                                                </a>
                                                                                <button type="button"
                                                                                     class="btn btn-sm btn-danger"
                                                                                     onclick="confirmDelete(${book.id})">
                                                                                     <i class="fas fa-trash"></i>
                                                                                </button>
                                                                           </div>
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

                    <!-- Delete Confirmation Modal -->
                    <div class="modal fade" id="deleteModal" tabindex="-1">
                         <div class="modal-dialog">
                              <div class="modal-content">
                                   <div class="modal-header">
                                        <h5 class="modal-title">Confirm Delete</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                   </div>
                                   <div class="modal-body">
                                        Are you sure you want to delete this book?
                                   </div>
                                   <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                             data-bs-dismiss="modal">Cancel</button>
                                        <button type="button" class="btn btn-danger"
                                             onclick="deleteBook()">Delete</button>
                                   </div>
                              </div>
                         </div>
                    </div>

                    <!-- Scripts -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
                    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>

                    <script>
                         let bookIdToDelete = null;
                         const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));

                         function confirmDelete(id) {
                              bookIdToDelete = id;
                              deleteModal.show();
                         }

                         function deleteBook() {
                              if (bookIdToDelete) {
                                   window.location.href = '${pageContext.request.contextPath}/admin/operations/books/delete?id=' + bookIdToDelete;
                              }
                         }

                         $(document).ready(function () {
                              $('#booksTable').DataTable({
                                   order: [[0, 'desc']], // Sort by ID in descending order
                                   pageLength: 10,
                                   language: {
                                        search: "Search books:",
                                        lengthMenu: "Show _MENU_ books per page",
                                        info: "Showing _START_ to _END_ of _TOTAL_ books",
                                        paginate: {
                                             first: "First",
                                             last: "Last",
                                             next: "Next",
                                             previous: "Previous"
                                        }
                                   }
                              });
                         });
                    </script>
               </body>

               </html>