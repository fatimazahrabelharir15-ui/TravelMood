package DAO;

import Entite.Paiement;
import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

public class PaiementDAO {
    public int savePaiment(Paiement paiement) {
    // 1. On prépare la requête (SANS inclure l'id_paiement car Postgres le gère tout seul via SERIAL)
    String query = "INSERT INTO paiement (id_reservation, montant, methode_paiement, statut_paiement) VALUES (?, ?, ?, ?)";
    
    // On initialise l'id à 0 (valeur d'échec)
    int idGénéré = 0;

    try (Connection con = Connect.getCon(); // Remplace par ta classe de connexion si nécessaire
         PreparedStatement ps = con.prepareStatement(query, java.sql.Statement.RETURN_GENERATED_KEYS)) {
        
        // 2. Injection des paramètres dans la requête
        ps.setInt(1, paiement.getId_reservation());
        ps.setFloat(2, paiement.getMontant());
        ps.setString(3, paiement.getMethode_paiement());
        ps.setString(4, paiement.getStatut_paiement());
        
        // 3. Exécution de la requête
        int affectedRows = ps.executeUpdate();
        
        // 4. Si la ligne est bien insérée, on va chercher l'ID généré par PostgreSQL
        if (affectedRows > 0) {
            try (java.sql.ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    idGénéré = generatedKeys.getInt(1); // On récupère le SERIAL généré
                }
            }
        }
        
    } catch (Exception e) {
        // Si PostgreSQL refuse l'insertion pour une contrainte, on lève l'erreur pour la voir sur l'écran
        throw new RuntimeException("Erreur SQL fatale dans PaiementDAO : " + e.getMessage(), e);
    }
    
    // On retourne le vrai ID (ex: 1, 2, 3...). S'il vaut toujours 0, le contrôleur saura que ça a échoué
    return idGénéré; 
}
    public double getChiffreAffaires() throws Exception {

    String sql = "SELECT SUM(montant) FROM paiement";

    PreparedStatement pst =
            Connect.getCon().prepareStatement(sql);

    ResultSet rs = pst.executeQuery();

    if (rs.next()) {
        return rs.getDouble(1);
    }

    return 0;
}
    public ArrayList<Object[]> getAllPaiements() throws Exception {

    ArrayList<Object[]> liste = new ArrayList<>();

    String sql =
        "SELECT " +
        "u.nom, " +
        "u.prenom, " +
        "p.montant, " +
        "p.methode_paiement, " +
        "p.statut_paiement " +
        "FROM paiement p " +
        "JOIN reservation r ON p.id_reservation = r.id_reservation " +
        "JOIN utilisateur u ON r.id_utilisateur = u.id_utilisateur " +
        "ORDER BY p.id_paiement DESC";

    PreparedStatement pst = Connect.getCon().prepareStatement(sql);

    ResultSet rs = pst.executeQuery();

    while (rs.next()) {

        Object[] ligne = new Object[5];

        ligne[0] = rs.getString("nom");
        ligne[1] = rs.getString("prenom");
        ligne[2] = rs.getDouble("montant");
        ligne[3] = rs.getString("methode_paiement");
        ligne[4] = rs.getString("statut_paiement");

        liste.add(ligne);
    }

    return liste;
}
    public ArrayList<Object[]> getPaiementsParMethode() throws Exception {

    ArrayList<Object[]> liste = new ArrayList<>();

    String sql =
        "SELECT methode_paiement, COUNT(*) AS total " +
        "FROM paiement " +
        "GROUP BY methode_paiement";

    PreparedStatement pst = Connect.getCon().prepareStatement(sql);
    ResultSet rs = pst.executeQuery();

    while (rs.next()) {
        Object[] ligne = new Object[2];
        ligne[0] = rs.getString("methode_paiement");
        ligne[1] = rs.getInt("total");
        liste.add(ligne);
    }

    return liste;
}
    public ArrayList<Object[]> getChiffreAffairesParMois() throws Exception {

    ArrayList<Object[]> liste = new ArrayList<>();

    String sql =
        "SELECT EXTRACT(MONTH FROM r.date_depart) AS mois, " +
        "SUM(p.montant) AS total " +
        "FROM paiement p " +
        "JOIN reservation r ON p.id_reservation = r.id_reservation " +
        "GROUP BY mois " +
        "ORDER BY mois";

    PreparedStatement pst = Connect.getCon().prepareStatement(sql);
    ResultSet rs = pst.executeQuery();

    while (rs.next()) {
        Object[] ligne = new Object[2];
        ligne[0] = rs.getInt("mois");
        ligne[1] = rs.getDouble("total");
        liste.add(ligne);
    }

    return liste;
}
}