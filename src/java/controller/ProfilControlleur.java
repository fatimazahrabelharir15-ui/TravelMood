package controller;

import DAO.ProfilDAO;
import Entite.Profil;
import Entite.Reservation;
import Entite.TypeVacance;
import Entite.Utilisateur;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ProfilControlleur", urlPatterns = {"/ProfilControlleur"})
public class ProfilControlleur extends HttpServlet {

    private final ProfilDAO dao = new ProfilDAO();

    /**
     * 1. AFFICHAGE INITIAL (Méthode GET)
     * Charge les réservations et le profil de l'utilisateur puis affiche la page profil.jsp.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("user");

        // Sécurité : Si l'utilisateur n'est pas connecté en session, on le renvoie à l'accueil/connexion
        if (user == null) {
            response.sendRedirect("connexion.jsp");
            return;
        }

        try {
            // Récupération de la liste des réservations via le DAO
            ArrayList<Reservation> list = dao.listerReservation(user);
            request.setAttribute("list", list);
            
            // Récupération des informations du profil voyageur
            Profil profil = dao.getProfilByUtilisateur(user.getId());
            request.setAttribute("profil", profil);
            // Dans le doGet de ProfilControlleur.java, juste après avoir chargé le profil :
            ArrayList<TypeVacance> typesVacances = dao.listerTypeVacance();
            request.setAttribute("typesVacances", typesVacances);
            
            // Redirection interne vers la vue JSP
            request.getRequestDispatcher("/profil.jsp").forward(request, response);                
        } catch (Exception e) {
            // En cas d'erreur SQL ou autre, on passe le message à la vue
            request.setAttribute("msgError", "Erreur lors du chargement de vos données : " + e.getMessage());
            request.getRequestDispatcher("/profil.jsp").forward(request, response);
        }
    }

    /**
     * 2. TRAITEMENT DU FORMULAIRE (Méthode POST)
     * Reçoit les modifications du modal, met à jour la BDD, puis réaffiche la page mise à jour.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("connexion.jsp");
            return;
        }
        try {
            String actionProfil = request.getParameter("actionProfil");

        // On vérifie que c'est bien le formulaire du modal qui a été soumis
        if ("enregistrer_preferences".equals(actionProfil)) {
            String budgetStr = request.getParameter("budget");
            String preferencesVoyage = request.getParameter("preferences_voyage");
            String typeVacanceStr = request.getParameter("type_vacance");
            
            // Conversions sécurisées pour éviter les NumberFormatException si les champs sont vides
            float budget = (budgetStr != null && !budgetStr.isEmpty()) ? Float.parseFloat(budgetStr) : 0.0f;
            int typeVacance = (typeVacanceStr != null && !typeVacanceStr.isEmpty()) ? Integer.parseInt(typeVacanceStr) : 0;

            // Instanciation de l'objet profil avec votre constructeur :
            // public Profil(int id, int idUtilisateur, String preference, int typeVacance, float budget)
            // On passe 0 pour l'id lors d'une création (la base s'occupe de l'auto-incrément)
            Profil p = new Profil(0, user.getId(), preferencesVoyage, typeVacance, budget);
            
            boolean success;
            
            // Si le profil existe déjà, on fait un UPDATE, sinon un INSERT (save)
            if (dao.getProfilByUtilisateur(user.getId()) != null) {
                success = dao.updateProfil(p, user.getId());
            } else {
                success = dao.saveProfil(p, user.getId());
            }

            // Notifications à afficher sur la page de destination
            if (success) {
                request.setAttribute("msgSuccess", "Vos préférences de voyage ont été enregistrées avec succès !");
            } else {
                request.setAttribute("msgError", "Une erreur est survenue lors de l'enregistrement en base de données.");
            }
        }

        // Après l'enregistrement, on appelle simplement doGet pour recharger 
        // les nouvelles données actualisées et afficher la vue sans dupliquer de code.
        doGet(request, response);
        } catch (Exception e) {
            System.out.println("💥 ERREUR DANS LE CONTRÔLEUR : " + e.getMessage());
    e.printStackTrace();
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Contrôleur gérant l'affichage du profil et la mise à jour des préférences voyageur.";
    }
}