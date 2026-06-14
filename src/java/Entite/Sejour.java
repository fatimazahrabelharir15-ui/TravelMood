package Entite;
public class Sejour {
    private int id;
    private String type_vacance;
    private String titre,description,humeur,image;
    private float prix;

    public Sejour() {
    }

    public Sejour(int id, String titre, String description, String humeur, String image, float prix) {
        this.id = id;
        this.titre = titre;
        this.description = description;
        this.humeur = humeur;
        this.image = image;
        this.prix = prix;
    }

    public Sejour(int id,
              String typeVacance,
              String titre,
              String description,
              String humeur,
              String image,
              float prix) {

    this.id = id;
    this.type_vacance = typeVacance;
    this.titre = titre;
    this.description = description;
    this.humeur = humeur;
    this.image = image;
    this.prix = prix;
}
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getHumeur() {
        return humeur;
    }

    public void setHumeur(String humeur) {
        this.humeur = humeur;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public float getPrix() {
        return prix;
    }

    public void setPrix(float prix) {
        this.prix = prix;
    }

   public String getTypeVacance() {
    return type_vacance;
}

public void setTypeVacance(String typeVacance) {
    this.type_vacance = typeVacance;
}
    
    
}
