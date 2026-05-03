<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Equida - Modifier un cheval</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
          crossorigin="anonymous">
    <style>
        body { padding-top: 70px; }
        .form-container {
            background-color: #f8f9fa;
            border-radius: 5px;
            padding: 20px;
            margin-top: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="/equidaweb">Gestion des chevaux</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="form-container">
                <h2>Modifier le cheval</h2>

                <% Cheval leCheval = (Cheval) request.getAttribute("pLeCheval"); %>

                <form class="form-horizontal" action="<%= request.getContextPath() %>/cheval-servlet/edit" method="POST">

                    <input type="hidden" name="idCheval" value="<%= leCheval.getId() %>">

                    <!-- Nom -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Nom *</label>
                        <div class="col-sm-9">
                            <input type="text" name="nom" class="form-control"
                                   value="<%= leCheval.getNom() != null ? leCheval.getNom() : "" %>" required>
                        </div>
                    </div>

                    <!-- Sexe -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Sexe</label>
                        <div class="col-sm-9">
                            <select name="sexe" class="form-control">
                                <option value="">-- Sélectionner --</option>
                                <option value="M" <%= "M".equals(leCheval.getSexe()) ? "selected" : "" %>>Mâle</option>
                                <option value="F" <%= "F".equals(leCheval.getSexe()) ? "selected" : "" %>>Femelle</option>
                            </select>
                        </div>
                    </div>

                    <!-- Code Sire -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Code Sire</label>
                        <div class="col-sm-9">
                            <input type="text" name="codeSire" class="form-control"
                                   value="<%= leCheval.getCodeSire() != null ? leCheval.getCodeSire() : "" %>">
                        </div>
                    </div>

                    <!-- Taille -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Taille (cm)</label>
                        <div class="col-sm-9">
                            <div class="input-group">
                                <input type="number" name="taille" class="form-control" min="50" max="300"
                                       value="<%= leCheval.getTaille() != null ? leCheval.getTaille() : "" %>">
                                <span class="input-group-addon">cm</span>
                            </div>
                        </div>
                    </div>

                    <!-- Poids -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Poids (kg)</label>
                        <div class="col-sm-9">
                            <div class="input-group">
                                <input type="number" name="poids" class="form-control" min="50" max="1500"
                                       value="<%= leCheval.getPoids() != null ? leCheval.getPoids() : "" %>">
                                <span class="input-group-addon">kg</span>
                            </div>
                        </div>
                    </div>

                    <!-- Date de naissance -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Date de naissance</label>
                        <div class="col-sm-9">
                            <input type="date" name="dateNaissance" class="form-control"
                                   value="<%= leCheval.getDateNaissance() != null ? leCheval.getDateNaissance().toString() : "" %>">
                        </div>
                    </div>

                    <!-- Race -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Race *</label>
                        <div class="col-sm-9">
                            <select name="race" class="form-control" required>
                                <option value="">Sélectionnez une race</option>
                                <% ArrayList<Race> lesRaces = (ArrayList<Race>) request.getAttribute("pLesRaces");
                                   if (lesRaces != null) {
                                       for (Race race : lesRaces) { %>
                                           <option value="<%= race.getId() %>"
                                               <%= leCheval.getRace() != null && leCheval.getRace().getId() == race.getId() ? "selected" : "" %>>
                                               <%= race.getNom() %>
                                           </option>
                                <% }} %>
                            </select>
                        </div>
                    </div>

                    <!-- Père -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Père</label>
                        <div class="col-sm-9">
                            <select name="pere_id" class="form-control">
                                <option value="">-- Aucun père --</option>
                                <% ArrayList<Cheval> lesChevaux = (ArrayList<Cheval>) request.getAttribute("pLesChevaux");
                                   if (lesChevaux != null) {
                                       for (Cheval c : lesChevaux) {
                                           if (c.getId() != leCheval.getId()) { %>
                                               <option value="<%= c.getId() %>"
                                                   <%= leCheval.getChevalPere() != null && leCheval.getChevalPere().getId() == c.getId() ? "selected" : "" %>>
                                                   <%= c.getNom() %>
                                               </option>
                                <% }}} %>
                            </select>
                        </div>
                    </div>

                    <!-- Mère -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Mère</label>
                        <div class="col-sm-9">
                            <select name="mere_id" class="form-control">
                                <option value="">-- Aucune mère --</option>
                                <% if (lesChevaux != null) {
                                       for (Cheval c : lesChevaux) {
                                           if (c.getId() != leCheval.getId()) { %>
                                               <option value="<%= c.getId() %>"
                                                   <%= leCheval.getChevalMere() != null && leCheval.getChevalMere().getId() == c.getId() ? "selected" : "" %>>
                                                   <%= c.getNom() %>
                                               </option>
                                <% }}} %>
                            </select>
                        </div>
                    </div>

                    <!-- Vendeur -->
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Vendeur</label>
                        <div class="col-sm-9">
                            <select name="vendeur" class="form-control">
                                <option value="">-- Sélectionner un vendeur --</option>
                                <% ArrayList<Vendeur> lesVendeurs = (ArrayList<Vendeur>) request.getAttribute("pLesVendeurs");
                                   if (lesVendeurs != null) {
                                       for (Vendeur v : lesVendeurs) { %>
                                           <option value="<%= v.getId() %>"
                                               <%= leCheval.getVendeur() == v.getId() ? "selected" : "" %>>
                                               <%= v.getNom() %>
                                           </option>
                                <% }} %>
                            </select>
                        </div>
                    </div>

                    <!-- Boutons -->
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-9">
                            <button type="submit" class="btn btn-warning">
                                <span class="glyphicon glyphicon-floppy-disk"></span> Sauvegarder
                            </button>
                            <a href="javascript:history.back()" class="btn btn-default">
                                <span class="glyphicon glyphicon-remove"></span> Annuler
                            </a>
                        </div>
                    </div>

                    <% if (request.getAttribute("message") != null) { %>
                        <div class="alert alert-danger">
                            <%= request.getAttribute("message") %>
                        </div>
                    <% } %>

                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>