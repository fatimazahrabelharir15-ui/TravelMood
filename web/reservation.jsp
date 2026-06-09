<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<%
    // 2. RÉCUPÉRATION DE L'ID DU SÉJOUR POUR LE RÉCAPITULATIF
    String idParam = request.getParameter("idSejour");
    
    String titre = "Séjour Général";
    String icone = "✈️";
    String prixTexte = "Sur devis";
    int prixUnitaire = 0;

    // Simulation des données (comme sur les autres pages)
    if (idParam != null) {
        if (idParam.equals("1")) {
            titre = "Bali — Détente & Plages"; icone = "🏖️"; prixTexte = "1 290 €"; prixUnitaire = 1290;
        } else if (idParam.equals("2")) {
            titre = "Atlas — Trek & Aventure"; icone = "🏔️"; prixTexte = "690 €"; prixUnitaire = 690;
        } else if (idParam.equals("3")) {
            titre = "Rome — Culture & Histoire"; icone = "🏛️"; prixTexte = "980 €"; prixUnitaire = 980;
        } else if (idParam.equals("4")) {
            titre = "Maldives — Luxe & Évasion"; icone = "🌴"; prixTexte = "3 450 €"; prixUnitaire = 3450;
        }
    }
%>

<div class="row mt-4 g-4">
    
    <div class="col-md-8">
        <div class="card shadow-sm border-0 p-4 bg-white rounded-3">
            <h3 class="fw-bold mb-4" style="color: #0D3249;">📋 Informations de réservation</h3>
            
            <form action="confirmation.jsp" method="POST" class="needs-validation">
                
                <input type="hidden" name="idSejour" value="<%= idParam %>">

                <div class="row g-3 mb-3">
                    <div class="col-sm-6">
                        <label for="nom" class="form-label fw-medium text-secondary">Nom *</label>
                        <input type="text" class="form-control" id="nom" name="nom" required placeholder="Ex: Dupont">
                    </div>
                    <div class="col-sm-6">
                        <label for="prenom" class="form-label fw-medium text-secondary">Prénom *</label>
                        <input type="text" class="form-control" id="prenom" name="prenom" required placeholder="Ex: Jean">
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-sm-6">
                        <label for="email" class="form-label fw-medium text-secondary">Adresse Email *</label>
                        <input type="email" class="form-control" id="email" name="email" required placeholder="nom@exemple.com">
                    </div>
                    <div class="col-sm-6">
                        <label for="telephone" class="form-label fw-medium text-secondary">Téléphone *</label>
                        <input type="tel" class="form-control" id="telephone" name="telephone" required placeholder="Ex: +212 6... ou 06...">
                    </div>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-sm-6">
                        <label for="dateDepart" class="form-label fw-medium text-secondary">Date de départ souhaitée *</label>
                        <input type="date" class="form-control" id="dateDepart" name="dateDepart" required>
                    </div>
                    <div class="col-sm-6">
                        <label for="voyageurs" class="form-label fw-medium text-secondary">Nombre de voyageurs *</label>
                        <input type="number" class="form-control" id="voyageurs" name="voyageurs" min="1" max="10" value="1" required onchange="calculerTotal(this.value, <%= prixUnitaire %>)">
                    </div>
                </div>

                <div class="mb-4">
                    <label for="remarques" class="form-label fw-medium text-secondary">Demandes particulières / Allergies / Préférences</label>
                    <textarea class="form-control" id="remarques" name="remarques" rows="3" placeholder="Ex: Chambre avec vue, lit bébé, menu végétarien..."></textarea>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-lg text-white fw-bold" style="background-color: #E86E4D;">
                        🚀 Confirmer ma demande de réservation
                    </button>
                    <a href="DetailControlleur?idSejour=<%= idParam %>" class="btn btn-outline-secondary">Annuler</a>
                </div>

            </form>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card shadow-sm border-0 bg-light p-3 sticky-top" style="top: 20px;">
            <h5 class="fw-bold mb-3" style="color: #0D3249;">🛒 Votre panier</h5>
            
            <div class="text-center py-3 bg-white rounded-3 mb-3 border">
                <span class="display-3"><%= icone %></span>
                <h5 class="fw-bold mt-2 mb-0" style="color: #0D3249;"><%= titre %></h5>
                <p class="text-muted small mb-0">Prix unitaire : <%= prixTexte %> / pers.</p>
            </div>

            <div class="p-2">
                <div class="d-flex justify-content-between mb-2">
                    <span class="text-secondary">Type de pack :</span>
                    <span class="fw-bold text-dark">Tout inclus</span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span class="text-secondary">Frais de dossier :</span>
                    <span class="text-success fw-bold">Offerts</span>
                </div>
                
                <hr>
                
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <span class="fw-bold text-dark fs-5">Prix Total :</span>
                    <span id="prix-total" class="fw-bold text-danger fs-4"><%= prixTexte %></span>
                </div>
            </div>
        </div>
    </div>

</div>

<script>
    function calculerTotal(nombreVoyageurs, prixUnitaire) {
        // Si aucun prix unitaire n'est défini (cas "Sur devis")
        if (prixUnitaire === 0) return;
        
        // Calcul
        let total = nombreVoyageurs * prixUnitaire;
        
        // Mise à jour de l'affichage HTML
        // .toLocaleString() permet d'ajouter des espaces pour les milliers (ex: 2 580)
        document.getElementById('prix-total').innerText = total.toLocaleString('fr-FR') + " DH";
    }
</script>

<jsp:include page="footer.jsp" />