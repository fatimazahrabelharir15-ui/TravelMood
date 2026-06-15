
<%@page import="Entite.Sejour"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    Sejour s = (Sejour) request.getAttribute("sejour");
%>

<%@ include file="header.jsp" %>

<div class="container py-5">

    <div class="row justify-content-center">

        <div class="col-lg-8">

            <div class="card shadow-lg border-0 rounded-4">

                <div class="card-header text-white text-center py-4"
                     style="background-color:#0D3249;">

                    <h2 class="fw-bold mb-0">
                        Modifier le séjour
                    </h2>

                    <p class="mb-0 mt-2 opacity-75">
                        Modifiez les informations du voyage
                    </p>

                </div>

                <div class="card-body p-5">

                    <form action="AdminControlleur" method="post">

                        <input type="hidden" name="action" value="modifier">

                        <input type="hidden"
                               name="id"
                               value="<%= s.getId() %>">

                        <div class="mb-4">
                            <label class="form-label fw-bold">
                                Titre du séjour
                            </label>

                            <input
                                type="text"
                                name="titre"
                                class="form-control form-control-lg"
                                value="<%= s.getTitre() %>"
                                required>
                        </div>

                        <div class="mb-4">

                            <label class="form-label fw-bold">
                                Description
                            </label>

                            <textarea
                                name="description"
                                class="form-control"
                                rows="5"
                                required><%= s.getDescription() %></textarea>

                        </div>

                        <div class="row">

                            <div class="col-md-6 mb-4">

                                <label class="form-label fw-bold">
                                    Humeur
                                </label>

                                <input
                                    type="text"
                                    name="humeur"
                                    class="form-control"
                                    value="<%= s.getHumeur() %>">

                            </div>

                            <div class="col-md-6 mb-4">

                                <label class="form-label fw-bold">
                                    Type de vacances
                                </label>

                                <input
                                    type="text"
                                    name="typeVacance"
                                    class="form-control"
                                    value="<%= s.getTypeVacance() %>">

                            </div>

                        </div>

                        <div class="row">

                            <div class="col-md-6 mb-4">

                                <label class="form-label fw-bold">
                                    Prix (DH)
                                </label>

                                <input
                                    type="number"
                                    step="0.01"
                                    name="prix"
                                    class="form-control"
                                    value="<%= s.getPrix() %>"
                                    required>

                            </div>

                            <div class="col-md-6 mb-4">

                                <label class="form-label fw-bold">
                                    Nom de l'image
                                </label>

                                <input
                                    type="text"
                                    name="image"
                                    class="form-control"
                                    value="<%= s.getImage() %>">

                            </div>

                        </div>

                        <div class="mb-4 text-center">

                            <label class="form-label fw-bold d-block">
                                Aperçu de l'image actuelle
                            </label>

                            <img
                                src="<%= request.getContextPath() %>/images/<%= s.getImage() %>"
                                alt="Image du séjour"
                                class="img-fluid rounded shadow"
                                style="max-height:250px;">

                        </div>

                        <div class="d-flex justify-content-end gap-3 mt-4">

                            <a href="AdminControlleur?tab=sejours"
                               class="btn btn-outline-secondary btn-lg">
                                Annuler
                            </a>

                            <button
                                type="submit"
                                class="btn btn-lg text-white"
                                style="background-color:#E86E4D;">

                                Enregistrer les modifications

                            </button>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

<%@ include file="footer.jsp" %>
```