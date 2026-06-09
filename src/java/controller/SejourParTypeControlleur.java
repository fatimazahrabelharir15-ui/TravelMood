
package controller;

import DAO.SejourDAO;
import Entite.Sejour;
import Entite.TypeVacance;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "SejourParTypeControlleur", urlPatterns = {"/SejourParTypeControlleur"})
public class SejourParTypeControlleur extends HttpServlet {// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        try {
            int type = Integer.parseInt(request.getParameter("type"));
            SejourDAO dao=new SejourDAO();
            ArrayList<Sejour> listSejour=dao.getSejoursByTypeVacance(type);
            request.setAttribute("listSejour", listSejour);
            ArrayList<TypeVacance> listTypes = dao.getAllTypeVacance();
            request.setAttribute("Typevacance", listTypes);
            
            request.setAttribute("idTypeActive", type);
            
            RequestDispatcher rd=request.getRequestDispatcher("/sejours.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            out.println(e.getMessage());
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
