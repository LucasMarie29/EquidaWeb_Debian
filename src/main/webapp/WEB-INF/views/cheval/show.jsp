<%@page import="model.ChevalCourse"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Cheval" %>
<%@page import="model.Vendeur"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<% Cheval leCheval = (Cheval) request.getAttribute("pLeCheval"); %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Equida - Détails du cheval</title>
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
        </style>
    </head>
    <body>
        <%@ include file="/WEB-INF/views/header.jsp" %>

        <div class="container special">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">

                    <div class="header-actions">
                        <h2>Détails du cheval : <%= leCheval != null ? leCheval.getNom() : "" %></h2>
                        <div>
                            <a href="javascript:history.back()" class="btn btn-default">
                                <span class="glyphicon glyphicon-arrow-left"></span> Retour
                            </a>
                            <% if (leCheval != null) { %>
                                <a href="<%= request.getContextPath() %>/cheval-servlet/edit?idCheval=<%= leCheval.getId() %>"
                                   class="btn btn-warning">
                                    <span class="glyphicon glyphicon-pencil"></span> Modifier
                                </a>
                                <a href="<%= request.getContextPath() %>/cheval-servlet/delete?idCheval=<%= leCheval.getId() %>"
                                   class="btn btn-danger"
                                   onclick="return confirm('Supprimer ce cheval ?')">
                                    <span class="glyphicon glyphicon-trash"></span> Supprimer
                                </a>
                            <% } %>
                        </div>
                    </div>

                    <div class="form-container">
                        <% if (leCheval != null) { %>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Identifiant</div>
                                <div class="col-sm-9 detail-value"><%= leCheval.getId() %></div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Nom</div>
                                <div class="col-sm-9 detail-value"><%= leCheval.getNom() %></div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Date de naissance</div>
                                <div class="col-sm-9 detail-value">
                                    <%= leCheval.getDateNaissance() != null ? leCheval.getDateNaissance() : "Non renseignée" %>
                                </div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Race</div>
                                <div class="col-sm-9 detail-value">
                                    <%= leCheval.getRace() != null ? leCheval.getRace().getNom() : "Non renseignée" %>
                                </div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Père</div>
                                <div class="col-sm-9 detail-value">
                                    <%= leCheval.getChevalPere() != null ? leCheval.getChevalPere().getNom() : "Non renseigné" %>
                                </div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Mère</div>
                                <div class="col-sm-9 detail-value">
                                    <%= leCheval.getChevalMere() != null ? leCheval.getChevalMere().getNom() : "Non renseignée" %>
                                </div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Sexe</div>
                                <div class="col-sm-9 detail-value">
                                    <%
                                        String sexe = leCheval.getSexe();
                                        if ("M".equals(sexe)) { %>Mâle
                                    <% } else if ("F".equals(sexe)) { %>Femelle
                                    <% } else { %>Non renseigné
                                    <% } %>
                                </div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Code Sire</div>
                                <div class="col-sm-9 detail-value">
                                    <%= leCheval.getCodeSire() != null && !leCheval.getCodeSire().isEmpty() ? leCheval.getCodeSire() : "Non renseigné" %>
                                </div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Taille</div>
                                <div class="col-sm-9 detail-value">
                                    <%= leCheval.getTaille() != null && !leCheval.getTaille().isEmpty() ? leCheval.getTaille() + " cm" : "Non renseignée" %>
                                </div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Poids</div>
                                <div class="col-sm-9 detail-value">
                                    <%= leCheval.getPoids() != null && !leCheval.getPoids().isEmpty() ? leCheval.getPoids() + " kg" : "Non renseigné" %>
                                </div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Vendeur</div>
                                <div class="col-sm-9 detail-value">
                                    <%
                                        ArrayList<Vendeur> lesVendeurs = (ArrayList<Vendeur>) request.getAttribute("pLesVendeurs");
                                        String nomVendeur = "Non renseigné";
                                        if (lesVendeurs != null && leCheval.getVendeur() != 0) {
                                            for (Vendeur v : lesVendeurs) {
                                                if (v.getId() == leCheval.getVendeur()) {
                                                    nomVendeur = v.getNom();
                                                    break;
                                                }
                                            }
                                        }
                                    %>
                                    <%= nomVendeur %>
                                </div>
                            </div>

                            <%
                                ArrayList<ChevalCourse> lesChevauxCourses = (ArrayList<ChevalCourse>) request.getAttribute("pLesCoursesChevaux");
                                if (lesChevauxCourses != null && !lesChevauxCourses.isEmpty()) {
                            %>
                            <h4>Courses</h4>
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Nom de la course</th>
                                        <th>Position</th>
                                        <th>Temps</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (ChevalCourse chevalCourse : lesChevauxCourses) { %>
                                        <tr>
                                            <td><%= chevalCourse.getCourse().getNom() %></td>
                                            <td><%= chevalCourse.getPosition() %></td>
                                            <td><%= chevalCourse.getTemps() %></td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                            <% } %>

                        <% } else { %>
                            <div class="alert alert-danger">
                                Le cheval demandé n'existe pas.
                            </div>
                            <a href="<%= request.getContextPath() %>/cheval-servlet/list" class="btn btn-default">
                                <span class="glyphicon glyphicon-arrow-left"></span> Retour à la liste
                            </a>
                        <% } %>
                    </div>

                </div>
            </div>
        </div>

        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </body>
</html>