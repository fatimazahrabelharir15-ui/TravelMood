package DAO;

import Entite.Profil;
import Entite.Reservation;
import Entite.Utilisateur;
import Entite.TypeVacance; // Ne pas oublier cet import !
import java.sql.*;
import java.util.ArrayList;

public class ProfilDAO {
    
    public ArrayList<Reservation> listerReservation(Utilisateur us) throws SQLException {
    ArrayList<Reservation> list = new ArrayList<>();
    String sql = "SELECT * "
               + "FROM reservation r "
               + "INNER JOIN Utilisateur u ON r.id_utilisateur = u.id_utilisateur "
               + "INNER JOIN sejour s ON s.id_sejour = r.id_sejour "
               + "WHERE u.id_utilisateur = ?";
    try {
        PreparedStatement pst = Connect.getCon().prepareStatement(sql);
        pst.setInt(1, us.getId());
        ResultSet rs = pst.executeQuery(); 
        
        while (rs.next()) {
            // FIX : Utilisation des bons types de données Java (Int, Date, String) 
            // au lieu de mettre rs.getInt() partout !
            list.add(new Reservation(
                rs.getInt("id_reservation"),     // 1. int
                rs.getInt("id_utilisateur"),     // 2. int
                rs.getInt("id_sejour"), 
                rs.getInt("nbr_chambre"),   
                rs.getInt("nb_places"),          // 4. int
                rs.getDate("date_depart"),       // 5. Date (Ajustez l'ordre selon votre constructeur)
                rs.getDate("date_arrivee"),      // 6. Date
                rs.getString("statut")           // 7. String
                
            ));
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        throw new SQLException(ex.getMessage());
    }
    return list;
}

    public boolean saveProfil(Profil p, int id_utilisateur) {
        try {
            String sql = "INSERT INTO profil(Budget, preferences_voyage, id_type_vacance, id_utilisateur) VALUES(?, ?, ?, ?)";
            PreparedStatement pst = Connect.getCon().prepareStatement(sql);
            pst.setFloat(1, p.getBudget());
            pst.setString(2, p.getPreference());
            pst.setInt(3, p.getTypeVacance());
            pst.setInt(4, id_utilisateur);
            return pst.executeUpdate() != 0;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean updateProfil(Profil p, int id_utilisateur) {
        try {
            String sql = "UPDATE profil SET budget = ?, preferences_voyage = ?, id_type_vacance = ? WHERE id_utilisateur = ?";            
            PreparedStatement pst = Connect.getCon().prepareStatement(sql);
            pst.setFloat(1, p.getBudget());
            pst.setString(2, p.getPreference());
            pst.setInt(3, p.getTypeVacance());
            pst.setInt(4, id_utilisateur); 
            return pst.executeUpdate() != 0;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }
    
    public Profil getProfilByUtilisateur(int id_utilisateur) {
        try {
            String sql = "SELECT * FROM profil WHERE id_utilisateur = ?";
            PreparedStatement pst = Connect.getCon().prepareStatement(sql);
            pst.setInt(1, id_utilisateur);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return new Profil(
                    rs.getInt("id_profil"), // Changez par "id" si c'est juste "id" dans votre table
                    rs.getInt("id_utilisateur"),
                    rs.getString("preferences_voyage"),
                    rs.getInt("id_type_vacance"),
                    rs.getFloat("Budget")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // AJOUT : La méthode qui va chercher la liste dans votre BDD
    public ArrayList<TypeVacance> listerTypeVacance() {
        ArrayList<TypeVacance> list = new ArrayList<>();
        String sql = "SELECT * FROM type_vacance";
        try {
            PreparedStatement pst = Connect.getCon().prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while(rs.next()){
                list.add(new TypeVacance(rs.getInt(1), rs.getString(2)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}