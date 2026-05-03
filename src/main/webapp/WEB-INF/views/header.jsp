<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="<%= request.getContextPath() %>/index.jsp">
                🐴 Equida
            </a>
        </div>

        <div class="collapse navbar-collapse" id="navbar">
            <ul class="nav navbar-nav">

                <!-- Home -->
                <li>
                    <a href="<%= request.getContextPath() %>/index.jsp">
                        <span class="glyphicon glyphicon-home"></span> Home
                    </a>
                </li>

                <!-- Chevaux -->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <span class="glyphicon glyphicon-th-list"></span> Chevaux
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="<%= request.getContextPath() %>/cheval-servlet/list">
                                <span class="glyphicon glyphicon-list"></span> Liste des chevaux
                            </a>
                        </li>
                        <li>
                            <a href="<%= request.getContextPath() %>/cheval-servlet/add">
                                <span class="glyphicon glyphicon-plus"></span> Ajouter un cheval
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- Ventes -->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <span class="glyphicon glyphicon-usd"></span> Ventes
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="<%= request.getContextPath() %>/vente-servlet/list">
                                <span class="glyphicon glyphicon-list"></span> Liste des ventes
                            </a>
                        </li>
                        <li>
                            <a href="<%= request.getContextPath() %>/vente-servlet/add">
                                <span class="glyphicon glyphicon-plus"></span> Ajouter une vente
                            </a>
                        </li>
                    </ul>
                </li>

            </ul>
        </div>
    </div>
</nav>