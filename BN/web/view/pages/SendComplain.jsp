<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 6/18/2025
  Time: 5:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="org.example.dto.ComplainDto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Send Complain</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" />
    </head>
    <body class="container">

        <div class="row justify-content-center align-items-center vh-100">
            <div class="col-md-6">
                <img src="http://localhost:8080/BN_Web_exploded/images/complain.png" class="img-fluid" alt="Placeholder Image">
            </div>
            <div class="col-md-6">
                <div class="card border-secondary rounded-5 shadow p-4">
                    <h1 class="mt-3 text-center">Submit your complain</h1>
                    <form action="http://localhost:8080/BN_Web_exploded/api/complin" method="post">
                        <div class="mb-3">
                            <label for="name" class="form-label">Your Name</label>
                            <input type="text" class="form-control" id="name" name="name" value="<%= session.getAttribute("employeeName") %>" readonly required>
                        </div>
                        <div class="mb-3">
                            <label for="complain" class="form-label">Your Complain</label>
                            <textarea class="form-control" id="complain" name="complain" rows="4" required></textarea>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">SEND COMPLAIN</button>
                            <p></p>
                            <button type="button" class="btn btn-light border-0 text-danger" onclick="window.location.href='http://localhost:8080/BN_Web_exploded/view/pages/SignIn.jsp'">back -></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <form class="modal-content" action="http://localhost:8080/BN_Web_exploded/api/complin" method="post">
                    <input type="hidden" name="action" value="update" />
                    <div class="modal-header">
                        <h1 class="modal-title fs-5">Complain Update</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="modal-id" class="form-label">Complain ID</label>
                            <input type="text" class="form-control" id="modal-id" name="id" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="modal-name" class="form-label">Complainer Name</label>
                            <input type="text" class="form-control" id="modal-name" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="modal-complain" class="form-label">Complain</label>
                            <input type="text" class="form-control" id="modal-complain" name="complain" required>
                        </div>
                        <div class="mb-3">
                            <label for="modal-status" class="form-label">Status</label>
                            <input type="text" class="form-control" id="modal-status" name="status" value="pending" readonly>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Update Complain</button>
                    </div>
                </form>
            </div>
        </div>
        <table class="table table-primary table-striped-columns">
            <thead>
              <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Complain</th>
                <th>Status</th>
                  <th>Actions</th>
            </tr>
            </thead>
            <tbody id="complainTable">
            <%
                List<ComplainDto> complainList = (List<ComplainDto>) request.getAttribute("complainList");
                if (complainList != null) {
                    for (ComplainDto dto : complainList) {
            %>
            <tr
                    data-id="<%= dto.getId() %>"
                    data-name="<%= dto.getName() %>"
                    data-complain="<%= dto.getComplain() %>"
                    data-status="<%= dto.getStatus() %>"
                    style="cursor: pointer;"
            >
                <td><%= dto.getId() %></td>
                <td><%= dto.getName() %></td>
                <td><%= dto.getComplain() %></td>
                <td><%= dto.getStatus() %></td>
                <td>
                    <form method="post" action="<%= request.getContextPath() %>/api/complin" onsubmit="return confirm('Are you sure you want to delete this complaint?');">
                        <input type="hidden" name="action" value="delete" />
                        <input type="hidden" name="id" value="<%= dto.getId() %>" />
                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
                crossorigin="anonymous"></script>
        <% String complainStatus = (String) request.getAttribute("complainStatus"); %>
        <script type="module" src="http://localhost:8080/BN_Web_exploded/view/js/sendComplain.js"></script>
        <script>
            window.onload = function () {
                <% if ("successcoplain".equals(complainStatus)) { %>
                alert("Complaint submitted successfully!");
                <% } %>

                const urlParams = new URLSearchParams(window.location.search);
                const status = urlParams.get("status");

                if (status === "success") {
                    alert("Login successfully!");
                    window.history.replaceState({}, document.title, window.location.pathname);
                } else if (status === "fail") {
                    alert("Login failed. Please try again.");
                }
            };
        </script>

        <% String status = (String) request.getAttribute("complainStatus"); %>
        <script>
            window.onload = function () {
                <% if ("successcoplain".equals(status)) { %>
                alert("Complaint submitted successfully!");
                <% } else if ("updated".equals(status)) { %>
                alert("Complaint updated successfully!");
                <% } else if ("invalidStatus".equals(status)) { %>
                alert("You cannot set the status back to 'pending'.");
                <% } else if ("updateFail".equals(status)) { %>
                alert("Failed to update complaint.");
                <% } %>
            };
        </script>

        <% String deleteStatus = (String) request.getAttribute("complainStatus"); %>
        <script>
            window.onload = function () {
                <% if ("deleted".equals(deleteStatus)) { %>
                alert("Complaint deleted successfully!");
                <% } else if ("deleteFail".equals(deleteStatus)) { %>
                alert("Failed to delete complaint.");
                <% } %>
            };
        </script>

    </body>
</html>
