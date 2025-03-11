<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - BookStore</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header i {
            font-size: 3rem;
            color: #0d6efd;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="login-header">
                <i class="fas fa-user-shield mb-3"></i>
                <h2>Admin Login</h2>
            </div>

            <c:if test="${not empty param.error}">
                <div class="alert alert-danger">
                    <c:choose>
                        <c:when test="${param.error eq 'admin.error.credentials.required'}">
                            All fields are required.
                        </c:when>
                        <c:when test="${param.error eq 'admin.error.invalid.credentials'}">
                            Invalid username or password.
                        </c:when>
                        <c:when test="${param.error eq 'admin.error.system'}">
                            System error occurred. Please try again later.
                        </c:when>
                        <c:otherwise>
                            ${param.error}
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <c:if test="${not empty param.message}">
                <div class="alert alert-success">
                    <c:choose>
                        <c:when test="${param.message eq 'admin.success.registration'}">
                            Registration successful! Please login.
                        </c:when>
                        <c:otherwise>
                            ${param.message}
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/auth/login" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Login</button>
            </form>

            <div class="mt-3 text-center">
                <p>Don't have an admin account? <a href="${pageContext.request.contextPath}/admin/auth/register">Register here</a></p>
                <p><a href="${pageContext.request.contextPath}/">Back to Home</a></p>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>