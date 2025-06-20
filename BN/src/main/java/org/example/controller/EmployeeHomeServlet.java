package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.dto.ComplainDto;
import org.example.model.ComplainModel;

import java.io.IOException;
import java.util.List;

@WebServlet("/employee/home")
public class EmployeeHomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");

        if (ds == null) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DataSource not found");
            return;
        }

        String employeeName = (String) req.getSession().getAttribute("employeeName");

        if (employeeName == null) {
            resp.sendRedirect(req.getContextPath() + "/view/pages/SignIn.jsp?status=fail");
            return;
        }

        ComplainModel model = new ComplainModel(ds);
        List<ComplainDto> complains = model.getComplainsByName(employeeName);

        req.setAttribute("complainList", complains);

        String status = req.getParameter("complainStatus");
        if (status != null) {
            req.setAttribute("complainStatus", status);
        }

        req.getRequestDispatcher("/view/pages/SendComplain.jsp").forward(req, resp);
    }
}
