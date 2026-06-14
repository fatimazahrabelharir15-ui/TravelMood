package DAO;

import Entite.Sejour;
import Entite.TypeVacance;
import java.sql.*;
import java.util.ArrayList;

public class SejourDAO {
    public ArrayList<Sejour> getAll() throws SQLException, Exception{
        ArrayList<Sejour> list=new ArrayList<>();
        String sql = "SELECT * FROM sejour ORDER BY id_sejour DESC";
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
    rs.getString("type_vacance"),
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
    public boolean delete(int id) throws Exception {

    String sql =
            "DELETE FROM sejour WHERE id_sejour=?";

    PreparedStatement pst =
            Connect.getCon().prepareStatement(sql);

    pst.setInt(1, id);

    int n = pst.executeUpdate();

    return n > 0;
}
 
    public boolean add(Sejour s) throws Exception {

    String sql =
        "INSERT INTO sejour(titre, description, prix, type_vacance, humeur, image) VALUES (?, ?, ?, ?, ?, ?)";

    PreparedStatement pst =
        Connect.getCon().prepareStatement(sql);

    pst.setString(1, s.getTitre());
    pst.setString(2, s.getDescription());
    pst.setFloat(3, s.getPrix());
    pst.setString(4, s.getTypeVacance());
    pst.setString(5, s.getHumeur());
    pst.setString(6, s.getImage());

    int n = pst.executeUpdate();

    return n > 0;
}
    public boolean update(Sejour s) throws Exception {

    String sql =
        "UPDATE sejour SET titre=?, description=?, prix=?, type_vacance=?, humeur=?, image=? WHERE id_sejour=?";

    PreparedStatement pst =
        Connect.getCon().prepareStatement(sql);

    pst.setString(1, s.getTitre());
    pst.setString(2, s.getDescription());
    pst.setFloat(3, s.getPrix());
    pst.setString(4, s.getTypeVacance());
    pst.setString(5, s.getHumeur());
    pst.setString(6, s.getImage());
    pst.setInt(7, s.getId());

    int n = pst.executeUpdate();

    return n > 0;
}
    public int countSejours() throws Exception {

    String sql = "SELECT COUNT(*) FROM sejour";

    Statement st = Connect.getCon().createStatement();

    ResultSet rs = st.executeQuery(sql);

    if (rs.next()) {
        return rs.getInt(1);
    }

    return 0;
}
    public ArrayList<String> getAllHumeurs() throws Exception {

    ArrayList<String> liste = new ArrayList<>();

    String sql = "SELECT DISTINCT humeur FROM sejour ORDER BY humeur";

    Statement st = Connect.getCon().createStatement();
    ResultSet rs = st.executeQuery(sql);

    while (rs.next()) {
        liste.add(rs.getString("humeur"));
    }

    return liste;
}
    public ArrayList<String> getAllTypesVacance() throws Exception {

    ArrayList<String> liste = new ArrayList<>();

    String sql = "SELECT DISTINCT type_vacance FROM sejour ORDER BY type_vacance";

    Statement st = Connect.getCon().createStatement();
    ResultSet rs = st.executeQuery(sql);

    while (rs.next()) {
        liste.add(rs.getString("type_vacance"));
    }

    return liste;
}
}
