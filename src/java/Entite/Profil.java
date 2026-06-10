package Entite;

public class Profil {
    private int id,idUtilisateur,typeVacance;
    private String preference;
    private float budget;

    public Profil() {
    }

    public Profil(int id, int idUtilisateur, String preference, int typeVacance, float budget) {
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

    public int getTypeVacance() {
        return typeVacance;
    }

    public void setTypeVacance(int typeVacance) {
        this.typeVacance = typeVacance;
    }

    public float getBudget() {
        return budget;
    }

    public void setBudget(float budget) {
        this.budget = budget;
    }
    
}
