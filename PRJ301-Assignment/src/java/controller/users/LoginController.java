/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.users;

import dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Feature;
import model.Role;
import model.User;

/**
 *
 * @author NITRO 5
 */
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("login.html").forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String param_user = request.getParameter("username");
        String param_pass = request.getParameter("password");

        UserDBContext db = new UserDBContext();
        User u = db.getWithRoles(param_user, param_pass);

        if (u != null) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("Hello " + u.getDisplayname() + "<br/>");
            for (Role role : u.getRoles()) {
                response.getWriter().println(role.getName() + "<br/>");
                for (Feature feature : role.getFeatures()) {
                    response.getWriter().println("->" + feature.getUrl() + "<br/>");
                }
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", u);

        } else {
            response.getWriter().println("login failed!");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
