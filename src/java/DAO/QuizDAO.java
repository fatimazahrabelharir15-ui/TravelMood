package DAO;

import Entite.Sejour;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class QuizDAO {

    // 1. Charger toutes les questions triées par ordre d'affichage
    public static List<Map<String, Object>> getAllQuestions() {
        List<Map<String, Object>> questions = new ArrayList<>();
        String sql = "SELECT * FROM question ORDER BY ordre_affichage";
        try {
            PreparedStatement pst = Connect.getCon().prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Map<String, Object> q = new HashMap<>();
                q.put("id", rs.getInt("id_question"));
                q.put("titre", rs.getString("titre_question"));
                questions.add(q);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return questions;
    }

    // 2. Charger les réponses associées à une question spécifique
    public static List<Map<String, Object>> getReponsesByQuestion(int idQuestion) {
        List<Map<String, Object>> reponses = new ArrayList<>();
        String sql = "SELECT * FROM reponse WHERE id_question = ?";
        try {
            PreparedStatement pst = Connect.getCon().prepareStatement(sql);
            pst.setInt(1, idQuestion);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Map<String, Object> r = new HashMap<>();
                r.put("id_reponse", rs.getInt("id_reponse"));
                r.put("texte", rs.getString("texte_reponse"));
                r.put("icone", rs.getString("icone"));
                reponses.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reponses;
    }

    // 3. Récupérer l'id_type_vacance associé à un ID de réponse précis
    public static int getTypeVacanceByReponse(int idReponse) {
        String sql = "SELECT id_type_vacance FROM reponse WHERE id_reponse = ?";
        try {
            PreparedStatement pst = Connect.getCon().prepareStatement(sql);
            pst.setInt(1, idReponse);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt("id_type_vacance");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 1; // Valeur par défaut (Détente) si problème
    }

    // 4. Enregistrer le questionnaire en BDD et retourner l'ID généré (SERIAL)
    public static int insertQuestionnaire(int idUtilisateur, int idTypeVacanceFinal) {
    // On garde uniquement les colonnes qui existent vraiment dans ta table !
    String sql = "INSERT INTO questionnaire (id_utilisateur, id_type_vacance_final) VALUES (?, ?)";
    try {
        PreparedStatement pst = Connect.getCon().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        pst.setInt(1, idUtilisateur);
        pst.setInt(2, idTypeVacanceFinal);
        pst.executeUpdate();
        
        ResultSet rsKeys = pst.getGeneratedKeys();
        if (rsKeys.next()) {
            return rsKeys.getInt(1); // Retourne l'id_questionnaire généré
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

    // 5. Enregistrer le résultat final calculé dans la table recommandation
    public static void insertRecommandation(int idQuestionnaire, int idSejour) {
        String sql = "INSERT INTO recommandation (id_questionnaire, id_sejour, score_compatibilite) VALUES (?, ?, 100)";
        try {
            PreparedStatement pst = Connect.getCon().prepareStatement(sql);
            pst.setInt(1, idQuestionnaire);
            pst.setInt(2, idSejour);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}