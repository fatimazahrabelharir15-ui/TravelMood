package DAO;

import Entite.Paiement;
import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
}
