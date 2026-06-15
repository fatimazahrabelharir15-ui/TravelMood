package controller;

import DAO.QuizDAO;
import DAO.SejourDAO;
import Entite.Sejour;
import Entite.Utilisateur;
import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "QuizControlleur", urlPatterns = {"/QuizControlleur"})
public class QuizControlleur extends HttpServlet {

    // GET : Prépare l'affichage du Quiz avec les données de la BDD
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Utilisation du DAO pour récupérer les questions lister dans la BDD
        List<Map<String, Object>> quizDynamique = QuizDAO.getAllQuestions();
        
        // Pour chaque question, on lui injecte ses réponses dynamiques via le DAO
        for (Map<String, Object> question : quizDynamique) {
            int idQ = (Integer) question.get("id");
            List<Map<String, Object>> reponses = QuizDAO.getReponsesByQuestion(idQ);
            question.put("reponses", reponses);
        }

        request.setAttribute("quizDynamique", quizDynamique);
        request.getRequestDispatcher("/recommande.jsp").forward(request, response);
    }

    // POST : Traite les réponses choisies, détermine l'humeur majoritaire et enregistre
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");
        int idUtilisateur = (user != null) ? user.getId() : 2; // Par défaut Malak pour les tests

        // Récupérer les IDs des réponses choisies par l'utilisateur
        Enumeration<String> parameterNames = request.getParameterNames();
        List<Integer> reponsesChoisies = new ArrayList<>();

        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            if (paramName.startsWith("reponse_")) {
                reponsesChoisies.add(Integer.parseInt(request.getParameter(paramName)));
            }
        }

        int idTypeVacanceGagnant = 1; // Par défaut : Détente
        Sejour sejourRecommande = null;

        if (!reponsesChoisies.isEmpty()) {
            Map<Integer, Integer> compteurType = new HashMap<>();
            
            // On calcule l'humeur spécifique à chaque réponse choisie
            for (int idRep : reponsesChoisies) {
                int idType = QuizDAO.getTypeVacanceByReponse(idRep);
                compteurType.put(idType, compteurType.getOrDefault(idType, 0) + 1);
            }

            // Extraction du type de vacances majoritaire (Gagnant)
            idTypeVacanceGagnant = Collections.max(compteurType.entrySet(), Map.Entry.comparingByValue()).getKey();
        }

        // Étape A & B : Enregistrement du questionnaire et sélection du séjour idéal via le DAO
        int idQuestionnaire = QuizDAO.insertQuestionnaire(idUtilisateur, idTypeVacanceGagnant);
        sejourRecommande = SejourDAO.getSejourRecommande(idTypeVacanceGagnant);

        // Étape C : Liaison finale dans la table recommandation
        if (sejourRecommande != null && idQuestionnaire != 0) {
            QuizDAO.insertRecommandation(idQuestionnaire, sejourRecommande.getId());
        }

        request.setAttribute("sejourRecommande", sejourRecommande);
        request.getRequestDispatcher("/recommande.jsp").forward(request, response);
    }
}