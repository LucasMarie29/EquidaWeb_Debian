package servlet;

import database.DaoCheval;
import database.DaoCourse;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cheval;
import model.Course;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "courseServlet", value = "/course-servlet/*")
public class CourseServlet extends HttpServlet {

    Connection cnx;

    @Override
    public void init() {
        ServletContext servletContext = getServletContext();
        cnx = (Connection)servletContext.getAttribute("connection");
        try {
            System.out.println("INIT SERVLET=" + cnx.getSchema());
        } catch (SQLException ex) {
            Logger.getLogger(ChevalServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String path = request.getPathInfo();
        System.out.println("PathInfo: " + path);

        if ("/list".equals(path)) {
            ArrayList<Course> lesCourses = DaoCourse.getLesCourses(cnx);
            request.setAttribute("pLesCourses", lesCourses);
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/course/list.jsp").forward(request, response);
        }
        if ("/show".equals(path)) {
            try {
                int idCourse = Integer.parseInt(request.getParameter("idCourse"));
                Course laCourse = DaoCourse.getLaCourse(cnx, idCourse);
                if (laCourse != null) {
                    request.setAttribute("pLaCourse", laCourse);
                    this.getServletContext().getRequestDispatcher("/WEB-INF/views/course/show.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                System.out.println("Erreur : l'id de la course n'est pas un nombre valide");
                response.sendRedirect(request.getContextPath() + "/course-servlet/list");
            }

        }
    }
    public void destroy() {
    }

}
