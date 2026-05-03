<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Cheval" %>
<%@ page import="model.Race" %>
<%@ page import="java.util.ArrayList" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


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
        <%@ include file="/WEB-INF/views/header.jsp" %>

        <div class="container special">
            <div class="header-actions">
                <h2 class="h2">Liste des chevaux</h2>
                <a href="<%= request.getContextPath() %>/cheval-servlet/add" class="btn btn-primary">
                    <span class="glyphicon glyphicon-plus"></span> Ajouter un cheval
                </a>
            </div>
            
            <div class="table-responsive">
                <% ArrayList<Cheval> lesChevaux = (ArrayList)request.getAttribute("pLesChevaux"); %>
                <table class="table table-striped table-sm">
                    <thead>
                        <tr>
                            <th>id</th>
                            <th>nom</th>
                            <th>race</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Cheval c : lesChevaux) { %>
                            <tr>
                                <td><%= c.getId() %></td>
                                <td><a href="<%= request.getContextPath() %>/cheval-servlet/show?idCheval=<%= c.getId() %>"><%= c.getNom() %></a></td>
                                <td><%= c.getRace().getNom() %></td>
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