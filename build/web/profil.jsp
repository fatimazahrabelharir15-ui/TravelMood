<%@page import="Entite.TypeVacance"%>
<%@page import="Entite.Profil"%>
<%@page import="Entite.Utilisateur"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entite.Reservation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<%
    // 1. RÉCUPÉRATION DES DONNÉES ENVOYÉES PAR LE CONTRÔLEUR
    ArrayList<Reservation> reservation = (ArrayList<Reservation>) request.getAttribute("list");
    Profil profil = (Profil) request.getAttribute("profil");
    ArrayList<TypeVacance> typesVacances = (ArrayList<TypeVacance>) request.getAttribute("typesVacances");
    
    // Récupération de l'utilisateur depuis la session
    Utilisateur user = (Utilisateur) session.getAttribute("user");

    // 2. SÉCURITÉ CRITIQUE & PROTECTION MVC
    if (user == null) {
        response.sendRedirect("connexion.jsp");
        return; 
    }

    // 3. PRÉPARATION DES VARIABLES
    Float currentBudget = (profil != null) ? profil.getBudget() : null;
    String currentPreferences = (profil != null) ? profil.getPreference() : "";
    int currentTypeVacance = (profil != null) ? profil.getTypeVacance() : 0;
    
    String msgSuccess = (String) request.getAttribute("msgSuccess");
    String msgError = (String) request.getAttribute("msgError");
%>

<% if (msgSuccess != null) { %>
    <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 mb-4" role="alert">
        ✅ <%= msgSuccess %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<% } %>
<% if (msgError != null) { %>
    <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0 mb-4" role="alert">
        ❌ <%= msgError %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<% } %>

<div class="row g-4">
    
    <div class="col-md-4">
        <div class="card shadow-sm border-0 text-center p-4 bg-white rounded-3">
            <div class="mx-auto rounded-circle text-white d-flex align-items-center justify-content-center shadow-sm mb-3" 
                 style="width: 90px; height: 90px; background-color: #0D3249; font-size: 2rem; font-weight: bold;">
                <%= (user.getPrenom() != null && !user.getPrenom().isEmpty()) ? user.getPrenom().substring(0,1).toUpperCase() : "U" %><%= (user.getNom() != null && !user.getNom().isEmpty()) ? user.getNom().substring(0,1).toUpperCase() : "" %>
            </div>
            
            <h4 class="fw-bold m-0" style="color: #0D3249;"><%= user.getPrenom() %> <%= user.getNom() %></h4>            
            <span class="badge bg-light text-dark border p-2 mb-4 w-100" style="font-size: 0.85rem;">
                <%= user.getEmail() %>
            </span>
            
            <div class="text-start mb-4 bg-light p-3 rounded-3 border-0">
                <div class="mb-2">
                    <label class="text-muted small fw-medium d-block">💰 Budget Vacances</label>
                    <span class="text-dark fw-bold"><%= (currentBudget != null) ? currentBudget + " DH" : "Non renseigné" %></span>
                </div>
                <div class="mb-2">
                    <label class="text-muted small fw-medium d-block">🏖️ Type de vacances préféré</label>
                    <span class="text-dark fw-bold">
                    <% 
                        String nomTypeTrouve = null;
                        if (typesVacances != null && currentTypeVacance != 0) {
                            for (TypeVacance tv : typesVacances) {
                                if (tv.getId() == currentTypeVacance) {
                                    nomTypeTrouve = tv.getTypeVacance();
                                    break;
                                }
                            }
                        }
                        out.print((nomTypeTrouve != null) ? nomTypeTrouve : "Non renseigné");
                    %>
                    </span>
                </div>
                <div>
                    <label class="text-muted small fw-medium d-block">🗺️ Mes Préférences</label>
                    <span class="text-dark small text-wrap"><%= (currentPreferences != null && !currentPreferences.isEmpty()) ? currentPreferences : "Aucune préférence enregistrée" %></span>
                </div>
            </div>
            
            <div class="d-grid gap-2">
                <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#modalProfil">⚙️ Modifier mes infos</button>
                <a href="connexion.jsp" class="btn btn-danger btn-sm text-white">🚪 Se déconnecter</a>
            </div>
        </div>
    </div>
    
    <div class="col-md-8">
        <div class="card shadow-sm border-0 p-4 bg-white rounded-3 h-100">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="fw-bold m-0" style="color: #0D3249;">🗂️ Mes Réservations</h4>
                <span class="badge bg-secondary p-2">
                    Total : <%= (reservation != null) ? reservation.size() : 0 %> voyage(s)
                </span>
            </div>

            <% if (reservation != null && !reservation.isEmpty()) { %>
            <div class="table-responsive">
                <table class="table table-hover align-middle border-light">
                    <thead class="table-light" style="color: #0D3249;">
                        <tr>
                            <th scope="col" class="fw-bold">Réf</th>
                            <th scope="col" class="fw-bold">Destination</th>
                            <th scope="col" class="fw-bold">Date Départ</th>
                            <th scope="col" class="fw-bold">Places</th>
                            <th scope="col" class="fw-bold">Statut</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Reservation r : reservation) { %>
                        <tr>
                            <td class="fw-bold text-secondary">#TM-<%= Math.abs(r.hashCode() % 1000) %></td>
                            <td>
                                <span class="me-2">✈️</span>
                                <strong>
                                    <%-- Sécurisation de l'accès au séjour --%>
                                    <%= (r.getId_Sejour() != 0) ? "Voyage N° " + r.getId_Sejour() : "Séjour TravelMood" %>
                                </strong>
                            </td>
                            <td><%= r.getDate_depart() %></td>
                            <td class="text-center"><%= r.getNb_places() %></td>
                            <td>
                                <% 
                                    String cl = "bg-warning text-warning";
                                    if (r.getStatut() != null) {
                                        if (r.getStatut().equalsIgnoreCase("Validée")) cl = "bg-success text-success";
                                        if (r.getStatut().equalsIgnoreCase("Rejetée")) cl = "bg-danger text-danger";
                                    }
                                %>
                                <span class="badge <%= cl %> bg-opacity-10 px-3 py-2 rounded-pill fw-bold">
                                    <%= (r.getStatut() != null) ? r.getStatut() : "En attente" %>
                                </span>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="alert alert-info border-0 shadow-sm">
                👋 Vous n'avez pas encore de réservations enregistrées.
            </div>
            <% } %>
        </div>
    </div>
</div>

<div class="modal fade" id="modalProfil" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalProfilLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow">
      <div class="modal-header text-white border-0" style="background-color: #0D3249;">
        <h5 class="modal-title fw-bold" id="modalProfilLabel">⚙️ Mettre à jour mes préférences</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="ProfilControlleur" method="POST">
          <input type="hidden" name="actionProfil" value="enregistrer_preferences">
          <div class="modal-body p-4">
              
              <div class="mb-3">
                  <label for="budget" class="form-label fw-medium text-secondary">💰 Budget maximum (DH)</label>
                  <input type="number" step="0.01" class="form-control" id="budget" name="budget" 
                         value="<%= (currentBudget != null) ? currentBudget : "" %>" placeholder="Ex: 5000.00">
              </div>
              
              <div class="mb-3">
                  <label for="type_vacance" class="form-label fw-medium text-secondary">🏖️ Type de vacances idéal</label>
                  <select class="form-select" id="type_vacance" name="type_vacance">
                      <option value="0" <%= (currentTypeVacance == 0) ? "selected" : "" %>>Choisir un type...</option>
                      <% if (typesVacances != null) { 
                          for (TypeVacance tv : typesVacances) { %>
                              <option value="<%= tv.getId() %>" <%= (currentTypeVacance == tv.getId()) ? "selected" : "" %>>
                                  <%= tv.getTypeVacance() %>
                              </option>
                      <%  } 
                      } %>
                  </select>
              </div>
              
              <div class="mb-3">
                  <label for="preferences_voyage" class="form-label fw-medium text-secondary">🗺️ Préférences de voyage</label>
                  <textarea class="form-control" id="preferences_voyage" name="preferences_voyage" rows="4" 
                            placeholder="Ex: Hôtels éco-responsables..."><%= (currentPreferences != null) ? currentPreferences : "" %></textarea>
              </div>
              
          </div>
          <div class="modal-footer border-0 bg-light rounded-bottom-3">
            <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Annuler</button>
            <button type="submit" class="btn text-white btn-sm px-4" style="background-color: #0D3249;">Enregistrer</button>
          </div>
      </form>
    </div>
  </div>
</div>

<jsp:include page="footer.jsp" />