package database;

import jakarta.servlet.ServletContext;
import model.Course;
import model.Vente;
import org.checkerframework.checker.units.qual.A;

import java.sql.*;
import java.util.ArrayList;

public class DaoCourse {
    Connection cnx;
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    public static ArrayList<Course> getLesCourses(Connection cnx) {
        ArrayList<Course> lesCourses = new ArrayList<Course>();
        try {
            requeteSql = cnx.prepareStatement(
                    "SELECT id, nom, lieu, date " +
                         "FROM course "
            );
            resultatRequete = requeteSql.executeQuery();
            while (resultatRequete.next()) {
                Course c = new Course();
                c.setId(resultatRequete.getInt("id"));
                c.setNom(resultatRequete.getString("nom"));
                c.setLieu(resultatRequete.getString("lieu"));
                c.setDate(resultatRequete.getDate("date"));
                lesCourses.add(c);
            }


        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLesCourses a généré une exception SQL");
        }
        return lesCourses;

    }
    public static Course getLaCourse(Connection cnx, int idCourse){
        Course course = new Course();
        try  {
            requeteSql = cnx.prepareStatement(
                    "SELECT id, nom, lieu, date " +
                            "FROM course " +
                            "WHERE id = ?"
            );
            requeteSql.setInt(1, idCourse);
            resultatRequete = requeteSql.executeQuery();
            if (resultatRequete.next()) {
                course = new Course();
                course.setId(resultatRequete.getInt("id"));
                course.setNom(resultatRequete.getString("nom"));
                course.setLieu(resultatRequete.getString("lieu"));

                java.sql.Date sqlDate = resultatRequete.getDate("date");
                if (sqlDate != null) {
                    course.setDate(Date.valueOf(sqlDate.toLocalDate()));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLaCourse a généré une exception SQL");
        }

        return course;
    }
}
