<%@page import="Entite.Sejour"%>
<%@page import="Entite.Utilisateur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<%
    // 1. RÉCUPÉRATION DE L'UTILISATEUR CONNECTÉ EN SESSION
    Utilisateur userConnecte = (Utilisateur) session.getAttribute("user");
    String user ;
        user = userConnecte.getNom()+" "+userConnecte.getPrenom();
    

    // 2. RÉCUPÉRATION DE L'OBJET SEJOUR (TRANSMIS PAR LE DO-GET DU CONTRÔLEUR)
    Sejour sejour = (Sejour) request.getAttribute("sejour");
    
    String idParam = "";
    String titre = "Séjour Général";
    float prixUnitaire = 0;
    String imageFichier = "";

    if (sejour != null) {
        // CORRECTION : On utilise la nomenclature exacte de ta base de données (id_sejour)
        idParam = String.valueOf(sejour.getId()); 
        titre = sejour.getTitre();
        prixUnitaire = sejour.getPrix();
        imageFichier = sejour.getImage();
    } else {
        // Fallback de secours si l'attribut est perdu
        idParam = request.getParameter("idSejour");
    }
%>

<div class="row mt-4 g-4">
    
    <div class="col-md-8">
        <div class="card shadow-sm border-0 p-4 bg-white rounded-3">
            <h3 class="fw-bold mb-4" style="color: #0D3249;">📋 Informations de réservation</h3>
            
            <p class="text-muted">Voyageur : <strong class="text-dark"><%=user %> </strong></p>
            
            <form action="ReservationControlleur" method="POST" class="needs-validation">
                
                <input type="hidden" name="idSejour" value="<%= idParam %>">

                <div class="row g-3 mb-3">
                    <div class="col-sm-6">
                        <label for="dateDepart" class="form-label fw-medium text-secondary">Date de départ souhaitée *</label>
                        <input type="date" class="form-control" id="dateDepart" name="dateDepart" required>
                    </div>
                    <div class="col-sm-6">
                        <label for="dateArrivee" class="form-label fw-medium text-secondary">Date d'arrivée souhaitée *</label>
                        <input type="date" class="form-control" id="dateArrivee" name="dateArrivee" required>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-sm-6">
                        <label for="voyageurs" class="form-label fw-medium text-secondary">Nombre de voyageurs *</label>
                        <input type="number" class="form-control" id="voyageurs" name="voyageurs" min="1" max="10" value="1" required onchange="calculerTotal(this.value, <%= prixUnitaire %>)">
                    </div>
                    <div class="col-sm-6">
                        <label for="chambres" class="form-label fw-medium text-secondary">Nombre de chambres *</label>
                        <input type="number" class="form-control" id="chambres" name="chambres" min="1" max="10" value="1" required>
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

    <div class="col-md-4 " >
        <div class="card shadow-sm border-0 bg-light p-3 sticky-top" style="top: 20px;">
            <h5 class="fw-bold mb-3" style="color: #0D3249;">🛒 Votre panier</h5>
            
            <div class="position-relative" style="height: 160px; overflow: hidden;">
                        <img src="<%= request.getContextPath() %>/images/<%= sejour.getImage() %>" 
                             class="card-img-top w-100 h-100" 
                             style="object-fit: cover;" 
                             alt="<%= sejour.getTitre() %>">
                    </div>

            <div class="p-2">
                <div class="d-flex justify-content-between mb-2">
                    <span class="text-secondary">Destination</span>
                    <span class="fw-bold text-dark"><%=sejour.getTitre()%></span>
                </div>
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
                    <span class="fw-bold text-dark fs-5">Prix Unitaire :</span>
                    <span id="prix-total" class="fw-bold text-danger fs-4"><%= sejour.getPrix() %></span>
                </div>
            </div>
        </div>
    </div>

</div>

<jsp:include page="footer.jsp" />