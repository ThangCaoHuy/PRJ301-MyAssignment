/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.management;

import controller.auth.RequiredAuthenticationBaseController;
import dal.DepartmentDBContext;
import dal.LeaveRequestDBContext;
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
public class ViewByDepartmentController extends RequiredAuthenticationBaseController {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        int pagesize = 10;
        String raw_pageindex = request.getParameter("page");
        if (raw_pageindex == null || raw_pageindex.length() == 0) {
            raw_pageindex = "1";
        }
        int pageindex = Integer.parseInt(raw_pageindex);
        String did = request.getParameter("did");

        LeaveRequestDBContext db = new LeaveRequestDBContext();
        DepartmentDBContext deptDB = new DepartmentDBContext();

        Integer id = (did == null || did.length() == 0 || did.equals("-1")) ? null : Integer.parseInt(did);
        ArrayList<LeaveRequest> leaves = db.getByDept(id);
        db = new LeaveRequestDBContext();
        int totalrows = db.count();
        int totalpage = (totalrows % pagesize == 0) ? totalrows / pagesize : ((totalrows / pagesize) + 1);

        request.setAttribute("pageindex", pageindex);
        request.setAttribute("totalpage", totalpage);
        request.setAttribute("leaves", leaves);
        request.setAttribute("depts", deptDB.list());
        request.getRequestDispatcher("../view/management/application_management.jsp").forward(request, response);
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
        if ("delete".equals(action)) {
            int requestId = Integer.parseInt(req.getParameter("requestId"));
            LeaveRequestDBContext db = new LeaveRequestDBContext();
            db.deleteRequest(requestId);
        }
        processRequest(req, resp, user);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
