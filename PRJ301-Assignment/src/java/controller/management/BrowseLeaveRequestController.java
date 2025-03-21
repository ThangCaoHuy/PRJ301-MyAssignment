/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.management;

import controller.auth.RequiredAuthenticationBaseController;
import dal.LeaveRequestDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.LeaveRequest;
import model.User;

/**
 *
 * @author NITRO 5
 */
public class BrowseLeaveRequestController extends RequiredAuthenticationBaseController {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        LeaveRequestDBContext db = new LeaveRequestDBContext();

        if (action != null && (action.equals("approve") || action.equals("reject"))) {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            int status = action.equals("approve") ? 2 : 1; // 2 = Approved, 1 = Rejected
            db.updateStatus(requestId, status);
            response.sendRedirect("management");
            return;
        }

        // Lấy một đơn nghỉ phép theo ID
        int requestId = Integer.parseInt(request.getParameter("id"));
        LeaveRequest leaveRequest = db.getID(requestId);
        request.setAttribute("leaveRequest", leaveRequest);

        request.getRequestDispatcher("../view/management/application_browse.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        processRequest(request, response, user);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
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

        resp.sendRedirect("management");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
