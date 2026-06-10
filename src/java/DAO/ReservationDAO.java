package DAO;

import Entite.Reservation;
import java.sql.*;

public class ReservationDAO {
    public int saveReservation(Reservation reservation) {
    String query = "INSERT INTO reservation (id_utilisateur, id_sejour, date_depart, date_arrivee, nb_places, nbr_chambre, statut) VALUES (?, ?, ?, ?, ?, ?, ?)";
    
    try (Connection con = Connect.getCon() ;// Remplace par ta classe de connexion
         PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
        
        ps.setInt(1, reservation.getId_Utilisateur());
        ps.setInt(2, reservation.getId_Sejour());
        ps.setDate(3, (java.sql.Date) reservation.getDate_depart());
        ps.setDate(4, (java.sql.Date) reservation.getDate_arrivee());
        ps.setInt(5, reservation.getNb_places());
        ps.setInt(6, reservation.getNbr_chambre());
        ps.setString(7, reservation.getStatut());
        
        int affectedRows = ps.executeUpdate();
        if (affectedRows > 0) {
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1); // Retourne le vrai ID généré par Postgres
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0; // Échec
}
}
