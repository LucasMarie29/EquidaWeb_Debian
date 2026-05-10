<%@ page import="model.Course" %>
<% Course laCourse = (Course) request.getAttribute("pLaCourse"); %>

                    <div class="form-container">
                        <% if (laCourse != null) { %>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Identifiant</div>
                                <div class="col-sm-9 detail-value"><%= laCourse.getId() %></div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Nom</div>
                                <div class="col-sm-9 detail-value"><%= laCourse.getNom() %></div>
                            </div>


                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Lieu</div>
                                <div class="col-sm-9 detail-value">
                                    <%= laCourse.getLieu() != null ? laCourse.getLieu() : "Non renseignée" %>
                                </div>
                            </div>

                            <div class="row detail-row">
                                <div class="col-sm-3 detail-label">Date</div>
                                <div class="col-sm-9 detail-value">
                                    <%= laCourse.getDate() != null ? laCourse.getDate() : "Non renseigné" %>
                                </div>
                            </div>
                        <% } else { %>
                            <a href="<%= request.getContextPath() %>/course-servlet/list" class="btn btn-default">
                                <span class="glyphicon glyphicon-arrow-left"></span> Retour à la liste
                            </a>
                        <% } %>
                    </div>