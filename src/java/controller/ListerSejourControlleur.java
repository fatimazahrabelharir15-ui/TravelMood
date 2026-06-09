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

@WebServlet(name = "ListerSejourControlleur", urlPatterns = {"/ListerSejourControlleur"})
public class ListerSejourControlleur extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        
        try {
            SejourDAO dao = new SejourDAO();
            ArrayList<TypeVacance> listTypes = dao.getAllTypeVacance();
            request.setAttribute("Typevacance", listTypes);
            
            ArrayList<Sejour> listSejour=dao.getAll();
            request.setAttribute("listSejour", listSejour);
            
            /*// 1. Récupération du paramètre "type"
            String typeParam = request.getParameter("type");
            int idTypeFiltre = 0; // 0 = "tous" par défaut
            
            if (typeParam != null && !typeParam.trim().isEmpty()) {
                idTypeFiltre = Integer.parseInt(typeParam);
            }
             
            // 2. Récupération des données depuis le DAO
            ArrayList<Sejour> listSejours = dao.getSejoursByTypeVacance(idTypeFiltre);
            
            // 3. Stockage des attributs pour la JSP
            
            request.setAttribute("listSejours", listSejours);
            request.setAttribute("idTypeActive", idTypeFiltre);*/
            
            // 4. Redirection vers la vue
            RequestDispatcher rd = request.getRequestDispatcher("/sejours.jsp");
            rd.forward(request, response);
            
        } catch(Exception e){
            out.println(e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}