package controller;

import DAO.SejourDAO;
import Entite.Sejour;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.ReservationDAO;
import DAO.PaiementDAO;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import DAO.UtilisateurDAO;



@WebServlet(name = "AdminControlleur", urlPatterns = {"/AdminControlleur"})
@MultipartConfig
public class AdminControlleur extends HttpServlet {

 @Override
protected void doGet(HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    try {

        String action = request.getParameter("action");
        // Valider une réservation
if ("validerReservation".equals(action)) {

    int id = Integer.parseInt(request.getParameter("id"));

    ReservationDAO dao = new ReservationDAO();
    dao.validerReservation(id);

    response.sendRedirect(
        request.getContextPath() + "/AdminControlleur?tab=reservations"
    );
    return;
}

// Rejeter une réservation
if ("rejeterReservation".equals(action)) {

    int id = Integer.parseInt(request.getParameter("id"));

    ReservationDAO dao = new ReservationDAO();
    dao.rejeterReservation(id);

    response.sendRedirect(
        request.getContextPath() + "/AdminControlleur?tab=reservations"
    );
    return;
}

        // Ouvrir le formulaire d'ajout
if ("ajouter".equals(action)) {

    SejourDAO dao = new SejourDAO();

    request.setAttribute("listeHumeurs", dao.getAllHumeurs());
    request.setAttribute("listeTypes", dao.getAllTypesVacance());

    request.getRequestDispatcher("/ajouterSejour.jsp")
           .forward(request, response);

    return;
}

        // Modifier un séjour
        if ("modifier".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));

            SejourDAO dao = new SejourDAO();

            int nombreSejours = dao.countSejours();
            request.setAttribute("nombreSejours", nombreSejours);

            Sejour s = dao.getOneDetail(id);

            request.setAttribute("sejour", s);

            request.getRequestDispatcher("/modifierSejour.jsp")
                   .forward(request, response);

            return;
        }

        // Suppression
        if ("supprimer".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));

            SejourDAO dao = new SejourDAO();
            dao.delete(id);

            response.sendRedirect(
                request.getContextPath() + "/AdminControlleur?tab=sejours"
            );

            return;
        }

            // Affichage des séjours
SejourDAO dao = new SejourDAO();

// Compter les réservations
ReservationDAO reservationDAO = new ReservationDAO();

int nombreReservations = reservationDAO.countReservations();
request.setAttribute("nombreReservations", nombreReservations);

// Compter les réservations en attente
int nbEnAttente = reservationDAO.countReservationsEnAttente();
request.setAttribute("nbEnAttente", nbEnAttente);

// Compter les séjours
int nombreSejours = dao.countSejours();
request.setAttribute("nombreSejours", nombreSejours);

UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

int nombreClients = utilisateurDAO.countClients();

request.setAttribute("nombreClients", nombreClients);

// Calculer le chiffre d'affaires
PaiementDAO paiementDAO = new PaiementDAO();

double chiffreAffaires = paiementDAO.getChiffreAffaires();

request.setAttribute(
        "chiffreAffaires",
        chiffreAffaires
);

request.setAttribute(
    "listePaiements",
    paiementDAO.getAllPaiements()
);
// Récupérer la liste
ArrayList<Sejour> listeSejours = dao.getAll();
request.setAttribute("listeSejours", listeSejours);

String tab = request.getParameter("tab");

if (tab == null) {
    tab = "dashboard";
}

request.setAttribute("tabActif", tab);

request.setAttribute(
    "listeReservations",
    reservationDAO.getAllReservations()
);

request.setAttribute(
    "reservationsParMois",
    reservationDAO.getReservationsParMois()
);

request.setAttribute(
    "paiementsParMethode",
    paiementDAO.getPaiementsParMethode()
);

request.setAttribute(
    "caParMois",
    paiementDAO.getChiffreAffairesParMois()
);
request.setAttribute(
    "listeHumeurs",
    dao.getAllHumeurs()
);
// Afficher admin.jsp
request.getRequestDispatcher("/admin.jsp")
       .forward(request, response);



        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Erreur : " + e.getMessage());
        }
    }

@Override
protected void doPost(HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    try {
        
        String action = request.getParameter("action");

        String titre = request.getParameter("titre");
        String description = request.getParameter("description");
        String typeVacance = request.getParameter("typeVacance");
        String humeur = request.getParameter("humeur");
        Part imagePart = request.getPart("image");
        String image = imagePart.getSubmittedFileName();

        float prix = Float.parseFloat(request.getParameter("prix"));

        Sejour s = new Sejour();
        s.setTitre(titre);
        s.setDescription(description);
        s.setTypeVacance(typeVacance);
        s.setHumeur(humeur);
        s.setImage(image);
        s.setPrix(prix);

        SejourDAO dao = new SejourDAO();

if ("modifier".equals(action)) {

    int id = Integer.parseInt(request.getParameter("id"));
    s.setId(id);

    dao.update(s);

} else {

    dao.add(s);

}
       response.sendRedirect(
    request.getContextPath() + "/AdminControlleur?tab=sejours"
);
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().println("Erreur : " + e.getMessage());
    }
}
}