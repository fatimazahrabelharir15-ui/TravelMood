/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.SejourDAO;
import Entite.Sejour;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MR TECHNOLOGIES
 */
@WebServlet(name = "SejourControlleur", urlPatterns = {"/SejourControlleur"})
public class SejourControlleur extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        
        try {
            SejourDAO dao=new SejourDAO();
            ArrayList<Sejour> list=dao.getAll();
            request.setAttribute("list", list);
            RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
            
        } catch (Exception ex) {
            out.println(ex.getMessage());
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
