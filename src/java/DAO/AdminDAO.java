package DAO;

import Entite.Admin;
import java.sql.*;


public class AdminDAO {

    public Admin getAdminByEmail(String email)
            throws Exception {

        String sql =
        "SELECT * FROM utilisateur " +
        "WHERE email=? AND role='admin'";

        PreparedStatement pst =
        Connect.getCon().prepareStatement(sql);

        pst.setString(1, email);

        ResultSet rs = pst.executeQuery();

        Admin admin = null;

        if(rs.next()) {

            admin = new Admin(
                rs.getInt("id_utilisateur"),
                rs.getString("nom"),
                rs.getString("prenom"),
                rs.getString("email")
            );
        }

        return admin;
    }
}