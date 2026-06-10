package controller;

import DAO.SejourDAO;
import Entite.Reservation;
import Entite.Sejour;
import Entite.Utilisateur;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ReservationControlleur", urlPatterns = {"/ReservationControlleur"})
public class ReservationControlleur extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        SejourDAO dao=new SejourDAO();
        
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        
        // Sécurité enfant : pas de session, pas de réservation
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/connexion.jsp");
            return;
        }
        
        // Récupération sécurisée du paramètre ID séjour
        int idSejour = Integer.parseInt(request.getParameter("idSejour"));
        Sejour sejour=dao.getOneDetail(idSejour);
        
        request.setAttribute("sejour", sejour);

        // Envoi interne vers la vue JSP (conserve les données de requêtes et de sessions)
        RequestDispatcher rd = request.getRequestDispatcher("/reservation.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. On récupère l'utilisateur en session pour avoir son ID
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/connexion.jsp");
            return;
        }

        try {
            // 2. Récupération des données du formulaire
            int idUtilisateur = user.getId(); // Adapte selon le getter de l'ID dans ton entité Utilisateur
            int idSejour = Integer.parseInt(request.getParameter("idSejour"));
            int nbPlaces = Integer.parseInt(request.getParameter("voyageurs"));
            int nbrChambre = Integer.parseInt(request.getParameter("chambres")); // Attention: tes deux inputs avaient le même name="voyageurs" dans ta JSP originelle, ajuste si tu as mis name="chambres"

            // Récupération et conversion des dates (HTML renvoie du String "YYYY-MM-DD")
            String dateDepartStr = request.getParameter("dateDepart");
            String dateArriveeStr = request.getParameter("dateArrivee"); // Ajuste le name de l'input si tu as mis dateArrivee

            java.sql.Date dateDepart = java.sql.Date.valueOf(dateDepartStr);
            java.sql.Date dateArrivee = java.sql.Date.valueOf(dateArriveeStr);

            String statut = "En attente";

            // 3. Création de l'objet Reservation
            // (Ajuste l'ordre des paramètres selon le constructeur de ton entité Entite.Reservation)
            Reservation reservation =new Reservation();
            reservation.setId_Utilisateur(idUtilisateur);
            reservation.setId_Sejour(idSejour);
            reservation.setDate_depart(dateDepart);
            reservation.setNb_places(nbPlaces);
            reservation.setStatut(statut);
            reservation.setDate_arrivee(dateArrivee);
            reservation.setNbr_chambre(nbrChambre);
            
            session.setAttribute("reservation", reservation); 

            DAO.ReservationDAO reservationDAO = new DAO.ReservationDAO();
            int idReservationGenere = reservationDAO.saveReservation(reservation);

            if (idReservationGenere > 0) {
                // CRUCIAL : On attribue le vrai ID à l'objet avant de le mettre en session
                reservation.setId_reservation(idReservationGenere); 

                session.setAttribute("reservation", reservation);
                
                SejourDAO sejourDAO = new SejourDAO();
                Sejour sejour = sejourDAO.getOneDetail(idSejour);
                request.setAttribute("sejour", sejour);
                session.setAttribute("sejour", sejour);

                // Redirection propre vers la page de paiement
                response.sendRedirect(request.getContextPath() + "/Paiement.jsp");
            } else {
                // En cas d'échec d'insertion SQL
                

                request.setAttribute("errorMsg", "Une erreur interne est survenue lors de l'enregistrement en base de données.");
                RequestDispatcher rd = request.getRequestDispatcher("/reservation.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            // Gestion des erreurs de parsing ou champs vides
            request.setAttribute("errorMsg", "Données invalides ou incomplètes. " + e.getMessage());
            String idSejour = request.getParameter("idSejour");
            RequestDispatcher rd = request.getRequestDispatcher("/reservation.jsp?idSejour=" + idSejour);
            rd.forward(request, response);
        }
    }
}