<%@page import="Entite.Sejour"%>
<%@page import="Entite.TypeVacance"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<%
    // Récupération de l'ID actif envoyé par le contrôleur (0 si "tous")
    Integer idTypeActive = (Integer) request.getAttribute("idTypeActive");
    if (idTypeActive == null) idTypeActive = 0;

    ArrayList<TypeVacance> listTypes = (ArrayList<TypeVacance>) request.getAttribute("Typevacance");
    ArrayList<Sejour> listSejours = (ArrayList<Sejour>) request.getAttribute("listSejour");
%>

<div class="row g-4 mt-2">
    
    <div class="col-md-3">
        <div class="card shadow-sm border-0 p-3">
            <h5 class="fw-bold mb-3" style="color: #0D3249;"> Filtrer par Catégorie</h5>
            <div class="list-group list-group-flush">
                
                <a href="ListerSejourControlleur?type=0" 
                   class="list-group-item list-group-item-action <%= idTypeActive == 0 ? "active fw-bold" : "" %>" 
                   <%= idTypeActive == 0 ? "style='background-color: #0D3249; border-color: #0D3249;'" : "" %>>
                     Tous les séjours
                </a>
                
                <% 
                    if (listTypes != null) {
                        for (TypeVacance tv : listTypes) {                
                %>
                <a href="SejourParTypeControlleur?type=<%= tv.getId() %>" 
                   class="list-group-item list-group-item-action <%= idTypeActive.equals(tv.getId()) ? "active fw-bold" : "" %>" 
                   <%= idTypeActive.equals(tv.getId()) ? "style='background-color: #0D3249; border-color: #0D3249;'" : "" %>>
                      <%= tv.getTypeVacance() %>
                </a>
                <% 
                        }
                    } 
                %>
            </div>
        </div>
    </div>
    
    <div class="col-md-9">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold m-0" style="color: #0D3249;">Notre Catalogue</h2>
            <span class="badge bg-secondary p-2">Filtre ID : <%= idTypeActive == 0 ? "TOUS" : idTypeActive %></span>
        </div>
        
        <div class="row g-4">
            <% 
                if (listSejours != null && !listSejours.isEmpty()) {
                    for (Sejour s : listSejours) {
            %>
            <div class="col-md-4 col-sm-6">
                <div class="card h-100 shadow-sm border-0">
                    <div class="position-relative" style="height: 160px; overflow: hidden;">
                        <img src="<%= request.getContextPath() %>/images/<%= s.getImage() %>" 
                             class="card-img-top w-100 h-100" 
                             style="object-fit: cover;" 
                             alt="<%= s.getTitre() %>">
                    </div>
                    <div class="card-body">
                        <span class="badge bg-dark mb-2"><%= s.getHumeur() %></span>
                        <h5 class="card-title fw-bold" style="color: #0D3249;"><%= s.getTitre() %></h5>
                        <p class="card-text text-muted small text-truncate"><%= s.getDescription() %></p>
                        <h6 class="fw-bold text-danger mt-2"><%= s.getPrix() %> DH</h6>
                    </div>
                    <div class="card-footer bg-white border-0 pb-3">
                        <a href="DetailControlleur?idSejour=<%= s.getId() %>" class="btn btn-sm w-100 text-white" style="background-color: #E86E4D;">Voir les détails</a>
                    </div>
                </div>
            </div>
            <% 
                    } 
                } else { 
            %>
            <div class="col-12 text-center py-5">
                <div class="alert alert-info d-inline-block">
                    Aucun séjour disponible pour cette catégorie pour le moment.
                </div>
            </div>
            <% } %>
        </div> 
    </div> 
</div> 

<jsp:include page="footer.jsp" />