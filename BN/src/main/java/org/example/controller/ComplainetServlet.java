package org.example.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.dto.ComplainDto;
import org.example.dto.UserDto;
import org.example.model.ComplainModel;
import org.example.model.UserModel;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/complin")
public class ComplainetServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");

        String overrideMethod = req.getParameter("_method");
        if ("put".equalsIgnoreCase(overrideMethod)) {
            doPut(req, resp);
            return;
        } else if ("delete".equalsIgnoreCase(overrideMethod)) {
            doDelete(req, resp);
            return;
        }
        String action = req.getParameter("action");
        if (action != null) action = action.trim().toLowerCase();

        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        if (ds == null) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DataSource not initialized");
            return;
        }

        ComplainModel model = new ComplainModel(ds);

        if ("update".equals(action)) {
            String idStr = req.getParameter("id");
            String name = req.getParameter("name");
            String complainText = req.getParameter("complain");
            String status = req.getParameter("status");

            if (idStr == null || idStr.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/employee/home?complainStatus=updateFail");
                return;
            }

            int id = Integer.parseInt(idStr);


            ComplainDto dto = new ComplainDto();
            dto.setId(id);
            dto.setName(name);
            dto.setComplain(complainText);
            dto.setStatus(status);

            boolean updated = model.updateComplain(dto);
            if (updated) {
                resp.sendRedirect(req.getContextPath() + "/employee/home?complainStatus=updated");
            } else {
                resp.sendRedirect(req.getContextPath() + "/employee/home?complainStatus=updateFail");
            }

        } else if ("delete".equals(action)) {
            String id = req.getParameter("id");

            if (id == null || id.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/employee/home?complainStatus=deleteFail");
                return;
            }

            boolean deleted = model.deleteComplainById(id);

            if (deleted) {
                resp.sendRedirect(req.getContextPath() + "/employee/home?complainStatus=deleted");
            } else {
                resp.sendRedirect(req.getContextPath() + "/employee/home?complainStatus=deleteFail");
            }

        } else {
            String name = req.getParameter("name");
            String complains = req.getParameter("complain");

            ComplainDto complain = new ComplainDto();
            complain.setName(name);
            complain.setComplain(complains);
            complain.setStatus("pending");

            boolean saved = model.saveComplain(complain);

            if (saved) {
                resp.sendRedirect(req.getContextPath() + "/employee/home?complainStatus=successcoplain");
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("Failed to save complain");
            }
        }
    }


    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String page = req.getParameter("page"); // <-- detect which page requested this delete

        if (id == null || id.isEmpty()) {
            redirectWithStatus(resp, req, page, "deleteFail");
            return;
        }

        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        ComplainModel model = new ComplainModel(ds);

        boolean deleted = model.deleteComplainById(id);

        if (deleted) {
            redirectWithStatus(resp, req, page, "deleted");
        } else {
            redirectWithStatus(resp, req, page, "deleteFail");
        }
    }

    private void redirectWithStatus(HttpServletResponse resp, HttpServletRequest req, String page, String status) throws IOException {
        if ("manage".equalsIgnoreCase(page)) {
            resp.sendRedirect(req.getContextPath() + "/api/complin?page=manage&complainStatus=" + status);
        } else {
            resp.sendRedirect(req.getContextPath() + "/employee/home?complainStatus=" + status);
        }
    }
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String contentType = req.getContentType();

        ComplainDto dto = new ComplainDto();

        if (contentType != null && contentType.contains("application/json")) {
            ObjectMapper mapper = new ObjectMapper();
            dto = mapper.readValue(req.getInputStream(), ComplainDto.class);
        } else {
            try {
                dto.setId(Integer.parseInt(req.getParameter("id")));
                dto.setName(req.getParameter("name"));
                dto.setComplain(req.getParameter("complain"));
                dto.setStatus(req.getParameter("status"));
            } catch (Exception e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid form data");
                return;
            }
        }

        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        ComplainModel model = new ComplainModel(ds);

        boolean updated = model.updateComplain(dto);

        if (updated) {
            resp.sendRedirect(req.getContextPath() + "/api/complin?page=manage&complainStatus=updated");
        } else {
            resp.sendRedirect(req.getContextPath() + "/api/complin?page=manage&complainStatus=updateFail");
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        if (ds == null) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DataSource not found");
            return;
        }

        String page = req.getParameter("page");
        ComplainModel model = new ComplainModel(ds);

        if ("manage".equalsIgnoreCase(page)) {
            List<ComplainDto> complains = model.getAllComplains();
            req.setAttribute("complainList", complains);
            req.getRequestDispatcher("/view/pages/CompalinManage.jsp").forward(req, resp);
        }else {
            String employeeName = (String) req.getSession().getAttribute("employeeName");
            if (employeeName == null) {
                resp.sendRedirect(req.getContextPath() + "/view/pages/SignIn.jsp?status=fail");
                return;
            }

            List<ComplainDto> complains = model.getComplainsByName(employeeName);
            req.setAttribute("complainList", complains);
            req.getRequestDispatcher("/view/pages/SendComplain.jsp").forward(req, resp);
        }
    }

}
