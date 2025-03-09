</main>

<footer class="footer mt-5 py-3 bg-light">
     <div class="container">
          <div class="row">
               <div class="col-md-6">
                    <h5><i class="fas fa-book"></i> Online BookStore</h5>
                    <p class="text-muted">Your one-stop shop for all your reading needs.</p>
               </div>
               <div class="col-md-3">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                         <li><a href="${pageContext.request.contextPath}/books/browse">Browse Books</a></li>
                         <li><a href="${pageContext.request.contextPath}/cart">Shopping Cart</a></li>
                         <li><a href="${pageContext.request.contextPath}/profile">My Account</a></li>
                    </ul>
               </div>
               <div class="col-md-3">
                    <h5>Contact Us</h5>
                    <ul class="list-unstyled">
                         <li><i class="fas fa-envelope"></i> support@bookstore.com</li>
                         <li><i class="fas fa-phone"></i> +1 234 567 8900</li>
                         <li><i class="fas fa-map-marker-alt"></i> 123 Book Street</li>
                    </ul>
               </div>
          </div>
          <hr>
          <div class="text-center">
               <p class="mb-0">&copy; 2024 Online BookStore. All rights reserved.</p>
          </div>
     </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JS -->
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>

</html>