package Entite;

public class Profil {
    private int id,idUtilisateur;
    private String preference,typeVacance;
    private double budget;

    public Profil() {
    }

    public Profil(int id, int idUtilisateur, String preference, String typeVacance, double budget) {
        this.id = id;
        this.idUtilisateur = idUtilisateur;
        this.preference = preference;
        this.typeVacance = typeVacance;
        this.budget = budget;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(int idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

    public String getPreference() {
        return preference;
    }

    public void setPreference(String preference) {
        this.preference = preference;
    }

    public String getTypeVacance() {
        return typeVacance;
    }

    public void setTypeVacance(String typeVacance) {
        this.typeVacance = typeVacance;
    }

    public double getBudget() {
        return budget;
    }

    public void setBudget(double budget) {
        this.budget = budget;
    }
    
}
