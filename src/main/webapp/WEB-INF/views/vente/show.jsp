<%@page import="model.Lot"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Vente"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Cheval" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


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
            body { 
                padding-top: 50px; 
            }
            .special { 
                padding-top: 50px; 
            }
            .form-container {
                background-color: #f8f9fa;
                border-radius: 5px;
                padding: 20px;
                margin-top: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .detail-row {
                margin-bottom: 15px;
            }
            .detail-label {
                font-weight: bold;
                color: #555;
            }
            .detail-value {
                padding-top: 7px;
            }
        </style>
 
    </head>
    <body>
        <%@ include file="/WEB-INF/views/header.jsp" %>

        <div class="container special">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="form-container">
                        <% 
                            Vente laVente = (Vente)request.getAttribute("pLaVente");
                            if(laVente != null) 
                            {
                        %>
                                <h2>Détails de la Vente : <%= laVente.getNom() %></h2>

                                <div class="row detail-row">
                                    <div class="col-sm-3 detail-label">Identifiant</div>
                                    <div class="col-sm-9 detail-value"><%= laVente.getId() %></div>
                                </div>

                                <div class="row detail-row">
                                    <div class="col-sm-3 detail-label">Nom</div>
                                    <div class="col-sm-9 detail-value"><%= laVente.getNom() %></div>
                                </div>

                                <div class="row detail-row">
                                    <div class="col-sm-3 detail-label">Date Début Vente</div>
                                    <div class="col-sm-9 detail-value"><%= laVente.getDateDebutVente() %></div>
                                </div>

                                <div class="row detail-row">
                                    <div class="col-sm-3 detail-label">Date Fin Vente</div>
                                    <div class="col-sm-9 detail-value"><%= laVente.getDateFinVente() %></div>
                                </div>

                                <div class="row detail-row">
                                    <div class="col-sm-3 detail-label">Date Début Inscription</div>
                                    <div class="col-sm-9 detail-value"><%= laVente.getDateDebutInscription() %></div>
                                </div>

                                <div class="row detail-row">
                                    <div class="col-sm-3 detail-label">Date Envoi Message</div>
                                    <div class="col-sm-9 detail-value"><%= laVente.getDateEnvoiMessage() %></div>
                                </div>

                                <div class="row detail-row">
                                    <div class="col-sm-3 detail-label">Objet Message</div>
                                    <div class="col-sm-9 detail-value"><%= laVente.getObjetMessage() %></div>
                                </div>

                                <div class="row detail-row">
                                    <div class="col-sm-3 detail-label">Corps Message</div>
                                    <div class="col-sm-9 detail-value"><%= laVente.getCorpsMessage() %></div>
                                </div>

                                <div class="row" style="margin-top: 30px;">
                                    <div class="col-sm-offset-3 col-sm-9">
                                        <a href="<%= request.getContextPath() %>/vente-servlet/list" class="btn btn-default">
                                            <span class="glyphicon glyphicon-arrow-left"></span> Retour à la liste
                                        </a>
                                        <!-- Vous pouvez ajouter d'autres boutons ici, comme Modifier ou Supprimer -->
                                    </div>
                                </div>
                    </div>                                            
                                <h2>Liste des lots</h2>
                                    <% 
                                        ArrayList<Lot> lesLots = (ArrayList<Lot>) request.getAttribute("pLesLots");
                                        if (lesLots != null && !lesLots.isEmpty()) {
                                    %>
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>ID du Lot</th>
                                                    <th>Prix de départ</th>
                                                    <th>Nom du Cheval</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (Lot lot : lesLots) { %>
                                                    <tr>
                                                        <td><%= lot.getId() %></td>
                                                        <td><%= lot.getPrixDepart() %></td>
                                                        <td><a href="<%= request.getContextPath() %>/cheval-servlet/show?idCheval=<%= lot.getId() %>"><%= lot.getCheval().getNom() %></a></td>
                                                    </tr>
                                                <% } %>
                                            </tbody>
                                        </table>
                                    <% 
                                        } else { 
                                    %>
                                        <div class="alert alert-warning">
                                            Aucun lot disponible pour cette vente.
                                        </div>
                                    <% 
                                        } 
                                    %>

                                <% 
                                    } else { 
                                %>
                                    <div class="alert alert-danger">
                                        La vente demandée n'existe pas.
                                    </div>
                                <% 
                                    } 
                                %>           
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Bootstrap JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </body>
</html>