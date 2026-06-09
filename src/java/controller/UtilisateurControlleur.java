package controller;

import DAO.UtilisateurDAO;
import Entite.Utilisateur;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "UtilisateurControlleur", urlPatterns = {"/UtilisateurControlleur"})
public class UtilisateurControlleur extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idSejour = request.getParameter("idSejour");
        
        if (idSejour != null) {
            HttpSession session = request.getSession();
            Utilisateur user = (Utilisateur) session.getAttribute("user");
            
            if (user == null) {
                // CAS 1 : L'utilisateur n'est pas connecté
                // On garde l'ID du séjour en session pour s'en souvenir après la connexion
                session.setAttribute("redirectIdSejour", idSejour);
                
                // Redirection vers ta page de connexion (adapter le nom du fichier si nécessaire, ex: login.jsp ou connexion.jsp)
                response.sendRedirect(request.getContextPath() + "/connexion.jsp");
            } else {
                // CAS 2 : L'utilisateur est déjà connecté
                // Redirection directe vers ton contrôleur de réservation (ex: ReservationControlleur)
                response.sendRedirect(request.getContextPath() + "/ReservationControlleur?idSejour=" + idSejour);
            }
        } else {
            // Si pas d'idSejour, redirection classique par défaut vers le catalogue
            response.sendRedirect(request.getContextPath() + "/SejourControlleur");
        }
       
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       PrintWriter out=response.getWriter();
        try {
            String email=request.getParameter("email");
            String password=request.getParameter("password");
            UtilisateurDAO dao=new UtilisateurDAO();
            Utilisateur user=dao.getUser(email, password);
            RequestDispatcher rd;
            if (user != null) 
            {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(15 * 60);
                if (user.getRole().equals("client")) {

                    // Au lieu du RequestDispatcher, on redirige proprement en GET
                    response.sendRedirect(request.getContextPath() + "/SejourControlleur");
                    return; 
                } else {
                    rd = request.getRequestDispatcher("/admin.jsp");
                }
                rd.forward(request, response);
                return;
            }
            else {
                request.setAttribute("msg", "Compte inexistant ou mot de passe incorrect");

                rd = request.getRequestDispatcher("/connexion.jsp"); 
                rd.forward(request, response);
                return; 
        }
        } catch (Exception e) {
            out.println(e.getMessage());
        }
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
