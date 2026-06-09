
package controller;

import DAO.SejourDAO;
import Entite.Sejour;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "DetailControlleur", urlPatterns = {"/DetailControlleur"})
public class DetailControlleur extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        try {
            int id = Integer.parseInt(request.getParameter("idSejour"));
            SejourDAO dao=new SejourDAO();
            Sejour s=dao.getOneDetail(id);
            request.setAttribute("detailSejour", s);
            RequestDispatcher rd=request.getRequestDispatcher("/details.jsp");
            rd.forward(request, response);
            
        } catch (Exception e) {
            System.out.println("-> CRASH DANS LE CONTROLLEUR : " + e.getMessage());
            e.printStackTrace();
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
