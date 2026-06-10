package controller;

import DAO.FactureDAO;
import DAO.PaiementDAO;
import Entite.Facture;
import Entite.Paiement;
import Entite.Reservation;
import Entite.Sejour;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "PaiementControlleur", urlPatterns = {"/PaiementControlleur"})
public class PaiementControlleur extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Sejour sejour=(Sejour)session.getAttribute("sejour");
        Reservation reservation =(Reservation)session.getAttribute("reservation");
        
        try {
            int id_reservation=reservation.getId_reservation();
            float montant=(sejour.getPrix() * reservation.getNb_places());
            String methode_paiement="viement";
            String statut_paiement="En attente";

            Paiement paiement=new Paiement();
            paiement.setId_reservation(id_reservation);
            paiement.setMontant(montant);
            paiement.setMethode_paiement(methode_paiement);
            paiement.setStatut_paiement(statut_paiement);

            PaiementDAO dao=new PaiementDAO();
            int idPaiementGenere = dao.savePaiment(paiement); 

            if (idPaiementGenere > 0) {
                // On met à jour l'ID dans notre objet pour la suite
                paiement.setId_paiement(idPaiementGenere);

                // 2. Création automatique de la Facture correspondante
                String numeroFacture = "FAC-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
                
                Facture facture = new Facture();
                facture.setNumero_facture(numeroFacture);
                facture.setId_reservation(id_reservation);
                facture.setId_paiment(idPaiementGenere);
                facture.setDate_facture(new java.sql.Date(System.currentTimeMillis()));

                FactureDAO factureDAO = new FactureDAO();
                boolean isFactureSaved = factureDAO.saveFacture(facture);
            if (isFactureSaved) {
                    // 3. Tout s'est bien passé ! On transmet toutes les infos à la JSP
                    request.setAttribute("paiement", paiement);
                    request.setAttribute("facture", facture);
                    request.setAttribute("reservation", reservation);
                    request.setAttribute("sejour", sejour);

                    RequestDispatcher rd = request.getRequestDispatcher("/facturation.jsp");
                    rd.forward(request, response);
                } else {
                    // Si la facture échoue
                    request.setAttribute("errorMsg", "Le paiement a été enregistré, mais la création de la facture a échoué en base de données.");
                    RequestDispatcher rd = request.getRequestDispatcher("/Paiement.jsp");
                    rd.forward(request, response);
                }
            } else {
                // Si le paiement renvoie 0 ou false
                request.setAttribute("errorMsg", "Échec de l'enregistrement du paiement. Vérifiez les contraintes de votre base de données.");
                RequestDispatcher rd = request.getRequestDispatcher("/Paiement.jsp");
                rd.forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace(); // Écrit le détail dans la console NetBeans
            request.setAttribute("errorMsg", "Erreur technique lors du traitement : " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/Paiement.jsp");
            rd.forward(request, response);
        }
        
        
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
