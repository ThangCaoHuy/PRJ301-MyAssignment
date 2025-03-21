/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.leaverequest;

import controller.auth.RequiredAuthenticationBaseController;
import dal.LeaveRequestDBContext;
import dal.DepartmentDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.LeaveRequest;
import model.User;

/**
 *
 * @author NITRO 5
 */
public class ViewLeaveRequestByDepartmentController extends RequiredAuthenticationBaseController {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        LeaveRequestDBContext db = new LeaveRequestDBContext();
        DepartmentDBContext deptDB = new DepartmentDBContext();
        String managerUsername = user.getUsername();

        // Lấy ID phòng ban của Team Leader
        Integer departmentId = user.getE().getDept().getId();

        // Lấy danh sách đơn nghỉ phép theo manager
        ArrayList<LeaveRequest> leaves = db.getRequestsByManager(managerUsername);

        request.setAttribute("leaves", leaves);
        request.setAttribute("selectedDeptId", departmentId);
        request.setAttribute("depts", deptDB.list()); // Trả về danh sách các phòng ban
        request.getRequestDispatcher("../view/leaverequest/list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        String action = req.getParameter("action");
        String requestIdParam = req.getParameter("requestId");

        if (requestIdParam == null || requestIdParam.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing requestId");
            return;
        }

        int requestId;
        try {
            requestId = Integer.parseInt(requestIdParam);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid requestId");
            return;
        }

        LeaveRequestDBContext db = new LeaveRequestDBContext();

        if ("approve".equals(action)) {
            db.updateStatus(requestId, 2); // 2: Accepted
        } else if ("reject".equals(action)) {
            db.updateStatus(requestId, 1); // 1: Rejected
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            return;
        }

        resp.sendRedirect("findbydept");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        processRequest(req, resp, user);
    }

}
