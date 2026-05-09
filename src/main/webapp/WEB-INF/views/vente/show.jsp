<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Vente" %>
<%@ page import="model.Lot" %>
<%@ page import="java.util.ArrayList" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<% Vente laVente = (Vente) request.getAttribute("pLaVente"); %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Equida - Détails de la vente</title>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
              integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
              crossorigin="anonymous">
        <style>
            body { padding-top: 50px; }
            .special { padding-top: 50px; }
            .form-container {
                background-color: #f8f9fa;
                border-radius: 5px;
                padding: 20px;
                margin-top: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .detail-row { margin-bottom: 15px; }
            .detail-label { font-weight: bold; color: #555; }
            .detail-value { padding-top: 7px; }
            .header-actions {
                margin-bottom: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
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

        <div class="container special">
            <div class="row">
                <div class="col-md-10 col-md-offset-1">

                    <div class="header-actions">
                        <h2>Détails de la vente : <%= laVente != null ? laVente.getNom() : "" %></h2>
                        <div>
                            <a href="<%= request.getContextPath() %>/vente-servlet/list" class="btn btn-default">
                                <span class="glyphicon glyphicon-arrow-left"></span> Retour
                            </a>
                            <% if (laVente != null) { %>
                                <a href="<%= request.getContextPath() %>/vente-servlet/edit?idVente=<%= laVente.getId() %>"
                                   class="btn btn-warning">
                                    <span class="glyphicon glyphicon-pencil"></span> Modifier
                                </a>
                                <a href="<%= request.getContextPath() %>/vente-servlet/delete?idVente=<%= laVente.getId() %>"
                                   class="btn btn-danger"
                                   onclick="return confirm('Supprimer définitivement cette vente ?')">
                                    <span class="glyphicon glyphicon-trash"></span> Supprimer
                                </a>
                            <% } %>
                        </div>
                    </div>

                    <div class="form-container">
                        <% if (laVente != null) { %>

                            <!-- INFORMATIONS GÉNÉRALES -->
                            <div class="section-title">Informations générales</div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Identifiant</div>
                                <div class="col-sm-9 detail-value"><%= laVente.getId() %></div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Nom</div>
                                <div class="col-sm-9 detail-value"><%= laVente.getNom() %></div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Lieu</div>
                                <div class="col-sm-9 detail-value">
                                    <%= laVente.getLieu() != null ? laVente.getLieu().getVille() : "Non renseigné" %>
                                </div>
                            </div>

                            <!-- DATES -->
                            <div class="section-title">Dates</div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Début de vente</div>
                                <div class="col-sm-9 detail-value">
                                    <%= laVente.getDateDebutVente() != null ? laVente.getDateDebutVente() : "Non renseignée" %>
                                </div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Fin de vente</div>
                                <div class="col-sm-9 detail-value">
                                    <%= laVente.getDateFinVente() != null ? laVente.getDateFinVente() : "Non renseignée" %>
                                </div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Début d'inscription</div>
                                <div class="col-sm-9 detail-value">
                                    <%= laVente.getDateDebutInscription() != null ? laVente.getDateDebutInscription() : "Non renseignée" %>
                                </div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Date d'envoi message</div>
                                <div class="col-sm-9 detail-value">
                                    <%= laVente.getDateEnvoiMessage() != null ? laVente.getDateEnvoiMessage() : "Non renseignée" %>
                                </div>
                            </div>

                            <!-- MESSAGE -->
                            <div class="section-title">Message aux participants</div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Objet</div>
                                <div class="col-sm-9 detail-value">
                                    <%= laVente.getObjetMessage() != null && !laVente.getObjetMessage().isEmpty() ? laVente.getObjetMessage() : "Non renseigné" %>
                                </div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Corps</div>
                                <div class="col-sm-9 detail-value">
                                    <%= laVente.getCorpsMessage() != null && !laVente.getCorpsMessage().isEmpty() ? laVente.getCorpsMessage() : "Non renseigné" %>
                                </div>
                            </div>

                            <!-- LOTS -->
                            <%
                                ArrayList<Lot> lesLots = (ArrayList<Lot>) request.getAttribute("pLesLots");
                                if (lesLots != null && !lesLots.isEmpty()) {
                            %>
                            <div class="section-title">Lots</div>
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Cheval</th>
                                        <th>Prix de départ</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Lot lot : lesLots) { %>
                                        <tr>
                                            <td><%= lot.getId() %></td>
                                            <td><%= lot.getCheval() != null ? lot.getCheval().getNom() : "N/A" %></td>
                                            <td><%= lot.getPrixDepart() %> €</td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                            <% } %>

                        <% } else { %>
                            <div class="alert alert-danger">
                                La vente demandée n'existe pas.
                            </div>
                            <a href="<%= request.getContextPath() %>/vente-servlet/list" class="btn btn-default">
                                <span class="glyphicon glyphicon-arrow-left"></span> Retour à la liste
                            </a>
                        <% } %>
                    </div>

                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </body>
</html>
