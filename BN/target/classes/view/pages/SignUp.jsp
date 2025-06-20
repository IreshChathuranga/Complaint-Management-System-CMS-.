<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 6/18/2025
  Time: 2:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SignUp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>
<body class="container">

<div class="row justify-content-center align-items-center vh-100">
    <div class="col-md-8">
        <div class="card border-secondary rounded-5 shadow p-4">
            <h1 class="mt-3 text-center">Sign Up</h1>
            <p class="lead text-center">Create your account to get started.</p>

            <form action="http://localhost:8080/BN_Web_exploded/api/user" method="post">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="role" class="form-label">Your Role</label>
                        <input type="text" class="form-control" id="role" name="role" placeholder="Admin/Employee" required>                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="name" class="form-label">Your Name</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Iresh Chathuranga" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="address" class="form-label">Your Address</label>
                        <input type="text" class="form-control" id="address" name="address" placeholder="Galle" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="phone" class="form-label">Your Mobile Number</label>
                        <input type="number" class="form-control" id="phone" name="phone" placeholder="093942345" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="email" class="form-label">Your Email</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="example@example.com" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="password" class="form-label">New Password</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="*********" required>
                    </div>
                </div>

                <div class="d-grid mt-3">
                    <button type="submit" class="btn btn-primary" id="sign-btn">SIGN UP</button>
                    <p class="text-center mt-2 mb-1"></p>
                    <p class="text-center text-danger">If you already have an account.</p>
                    <button type="button" class="btn btn-secondary" onclick="window.location.href='SignIn.jsp'">LOGIN</button>
                </div>
            </form>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
        crossorigin="anonymous"></script>
<script src="http://localhost:8080/BN_Web_exploded/view/js/signup.js"></script>
<script>
    window.onload = function () {
        const urlParams = new URLSearchParams(window.location.search);
        const status = urlParams.get("status");

        if (status === "success") {
            alert("User registered successfully!");
        } else if (status === "fail") {
            alert("Registration failed. Please try again.");
        }
    };
</script>
</body>
</html>

