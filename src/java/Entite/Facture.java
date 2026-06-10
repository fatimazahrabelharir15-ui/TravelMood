package Entite;

import java.util.Date;


public class Facture {
   private String numero_facture;
   private int id_reservation,id_paiment;
   private Date date_facture;

    public Facture() {
    }

    public Facture(String numero_facture, int id_reservation, int id_paiment, Date date_facture) {
        this.numero_facture = numero_facture;
        this.id_reservation = id_reservation;
        this.id_paiment = id_paiment;
        this.date_facture = date_facture;
    }

    public String getNumero_facture() {
        return numero_facture;
    }

    public void setNumero_facture(String numero_facture) {
        this.numero_facture = numero_facture;
    }

    public int getId_reservation() {
        return id_reservation;
    }

    public void setId_reservation(int id_reservation) {
        this.id_reservation = id_reservation;
    }

    public int getId_paiment() {
        return id_paiment;
    }

    public void setId_paiment(int id_paiment) {
        this.id_paiment = id_paiment;
    }

    public Date getDate_facture() {
        return date_facture;
    }

    public void setDate_facture(Date date_facture) {
        this.date_facture = date_facture;
    }
   
   
   
}
