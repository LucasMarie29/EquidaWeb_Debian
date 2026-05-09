<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Lieu" %>
<%@ page import="model.CategVente" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Equida - Ajouter une vente</title>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
              integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
              crossorigin="anonymous">
        <style>
            body {
                padding-top: 50px;
            }
            .special {
                padding-top: 50px;
            }
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

        <div class="container special">
            <div class="row">
                <div class="col-md-10 col-md-offset-1">
                    <div class="form-container">
                        <h2>Ajouter une nouvelle vente</h2>

                        <!-- Message d'erreur -->
                        <% if(request.getAttribute("message") != null) { %>
                            <div class="alert alert-danger">
                                <%= request.getAttribute("message") %>
                            </div>
                        <% } %>

                        <form class="form-horizontal" action="<%= request.getContextPath() %>/vente-servlet/add" method="POST">

                            <!-- INFORMATIONS GÉNÉRALES -->
                            <div class="section-title">Informations générales</div>

                            <div class="form-group">
                                <label for="nom" class="col-sm-3 control-label">Nom *</label>
                                <div class="col-sm-9">
                                    <input type="text" name="nom" id="nom" class="form-control" required
                                           value="<%= request.getAttribute("pNom") != null ? request.getAttribute("pNom") : "" %>">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="lieu_id" class="col-sm-3 control-label">Lieu *</label>
                                <div class="col-sm-9">
                                    <select name="lieu_id" id="lieu_id" class="form-control" required>
                                        <option value="">-- Sélectionner un lieu --</option>
                                        <%
                                            ArrayList<model.Lieu> lesLieux = (ArrayList<model.Lieu>) request.getAttribute("pLesLieux");
                                            if (lesLieux != null) {
                                                for (model.Lieu lieu : lesLieux) {
                                        %>
                                            <option value="<%= lieu.getId() %>"><%= lieu.getVille() %></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="categVente_id" class="col-sm-3 control-label">Catégorie</label>
                                <div class="col-sm-9">
                                    <select name="categVente_id" id="categVente_id" class="form-control">
                                        <option value="">-- Sélectionner une catégorie --</option>
                                        <%
                                            ArrayList<model.CategVente> lesCategs = (ArrayList<model.CategVente>) request.getAttribute("pLesCategVentes");
                                            if (lesCategs != null) {
                                                for (model.CategVente categ : lesCategs) {
                                        %>
                                            <option value="<%= categ.getId() %>"><%= categ.getLibelle() %></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>

                            <!-- DATES -->
                            <div class="section-title">Dates</div>

                            <div class="form-group">
                                <label for="dateDebutVente" class="col-sm-3 control-label">Début de vente</label>
                                <div class="col-sm-9">
                                    <input type="date" name="dateDebutVente" id="dateDebutVente" class="form-control">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="dateFinVente" class="col-sm-3 control-label">Fin de vente</label>
                                <div class="col-sm-9">
                                    <input type="date" name="dateFinVente" id="dateFinVente" class="form-control">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="dateDebutInscription" class="col-sm-3 control-label">Début d'inscription</label>
                                <div class="col-sm-9">
                                    <input type="date" name="dateDebutInscription" id="dateDebutInscription" class="form-control">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="dateEnvoiMessage" class="col-sm-3 control-label">Date d'envoi message</label>
                                <div class="col-sm-9">
                                    <input type="date" name="dateEnvoiMessage" id="dateEnvoiMessage" class="form-control">
                                </div>
                            </div>

                            <!-- MESSAGE -->
                            <div class="section-title">Message aux participants</div>

                            <div class="form-group">
                                <label for="objetMessage" class="col-sm-3 control-label">Objet du message</label>
                                <div class="col-sm-9">
                                    <input type="text" name="objetMessage" id="objetMessage" class="form-control"
                                           placeholder="Objet de l'email envoyé aux participants">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="corpsMessage" class="col-sm-3 control-label">Corps du message</label>
                                <div class="col-sm-9">
                                    <textarea name="corpsMessage" id="corpsMessage" class="form-control" rows="5"
                                              placeholder="Contenu de l'email envoyé aux participants"></textarea>
                                </div>
                            </div>

                            <!-- BOUTONS -->
                            <div class="form-group" style="margin-top: 25px;">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <button type="submit" class="btn btn-primary">
                                        <span class="glyphicon glyphicon-plus"></span> Ajouter
                                    </button>
                                    <a href="<%= request.getContextPath() %>/vente-servlet/list" class="btn btn-default">
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
