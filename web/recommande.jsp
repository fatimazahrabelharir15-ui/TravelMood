<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<div class="row mt-4">
    <div class="col-md-8 mx-auto">
        
        <div class="text-center mb-4">
            <h2 class="fw-bold" style="color: #0D3249;">Trouvez votre voyage idéal</h2>
            <p class="text-muted">Répondez à des questions rapides pour découvrir la destination faite pour vous.</p>
            
            <div class="progress mt-3" style="height: 10px;">
                <div id="quiz-progress" class="progress-bar progress-bar-striped progress-bar-animated" 
                     role="progressbar" style="width: 25%; background-color: #3B8FB5;"></div>
            </div>
        </div>

        <div class="card shadow-sm border-0 p-4 p-md-5 bg-white rounded-3">
            
            <div id="q1" class="quiz-step d-block">
                <h4 class="fw-bold mb-4 text-center" style="color: #0D3249;">1. Quelle est votre humeur ou envie actuelle ?</h4>
                <div class="row g-3">
                    <div class="col-sm-6">
                        <button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="selectHumeur('detente', this)">
                            <span class="fs-2 d-block mb-2">🏖️</span> Besoin de me détendre & bronzer
                        </button>
                    </div>
                    <div class="col-sm-6">
                        <button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="selectHumeur('aventure', this)">
                            <span class="fs-2 d-block mb-2">🏔️</span> Envie d'aventure & de bouger
                        </button>
                    </div>
                    <div class="col-sm-6">
                        <button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="selectHumeur('culture', this)">
                            <span class="fs-2 d-block mb-2">🏛️</span> Curieux d'histoire & de culture
                        </button>
                    </div>
                    <div class="col-sm-6">
                        <button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="selectHumeur('luxe', this)">
                            <span class="fs-2 d-block mb-2">🌴</span> Envie de luxe & d'exclusivité
                        </button>
                    </div>
                </div>
                <div class="text-end mt-4">
                    <button type="button" class="btn text-white px-4" style="background-color: #0D3249;" onclick="nextStep(2)">Suivant ➡️</button>
                </div>
            </div>

            <div id="q2" class="quiz-step d-none">
                <h4 class="fw-bold mb-4 text-center" style="color: #0D3249;">2. Avec qui allez-vous voyager ?</h4>
                <div class="row g-3">
                    <div class="col-sm-6"><button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="highlightBtn(this)">👤 Seul(e)</button></div>
                    <div class="col-sm-6"><button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="highlightBtn(this)">💑 En couple</button></div>
                    <div class="col-sm-6"><button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="highlightBtn(this)">👨‍👩‍👧 En famille</button></div>
                    <div class="col-sm-6"><button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="highlightBtn(this)">👥 Entre amis</button></div>
                </div>
                <div class="d-flex justify-content-between mt-4">
                    <button type="button" class="btn btn-outline-secondary px-4" onclick="nextStep(1)">⬅️ Retour</button>
                    <button type="button" class="btn text-white px-4" style="background-color: #0D3249;" onclick="nextStep(3)">Suivant ➡️</button>
                </div>
            </div>

            <div id="q3" class="quiz-step d-none">
                <h4 class="fw-bold mb-4 text-center" style="color: #0D3249;">3. Quelle est la durée idéale de votre séjour ?</h4>
                <div class="row g-3">
                    <div class="col-sm-4"><button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="highlightBtn(this)">⏱️ Court (3 à 5 jours)</button></div>
                    <div class="col-sm-4"><button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="highlightBtn(this)">🗓️ Standard (1 semaine)</button></div>
                    <div class="col-sm-4"><button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="highlightBtn(this)">✈️ Long (10 jours ou +)</button></div>
                </div>
                <div class="d-flex justify-content-between mt-4">
                    <button type="button" class="btn btn-outline-secondary px-4" onclick="nextStep(2)">⬅️ Retour</button>
                    <button type="button" class="btn text-white px-4" style="background-color: #0D3249;" onclick="nextStep(4)">Suivant ➡️</button>
                </div>
            </div>

            <div id="q4" class="quiz-step d-none">
                <h4 class="fw-bold mb-4 text-center" style="color: #0D3249;">4. Quel est votre budget estimé par personne ?</h4>
                <div class="row g-3">
                    <div class="col-sm-4"><button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="highlightBtn(this)">💰 Économique (< 800€)</button></div>
                    <div class="col-sm-4"><button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="highlightBtn(this)">💳 Moyen (800€ - 2000€)</button></div>
                    <div class="col-sm-4"><button type="button" class="btn btn-outline-dark w-100 py-3 option-btn" onclick="highlightBtn(this)">💎 Premium (> 2000€)</button></div>
                </div>
                <div class="d-flex justify-content-between mt-4">
                    <button type="button" class="btn btn-outline-secondary px-4" onclick="nextStep(3)">⬅️ Retour</button>
                    <button type="button" class="btn btn-warning fw-bold px-4 text-white" style="background-color: #E86E4D; border-color: #E86E4D;" onclick="showResults()">✨ Voir mon résultat</button>
                </div>
            </div>

            <div id="q-results" class="quiz-step d-none text-center py-4">
                <h3 class="fw-bold mb-3" style="color: #0D3249;">🎉 Voici votre recommandation !</h3>
                <p class="text-muted mb-4">D'après vos réponses, voici le séjour TravelMood idéal pour vous :</p>
                
                <div class="card border-0 shadow-sm mx-auto bg-light p-4 mb-4" style="max-width: 450px;">
                    <div id="res-icone" class="display-1 mb-2">🏖️</div>
                    <h4 id="res-titre" class="fw-bold text-dark">Destination</h4>
                    <p id="res-desc" class="text-muted small">Description courte...</p>
                    <h5 id="res-prix" class="fw-bold text-danger my-3">0 €</h5>
                    
                    <a id="res-lien" href="#" class="btn text-white w-100 fw-bold" style="background-color: #E86E4D;">
                        🔍 Découvrir ce séjour en détail
                    </a>
                </div>
                
                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="resetQuiz()">🔄 Recommencer le test</button>
            </div>

        </div>
    </div>
</div>

<script>
    // Variable globale pour stocker l'humeur choisie à la question 1
    let humeurChoisie = "detente";

    // Fonction pour styliser le bouton sélectionné dans une question
    function highlightBtn(btn) {
        // Supprime la sélection des autres boutons de la même question
        const parent = btn.closest('.row');
        parent.querySelectorAll('.option-btn').forEach(b => {
            b.classList.remove('btn-dark', 'text-white');
            b.classList.add('btn-outline-dark');
        });
        // Active le bouton cliqué
        btn.classList.remove('btn-outline-dark');
        btn.classList.add('btn-dark', 'text-white');
    }

    // Fonction spéciale pour la question 1 (Enregistre l'humeur)
    function selectHumeur(humeur, btn) {
        humeurChoisie = humeur;
        highlightBtn(btn);
    }

    // Fonction pour naviguer entre les étapes (1, 2, 3, 4)
    function nextStep(stepNumber) {
        // Masquer toutes les étapes
        document.querySelectorAll('.quiz-step').forEach(step => {
            step.classList.remove('d-block');
            step.classList.add('d-none');
        });
        // Afficher l'étape demandée
        document.getElementById('q' + stepNumber).classList.remove('d-none');
        document.getElementById('q' + stepNumber).classList.add('d-block');
        
        // Mettre à jour la barre de progression
        const progressPercent = stepNumber * 25;
        document.getElementById('quiz-progress').style.width = progressPercent + '%';
    }

    // Fonction pour calculer et afficher le résultat
    function showResults() {
        // Masquer l'étape 4
        document.getElementById('q4').classList.remove('d-block');
        document.getElementById('q4').classList.add('d-none');
        
        // Afficher la section résultats
        document.getElementById('q-results').classList.remove('d-none');
        document.getElementById('q-results').classList.add('d-block');
        document.getElementById('quiz-progress').style.width = '100%';
        
        // Configuration dynamique du résultat selon l'humeur stockée
        const resIcone = document.getElementById('res-icone');
        const resTitre = document.getElementById('res-titre');
        const resDesc = document.getElementById('res-desc');
        const resPrix = document.getElementById('res-prix');
        const resLien = document.getElementById('res-lien');
        
        if (humeurChoisie === 'detente') {
            resIcone.innerText = "🏖️";
            resTitre.innerText = "Bali — Détente absolue";
            resDesc.innerText = "7 nuits en hébergement 4★ avec spa, idéal pour recharger vos batteries.";
            resPrix.innerText = "1 290 €";
            resLien.href = "details.jsp?idSejour=1";
        } else if (humeurChoisie === 'aventure') {
            resIcone.innerText = "🏔️";
            resTitre.innerText = "Atlas — Trek & Randonnée";
            resDesc.innerText = "5 nuits d'immersion totale et de paysages montagneux à couper le souffle.";
            resPrix.innerText = "690 €";
            resLien.href = "details.jsp?idSejour=2";
        } else if (humeurChoisie === 'culture') {
            resIcone.innerText = "🏛️";
            resTitre.innerText = "Rome — Histoire & Gastronomie";
            resDesc.innerText = "4 nuits au centre de la ville éternelle avec billets coupe-file inclus.";
            resPrix.innerText = "980 €";
            resLien.href = "details.jsp?idSejour=3";
        } else if (humeurChoisie === 'luxe') {
            resIcone.innerText = "🌴";
            resTitre.innerText = "Maldives — Bungalow Pilotis";
            resDesc.innerText = "10 nuits d'évasion haut de gamme suspendu au-dessus d'un lagon bleu turquoise.";
            resPrix.innerText = "3 450 €";
            resLien.href = "details.jsp?idSejour=4";
        }
    }

    // Fonction pour relancer le Quiz à zéro
    function resetQuiz() {
        humeurChoisie = "detente";
        // Enlever la sélection colorée de tous les boutons
        document.querySelectorAll('.option-btn').forEach(b => {
            b.classList.remove('btn-dark', 'text-white');
            b.classList.add('btn-outline-dark');
        });
        nextStep(1);
    }
</script>

<jsp:include page="footer.jsp" />