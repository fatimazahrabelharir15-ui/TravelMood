<%@page import="Entite.Paiement"%>
<%@page import="Entite.Reservation"%>
<%@page import="Entite.Sejour"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<%
    Sejour sejour = (Sejour) session.getAttribute("sejour");
    Reservation reservation = (Reservation) session.getAttribute("reservation");
    
    // Sécurité d'accès : si la session est vide, on retourne à l'accueil
    if (sejour == null || reservation == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    
    // Calcul dynamique et sécurisé du montant total à payer
    float montantTotal = sejour.getPrix() * reservation.getNb_places();
    
    // Récupération d'un éventuel message d'erreur renvoyé par le contrôleur
    String errorMsg = (String) request.getAttribute("errorMsg");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Paiement Sécurisé</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
    </style>
</head>
<body>

<div class="container my-5">
    <div class="row g-4 justify-content-center">
        
        <div class="col-md-7 col-lg-8">
            <div class="card shadow-sm border-0 p-4 bg-white rounded-3">
                <div class="card-body">
                    <h2 class="fw-bold mb-3" style="color: #0D3249;">Paiement</h2>
                    <p class="text-muted small mb-4">Veuillez entrer vos informations de paiement</p>
                    
                    <% if (errorMsg != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show rounded-3 mb-4" role="alert">
                            <strong>⚠️ Échec du traitement :</strong> <%= errorMsg %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <% } %>
                    
                    <form action="PaiementControlleur" method="POST" class="needs-validation" novalidate>
                        
                        <div class="mb-3">
                            <label for="numeroCarte" class="form-label text-secondary small fw-medium">Numéro de carte</label>
                            <input type="text" class="form-control py-2" id="numeroCarte" name="numeroCarte" placeholder="XXXX XXXX XXXX XXXX" required>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-6">
                                <label for="expiration" class="form-label text-secondary small fw-medium">Expiration</label>
                                <input type="text" class="form-control py-2" id="expiration" name="expiration" placeholder="MM/AA" required>
                            </div>
                            <div class="col-6">
                                <label for="cvv" class="form-label text-secondary small fw-medium">CVV</label>
                                <input type="password" class="form-control py-2" id="cvv" name="cvv" placeholder="XXX" maxlength="3" required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="titulaire" class="form-label text-secondary small fw-medium">Titulaire</label>
                            <input type="text" class="form-control py-2" id="titulaire" name="titulaire" placeholder="Nom sur la carte" required>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-lg text-white fw-bold py-2.5" style="background-color: #E86E4D; border: none;">
                                ✅ Confirmer et payer
                            </button>
                            <a href="reservation.jsp" class="btn btn-link text-decoration-none text-muted text-center small">Retour aux informations</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-md-5 col-lg-4">
            <div class="card border-0 shadow-sm text-white p-4 h-100 rounded-3" style="background-color: #0B2535;">
                <div class="card-body d-flex flex-column justify-content-between">
                    <div>
                        <h5 class="fw-bold mb-4">📋 Récapitulatif</h5>

                        <div class="position-relative mb-3" style="height: 240px; overflow: hidden; border-radius: 0.375rem;">
                            <img src="<%= request.getContextPath() %>/images/<%= sejour.getImage() %>" 
                                 class="w-100 h-100" 
                                 style="object-fit: cover;" 
                                 alt="<%= sejour.getTitre() %>">
                        </div>

                        <h5 class="fw-bold mb-3"><%= sejour.getTitre() %></h5>

                        <div class="small w-100">
                            <div class="d-flex justify-content-between mb-2">
                                <span style="color: rgba(255,255,255,0.6);">Durée :</span>
                                <span class="fw-bold">7 nuits</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span style="color: rgba(255,255,255,0.6);">Voyageurs :</span>
                                <span class="fw-bold"><%= reservation.getNb_places() %> personnes</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span style="color: rgba(255,255,255,0.6);">Chambres :</span>
                                <span class="fw-bold"><%= reservation.getNbr_chambre() %> chambre(s)</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span style="color: rgba(255,255,255,0.6);">Transport :</span>
                                <span class="text-success fw-bold">Inclus</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span style="color: rgba(255,255,255,0.6);">Hébergement :</span>
                                <span class="fw-bold">4★ Tout inclus</span>
                            </div>
                        </div>
                    </div>

                    <div class="mt-4">
                        <hr style="border-color: rgba(255, 255, 255, 0.15);">
                        <div class="d-flex justify-content-between align-items-center my-3">
                            <span class="fs-5">Total</span>
                            <span class="fs-3 fw-bold text-warning"><%= montantTotal %> DH</span>
                        </div>
                        <div class="text-center small opacity-50" style="font-size: 0.75rem;">
                            Paiement 100% sécurisé · Annulation gratuite 48h
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<jsp:include page="footer.jsp" />