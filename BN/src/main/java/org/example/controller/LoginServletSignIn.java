package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.dto.UserDto;
import org.example.model.UserModel;

import java.io.IOException;

@WebServlet("/api/login")
public class LoginServletSignIn extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");

        String role = req.getParameter("role");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        if (ds == null) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DataSource not initialized");
            return;
        }

        UserModel model = new UserModel(ds);
        UserDto user = model.getUserByCredentials(role, email, password);

        if (user != null) {
            req.getSession().setAttribute("employeeName", user.getName());

            if ("Admin".equalsIgnoreCase(role)) {
                resp.sendRedirect(req.getContextPath() + "/api/complin?page=manage");
            } else if ("Employee".equalsIgnoreCase(role)) {
                resp.sendRedirect(req.getContextPath() + "/employee/home");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/view/pages/SignIn.jsp?status=fail");
        }
    }
}