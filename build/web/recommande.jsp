<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<%
    // On récupère la liste dynamique envoyée par le QuizControlleur (doGet)
    List<Map<String, Object>> quizDynamique = (List<Map<String, Object>>) request.getAttribute("quizDynamique");
%>

<div class="row mt-4">
    <div class="col-md-8 mx-auto">
        <div class="text-center mb-4">
            <h2 class="fw-bold" style="color: #0D3249;">Trouvez votre voyage idéal</h2>
            <p class="text-muted">Répondez aux questions pour obtenir votre recommandation sur-mesure.</p>
        </div>

        <div class="card shadow-sm border-0 p-4 p-md-5 bg-white rounded-3">
            
            <%-- SI L'UTILISATEUR N'A PAS ENCORE SOUMIS LE QUIZ --%>
            <% if (request.getAttribute("sejourRecommande") == null && quizDynamique != null) { %>
            <form id="quizForm" action="QuizControlleur" method="POST" onsubmit="return validerDerniereEtape(<%= quizDynamique.get(quizDynamique.size() - 1).get("id") %>)">
                
                <% 
                int step = 1;
                int totalSteps = quizDynamique.size();
                
                // BOUCLE 1 : On parcourt chaque question de la BDD
                for (Map<String, Object> q : quizDynamique) { 
                    int idQ = (Integer) q.get("id");
                    String titreQ = (String) q.get("titre");
                    List<Map<String, Object>> reponses = (List<Map<String, Object>>) q.get("reponses");
                %>
                    <div id="q<%= step %>" class="quiz-step <%= (step == 1) ? "d-block" : "d-none" %>" data-idquestion="<%= idQ %>">
                        <h4 class="fw-bold mb-4 text-center" style="color: #0D3249;"><%= titreQ %></h4>
                        
                        <input type="hidden" id="hidden-q<%= idQ %>" name="reponse_<%= idQ %>" value="">

                        <div class="alert alert-warning py-2 text-center d-none alerte-selection" id="alerte-q<%= idQ %>">
                            ⚠️ Veuillez sélectionner une réponse avant de continuer.
                        </div>

                        <div class="row g-3">
                            <% 
                            // BOUCLE 2 : On parcourt toutes les réponses liées à cette question
                            if (reponses != null) {
                                for (Map<String, Object> r : reponses) { 
                            %>
                                <div class="col-sm-6">
                                    <button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" 
                                            onclick="selectOption(<%= idQ %>, <%= r.get("id_reponse") %>, this)">
                                        <span class="fs-2 d-block mb-2"><%= r.get("icone") %></span>
                                        <%= r.get("texte") %>
                                    </button>
                                </div>
                            <% 
                                } 
                            }
                            %>
                        </div>
                        
                        <div class="d-flex <%= (step == 1) ? "justify-content-end" : "justify-content-between" %> mt-4">
                            <% if (step > 1) { %>
                                <button type="button" class="btn btn-outline-secondary px-4" onclick="retourStep(<%= step - 1 %>)">⬅️ Retour</button>
                            <% } %>
                            
                            <% if (step < totalSteps) { %>
                                <button type="button" class="btn text-white px-4" style="background-color: #0D3249;" onclick="nextStep(<%= step %>)">Suivant ➡️</button>
                            <% } else { %>
                                <button type="submit" class="btn btn-warning fw-bold px-4 text-white" style="background-color: #E86E4D; border-color: #E86E4D;">✨ Découvrir mon voyage idéal</button>
                            <% } %>
                        </div>
                    </div>
                <% 
                    step++;
                } 
                %>
            </form>
            <% } else if (quizDynamique == null && request.getAttribute("sejourRecommande") == null) { %>
                <div class="alert alert-danger text-center">
                    ⚠️ Erreur : Impossible de charger les questions depuis la base de données. Vérifiez votre QuizControlleur.
                </div>
            <% } %>

            <%-- AFFICHAGE DU RÉSULTAT DU SÉJOUR RECOMMANDÉ --%>
            <% if (request.getAttribute("sejourRecommande") != null) { 
                Entite.Sejour sj = (Entite.Sejour) request.getAttribute("sejourRecommande");
            %>
                <div class="text-center py-4">
                    <h3 class="fw-bold mb-3" style="color: #0D3249;">🎉 Voici votre recommandation !</h3>
                    <div class="card border-0 shadow-sm mx-auto bg-light p-4 mb-4" style="max-width: 450px;">
                        <img src="images/<%= sj.getImage() %>" class="img-fluid rounded mb-3" style="height:220px; object-fit:cover;" onerror="this.src='images/default.jpeg'">
                        <h4 class="fw-bold text-dark"><%= sj.getTitre() %></h4>
                        <p class="text-muted small"><%= sj.getDescription() %></p>
                        <h5 class="fw-bold text-danger my-3"><%= sj.getPrix() %> DH</h5>
                        <a href="DetailControlleur?idSejour=<%= sj.getId() %>" class="btn text-white w-100 fw-bold" style="background-color: #E86E4D;">🔍 Découvrir ce séjour</a>
                    </div>
                    <a href="QuizControlleur" class="btn btn-outline-secondary btn-sm">🔄 Recommencer le test</a>
                </div>
            <% } %>

        </div>
    </div>
</div>

<script>
    // Gère la sélection visuelle et stocke l'ID de la réponse dans l'input masqué
    function selectOption(idQuestion, idReponse, btn) {
        document.getElementById('hidden-q' + idQuestion).value = idReponse;
        
        // Masquer l'alerte si elle était affichée
        document.getElementById('alerte-q' + idQuestion).classList.add('d-none');
        
        const parent = btn.closest('.row');
        parent.querySelectorAll('.option-btn').forEach(b => {
            b.classList.remove('btn-dark', 'text-white');
            b.classList.add('btn-outline-dark');
        });
        btn.classList.remove('btn-outline-dark');
        btn.classList.add('btn-dark', 'text-white');
    }

    // Fonction Suivant modifiée avec contrôle de sélection
    function nextStep(currentStep) {
        // Récupérer l'élément de l'étape actuelle
        const currentDiv = document.getElementById('q' + currentStep);
        const idQuestion = currentDiv.getAttribute('data-idquestion');
        const valeurReponse = document.getElementById('hidden-q' + idQuestion).value;

        // Si l'input masqué est vide, on bloque le passage et on affiche l'alerte
        if (valeurReponse === "") {
            document.getElementById('alerte-q' + idQuestion).classList.remove('d-none');
            return; // Bloque l'exécution
        }

        // Sinon, on passe normalement à l'étape suivante
        currentDiv.classList.remove('d-block');
        currentDiv.classList.add('d-none');
        
        const nextDiv = document.getElementById('q' + (currentStep + 1));
        nextDiv.classList.remove('d-none');
        nextDiv.classList.add('d-block');
    }

    // Fonction de retour simple (pas besoin de valider pour reculer)
    function retourStep(previousStep) {
        document.querySelectorAll('.quiz-step').forEach(step => {
            step.classList.remove('d-block');
            step.classList.add('d-none');
        });
        document.getElementById('q' + previousStep).classList.remove('d-none');
        document.getElementById('q' + previousStep).classList.add('d-block');
    }

    // Vérification finale lors du submit sur la dernière question
    function validerDerniereEtape(idDerniereQuestion) {
        const valeurReponse = document.getElementById('hidden-q' + idDerniereQuestion).value;
        if (valeurReponse === "") {
            document.getElementById('alerte-q' + idDerniereQuestion).classList.remove('d-none');
            return false; // Empêche l'envoi du formulaire au contrôleur
        }
        return true;
    }
</script>
<jsp:include page="footer.jsp" />