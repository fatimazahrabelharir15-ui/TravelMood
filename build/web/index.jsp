<%@page import="java.util.ArrayList"%>
<%@page import="Entite.Sejour"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<!-- ================= BanniÈre (Hero Section) ================= -->
<div class="text-center py-5 rounded-4 shadow-sm text-white mb-5" style="background: linear-gradient(135deg, #0D3249 0%, #1A4C6B 50%, #3B8FB5 100%);">
    <h1 class="display-4 fw-bold mb-3">Voyagez selon <em class="text-warning" style="font-style: normal;">votre humeur</em></h1>
    <p class="lead mb-4">Des séjours tout inclus personnalisés selon votre budget et votre style.</p>
    
    <!-- Boutons d'action -->
    <div class="d-flex justify-content-center gap-3 flex-wrap">
        <a href="recommande.jsp" class="btn btn-warning btn-lg fw-bold" style="background-color: #E86E4D; border-color: #E86E4D; color: white;"> Trouver mon voyage</a>
        <a href="ListerSejourControlleur" class="btn btn-outline-light btn-lg">Voir tous les séjours</a>
    </div>
</div>

<!-- ================= Section des Séjours Populaires ================= -->
<div class="text-center mb-4">
    <h2 class="fw-bold" style="color: #0D3249;">Séjours populaires</h2>
    <p class="text-muted">Sélectionnés par notre équipe pour chaque type de voyageur</p>
</div>

<!-- Grille de 4 cartes (Bootstrap : row et col-md-3) -->
<div class="row g-4 mb-5">
    
    <%
        // On récupère la liste envoyée par le contrôleur
        ArrayList<Sejour> listSejours = (ArrayList<Sejour>) request.getAttribute("list");
        
        // Sécurité : On vérifie si la liste existe et n'est pas vide
        if (listSejours != null && !listSejours.isEmpty()) {
            for (Sejour s : listSejours) {
    %>
    <!--sejour -->
    <div class="col-md-3 col-sm-6">
        <div class="card h-100 shadow-sm border-0 transition-hover">
            <div class="position-relative" style="height: 180px; overflow: hidden;">
                <img src="<%= request.getContextPath() %>/images/<%= s.getImage()%>" 
                    class="card-img-top w-100 h-100" 
                    style="object-fit: cover;" 
                    alt="<%= s.getTitre() %>">
            </div>
            <div class="card-body">
                <h5 class="card-title fw-bold" style="color: #0D3249;"><%= s.getTitre()%></h5>
                <p class="card-text text-muted small"><%= s.getDescription()%></p>
            </div>
            <div class="card-footer bg-white border-0 d-flex justify-content-between align-items-center pb-3">
                <strong style="color: #E86E4D; font-size: 1.1rem;"><%= s.getPrix()%> </strong>
                <!-- LIEN VERS LES DÉTAILS DU SÉJOUR 1 -->
                <a href="DetailControlleur?idSejour=<%=s.getId()%>" class="btn btn-sm btn-outline-dark">Voir détails</a>
            </div>
        </div>
    </div>
    <%
            } 
        } else {
    %>
    <div class="col-12 text-center py-4">
        <div class="alert alert-warning d-inline-block shadow-sm">
            ⚠️ Aucun séjour n'est disponible pour le moment ou l'accès direct à la page JSP est impossible.
        </div>
    </div>
    <%
        }
    %>
</div>

<jsp:include page="footer.jsp" />