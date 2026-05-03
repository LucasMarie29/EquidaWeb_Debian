<%@page import="model.Vente"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Equida</title>
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
            .header-actions {
                margin-bottom: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <a href='/equidaweb' class="navbar-brand">
                        Système de gestion des ventes
                    </a>
                </div>
            </div>
        </nav>

        <div class="container special">
            <div class="header-actions">
                <h2 class="h2">Liste des ventes</h2>
                <a href="<%= request.getContextPath() %>/vente-servlet/add" class="btn btn-primary">
                    <span class="glyphicon glyphicon-plus"></span> Ajouter une vente
                </a>
            </div>
            

            
            <div class="table-responsive">
                <% ArrayList<Vente> lesVentes = (ArrayList)request.getAttribute("pLesVentes"); %>
                <table class="table table-striped table-sm">
                    <thead>
                        <tr>
                            <th>id</th>
                            <th>nom</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Vente v : lesVentes) { %>
                            <tr>
                                <td><%= v.getId() %></td>
                                <td><a href="<%= request.getContextPath() %>/vente-servlet/show?idVente=<%= v.getId() %>"><%= v.getNom() %></a></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <a href="javascript:history.back()" class="btn btn-default">
                <span class="glyphicon glyphicon-arrow-left"></span> Retour
            </a>
        </div>
        
        <!-- Bootstrap JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </body>
</html>