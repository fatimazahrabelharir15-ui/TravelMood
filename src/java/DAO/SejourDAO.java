package DAO;

import Entite.Sejour;
import Entite.TypeVacance;
import java.sql.*;
import java.util.ArrayList;

public class SejourDAO {
    public ArrayList<Sejour> getAll() throws SQLException, Exception{
        ArrayList<Sejour> list=new ArrayList<>();
        String sql="select * from sejour ";
        Statement st=Connect.getCon().createStatement();
        ResultSet rs=st.executeQuery(sql);
        while(rs.next()){
            list.add(new Sejour(rs.getInt("id_sejour"),rs.getString("titre"),rs.getString("description"),rs.getString("humeur"),rs.getString("image"),rs.getFloat("prix")));
        }
        return list;
    }
    public ArrayList<Sejour> getSejoursByHumeur(String humeurFiltre) throws Exception {
        ArrayList<Sejour> list = new ArrayList<>();
        String sql;
        PreparedStatement ps;
        Connection con = Connect.getCon();

        // Si le filtre est "tous", on prend tout, sinon on filtre par l'humeur
        if (humeurFiltre == null || humeurFiltre.equalsIgnoreCase("tous")) {
            sql = "SELECT * FROM sejour";
            ps = con.prepareStatement(sql);
        } else {
            sql = "SELECT * FROM sejour WHERE LOWER(humeur) = LOWER(?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, humeurFiltre);
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(new Sejour(
                rs.getInt("id_sejour"),
                rs.getString("titre"),
                rs.getString("description"),
                rs.getString("humeur"),
                rs.getString("image"),
                rs.getFloat("prix")
            ));
        }
        
        rs.close();
        ps.close();
        return list;
    }
    public ArrayList<TypeVacance> getAllTypeVacance() throws SQLException{
        try {
            ArrayList<TypeVacance> list=new ArrayList<>();
            String sql="select * from type_vacance";
            Statement st=Connect.getCon().createStatement();
            ResultSet rs=st.executeQuery(sql);
            while(rs.next()){
                list.add(new TypeVacance(rs.getInt(1),rs.getString(2)));
            }
            return list;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;   
    }
    public ArrayList<Sejour> getSejoursByTypeVacance(int idTypeFiltre) throws Exception {
    ArrayList<Sejour> list = new ArrayList<>();
    String sql= "SELECT * FROM sejour WHERE id_type_vacance = ?";
    PreparedStatement ps;

    // Si l'ID est 0, on récupère tout. Sinon, on filtre par la clé étrangère
    if (idTypeFiltre == 0) {
        sql = "SELECT * FROM sejour";
        ps = Connect.getCon().prepareStatement(sql);
    } else {
        ps = Connect.getCon().prepareStatement(sql);
        ps.setInt(1, idTypeFiltre);
    }

    ResultSet rs = ps.executeQuery();
    while (rs.next()) {
        list.add(new Sejour(
            rs.getInt("id_sejour"),
            rs.getString("titre"),
            rs.getString("description"),
            rs.getString("humeur"),
            rs.getString("image"),
            rs.getFloat("prix")
        ));
    }
    rs.close();
    ps.close();
    return list;
}
   public Sejour getOneDetail(int id) {
    try {
        String sql = "SELECT * FROM sejour WHERE id_sejour = ?";
        PreparedStatement pst = Connect.getCon().prepareStatement(sql);
        pst.setInt(1, id);
        ResultSet rs = pst.executeQuery();
        
        if (rs.next()) {
            return new Sejour(
                rs.getInt("id_sejour"),
                rs.getString("titre"),
                rs.getString("description"),
                rs.getString("humeur"),
                rs.getString("image"),
                rs.getFloat("prix")
            );
        }
    } catch (Exception ex) {
        // Reste ici pour intercepter les vraies erreurs sans faire crasher Tomcat
        ex.printStackTrace(); 
    }
    return null;
}
    
    
}
