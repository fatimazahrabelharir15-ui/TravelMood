<%@page import="Entite.Sejour"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<%
    // 1. RÉCUPÉRATION DE L'OBJET SEJOUR DEPUIS LE CONTRÔLEUR
    Sejour sejour = (Sejour) request.getAttribute("detailSejour");

    // Initialisation des variables secondaires (si elles ne sont pas encore en base de données)
    String duree = "7 nuits / 8 jours";
    String inclusion = "Vol A/R, Hôtel sélectionné, Guide local & Activités incluses";

    if (sejour != null) {
        // Simulation temporaire pour la durée/inclusion basée sur l'ID de ton objet dynamique
        if (String.valueOf(sejour.getId()).equals("2")) {
            duree = "5 nuits / 6 jours";
            inclusion = "Hébergement en bivouac guidé, Repas traditionnels & Accompagnement Muletiers";
        } else if (String.valueOf(sejour.getId()).equals("3")) {
            duree = "4 nuits / 5 jours";
            inclusion = "Hôtel au centre-ville, Billets coupe-file (Colisée & Vatican) inclus";
        } else if (String.valueOf(sejour.getId()).equals("4")) {
            duree = "10 nuits / 11 jours";
            inclusion = "Bungalow sur pilotis, Formule Pension Complète, Matériel de plongée à disposition";
        }
    }
%>

<% if (sejour != null) { %>
<div class="row mt-4 g-4">
    
    <div class="col-md-4">
        <div class="card shadow-sm border-0 text-center">
            
            <div class="position-relative" style="height: 240px; overflow: hidden; border-top-left-radius: 0.375rem; border-top-right-radius: 0.375rem;">
                <img src="<%= request.getContextPath() %>/images/<%= sejour.getImage() %>" 
                     class="w-100 h-100" 
                     style="object-fit: cover;" 
                     alt="<%= sejour.getTitre() %>">
            </div>
            
            <div class="card-body py-4">
                <span class="badge bg-secondary mb-2" style="font-size: 0.9rem;"><%= duree %></span>
                <span class="badge bg-dark mb-2 d-block mx-auto" style="max-width: max-content;"><%= sejour.getHumeur() %></span>
                
                <h3 class="fw-bold mt-2" style="color: #E86E4D;">
                    <%= sejour.getPrix() %> DH <span class="fs-6 text-muted font-weight-normal">/ pers.</span>
                </h3>
                <hr class="my-4">
                
                <div class="d-grid gap-2">
                    <a href="UtilisateurControlleur?idSejour=<%= sejour.getId() %>" class="btn btn-lg fw-bold text-white" style="background-color: #E86E4D;">
                         Réserver ce séjour
                    </a>
                    <a href="ListerSejourControlleur" class="btn btn-outline-secondary">
                        Retour au Catalogue
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-8">
        <div class="card shadow-sm border-0 h-100 p-4">
            <div class="card-body">
                <h1 class="fw-bold mb-3" style="color: #0D3249;"><%= sejour.getTitre() %></h1>
                
                <h5 class="fw-bold mt-4 mb-2 text-uppercase text-muted" style="font-size: 0.85rem; letter-spacing: 1px;">Description du voyage</h5>
                <p class="lead text-secondary" style="line-height: 1.8;"><%= sejour.getDescription() %></p>
                
                <div class="mt-5 p-4 rounded-3" style="background-color: #F5EFE0;">
                    <h5 class="fw-bold mb-3" style="color: #0D3249;"> Ce qui est inclus dans le pack :</h5>
                    <p class="mb-0 text-dark fw-medium"><%= inclusion %></p>
                </div>
            </div>
        </div>
    </div>
    
</div>
<% } else { %>
    <div class="alert alert-warning text-center my-5 py-4 shadow-sm border-0">
         <h4>Désolé, les détails de ce séjour sont introuvables.</h4>
        <a href="ListerSejourControlleur" class="btn btn-primary mt-3">Retourner au catalogue</a>
    </div>
<% } %>

<jsp:include page="footer.jsp" />