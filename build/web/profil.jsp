<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<jsp:include page="header.jsp" />

<%
    // 1. RÉCUPÉRATION DE L'ID UTILISATEUR DEPUIS LA SESSION
    // (À adapter selon votre système de connexion, ici on utilise une valeur fictive '1' si vide pour le test)
    Integer idUtilisateur = (Integer) session.getAttribute("id_utilisateur");
    if (idUtilisateur == null) {
        idUtilisateur = 1; 
    }

    // 2. RÉCUPÉRATION DES DONNÉES DU FORMULAIRE DE CONNEXION/INSCRIPTION (Votre code existant)
    String actionType = request.getParameter("actionType");
    String prenom = request.getParameter("prenom");
    String nom = request.getParameter("nom");
    String email = request.getParameter("email");

    if (prenom == null || prenom.isEmpty()) prenom = "Ahmed";
    if (nom == null || nom.isEmpty()) nom = "Alaoui";
    if (email == null || email.isEmpty()) email = "ahmed.alaoui@email.com";

    // 3. LOGIQUE D'ENREGISTREMENT DU PROFIL VOYAGEUR (Nouveau)
    String dbUrl = "jdbc:postgresql://localhost:5432/votre_bdd"; // À remplacer par vos accès
    String dbUser = "postgres";
    String dbPass = "password";

    String msgSuccess = null;
    String msgError = null;

    // Si le formulaire des préférences est soumis
    String actionProfil = request.getParameter("actionProfil");
    if ("enregistrer_preferences".equals(actionProfil)) {
        String budgetStr = request.getParameter("budget");
        String preferencesVoyage = request.getParameter("preferences_voyage");
        String typeVacance = request.getParameter("type_vacance");
        Double budget = (budgetStr != null && !budgetStr.isEmpty()) ? Double.parseDouble(budgetStr) : null;

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
            
            // Utilisation d'un UPSERT (INSERT ON CONFLICT) spécifique à PostgreSQL
            String sql = "INSERT INTO profil (id_utilisateur, budget, preferences_voyage, type_vacance) "
                       + "VALUES (?, ?, ?, ?) "
                       + "ON CONFLICT (id_utilisateur) "
                       + "DO UPDATE SET budget = EXCLUDED.budget, preferences_voyage = EXCLUDED.preferences_voyage, type_vacance = EXCLUDED.type_vacance";
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idUtilisateur);
            if (budget != null) pstmt.setDouble(2, budget); else pstmt.setNull(2, Types.DECIMAL);
            pstmt.setString(3, preferencesVoyage);
            pstmt.setString(4, typeVacance);
            
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            msgSuccess = "Vos préférences de voyage ont été mises à jour avec succès !";
        } catch (Exception e) {
            msgError = "Erreur lors de l'enregistrement : " + e.getMessage();
        }
    }

    // 4. CHARGEMENT DES DONNÉES DU PROFIL DEPUIS LA BDD (Pour l'affichage)
    Double currentBudget = null;
    String currentPreferences = "";
    String currentTypeVacance = "";

    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        String sql = "SELECT budget, preferences_voyage, type_vacance FROM profil WHERE id_utilisateur = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, idUtilisateur);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            currentBudget = rs.getDouble("budget");
            if (rs.wasNull()) currentBudget = null;
            currentPreferences = rs.getString("preferences_voyage");
            currentTypeVacance = rs.getString("type_vacance");
        }
        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        // Gérer l'erreur silencieusement ou afficher un message
    }
%>

<% if (actionType != null) { %>
    <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 mb-4" role="alert">
        ✨ <strong>Bienvenue <%= prenom %> !</strong> 
        <%= actionType.equals("inscription") ? "Votre compte a été créé avec succès." : "Connexion réussie à votre espace TravelMood." %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<% } %>

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
                <%= prenom.substring(0,1).toUpperCase() %><%= nom.substring(0,1).toUpperCase() %>
            </div>
            
            <h4 class="fw-bold m-0" style="color: #0D3249;"><%= prenom %> <%= nom %></h4>
            <p class="text-muted small mb-3">Membre depuis : 2025</p>
            
            <span class="badge bg-light text-dark border p-2 mb-4 w-100" style="font-size: 0.85rem;">
                ✈️ Statut : Voyageur Passionné
            </span>
            
            <div class="text-start mb-4 bg-light p-3 rounded-3 border-0">
                <div class="mb-2">
                    <label class="text-muted small fw-medium d-block">Adresse Email</label>
                    <span class="text-dark fw-bold"><%= email %></span>
                </div>
                <div class="mb-2">
                    <label class="text-muted small fw-medium d-block">Type de compte</label>
                    <span class="text-dark fw-bold">Client standard</span>
                </div>
                <div class="mb-2">
                    <label class="text-muted small fw-medium d-block">💰 Budget Vacances</label>
                    <span class="text-dark fw-bold"><%= (currentBudget != null) ? currentBudget + " €" : "Non renseigné" %></span>
                </div>
                <div class="mb-2">
                    <label class="text-muted small fw-medium d-block">🏖️ Type de vacances préféré</label>
                    <span class="text-dark fw-bold"><%= (currentTypeVacance != null && !currentTypeVacance.isEmpty()) ? currentTypeVacance : "Non renseigné" %></span>
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
                <span class="badge bg-secondary p-2">Total : 2 voyages</span>
            </div>
            
            <div class="table-responsive">
                <table class="table table-hover align-middle border-light">
                    <thead class="table-light" style="color: #0D3249;">
                        <tr>
                            <th scope="col" class="fw-bold">Réf</th>
                            <th scope="col" class="fw-bold">Destination</th>
                            <th scope="col" class="fw-bold">Date Départ</th>
                            <th scope="col" class="fw-bold">Places</th>
                            <th scope="col" class="fw-bold">Prix Total</th>
                            <th scope="col" class="fw-bold">Statut</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="fw-bold text-secondary">#TM-894</td>
                            <td>
                                <span class="me-2">🏖️</span><strong>Bali</strong> — Détente
                            </td>
                            <td>12 Juillet 2025</td>
                            <td class="text-center">2</td>
                            <td class="fw-bold" style="color: #0D3249;">2 580 €</td>
                            <td>
                                <span class="badge bg-success bg-opacity-10 text-success px-3 py-2 rounded-pill fw-bold">
                                    ✓ Validée
                                </span>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="fw-bold text-secondary">#TM-432</td>
                            <td>
                                <span class="me-2">🏔️</span><strong>Atlas</strong> — Trek
                            </td>
                            <td>05 Octobre 2025</td>
                            <td class="text-center">1</td>
                            <td class="fw-bold" style="color: #0D3249;">690 €</td>
                            <td>
                                <span class="badge bg-warning bg-opacity-10 text-warning px-3 py-2 rounded-pill fw-bold" style="color: #b57a00 !important;">
                                    ⏳ En attente
                                </span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <div class="mt-auto p-3 bg-light rounded-3 text-muted small">
                💡 <strong>Besoin d'aide ?</strong> Pour toute modification ou annulation d'un séjour dont le statut est "En attente", veuillez contacter notre support technique.
            </div>
        </div>
    </div>
    
</div>

<div class="modal fade" id="modalProfil" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalProfilLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow">
      <div class="modal-header text-white border-0" style="background-color: #0D3249;">
        <h5 class="modal-title fw-bold" id="modalProfilLabel">⚙️ Mettre à jour mon profil voyageur</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="profil.jsp" method="POST">
          <input type="hidden" name="actionProfil" value="enregistrer_preferences">
          <div class="modal-body p-4">
              
              <div class="mb-3">
                  <label for="budget" class="form-label fw-medium text-secondary">💰 Budget maximum (€)</label>
                  <input type="number" step="0.01" class="form-control" id="budget" name="budget" 
                         value="<%= (currentBudget != null) ? currentBudget : "" %>" placeholder="Ex: 1500.00">
              </div>
              
              <div class="mb-3">
                  <label for="type_vacance" class="form-label fw-medium text-secondary">🏖️ Type de vacances idéal</label>
                  <select class="form-select" id="type_vacance" name="type_vacance">
                      <option value="" <%= "".equals(currentTypeVacance) ? "selected" : "" %>>Choisir un type...</option>
                      <option value="Détente & Plage" <%= "Détente & Plage".equals(currentTypeVacance) ? "selected" : "" %>>🏖️ Détente & Plage</option>
                      <option value="Aventure & Trek" <%= "Aventure & Trek".equals(currentTypeVacance) ? "selected" : "" %>>🏔️ Aventure & Trek</option>
                      <option value="Culture & Histoire" <%= "Culture & Histoire".equals(currentTypeVacance) ? "selected" : "" %>>🏛️ Culture & Histoire</option>
                      <option value="Croisière & Mer" <%= "Croisière & Mer".equals(currentTypeVacance) ? "selected" : "" %>>🚢 Croisière & Mer</option>
                  </select>
              </div>
              
              <div class="mb-3">
                  <label for="preferences_voyage" class="form-label fw-medium text-secondary">🗺️ Préférences de voyage (Hébergement, Climat...)</label>
                  <textarea class="form-control" id="preferences_voyage" name="preferences_voyage" rows="4" 
                            placeholder="Ex: Préfère les hôtels éco-responsables, les climats tropicaux, voyage souvent seul..."><%= (currentPreferences != null) ? currentPreferences : "" %></textarea>
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