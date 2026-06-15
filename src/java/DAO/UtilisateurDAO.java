package DAO;

import Entite.Utilisateur;
import java.sql.*;
import java.util.*;

public class UtilisateurDAO {
    public Utilisateur getUser(String login,String pwd) throws SQLException, Exception{
        String sql="select * from utilisateur where email=? and mot_de_passe=?";
        PreparedStatement pst = Connect.getCon().prepareStatement(sql);
        pst.setString(1, login);
        pst.setString(2, pwd);
        ResultSet rs=pst.executeQuery();
        Utilisateur us = null;
        while(rs.next()){
            us=new Utilisateur(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7));
        }
        return us;
    }
    public boolean saveUser(Utilisateur us) throws SQLException, Exception{
        String sql="insert into utilisateur(nom,prenom,email,telephone,mot_de_passe,role) values(?,?,?,?,?,?)";
        PreparedStatement pst = Connect.getCon().prepareStatement(sql);
        pst.setString(1,us.getNom());
        pst.setString(2,us.getPrenom());
        pst.setString(3,us.getEmail());
        pst.setString(4, us.getTelephone());
        pst.setString(5, us.getMotpass());
        pst.setString(6, us.getRole());
        int n=pst.executeUpdate();
        return n!=0;
    }
    public int countClients() throws Exception {

    String sql = "SELECT COUNT(*) FROM utilisateur WHERE role = 'client'";

    PreparedStatement pst = Connect.getCon().prepareStatement(sql);
    ResultSet rs = pst.executeQuery();

    if (rs.next()) {
        return rs.getInt(1);
    }

    return 0;
<<<<<<< HEAD
=======
}
>>>>>>> 49270c68072751f1f4f575846aba712c45c8b380
}
}