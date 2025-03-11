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
                    <title>${empty book ? 'Add New' : 'Edit'} Book - Admin Dashboard</title>

                    <!-- Bootstrap CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                         rel="stylesheet">
                    <!-- FontAwesome -->
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                         rel="stylesheet">
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
                                        <h1>
                                             <i class="fas fa-${empty book ? 'plus' : 'edit'}"></i>
                                             ${empty book ? 'Add New' : 'Edit'} Book
                                        </h1>
                                   </div>

                                   <!-- Book Form -->
                                   <div class="card">
                                        <div class="card-body">
                                             <form action="${pageContext.request.contextPath}/admin/operations/books/${empty book ? 'add' : 'edit'}"
                                                  method="POST" enctype="multipart/form-data" class="needs-validation"
                                                  novalidate>

                                                  <c:if test="${not empty book}">
                                                       <input type="hidden" name="id" value="${book.id}">
                                                  </c:if>

                                                  <!-- Title -->
                                                  <div class="mb-3">
                                                       <label for="title" class="form-label">Title</label>
                                                       <input type="text" class="form-control" id="title" name="title"
                                                            value="${book.title}" required>
                                                       <div class="invalid-feedback">
                                                            Please enter a title.
                                                       </div>
                                                  </div>

                                                  <!-- Author -->
                                                  <div class="mb-3">
                                                       <label for="author" class="form-label">Author</label>
                                                       <input type="text" class="form-control" id="author" name="author"
                                                            value="${book.author}" required>
                                                       <div class="invalid-feedback">
                                                            Please enter an author.
                                                       </div>
                                                  </div>

                                                  <!-- Price -->
                                                  <div class="mb-3">
                                                       <label for="price" class="form-label">Price ($)</label>
                                                       <input type="number" class="form-control" id="price" name="price"
                                                            value="${book.price}" step="0.01" min="0" required>
                                                       <div class="invalid-feedback">
                                                            Please enter a valid price.
                                                       </div>
                                                  </div>

                                                  <!-- Stock/Quantity -->
                                                  <div class="mb-3">
                                                       <label for="quantity" class="form-label">Stock</label>
                                                       <input type="number" class="form-control" id="quantity"
                                                            name="quantity" value="${book.quantity}" min="0" required>
                                                       <div class="invalid-feedback">
                                                            Please enter a valid stock amount.
                                                       </div>
                                                  </div>

                                                  <!-- Description -->
                                                  <div class="mb-3">
                                                       <label for="description" class="form-label">Description</label>
                                                       <textarea class="form-control" id="description"
                                                            name="description" rows="3"
                                                            required>${book.description}</textarea>
                                                       <div class="invalid-feedback">
                                                            Please enter a description.
                                                       </div>
                                                  </div>

                                                  <!-- Image -->
                                                  <div class="mb-3">
                                                       <label for="image" class="form-label">Book Cover Image</label>
                                                       <input type="file" class="form-control" id="image" name="image"
                                                            accept="image/*" ${empty book ? 'required' : '' }>
                                                       <div class="invalid-feedback">
                                                            Please select an image file.
                                                       </div>
                                                       <c:if test="${not empty book.imageUrl}">
                                                            <div class="mt-2">
                                                                 <img src="${book.imageUrl}" alt="${book.title}"
                                                                      class="img-thumbnail" style="max-height: 100px;">
                                                            </div>
                                                       </c:if>
                                                  </div>

                                                  <!-- Submit Buttons -->
                                                  <div class="d-flex justify-content-between">
                                                       <a href="${pageContext.request.contextPath}/admin/operations/books"
                                                            class="btn btn-secondary">
                                                            <i class="fas fa-arrow-left"></i> Back to Books
                                                       </a>
                                                       <button type="submit" class="btn btn-primary">
                                                            <i class="fas fa-save"></i> ${empty book ? 'Add' : 'Update'}
                                                            Book
                                                       </button>
                                                  </div>
                                             </form>
                                        </div>
                                   </div>
                              </main>
                         </div>
                    </div>

                    <!-- Bootstrap Bundle with Popper -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                    <!-- Form Validation Script -->
                    <script>
                         (function () {
                              'use strict'
                              var forms = document.querySelectorAll('.needs-validation')
                              Array.prototype.slice.call(forms).forEach(function (form) {
                                   form.addEventListener('submit', function (event) {
                                        if (!form.checkValidity()) {
                                             event.preventDefault()
                                             event.stopPropagation()
                                        }
                                        form.classList.add('was-validated')
                                   }, false)
                              })
                         })()
                    </script>
               </body>

               </html>