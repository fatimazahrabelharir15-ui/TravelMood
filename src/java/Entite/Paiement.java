package Entite;


public class Paiement {
    private int id_paiement,id_reservation;
    private float montant;
    private String statut_paiement,methode_paiement;

    public Paiement() {
    }

    public Paiement(int id_paiement, int id_reservation, float montant, String statut_paiement, String methode_paiement) {
        this.id_paiement = id_paiement;
        this.id_reservation = id_reservation;
        this.montant = montant;
        this.statut_paiement = statut_paiement;
        this.methode_paiement = methode_paiement;
    }

    public int getId_paiement() {
        return id_paiement;
    }

    public void setId_paiement(int id_paiement) {
        this.id_paiement = id_paiement;
    }

    public int getId_reservation() {
        return id_reservation;
    }

    public void setId_reservation(int id_reservation) {
        this.id_reservation = id_reservation;
    }

    public float getMontant() {
        return montant;
    }

    public void setMontant(float montant) {
        this.montant = montant;
    }

    public String getStatut_paiement() {
        return statut_paiement;
    }

    public void setStatut_paiement(String statut_paiement) {
        this.statut_paiement = statut_paiement;
    }

    public String getMethode_paiement() {
        return methode_paiement;
    }

    public void setMethode_paiement(String methode_paiement) {
        this.methode_paiement = methode_paiement;
    }
    
    
    
}
