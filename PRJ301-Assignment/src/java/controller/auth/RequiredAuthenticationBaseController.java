/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Feature;
import model.Role;
import model.User;

/**
 *
 * @author NITRO 5
 */
public abstract class RequiredAuthenticationBaseController extends HttpServlet {

    private User getLoggedUser(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        return user;
    }

    private boolean isAuthorized(HttpServletRequest request, User u) {
        if (u == null) {
            return false;
        }
        String current_url = request.getServletPath();
        for (Role role : u.getRoles()) {
            for (Feature feature : role.getFeatures()) {
                if (feature.getUrl().equals(current_url)) {
                    return true;
                }
            }
        }
        return false;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = getLoggedUser(request);
        if (isAuthorized(request, user)) {
            doGet(request, response, user);
        } else {
            response.getWriter().println("access denied!");
        }
    }

    protected abstract void doGet(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException;

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
        User user = getLoggedUser(request);
        if (isAuthorized(request, user)) {
            //do biz
            doPost(request, response, user);
        } else {
            response.getWriter().println("access denied!");
        }
    }

    protected abstract void doPost(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException;

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
