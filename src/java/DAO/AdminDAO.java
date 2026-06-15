<<<<<<< HEAD
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
=======
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
>>>>>>> 49270c68072751f1f4f575846aba712c45c8b380
}