package controller;

import DAO.UtilisateurDAO;
import Entite.Utilisateur;
import java.io.IOException;
import java.io.PrintWriter;
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
                // On met l'ID du séjour de côté en session
                session.setAttribute("redirectIdSejour", idSejour);
                response.sendRedirect(request.getContextPath() + "/connexion.jsp");
            } else {
                // CAS 2 : L'utilisateur est déjà connecté
                // On passe par le contrôleur de réservation en lui transmettant l'ID
                response.sendRedirect(request.getContextPath() + "/ReservationControlleur?idSejour=" + idSejour);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/SejourControlleur");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            UtilisateurDAO dao = new UtilisateurDAO();
            Utilisateur user = dao.getUser(email, password);
            RequestDispatcher rd;
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                
                if (user.getRole().equals("client")) {
                    // --- SYNCHRONISATION ICI ---
                    // On vérifie si l'utilisateur voulait réserver un séjour avant de se connecter
                    String idSejourEnAttente = (String) session.getAttribute("redirectIdSejour");
                    
                    if (idSejourEnAttente != null) {
                        session.removeAttribute("redirectIdSejour"); // Nettoyage de la session
                        // On l'envoie vers le contrôleur de réservation avec son ID retenu
                        response.sendRedirect(request.getContextPath() + "/ReservationControlleur?idSejour=" + idSejourEnAttente);
                    } else {
                        response.sendRedirect(request.getContextPath() + "/SejourControlleur");
                    }
                    return; 
                } else {
                    rd = request.getRequestDispatcher("/admin.jsp");
                }
                rd.forward(request, response);
                return;
            } else {
                request.setAttribute("msg", "Compte inexistant ou mot de passe incorrect");
                rd = request.getRequestDispatcher("/ReservationControlleur"); 
                rd.forward(request, response);
                return; 
            }
        } catch (Exception e) {
            out.println(e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Gestion des connexions et suivi des intentions de réservation";
    }
}