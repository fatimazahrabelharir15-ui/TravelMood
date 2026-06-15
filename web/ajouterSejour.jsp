<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="header.jsp" %>
<%@ page import="java.util.ArrayList" %>

<%
ArrayList<String> listeHumeurs =
    (ArrayList<String>) request.getAttribute("listeHumeurs");

ArrayList<String> listeTypes =
    (ArrayList<String>) request.getAttribute("listeTypes");
%>

<div class="container py-5">

    <div class="row justify-content-center">

        <div class="col-lg-8">

            <div class="card shadow-lg border-0 rounded-4">

                <div class="card-header text-white text-center py-4"
                     style="background-color:#0D3249;">

                    <h2 class="fw-bold mb-0">
                        Ajouter un nouveau séjour
                    </h2>

                    <p class="mb-0 mt-2 opacity-75">
                        Renseignez les informations du voyage
                    </p>

                </div>

                <div class="card-body p-5">

<form action="AdminControlleur"
      method="post"
      enctype="multipart/form-data">
                        <!-- Titre -->

                        <div class="mb-4">

                            <label class="form-label fw-bold">
                                Titre du séjour*
                            </label>

                            <input
                                type="text"
                                name="titre"
                                class="form-control form-control-lg"
                                required>

                        </div>

                        <!-- Description -->

                        <div class="mb-4">

                            <label class="form-label fw-bold">
                                Description
                            </label>

                            <textarea
                                name="description"
                                class="form-control"
                                rows="5"
                                placeholder="Décrivez ce séjour..." ></textarea>

                        </div>

                        <!-- Humeur + Type -->

                        <div class="row">

                            <div class="col-md-6 mb-4">

                                <label class="form-label fw-bold">
                                    Humeur*
                                </label>
                                

                                <select name="humeur" class="form-select form-select-lg" required>

    <option value="">-- Choisir une humeur --</option>

    <%
    if (listeHumeurs != null) {
        for (String humeur : listeHumeurs) {
    %>

        <option value="<%= humeur %>">
            <%= humeur %>
        </option>

    <%
        }
    }
    %>

</select>

                            </div>

                            <div class="col-md-6 mb-4">

                                <label class="form-label fw-bold">
                                    Type de vacances*
                                </label>
                                

                                <select name="typeVacance" class="form-select form-select-lg" required>

    <option value="">-- Choisir un type --</option>

    <%
    if (listeTypes != null) {
        for (String type : listeTypes) {
    %>

        <option value="<%= type %>">
            <%= type %>
        </option>

    <%
        }
    }
    %>

</select>

                            </div>

                        </div>

                        <!-- Prix + Image -->

                        <div class="row">

                            <div class="col-md-6 mb-4">

                                <label class="form-label fw-bold">
                                    Prix (DH)*
                                </label>

                                <input
                                    type="number"
                                    step="0.01"
                                    name="prix"
                                    class="form-control"
                                    required>

                            </div>

                            <div class="col-md-6 mb-4">

                                <div class="mb-4">
    <label class="form-label fw-bold" >
        Image du séjour*
    </label>

    <input
        type="file"
        name="image"
        class="form-control form-control-lg"
        accept="image/*"
        required>

    <div class="form-text">
        Formats acceptés : JPG, JPEG, PNG.
    </div>
</div>

                            </div>

                        </div>

                        <!-- Boutons -->

                        <div class="d-flex justify-content-end gap-3 mt-4">

    <a href="AdminControlleur?tab=sejours"
       class="btn btn-outline-secondary px-4 py-2">
        Annuler
    </a>

    <button type="submit"
            class="btn text-white px-5 py-2"
            style="background-color:#E86E4D;">
        Ajouter le séjour
    </button>

</div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

<%@ include file="footer.jsp" %>