<%@page import="Entite.Utilisateur"%>
<%
    // SECURISATION DE L'ESPACE ADMIN
    // 1. On récupère l'objet Utilisateur complet stocké par le contrôleur
    Utilisateur userConnected = (Utilisateur) session.getAttribute("user");
    
    // 2. On vérification si l'utilisateur existe ET s'il est bien admin
    // (Utilisation de equalsIgnoreCase pour éviter les pièges de majuscules)
    if (userConnected == null || ! "admin".equalsIgnoreCase(userConnected.getRole())) {
        response.sendRedirect("connexion.jsp?erreur=interdit");
        return; // On arrête immédiatement le rendu du reste de la page
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<%
    // Plus besoin de simuler ! Si le code arrive ici, c'est que l'utilisateur EST admin.
    boolean isAdmin = true; 
%>

<div class="row mt-4 g-4">
    
    <div class="col-md-3">
        <div class="card shadow-sm border-0 p-3 bg-white rounded-3 sticky-top" style="top: 20px;">
            <div class="text-center py-3 mb-3 border-bottom">
                <div class="fs-1">⚡</div>
                <h5 class="fw-bold m-0 mt-2" style="color: #0D3249;">Espace Admin</h5>
                <span class="badge bg-danger mt-1">Directeur</span>
            </div>
            
            <div class="nav flex-column nav-pills" id="adminTabs" role="tablist" aria-orientation="vertical">
                <button class="nav-link active text-start py-3 fw-bold mb-2" id="dash-tab" data-bs-toggle="tab" data-bs-target="#panel-dash" type="button" role="tab">
                    📊 Tableau de bord
                </button>
                <button class="nav-link text-start py-3 fw-bold mb-2" id="sejours-tab" data-bs-toggle="tab" data-bs-target="#panel-sejours" type="button" role="tab">
                    🏖️ Gestion des Séjours
                </button>
                <button class="nav-link text-start py-3 fw-bold mb-2" id="reservations-tab" data-bs-toggle="tab" data-bs-target="#panel-reservations" type="button" role="tab">
                    📝 Réservations <span class="badge bg-warning text-dark float-end mt-1">1</span>
                </button>
                <button class="nav-link text-start py-3 fw-bold mb-2" id="paiements-tab" data-bs-toggle="tab" data-bs-target="#panel-paiements" type="button" role="tab">
                    💳 Suivi des Paiements
                </button>
            </div>
            
            <hr>
            <a href="index.jsp" class="btn btn-outline-secondary btn-sm w-100">Quitter l'espace admin</a>
        </div>
    </div>
    
    <div class="col-md-9">
        <div class="tab-content" id="adminTabsContent">
            
            <div class="tab-pane fade show active" id="panel-dash" role="tabpanel">
                <h3 class="fw-bold mb-4" style="color: #0D3249;">Tableau de bord</h3>
                
                <div class="row g-3 mb-4">
                    <div class="col-sm-6 col-lg-3">
                        <div class="card p-3 border-0 shadow-sm bg-white rounded-3">
                            <span class="text-muted small fw-medium">Chiffre d'Affaires</span>
                            <h3 class="fw-bold my-1 text-success">4 260 €</h3>
                            <span class="text-xs text-muted">Ce mois-ci</span>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-3">
                        <div class="card p-3 border-0 shadow-sm bg-white rounded-3">
                            <span class="text-muted small fw-medium">Réservations</span>
                            <h3 class="fw-bold my-1" style="color: #0D3249;">3</h3>
                            <span class="text-xs text-warning fw-bold">1 en attente</span>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-3">
                        <div class="card p-3 border-0 shadow-sm bg-white rounded-3">
                            <span class="text-muted small fw-medium">Séjours Actifs</span>
                            <h3 class="fw-bold my-1" style="color: #3B8FB5;">4</h3>
                            <span class="text-xs text-muted">Dans le catalogue</span>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-3">
                        <div class="card p-3 border-0 shadow-sm bg-white rounded-3">
                            <span class="text-muted small fw-medium">Taux de Satisfaction</span>
                            <h3 class="fw-bold my-1" style="color: #E86E4D;">96%</h3>
                            <span class="text-xs text-muted">Avis clients</span>
                        </div>
                    </div>
                </div>
                
                <div class="p-4 rounded-3 bg-light border border-warning">
                    <h5 class="fw-bold text-dark">🔔 Action requise</h5>
                    <p class="mb-0 text-secondary small">Une nouvelle demande de réservation pour le séjour <strong>"Atlas — Trek"</strong> vient d'être déposée par Ahmed Alaoui. Veuillez la valider dans l'onglet dédié.</p>
                </div>
            </div>
            
            <div class="tab-pane fade" id="panel-sejours" role="tabpanel">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3 class="fw-bold m-0" style="color: #0D3249;">Gestion des Séjours</h3>
                    <button class="btn text-white fw-bold btn-sm" style="background-color: #E86E4D;" onclick="alert('Formulaire d\'ajout : Ce bouton ouvrira un Modal d\'insertion SQL en 2ème année !')">
                        ➕ Ajouter un séjour
                    </button>
                </div>
                
                <div class="card border-0 shadow-sm bg-white p-3 rounded-3 table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th><th>Séjour</th><th>Humeur</th><th>Prix</th><th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td><td><strong>Bali</strong> — Détente</td><td>Détente</td><td>1 290 €</td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary me-1">✏️</button>
                                    <button class="btn btn-sm btn-outline-danger">🗑️</button>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td><td><strong>Atlas</strong> — Trek</td><td>Aventure</td><td>690 €</td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary me-1">✏️</button>
                                    <button class="btn btn-sm btn-outline-danger">🗑️</button>
                                </td>
                            </tr>
                            <tr>
                                <td>3</td><td><strong>Rome</strong> — Culture</td><td>Culture</td><td>980 €</td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary me-1">✏️</button>
                                    <button class="btn btn-sm btn-outline-danger">🗑️</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="tab-pane fade" id="panel-reservations" role="tabpanel">
                <h3 class="fw-bold mb-4" style="color: #0D3249;">Gestion des Réservations</h3>
                
                <div class="card border-0 shadow-sm bg-white p-3 rounded-3 table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Client</th><th>Voyage</th><th>Date</th><th>Places</th><th>Statut</th><th>Action admin</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Ahmed Alaoui</td><td>Atlas — Trek</td><td>05/10/2025</td><td>1</td>
                                <td><span class="badge bg-warning text-dark">En attente</span></td>
                                <td>
                                    <button class="btn btn-xs btn-success text-white py-1 px-2 fw-bold" style="font-size: 0.75rem;">✓ Valider</button>
                                    <button class="btn btn-xs btn-danger text-white py-1 px-2 fw-bold" style="font-size: 0.75rem;">✕ Rejeter</button>
                                </td>
                            </tr>
                            <tr>
                                <td>Meryem Bannani</td><td>Bali — Plages</td><td>12/07/2025</td><td>2</td>
                                <td><span class="badge bg-success">Validée</span></td>
                                <td><span class="text-muted small">Aucune action</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="tab-pane fade" id="panel-paiements" role="tabpanel">
                <h3 class="fw-bold mb-4" style="color: #0D3249;">Suivi des Paiements</h3>
                
                <div class="card border-0 shadow-sm bg-white p-3 rounded-3 table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Réf Transaction</th><th>Client</th><th>Montant</th><th>Méthode</th><th>Statut</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="text-secondary fw-bold">#TR-9821</td><td>Meryem Bannani</td><td>2 580 €</td><td>💳 Carte Bancaire</td>
                                <td><span class="badge bg-success bg-opacity-10 text-success border border-success">Payé</span></td>
                            </tr>
                            <tr>
                                <td class="text-secondary fw-bold">#TR-1045</td><td>Ahmed Alaoui</td><td>690 €</td><td>💵 Virement</td>
                                <td><span class="badge bg-warning bg-opacity-10 text-warning border border-warning text-dark">Vérification</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
        </div>
    </div>
    
</div>

<jsp:include page="footer.jsp" />