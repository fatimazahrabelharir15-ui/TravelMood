<%@page import="Entite.Paiement"%>
<%@page import="Entite.Facture"%>
<%@page import="Entite.Reservation"%>
<%@page import="Entite.Sejour"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<%
    // Récupération des objets transmis par le FactureControlleur
    Facture facture = (Facture) request.getAttribute("facture");
    Paiement paiement =(Paiement) request.getAttribute("paiement");
    
    Reservation reservation = (Reservation) request.getAttribute("reservation");
    Sejour sejour = (Sejour) request.getAttribute("sejour");

    if (facture == null || reservation == null) {
        response.sendRedirect(request.getContextPath() + "/SejourControlleur");
        return;
    }
    
%>

<style>
    /* Style pour optimiser le rendu PDF au moment du téléchargement */
    @media print {
        .no-print, footer, nav, .btn {
            display: none !important;
        }
        .card {
            border: none !important;
            box-shadow: none !important;
        }
        body {
            background-color: #fff !important;
        }
    }
</style>

<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="col-md-9">
            
            <div class="d-flex justify-content-between align-items-center mb-4 no-print">
                <a href="SejourControlleur" class="btn btn-outline-secondary">
                    ↩️ Retour à l'accueil
                </a>
                <button onclick="telechargerFacture()" class="btn btn-success fw-bold px-4">
                    📥 Télécharger la facture (PDF)
                </button>
            </div>

            <div id="section-facture" class="card shadow-sm border-0 p-5 bg-white rounded-3">
                
                <div class="row mb-4">
                    <div class="col-sm-6">
                        <h2 class="fw-bold" style="color: #0D3249;">✨ TravelMood</h2>
                        <p class="text-muted small">
                            Application de Réservation de Voyages<br>
                            Contact: support@travelmood.ma
                        </p>
                    </div>
                    <div class="col-sm-6 text-sm-end">
                        <h3 class="text-uppercase text-secondary fw-bold">Facture</h3>
                        <h5 class="text-dark fw-medium">N° <%= facture.getNumero_facture() %></h5>
                        <p class="text-muted small">Date d'émission : <strong><%= facture.getDate_facture() %></strong></p>
                    </div>
                </div>

                <hr class="my-4">

                <div class="row mb-4">
                    <div class="col-sm-6">
                        <h6 class="text-secondary text-uppercase font-monospace">Détails de la réservation</h6>
                        <p class="mb-1">Réf Réservation : <strong>#<%= reservation.getId_reservation() %></strong></p>
                        <p class="mb-1">Date de Départ : <%= reservation.getDate_depart() %></p>
                        <p class="mb-1">Date d'Arrivée : <%= reservation.getDate_arrivee() %></p>
                    </div>
                    <div class="col-sm-6 text-sm-end">
                        <h6 class="text-secondary text-uppercase font-monospace">Statut du règlement</h6>
                        <span class="badge bg-success fs-6 mt-1">💳 Payé</span>
                        <p class="text-muted small mt-2">Réf Paiement : #<%= facture.getId_paiment() %></p>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-borderless my-4">
                        <thead>
                            <tr class="border-bottom" style="background-color: #f8f9fa;">
                                <th scope="col" class="py-3">Désignation du Voyage</th>
                                <th scope="col" class="text-center py-3">Prix Unitaire</th>
                                <th scope="col" class="text-center py-3">Quantité (Voyageurs)</th>
                                <th scope="col" class="text-end py-3">Total HT</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="border-bottom align-middle">
                                <td class="py-3">
                                    <span class="fw-bold text-dark"><%= sejour.getTitre() %></span><br>
                                    <small class="text-muted">Pack tout inclus - <%= reservation.getNbr_chambre() %> chambre(s)</small>
                                </td>
                                <td class="text-center py-3"><%= sejour.getPrix() %> DH</td>
                                <td class="text-center py-3"><%= reservation.getNb_places() %></td>
                                <td class="text-end fw-bold py-3"><%= paiement.getMontant() %> DH</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="row justify-content-end mt-3">
                    <div class="col-sm-5 text-sm-end">
                        <div class="d-flex justify-content-between border-bottom pb-2">
                            <span class="text-secondary">Frais de dossier :</span>
                            <span class="text-success fw-bold">Offerts</span>
                        </div>
                        <div class="d-flex justify-content-between pt-3 align-items-center">
                            <span class="fs-5 fw-bold text-dark">Montant Total :</span>
                            <span class="fs-3 fw-bold text-danger"><%= paiement.getMontant() %> DH</span>
                        </div>
                    </div>
                </div>

                <hr class="my-5">
                
                <div class="text-center text-muted small">
                    <p class="mb-1">Merci pour votre confiance et excellent voyage avec TravelMood !</p>
                </div>

            </div> </div>
    </div>
</div>

<script>
    // Déclenche l'imprimante native ou l'enregistrement PDF du navigateur
    function telechargerFacture() {
        window.print();
    }
</script>

<jsp:include page="footer.jsp" />