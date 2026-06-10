package DAO;

import Entite.Facture;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FactureDAO {
    public boolean saveFacture(Facture f)throws SQLException{
        try {
             String sql="insert into facture(numero_facture,id_reservation,id_paiement,date_facture) values(?,?,?,?)";
            PreparedStatement pst = Connect.getCon().prepareStatement(sql);
            pst.setString(1,f.getNumero_facture());
            pst.setInt(2,f.getId_reservation());
            pst.setInt(3,f.getId_paiment());
            pst.setDate(4, (Date) f.getDate_facture());
            int n=pst.executeUpdate();
            return n!=0;
        } catch (Exception e) {
            return false;
        }
       
    }
}
