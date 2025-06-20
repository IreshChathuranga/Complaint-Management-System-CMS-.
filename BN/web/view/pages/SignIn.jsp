<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 6/18/2025
  Time: 3:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SignIn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>
    <body class="container">
        <div class="row justify-content-center align-items-center vh-100">
            <div class="col-md-6">
                <div class="card border-secondary rounded-5 shadow p-4">
                    <h1 class="mt-3 text-center">Sign In</h1>
                    <p class="lead text-center">Login your account to get started.</p>

                    <form action="http://localhost:8080/BN_Web_exploded/api/login" method="post">
                        <div class="mb-3">
                            <label for="role" class="form-label">Your Role</label>
                            <input type="text" class="form-control" id="role" name="role" placeholder="Admin/Employee" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Your Email</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="example@example.com" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Your Password</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="*********" required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary" id="sign-btn">LOGIN</button>
                            <p class="text-center mt-2"></p>
                            <p class="text-center text-danger">If you don't have an account.</p>
                            <button type="button" class="btn btn-secondary" onclick="window.location.href='SignUp.jsp'">SIGN UP</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-md-6">
                <img src="http://localhost:8080/BN_Web_exploded/images/loginpic.png" class="img-fluid" alt="Placeholder Image">
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
                crossorigin="anonymous"></script>
        <script src="<%= request.getContextPath() %>/org/example/view/js/jquery-3.6.0.min.js"></script>
        <script src="http://localhost:8080/BN_Web_exploded/view/js/signIn.js"></script>

        <!-- <script src="<%= request.getContextPath() %>/js/signin.js"></script> -->

    </body>
</html>
