package DAO;

import Entite.Reservation;
import java.sql.*;
import java.util.ArrayList;

public class ReservationDAO {
    public int saveReservation(Reservation reservation) {
    String query = "INSERT INTO reservation (id_utilisateur, id_sejour, date_depart, date_arrivee, nb_places, nbr_chambre, statut) VALUES (?, ?, ?, ?, ?, ?, ?)";
    
    try (Connection con = Connect.getCon() ;// Remplace par ta classe de connexion
         PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
        
        ps.setInt(1, reservation.getId_Utilisateur());
        ps.setInt(2, reservation.getId_Sejour());
       ps.setDate(3, new java.sql.Date(reservation.getDate_depart().getTime()));
ps.setDate(4, new java.sql.Date(reservation.getDate_arrivee().getTime()));
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
    public int countReservations() throws Exception {

    String sql = "SELECT COUNT(*) FROM reservation";

    PreparedStatement pst =
            Connect.getCon().prepareStatement(sql);

    ResultSet rs = pst.executeQuery();

    if (rs.next()) {
        return rs.getInt(1);
    }

    return 0;
<<<<<<< HEAD
=======
}
 public ArrayList<Object[]> getAllReservations() throws Exception {

    ArrayList<Object[]> liste = new ArrayList<>();

    String sql =
    "SELECT r.id_reservation, " +
    "u.nom, u.prenom, " +
    "s.titre, " +
    "r.date_depart, " +
    "r.nb_places, " +
    "r.statut " +
    "FROM reservation r " +
    "LEFT JOIN utilisateur u ON r.id_utilisateur = u.id_utilisateur " +
    "LEFT JOIN sejour s ON r.id_sejour = s.id_sejour " +
    "ORDER BY r.id_reservation DESC";

    PreparedStatement pst = Connect.getCon().prepareStatement(sql);

    ResultSet rs = pst.executeQuery();

    while (rs.next()) {

        Object[] ligne = new Object[7];

        ligne[0] = rs.getInt("id_reservation");
        ligne[1] = rs.getString("nom");
        ligne[2] = rs.getString("prenom");
        ligne[3] = rs.getString("titre");
        ligne[4] = rs.getDate("date_depart");
        ligne[5] = rs.getInt("nb_places");
        ligne[6] = rs.getString("statut");

        liste.add(ligne);
    }
System.out.println("Nombre de réservations récupérées : " + liste.size());
    return liste;
} 
 public boolean validerReservation(int id) throws Exception {

    String sql =
        "UPDATE reservation SET statut='Validée' WHERE id_reservation=?";

    PreparedStatement pst =
        Connect.getCon().prepareStatement(sql);

    pst.setInt(1, id);

    return pst.executeUpdate() > 0;
}

public boolean rejeterReservation(int id) throws Exception {

    String sql =
        "UPDATE reservation SET statut='Rejetée' WHERE id_reservation=?";

    PreparedStatement pst =
        Connect.getCon().prepareStatement(sql);

    pst.setInt(1, id);

    return pst.executeUpdate() > 0;
}
public int countReservationsEnAttente() throws Exception {

    String sql = "SELECT COUNT(*) FROM reservation WHERE statut = 'En attente'";

    PreparedStatement pst = Connect.getCon().prepareStatement(sql);
    ResultSet rs = pst.executeQuery();

    if (rs.next()) {
        return rs.getInt(1);
    }

    return 0;
}
public ArrayList<Object[]> getReservationsParMois() throws Exception {

    ArrayList<Object[]> liste = new ArrayList<>();

    String sql =
        "SELECT EXTRACT(MONTH FROM date_depart) AS mois, " +
        "COUNT(*) AS total " +
        "FROM reservation " +
        "GROUP BY mois " +
        "ORDER BY mois";

    PreparedStatement pst = Connect.getCon().prepareStatement(sql);
    ResultSet rs = pst.executeQuery();

    while (rs.next()) {
        Object[] ligne = new Object[2];
        ligne[0] = rs.getInt("mois");
        ligne[1] = rs.getInt("total");
        liste.add(ligne);
    }

    return liste;
}

>>>>>>> 49270c68072751f1f4f575846aba712c45c8b380
}
 public ArrayList<Object[]> getAllReservations() throws Exception {

    ArrayList<Object[]> liste = new ArrayList<>();

    String sql =
    "SELECT r.id_reservation, " +
    "u.nom, u.prenom, " +
    "s.titre, " +
    "r.date_depart, " +
    "r.nb_places, " +
    "r.statut " +
    "FROM reservation r " +
    "LEFT JOIN utilisateur u ON r.id_utilisateur = u.id_utilisateur " +
    "LEFT JOIN sejour s ON r.id_sejour = s.id_sejour " +
    "ORDER BY r.id_reservation DESC";

    PreparedStatement pst = Connect.getCon().prepareStatement(sql);

    ResultSet rs = pst.executeQuery();

    while (rs.next()) {

        Object[] ligne = new Object[7];

        ligne[0] = rs.getInt("id_reservation");
        ligne[1] = rs.getString("nom");
        ligne[2] = rs.getString("prenom");
        ligne[3] = rs.getString("titre");
        ligne[4] = rs.getDate("date_depart");
        ligne[5] = rs.getInt("nb_places");
        ligne[6] = rs.getString("statut");

        liste.add(ligne);
    }
System.out.println("Nombre de réservations récupérées : " + liste.size());
    return liste;
} 
 public boolean validerReservation(int id) throws Exception {

    String sql =
        "UPDATE reservation SET statut='Validée' WHERE id_reservation=?";

    PreparedStatement pst =
        Connect.getCon().prepareStatement(sql);

    pst.setInt(1, id);

    return pst.executeUpdate() > 0;
}

public boolean rejeterReservation(int id) throws Exception {

    String sql =
        "UPDATE reservation SET statut='Rejetée' WHERE id_reservation=?";

    PreparedStatement pst =
        Connect.getCon().prepareStatement(sql);

    pst.setInt(1, id);

    return pst.executeUpdate() > 0;
}
public int countReservationsEnAttente() throws Exception {

    String sql = "SELECT COUNT(*) FROM reservation WHERE statut = 'En attente'";

    PreparedStatement pst = Connect.getCon().prepareStatement(sql);
    ResultSet rs = pst.executeQuery();

    if (rs.next()) {
        return rs.getInt(1);
    }

    return 0;
}
public ArrayList<Object[]> getReservationsParMois() throws Exception {

    ArrayList<Object[]> liste = new ArrayList<>();

    String sql =
        "SELECT EXTRACT(MONTH FROM date_depart) AS mois, " +
        "COUNT(*) AS total " +
        "FROM reservation " +
        "GROUP BY mois " +
        "ORDER BY mois";

    PreparedStatement pst = Connect.getCon().prepareStatement(sql);
    ResultSet rs = pst.executeQuery();

    while (rs.next()) {
        Object[] ligne = new Object[2];
        ligne[0] = rs.getInt("mois");
        ligne[1] = rs.getInt("total");
        liste.add(ligne);
    }

    return liste;
}

}