<%@page import="java.util.List"%>
<%@page import="model.Vendeur"%>
<%@page import="model.Cheval"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Race" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Equida - Ajouter un cheval</title>
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
        </style>
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="/equidaweb">
                        Gestion des chevaux
                    </a>
                </div>
            </div>
        </nav>

        <div class="container special">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="form-container">
                        <h2>Ajouter un nouveau cheval</h2>
                        
                        <form class="form-horizontal" action="<%= request.getContextPath() %>/cheval-servlet/add" method="POST">
                            
                            <!-- Nom du cheval -->
                            <div class="form-group">
                                <label for="nom" class="col-sm-3 control-label">Nom *</label>
                                <div class="col-sm-9">
                                    <input type="text" name="nom" id="nom" class="form-control" required>
                                </div>
                            </div>
                            
                            <!-- Père -->
                            <div class="form-group">
                                <label for="pere" class="col-sm-3 control-label">Père</label>
                                <div class="col-sm-9">
                                   <select name="pere_id" id="pere" class="form-control">
                                        <option value="">-- Aucun père --</option>
                                        <% 
                                            ArrayList<Cheval> lesPeres = (ArrayList<Cheval>) request.getAttribute("pLesChevaux");
                                            if (lesPeres != null) {
                                                for (Cheval pere : lesPeres) { %>
                                                    <option value="<%= pere.getId() %>"><%= pere.getNom() %></option>
                                        <%      }
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>

                            <!-- Mère -->
                            <div class="form-group">
                                <label for="mere" class="col-sm-3 control-label">Mère</label>
                                <div class="col-sm-9">
                                    <select name="mere_id" id="mere" class="form-control">
                                        <option value="">-- Aucune mère --</option>
                                        <% 
                                            ArrayList<Cheval> lesMeres = (ArrayList<Cheval>) request.getAttribute("pLesChevaux");
                                            if (lesMeres != null) {
                                                for (Cheval mere : lesMeres) { %>
                                                    <option value="<%= mere.getId() %>"><%= mere.getNom() %></option>
                                        <%      }
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>

                            <!-- Sexe -->
                            <div class="form-group">
                                <label for="sexe" class="col-sm-3 control-label">Sexe *</label>
                                <div class="col-sm-9">
                                    <select name="sexe" id="sexe" class="form-control" required>
                                        <option value="">-- Sélectionner --</option>
                                        <option value="M">Mâle</option>
                                        <option value="F">Femelle</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="codeSire" class="col-sm-3 control-label">Code sire *</label>
                                <div class="col-sm-9">
                                    <input type="text" name="codeSire" id="codeSire" class="form-control" required>
                                </div>
                            </div>

                            <!-- Taille -->
                            <div class="form-group">
                                <label for="taille" class="col-sm-3 control-label">Taille (cm)</label>
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <input type="number" name="taille" id="taille" class="form-control" min="50" max="300" placeholder="ex: 165">
                                        <span class="input-group-addon">cm</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Poids -->
                            <div class="form-group">
                                <label for="poids" class="col-sm-3 control-label">Poids (kg)</label>
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <input type="number" name="poids" id="poids" class="form-control" min="50" max="1500" placeholder="ex: 500">
                                        <span class="input-group-addon">kg</span>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Date de naissance -->
                            <div class="form-group">
                                <label for="dateNaissance" class="col-sm-3 control-label">Date de naissance</label>
                                <div class="col-sm-9">
                                    <input type="date" name="dateNaissance" id="dateNaissance" class="form-control">
                                </div>
                            </div>

                            <!-- Race -->
                            <div class="form-group">
                                <label for="race" class="col-sm-3 control-label">Race *</label>
                                <div class="col-sm-9">
                                    <select name="race" id="race" class="form-control" required>
                                        <option value="">-- Sélectionnez une race --</option>
                                        <% ArrayList<Race> lesRaces = (ArrayList<Race>)request.getAttribute("pLesRaces");
                                           if (lesRaces != null) {
                                               for(Race race : lesRaces) { %>
                                                   <option value="<%= race.getId() %>">
                                                       <%= race.getNom() %>
                                                   </option>
                                        <% }} %>
                                    </select>
                                </div>
                            </div>

                            <!-- Vendeur -->
                            <div class="form-group">
                                <label for="vendeur" class="col-sm-3 control-label">Vendeur *</label>
                                <div class="col-sm-9">
                                    <select class="form-control" id="vendeur" name="vendeur" required>
                                        <option value="">-- Sélectionner un vendeur --</option>
                                        <%
                                            ArrayList<Vendeur> lesVendeurs = (ArrayList<Vendeur>) request.getAttribute("pLesVendeurs");
                                            if (lesVendeurs != null) {
                                                for (Vendeur v : lesVendeurs) { %>
                                                    <option value="<%= v.getId() %>"><%= v.getNom() %></option>
                                        <%      }
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>

                            <!-- Boutons -->
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <button type="submit" class="btn btn-primary">
                                        <span class="glyphicon glyphicon-plus"></span> Ajouter
                                    </button>
                                    <a href="<%= request.getContextPath() %>/cheval-servlet/list" class="btn btn-default">
                                        <span class="glyphicon glyphicon-remove"></span> Annuler
                                    </a>
                                </div>
                            </div>

                            <!-- Message d'erreur -->
                            <% if(request.getAttribute("message") != null) { %>
                                <div class="alert alert-danger">
                                    <%= request.getAttribute("message") %>
                                </div>
                            <% } %>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Bootstrap JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </body>
</html>