<%@ page import="model.Course" %>
<%@ page import="java.util.ArrayList" %>

<div class="table-responsive">
                <% ArrayList<Course> lesCourses = (ArrayList)request.getAttribute("pLesCourses"); %>
                <table class="table table-striped table-sm">
                    <thead>
                        <tr>
                            <th>id</th>
                            <th>nom</th>
                            <th>lieu</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Course c : lesCourses) { %>
                            <tr>
                                <td><%= c.getId() %></td>
                                <td><a href="<%= request.getContextPath() %>/course-servlet/show?idCourse=<%= c.getId() %>"><%= c.getNom() %></a></td>
                                <td><%= c.getLieu() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>