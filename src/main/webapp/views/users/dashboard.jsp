<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.example.bookstore.models.Book" %>
            <%@ page session="true" %>
                <% String userRole=(String) session.getAttribute("userRole"); if (userRole==null) {
                    response.sendRedirect(request.getContextPath() + "/auth/login.jsp" ); return; } %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <title>User Dashboard - Online Bookstore</title>
                        <link rel="stylesheet"
                            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
                    </head>

                    <body>
                        <div class="container mt-5">
                            <h2 class="text-center">Welcome to Online Bookstore</h2>
                            <div class="d-flex justify-content-center gap-3 mb-4">
                                <a href="${pageContext.request.contextPath}/views/users/browse_books.jsp"
                                    class="btn btn-primary">Browse Books</a>
                                <a href="${pageContext.request.contextPath}/views/users/order_history.jsp"
                                    class="btn btn-secondary">Order History</a>
                                <a href="${pageContext.request.contextPath}/auth/logout"
                                    class="btn btn-danger">Logout</a>
                            </div>
                        </div>

                        <!-- Bootstrap JS -->
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    </body>

                    </html>