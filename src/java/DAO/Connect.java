package DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class Connect {
    private static Connection con;

    private Connect() {}

    public static Connection getCon() throws Exception { // On propage l'erreur au lieu de la cacher
        if (con == null || con.isClosed()) {
            // 1. Force le chargement du Driver
            Class.forName("org.postgresql.Driver");
            
            // 2. Tentative de connexion
           con = DriverManager.getConnection(
    "jdbc:postgresql://localhost:5432/travelmood",
    "postgres",
    "NouveauMotDePasse123"
);      }
        return con;
    }
}