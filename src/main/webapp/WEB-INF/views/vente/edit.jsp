<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Vente" %>
<%@ page import="model.Lieu" %>
<%@ page import="model.CategVente" %>
<%@ page import="java.util.ArrayList" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>



<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Equida - Modifier une vente</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
          crossorigin="anonymous">
    <style>
        body { padding-top: 70px; }
        .form-container {
            background-color: #f8f9fa;
            border-radius: 5px;
            padding: 30px;
            margin-top: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .section-title {
            font-size: 14px;
            font-weight: bold;
            color: #777;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 8px;
            margin-top: 20px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>

<%  Vente laVente = (Vente) request.getAttribute("pLaVente"); %>

<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="form-container">
                <h2>Modifier la vente</h2>

                <% if (request.getAttribute("message") != null) { %>
                    <div class="alert alert-danger">
                        <%= request.getAttribute("message") %>
                    </div>
                <% } %>

                <form class="form-horizontal" action="<%= request.getContextPath() %>/vente-servlet/edit" method="POST">

                    <input type="hidden" name="idVente" value="<%= laVente.getId() %>">

                    <!-- INFORMATIONS GÉNÉRALES -->
                    <div class="section-title">Informations générales</div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">Nom *</label>
                        <div class="col-sm-9">
                            <input type="text" name="nom" class="form-control" required
                                   value="<%= laVente.getNom() != null ? laVente.getNom() : "" %>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">Lieu *</label>
                        <div class="col-sm-9">
                            <select name="lieu_id" class="form-control" required>
                                <option value="">-- Sélectionner un lieu --</option>
                                <%
                                    ArrayList<Lieu> lesLieux = (ArrayList<Lieu>) request.getAttribute("pLesLieux");
                                    if (lesLieux != null) {
                                        for (Lieu lieu : lesLieux) {
                                            boolean selected = laVente.getLieu() != null && laVente.getLieu().getId() == lieu.getId();
                                %>
                                    <option value="<%= lieu.getId() %>" <%= selected ? "selected" : "" %>>
                                        <%= lieu.getVille() %>
                                    </option>
                                <%  }
                                    } %>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">Catégorie</label>
                        <div class="col-sm-9">
                            <select name="categVente_id" class="form-control">
                                <option value="">-- Sélectionner une catégorie --</option>
                                <%
                                    ArrayList<CategVente> lesCategs = (ArrayList<CategVente>) request.getAttribute("pLesCategVentes");
                                    if (lesCategs != null) {
                                        for (CategVente categ : lesCategs) {
                                            boolean selected = laVente.getCategVente() != null && laVente.getCategVente().getId() == categ.getId();
                                %>
                                    <option value="<%= categ.getId() %>" <%= selected ? "selected" : "" %>>
                                        <%= categ.getLibelle() %>
                                    </option>
                                <%  }
                                    } %>
                            </select>
                        </div>
                    </div>

                    <!-- DATES -->
                    <div class="section-title">Dates</div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">Début de vente</label>
                        <div class="col-sm-9">
                            <input type="date" name="dateDebutVente" class="form-control"
                                   value="<%= laVente.getDateDebutVente() != null ? laVente.getDateDebutVente().toString() : "" %>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">Fin de vente</label>
                        <div class="col-sm-9">
                            <input type="date" name="dateFinVente" class="form-control"
                                   value="<%= laVente.getDateFinVente() != null ? laVente.getDateFinVente().toString() : "" %>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">Début d'inscription</label>
                        <div class="col-sm-9">
                            <input type="date" name="dateDebutInscription" class="form-control"
                                   value="<%= laVente.getDateDebutInscription() != null ? laVente.getDateDebutInscription().toString() : "" %>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">Date d'envoi message</label>
                        <div class="col-sm-9">
                            <input type="date" name="dateEnvoiMessage" class="form-control"
                                   value="<%= laVente.getDateEnvoiMessage() != null ? laVente.getDateEnvoiMessage().toString() : "" %>">
                        </div>
                    </div>

                    <!-- MESSAGE -->
                    <div class="section-title">Message aux participants</div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">Objet du message</label>
                        <div class="col-sm-9">
                            <input type="text" name="objetMessage" class="form-control"
                                   value="<%= laVente.getObjetMessage() != null ? laVente.getObjetMessage() : "" %>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">Corps du message</label>
                        <div class="col-sm-9">
                            <textarea name="corpsMessage" class="form-control" rows="5"><%= laVente.getCorpsMessage() != null ? laVente.getCorpsMessage() : "" %></textarea>
                        </div>
                    </div>

                    <!-- BOUTONS -->
                    <div class="form-group" style="margin-top: 25px;">
                        <div class="col-sm-offset-3 col-sm-9">
                            <button type="submit" class="btn btn-warning">
                                <span class="glyphicon glyphicon-floppy-disk"></span> Sauvegarder
                            </button>
                            <a href="<%= request.getContextPath() %>/vente-servlet/show?idVente=<%= laVente.getId() %>" class="btn btn-default">
                                <span class="glyphicon glyphicon-remove"></span> Annuler
                            </a>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
