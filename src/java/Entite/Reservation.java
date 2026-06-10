package Entite;

import java.util.Date;

public class Reservation {
    private int id_reservation,id_Utilisateur,id_Sejour,nbr_chambre,nb_places;
    private Date date_depart,date_arrivee;
    private String statut;

    public Reservation() {
    }

    public Reservation(int id_reservation, int id_Utilisateur, int id_Sejour, int nbr_chambre, int nb_places, Date date_depart, Date date_arrivee, String statut) {
        this.id_reservation = id_reservation;
        this.id_Utilisateur = id_Utilisateur;
        this.id_Sejour = id_Sejour;
        this.nbr_chambre = nbr_chambre;
        this.nb_places = nb_places;
        this.date_depart = date_depart;
        this.date_arrivee = date_arrivee;
        this.statut = statut;
    }

    public int getId_reservation() {
        return id_reservation;
    }

    public void setId_reservation(int id_reservation) {
        this.id_reservation = id_reservation;
    }

    public int getId_Utilisateur() {
        return id_Utilisateur;
    }

    public void setId_Utilisateur(int id_Utilisateur) {
        this.id_Utilisateur = id_Utilisateur;
    }

    public int getId_Sejour() {
        return id_Sejour;
    }

    public void setId_Sejour(int id_Sejour) {
        this.id_Sejour = id_Sejour;
    }

    public int getNbr_chambre() {
        return nbr_chambre;
    }

    public void setNbr_chambre(int nbr_chambre) {
        this.nbr_chambre = nbr_chambre;
    }

    public int getNb_places() {
        return nb_places;
    }

    public void setNb_places(int nb_places) {
        this.nb_places = nb_places;
    }

    public Date getDate_depart() {
        return date_depart;
    }

    public void setDate_depart(Date date_depart) {
        this.date_depart = date_depart;
    }

    public Date getDate_arrivee() {
        return date_arrivee;
    }

    public void setDate_arrivee(Date date_arrivee) {
        this.date_arrivee = date_arrivee;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }
    
}
