<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page session="true" %>
        <% String userRole=(String) session.getAttribute("userRole"); if (userRole==null || !userRole.equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp" ); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Admin Dashboard - Online Bookstore</title>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
            </head>

            <body>
                <div class="container mt-5">
                    <h2 class="text-center">Admin Dashboard</h2>
                    <div class="list-group">
                        <a href="manage_books.jsp" class="list-group-item list-group-item-action">Manage Books</a>
                        <a href="add_book.jsp" class="list-group-item list-group-item-action">Add Books</a>
                        <a href="${pageContext.request.contextPath}/auth/logout"
                            class="list-group-item list-group-item-action text-danger">Logout</a>
                    </div>
                </div>
            </body>

            </html>