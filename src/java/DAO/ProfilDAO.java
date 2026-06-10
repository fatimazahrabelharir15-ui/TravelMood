package DAO;

import Entite.Profil;
import Entite.Reservation;
import Entite.Utilisateur;
import java.sql.*;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProfilDAO {
    
    public ArrayList<Reservation> listerReservation(Utilisateur us)throws SQLException{
        try {
            ArrayList<Reservation> list=new ArrayList<>();
            String sql="select * from reservation r inner join Utilisateur u on r.id_utilisateur=u.id_utilisateur"
                    + "inner join sejour s on s.id_sejour=r.id_sejour where id_utilisateur=?";
            PreparedStatement pst=Connect.getCon().prepareStatement(sql);
            pst.setInt(1, us.getId());
            ResultSet rs=pst.executeQuery(sql);
            while(rs.next()){
                list.add(new Reservation(rs.getInt(1),rs.getInt(2),rs.getInt(3),rs.getInt(4),rs.getInt(5),rs.getDate(6),rs.getDate(7),rs.getString(8)));
            }
            return list;
        } catch (Exception ex) {
            return null;
        }
        
    }
    public boolean saveProfil(Profil p,int id_utilisateur){
        try {
            String sql="insert into profil(Budget,preferences_voyage,id_type_vacance) values(?,?,?) ";
            PreparedStatement pst=Connect.getCon().prepareStatement(sql);
            pst.setFloat(1, p.getBudget());
            pst.setString(2,p.getPreference());
            pst.setInt(3,p.getTypeVacance());
            int n=pst.executeUpdate();
            return n!=0;
            
        } catch (Exception ex) {
            return false;
        }
    }
    public boolean updateProfil(Profil p,int id_utilisateur){
        try {
            String sql = "UPDATE profil SET budget = ?, preferences_voyage = ?, id_type_vacance = ? WHERE id_utilisateur = ?";            
            PreparedStatement pst=Connect.getCon().prepareStatement(sql);
            pst.setFloat(1, p.getBudget());
            pst.setString(2,p.getPreference());
            pst.setInt(3,p.getTypeVacance());
            int n=pst.executeUpdate();
            return n!=0;
            
        } catch (Exception ex) {
            return false;
        }
    }
    
}

