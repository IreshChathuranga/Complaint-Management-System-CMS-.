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

@WebServlet("/api/user")
public class UserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");

        String role = req.getParameter("role");
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String phoneStr = req.getParameter("phone");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        int phone = 0;
        try {
            phone = Integer.parseInt(phoneStr);
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("Invalid phone number");
            return;
        }

        UserDto user = new UserDto();
        user.setRole(role);
        user.setName(name);
        user.setAddress(address);
        user.setPhone(phone);
        user.setEmail(email);
        user.setPassword(password);

        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        if (ds == null) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DataSource not initialized");
            return;
        }

        UserModel model = new UserModel(ds);
        boolean saved = model.saveUser(user);

        if (saved) {
            resp.sendRedirect(req.getContextPath() + "/view/pages/SignIn.jsp?status=success");
        } else {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.sendRedirect(req.getContextPath() + "/view/pages/SignUp.jsp?status=fail");
        }
    }
}
