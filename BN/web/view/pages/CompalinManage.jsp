<%@ page import="org.example.dto.ComplainDto" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 6/18/2025
  Time: 5:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Complain Manage</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" />
    </head>
    <body>
        <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <form class="modal-content" method="post" action="${pageContext.request.contextPath}/api/complin">
                    <input type="hidden" name="_method" value="put" />
                    <div class="modal-header">
                        <h1 class="modal-title fs-5">Complain Update</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="id" class="form-label">Complain ID</label>
                            <input type="text" class="form-control" id="id" name="id" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="name" class="form-label">Complainer Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="modalcomplain" class="form-label">Complain</label>
                            <input type="text" class="form-control" id="modalcomplain" name="complain" required>
                        </div>
                        <div class="mb-3">
                            <label for="status" class="form-label">Status</label>
                            <select class="form-control" id="status" name="status" required>
                                <option value="in progress">in progress</option>
                                <option value="resolved">resolved</option>
                            </select>
                        </div>
                    </div>
                    <div class="module-footer">
                        <button type="submit" class="btn btn-primary">Update Complain</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="d-flex justify-content-center align-items-center" style="min-height: 100vh;">
            <div style="width: 90%; max-width: 900px;">
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
                            <form method="post" action="${pageContext.request.contextPath}/api/complin" onsubmit="return confirm('Are you sure you want to delete this complaint?');">
                                <input type="hidden" name="_method" value="delete" />
                                <input type="hidden" name="id" value="<%= dto.getId() %>" />
                                <input type="hidden" name="page" value="manage" />
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
            </div>
            <div class="d-flex justify-content-center mt-3" style="flex-direction: column;">
                <button type="button" class="btn btn-light border-0 text-dark"
                        onclick="window.location.href='http://localhost:8080/BN_Web_exploded/view/pages/SignIn.jsp'">
                    ← Back to login
                </button>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
                crossorigin="anonymous"></script>
        <script type="module" src="http://localhost:8080/BN_Web_exploded/view/js/complainManage.js"></script>

    </body>
</html>
