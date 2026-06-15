<%@page import="Entite.Utilisateur"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entite.Sejour"%>
<<<<<<< HEAD
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
=======
>>>>>>> 49270c68072751f1f4f575846aba712c45c8b380
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
<style>
@keyframes flotter {
    0%   { transform: translateY(0px) rotate(0deg); }
    50%  { transform: translateY(-6px) rotate(3deg); }
    100% { transform: translateY(0px) rotate(0deg); }
}

.logo-avion {
    animation: flotter 2.5s ease-in-out infinite;
    .nav-pills .nav-link {
    transition: all 0.3s ease;
}

.nav-pills .nav-link:hover {
    transform: translateX(6px);
    .dashboard-card {
    animation: fadeInUp 0.6s ease;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(25px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
}
}
</style>
<%
String tab = request.getParameter("tab");

if (tab == null) {
    tab = "dashboard";
}
%>
<%
    // Plus besoin de simuler ! Si le code arrive ici, c'est que l'utilisateur EST admin.
    boolean isAdmin = true; 
%>
<%
ArrayList<Sejour> listeSejours =
        (ArrayList<Sejour>) request.getAttribute("listeSejours");
%>
<div class="row mt-4 g-4">
    
    <div class="col-md-3">
        <div class="card shadow-sm border-0 p-3 bg-white rounded-3 sticky-top" style="top: 20px;">
            
            <div class="text-center py-3 mb-3 border-bottom">
             
                <h4 class="fw-bold m-0 mt-3">
    <span >Administrateur</span>
</h4>

            </div>
            
            <div class="nav flex-column nav-pills" id="adminTabs" role="tablist" aria-orientation="vertical">
                <button class="nav-link text-start py-3 fw-bold mb-2" id="dash-tab" data-bs-toggle="tab" data-bs-target="#panel-dash" type="button" role="tab">
                    <i class="bi bi-grid-1x2-fill me-2"></i> Tableau de bord
                </button>
                <button class="nav-link text-start py-3 fw-bold mb-2"
        id="sejours-tab"
        data-bs-toggle="tab"
        data-bs-target="#panel-sejours"
        type="button"
        role="tab">
    <i class="bi bi-airplane-fill me-2"></i>
    Gestion des Séjours
</button>
                <button class="nav-link text-start py-3 fw-bold mb-2" id="reservations-tab" data-bs-toggle="tab" data-bs-target="#panel-reservations" type="button" role="tab">
                    <i class="bi bi-calendar-check-fill me-2"></i> Réservations

<%
Integer nbEnAttente = (Integer) request.getAttribute("nbEnAttente");
if (nbEnAttente != null && nbEnAttente > 0) {
%>

<span class="badge bg-warning text-dark float-end mt-1">
    <%= nbEnAttente %>
</span>

<%
}
%>

                </button>
                <button class="nav-link text-start py-3 fw-bold mb-2" id="paiements-tab" data-bs-toggle="tab" data-bs-target="#panel-paiements" type="button" role="tab">
                    <i class="bi bi-credit-card-2-front-fill me-2"></i> Suivi des Paiements
                </button>
            </div>
            
            <hr>
<a href="<%= request.getContextPath() %>/logout"
   class="btn btn-danger w-100 fw-bold rounded-3 py-2">
    <i class="bi bi-box-arrow-right me-2"></i>
    Déconnexion
</a>      </div>
    </div>
    
    <div class="col-md-9">
        <div class="tab-content" id="adminTabsContent">
            
            
            <div class="tab-pane fade" id="panel-dash" role="tabpanel">
                
                <div class="card border-0 text-center shadow-sm mb-4"
     style="background: linear-gradient(135deg, #0D3249, #1E88E5); border-radius:20px;">

    <div class="card-body p-4 text-white" text-align:"center">

        <h2 class="fw-bold mb-2">
            👋 Bonjour Administrateur
        </h2>

        <p class="mb-0 fs-5">
            Bienvenue sur votre tableau de bord <strong>TravelMood</strong>.
        </p>

        <!-- 📅 Date du jour -->
        <p class="text-warning fw-bold mb-0">
    🔔 <%= request.getAttribute("nbEnAttente") %> réservation(s) en attente de validation
</p>


    </div>

</div>
<h3 class="fw-bold mb-4" style="color: #0D3249;">Tableau de bord</h3>
                <div class="row g-3 mb-4">
                    <div class="card border-0 shadow-sm rounded-4 h-100">
    <div class="card-body d-flex align-items-center">
        <div class="rounded-circle d-flex align-items-center justify-content-center me-3"
             style="width:60px;height:60px;background:#E8F5E9;">
            <i class="bi bi-cash-stack text-success fs-3"></i>
        </div>

        <div>
            <small class="text-muted">Chiffre d'Affaires</small>
            <h2 class="fw-bold text-success mb-0">${chiffreAffaires} DH</h2>
            <small class="text-secondary">Ce mois-ci</small>
        </div>
    </div>
</div>
                   <div class="card border-0 shadow-sm rounded-4 h-100">
    <div class="card-body d-flex align-items-center">

        <div class="rounded-circle d-flex align-items-center justify-content-center me-3"
             style="width:60px;height:60px;background:#E3F2FD;">
            <i class="bi bi-calendar-check-fill text-primary fs-3"></i>
        </div>

        <div>
            <small class="text-muted">Réservations</small>
            <h2 class="fw-bold text-primary mb-0">
                ${nombreReservations}
            </h2>
            <small class="text-warning fw-bold">
                <%= request.getAttribute("nbEnAttente") %> en attente
            </small>
        </div>

    </div>
</div>
                    <div class="card border-0 shadow-sm rounded-4 h-100">
    <div class="card-body d-flex align-items-center">

        <div class="rounded-circle d-flex align-items-center justify-content-center me-3"
             style="width:60px;height:60px;background:#E0F7FA;">
            <i class="bi bi-airplane-fill text-info fs-3"></i>
        </div>

        <div>
            <small class="text-muted">Séjours Actifs</small>
            <h2 class="fw-bold text-info mb-0">
                ${nombreSejours}
            </h2>
            <small class="text-secondary">
                Dans le catalogue
            </small>
        </div>

    </div>
</div>
                    <div class="card border-0 shadow-sm rounded-4 h-100">
    <div class="card-body d-flex align-items-center">

        <div class="rounded-circle d-flex align-items-center justify-content-center me-3"
             style="width:60px;height:60px;background:#E8F5E9;">
            <i class="bi bi-people-fill text-success fs-3"></i>
        </div>

        <div>
            <small class="text-muted">Clients inscrits</small>
            <h2 class="fw-bold text-success mb-0">
                ${nombreClients}
            </h2>
            <small class="text-secondary">
                Comptes enregistrés
            </small>
        </div>

    </div>
</div>
                </div>
                
                <div class="card border-0 shadow-sm rounded-4 p-4">
    <h5 class="fw-bold mb-4">
        <i class="bi bi-lightning-charge-fill me-2"></i>
        Actions rapides
    </h5>

    <div class="d-flex gap-3 flex-wrap">

        <a href="AdminControlleur?action=ajouter"
   class="btn btn-outline-primary">
    <i class="bi bi-plus-circle me-2"></i>
    Ajouter un séjour
</a>

        <button class="btn btn-outline-success"
                onclick="document.getElementById('reservations-tab').click();">
            <i class="bi bi-calendar-check me-2"></i>
            Voir les réservations
        </button>

        <button class="btn btn-outline-warning"
                onclick="document.getElementById('paiements-tab').click();">
            <i class="bi bi-credit-card me-2"></i>
            Voir les paiements
        </button>

    </div>
                    <div class="row mt-4">

    <div class="col-md-6">
        <div class="card p-3 shadow-sm" style="height: 500px;">
            <h5>📊 Réservations par mois</h5>
            <canvas id="chartReservations" style="height: 350px;"></canvas>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card p-3 shadow-sm" style="height: 500px;">
            <h5>🥧 Répartition des paiements</h5>
            <canvas id="chartPaiements" ></canvas>
        </div>
    </div>

</div>

<div class="row mt-4">
    <div class="col-md-12">
        <div class="card p-3 shadow-sm">
            <h5>📈 Évolution du chiffre d'affaires</h5>
            <canvas id="chartCA"></canvas>
        </div>
    </div>
</div>
</div>
            </div>
            
            <div class="tab-pane fade"
     id="panel-sejours">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3 class="fw-bold m-0" style="color: #0D3249;">Gestion des Séjours</h3>
                   
                </div>
                
                <div class="card border-0 shadow-sm bg-white p-3 rounded-3 table-responsive">
                    <div class="d-flex justify-content-between align-items-center flex-wrap mb-4">

    <div class="d-flex gap-3">

        <!-- Recherche -->
        <input
            type="text"
            id="searchSejour"
            class="form-control"
            placeholder="🔍 Rechercher un séjour..."
            style="width:300px;">

        <!-- Filtre humeur -->
        <select id="filterHumeur" class="form-select" style="width:200px;">
    <option value="">Toutes les humeurs</option>

    <%
        ArrayList<String> listeHumeurs =
            (ArrayList<String>) request.getAttribute("listeHumeurs");

        if (listeHumeurs != null) {
            for (String h : listeHumeurs) {
    %>
        <option value="<%= h %>"><%= h %></option>
    <%
            }
        }
    %>
</select>

    </div>

    <a href="AdminControlleur?action=ajouter"
       class="btn text-white px-4 py-2"
       style="background:#E86E4D;border-radius:10px;font-weight:600;">
        <i class="bi bi-plus-lg"></i>
        Ajouter un séjour
    </a>

</div>
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Séjour</th><th>Humeur</th><th>Prix</th><th>Actions</th>
                            </tr>
                        </thead>
                       
                        <tbody>

<%
if(listeSejours != null){
    for(Sejour s : listeSejours){
%>

<tr class="ligneSejour"
    data-titre="<%= s.getTitre() %>"
    data-humeur="<%= s.getHumeur() %>">

    

    <td>
    <div class="d-flex align-items-center">

        <!-- Miniature -->
        <img src="<%= request.getContextPath() %>/images/<%= s.getImage() %>"
             alt="<%= s.getTitre() %>"
             class="rounded-3 shadow-sm me-3"
             style="width:50px;height:50px;object-fit:cover;">

        <!-- Informations -->
        <div>
            <div class="fw-bold fs-6">
                <%= s.getTitre() %>
            </div>

            <small class="text-muted">
               <%= s.getHumeur() %>
            </small>
        </div>

    </div>
</td>

    <td><%= s.getHumeur() %></td>

    <td><%= s.getPrix() %> DH</td>

    <td>

        <a href="AdminControlleur?action=modifier&id=<%= s.getId() %>"
   class="btn btn-outline-primary btn-sm me-2"
   title="Modifier">
    <i class="bi bi-pencil-fill"></i>
</a>

<a href="#"
   class="btn btn-outline-danger btn-sm"
   data-bs-toggle="modal"
   data-bs-target="#deleteModal"
   onclick="preparerSuppression(<%= s.getId() %>, '<%= s.getTitre() %>')">
    <i class="bi bi-trash-fill"></i>
</a>

    </td>

</tr>

<%
    }
}
%>

</tbody>
                    </table>
                </div>
            </div>
            
            <div class="tab-pane fade" id="panel-reservations" role="tabpanel">
                <h3 class="fw-bold mb-4" style="color: #0D3249;">Gestion des Réservations</h3>
                
                <div class="card border-0 shadow-sm bg-white p-3 rounded-3 table-responsive">
                    <table class="table table-hover align-middle w-100">
                        <thead class="table-light">
                            <tr>
                                <th>Client</th><th>Voyage</th><th>Date</th><th>Places</th><th>Statut</th><th style="width: 220px;">Action admin</th>
                            </tr>
                        </thead>
                       <%
ArrayList<Object[]> reservations =
    (ArrayList<Object[]>) request.getAttribute("listeReservations");
%>

<tbody>

<%
if (reservations != null && !reservations.isEmpty()) {

    for (Object[] r : reservations) {
%>

<tr>
    <td class="text-nowrap"><%= r[1] %> <%= r[2] %></td>
<td class="text-nowrap"><%= r[3] %></td>
<td class="text-nowrap"><%= r[4] %></td>
<td class="text-nowrap"><%= r[5] %></td>
    <td>

<%
String statut = (String) r[6];

if ("En attente".equals(statut)) {
%>

    <span class="badge bg-warning text-dark">
        En attente
    </span>

<%
} else if ("Validée".equals(statut)) {
%>

    <span class="badge bg-success">
        Validée
    </span>

<%
} else {
%>

    <span class="badge bg-danger">
        Rejetée
    </span>

<%
}
%>

</td>

<td>

<%
if ("En attente".equals(statut)) {
%>

 <div class="d-flex justify-content-center gap-2">

    <a href="AdminControlleur?action=validerReservation&id=<%= r[0] %>"
       class="btn btn-success btn-sm me-1">
        ✓ Valider
    </a>

    <a href="AdminControlleur?action=rejeterReservation&id=<%= r[0] %>"
       class="btn btn-danger btn-sm">
        ✕ Rejeter
    </a>

 </div>
<%
} else {
%>

<span class="text-muted">
    Aucune action
</span>

<%
}
%>

</td>
</tr>

<%
    }

} else {
%>

<tr>
    <td colspan="6" class="text-center">
        Aucune réservation trouvée.
    </td>
</tr>

<%
}
%>

</tbody>
                    </table>
                </div>
            </div>
            <div class="tab-pane fade" id="panel-paiements" role="tabpanel">

    <h3 class="fw-bold mb-4" style="color:#0D3249;">
        Suivi des Paiements
    </h3>

    <div class="card border-0 shadow-sm bg-white p-3 rounded-3 table-responsive">

        <table class="table table-hover align-middle">

            <thead class="table-light">
                <tr>
                    <th>Client</th>
                    <th>Montant</th>
                    <th>Méthode</th>
                    <th>Statut</th>
                </tr>
            </thead>

            <tbody>

<%
ArrayList<Object[]> paiements =
    (ArrayList<Object[]>) request.getAttribute("listePaiements");

if (paiements != null && !paiements.isEmpty()) {

    for (Object[] p : paiements) {
%>

<tr>

    <td>
        <%= p[0] %> <%= p[1] %>
    </td>

    <td>
        <%= p[2] %> DH
    </td>

    <td>
        <%= p[3] %>
    </td>

    <td>

<%
String statutPaiement = (String) p[4];

if ("Payé".equals(statutPaiement)) {
%>

<span class="badge bg-success">
    Payé
</span>

<%
} else {
%>

<span class="badge bg-warning text-dark">
    en attente
</span>

<%
}
%>

    </td>

</tr>

<%
    }

} else {
%>

<tr>
    <td colspan="4" class="text-center">
        Aucun paiement trouvé.
    </td>
</tr>

<%
}
%>

            </tbody>

        </table>

    </div>

</div>
        </div>
    </div>
    
</div>

<script>
window.addEventListener("load", function () {

    const tab = "<%= tab %>";

    if (tab === "sejours") {
        bootstrap.Tab.getOrCreateInstance(
            document.getElementById("sejours-tab")
        ).show();

    } else if (tab === "reservations") {
        bootstrap.Tab.getOrCreateInstance(
            document.getElementById("reservations-tab")
        ).show();

    } else if (tab === "paiements") {
        bootstrap.Tab.getOrCreateInstance(
            document.getElementById("paiements-tab")
        ).show();

    } else {
        bootstrap.Tab.getOrCreateInstance(
            document.getElementById("dash-tab")
        ).show();
    }

});
</script>
<script>
const recherche = document.getElementById("searchSejour");
const humeur = document.getElementById("filterHumeur");

function filtrer() {
    const texte = recherche.value.toLowerCase();
    const humeurChoisie = humeur.value.toLowerCase();

    document.querySelectorAll(".ligneSejour").forEach(function(ligne) {

        const titre = ligne.dataset.titre.toLowerCase();
        const humeurLigne = ligne.dataset.humeur.toLowerCase();

        const okRecherche = titre.includes(texte);
        const okHumeur = humeurChoisie === "" || humeurLigne === humeurChoisie;

        ligne.style.display = (okRecherche && okHumeur) ? "" : "none";
    });
}

recherche.addEventListener("keyup", filtrer);
humeur.addEventListener("change", filtrer);
</script>
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow">

            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold">
                    <i class="bi bi-exclamation-triangle-fill text-danger me-2"></i>
                    Confirmation
                </h5>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal">
                </button>
            </div>

            <div class="modal-body">
                <p class="mb-0">
                    Êtes-vous sûr de vouloir supprimer le séjour
                    <strong id="nomSejour"></strong> ?
                </p>
            </div>

            <div class="modal-footer border-0">

                <button type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal">
                    Annuler
                </button>

                <a id="btnConfirmerSuppression"
   class="btn btn-danger">
    <i class="bi bi-trash-fill"></i>
    Supprimer
</a>

            </div>

        </div>
    </div>
</div>
<script>
function preparerSuppression(id, titre) {

    document.getElementById("nomSejour").textContent = '"' + titre + '"';

    document.getElementById("btnConfirmerSuppression").href =
        "AdminControlleur?action=supprimer&id=" + id;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<%
ArrayList<Object[]> reservationsParMois =
    (ArrayList<Object[]>) request.getAttribute("reservationsParMois");

ArrayList<Object[]> paiementsParMethode =
    (ArrayList<Object[]>) request.getAttribute("paiementsParMethode");

ArrayList<Object[]> caParMois =
    (ArrayList<Object[]>) request.getAttribute("caParMois");
%>

<script>
document.addEventListener("DOMContentLoaded", function () {

    // ---------- Réservations par mois ----------
    const labelsReservations = [
        <% 
        if (reservationsParMois != null) {
            for (int i = 0; i < reservationsParMois.size(); i++) {
                Object[] r = reservationsParMois.get(i);
        %>
            "Mois <%= r[0] %>"<%= (i < reservationsParMois.size()-1 ? "," : "") %>
        <%
            }
        }
        %>
    ];

    const dataReservations = [
        <%
        if (reservationsParMois != null) {
            for (int i = 0; i < reservationsParMois.size(); i++) {
                Object[] r = reservationsParMois.get(i);
        %>
            <%= r[1] %><%= (i < reservationsParMois.size()-1 ? "," : "") %>
        <%
            }
        }
        %>
    ];

    new Chart(document.getElementById("chartReservations"), {
        type: "bar",
        data: {
            labels: labelsReservations,
            datasets: [{
                label: "Réservations",
                data: dataReservations
            }]
        }
    });

    // ---------- Paiements par méthode ----------
    const labelsPaiements = [
        <%
        if (paiementsParMethode != null) {
            for (int i = 0; i < paiementsParMethode.size(); i++) {
                Object[] r = paiementsParMethode.get(i);
        %>
            "<%= r[0] %>"<%= (i < paiementsParMethode.size()-1 ? "," : "") %>
        <%
            }
        }
        %>
    ];

    const dataPaiements = [
        <%
        if (paiementsParMethode != null) {
            for (int i = 0; i < paiementsParMethode.size(); i++) {
                Object[] r = paiementsParMethode.get(i);
        %>
            <%= r[1] %><%= (i < paiementsParMethode.size()-1 ? "," : "") %>
        <%
            }
        }
        %>
    ];

    new Chart(document.getElementById("chartPaiements"), {
        type: "pie",
        data: {
            labels: labelsPaiements,
            datasets: [{
                data: dataPaiements
            }]
        }
    });

    // ---------- Chiffre d'affaires ----------
    const labelsCA = [
        <%
        if (caParMois != null) {
            for (int i = 0; i < caParMois.size(); i++) {
                Object[] r = caParMois.get(i);
        %>
            "Mois <%= r[0] %>"<%= (i < caParMois.size()-1 ? "," : "") %>
        <%
            }
        }
        %>
    ];

    const dataCA = [
        <%
        if (caParMois != null) {
            for (int i = 0; i < caParMois.size(); i++) {
                Object[] r = caParMois.get(i);
        %>
            <%= r[1] %><%= (i < caParMois.size()-1 ? "," : "") %>
        <%
            }
        }
        %>
    ];

    new Chart(document.getElementById("chartCA"), {
        type: "line",
        data: {
            labels: labelsCA,
            datasets: [{
                label: "Chiffre d'affaires",
                data: dataCA,
                fill: false,
                tension: 0.3
            }]
        }
    });

});
</script>
<jsp:include page="footer.jsp" />