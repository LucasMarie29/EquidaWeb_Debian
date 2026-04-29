package database;

import model.Cheval;
import model.Race;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.ChevalCourse;
import model.Course;

public class DaoCheval {

    public static ArrayList<Cheval> getLesChevaux(Connection cnx) {
        ArrayList<Cheval> lesChevaux = new ArrayList<Cheval>();
        PreparedStatement requeteSql = null;
        ResultSet resultatRequete = null;
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT c.id as c_id, c.nom as c_nom, " +
                "r.id as r_id, r.libelle as r_nom " +
                "FROM cheval c " +
                "LEFT JOIN race r ON c.race_id = r.id"
            );
            resultatRequete = requeteSql.executeQuery();
            while (resultatRequete.next()) {
                Cheval c = new Cheval();
                c.setId(resultatRequete.getInt("c_id"));
                c.setNom(resultatRequete.getString("c_nom"));

                int raceId = resultatRequete.getInt("r_id");
                if (!resultatRequete.wasNull()) {
                    Race r = new Race();
                    r.setId(raceId);
                    r.setNom(resultatRequete.getString("r_nom"));
                    c.setRace(r);
                }

                lesChevaux.add(c);
            }
        } catch (SQLException e) {
            System.out.println("ERREUR SQL getLesChevaux : " + e.getMessage());
            e.printStackTrace();
        } finally {
            try { if (resultatRequete != null) resultatRequete.close(); } catch (SQLException e) {}
            try { if (requeteSql != null) requeteSql.close(); } catch (SQLException e) {}
        }
        return lesChevaux;
    }

    public static ArrayList<ChevalCourse> getLesCoursesByCheval(Connection cnx, int idCheval) {
        ArrayList<ChevalCourse> lesCoursesChevaux = new ArrayList<ChevalCourse>();
        PreparedStatement requeteSql = null;
        ResultSet resultatRequete = null;
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT c.id as c_id, co.id as co_id, c.nom as c_nom, co.nom as co_nom, " +
                "cc.position as cc_position, cc.temps as cc_temps " +
                "FROM chevalcourse cc " +
                "INNER JOIN cheval c ON cc.cheval_id = c.id " +
                "INNER JOIN course co ON cc.course_id = co.id " +
                "WHERE c.id = ? "
            );
            requeteSql.setInt(1, idCheval);
            resultatRequete = requeteSql.executeQuery();
            while (resultatRequete.next()) {
                ChevalCourse cc = new ChevalCourse();
                cc.setPosition(resultatRequete.getInt("cc_position"));
                cc.setTemps(resultatRequete.getTime("cc_temps"));

                Cheval cheval = new Cheval();
                cheval.setId(resultatRequete.getInt("c_id"));
                cheval.setNom(resultatRequete.getString("c_nom"));
                cc.setCheval(cheval);

                Course course = new Course();
                course.setId(resultatRequete.getInt("co_id"));
                course.setNom(resultatRequete.getString("co_nom"));
                cc.setCourse(course);

                lesCoursesChevaux.add(cc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLesCoursesByCheval a généré une exception SQL");
        } finally {
            try { if (resultatRequete != null) resultatRequete.close(); } catch (SQLException e) {}
            try { if (requeteSql != null) requeteSql.close(); } catch (SQLException e) {}
        }
        return lesCoursesChevaux;
    }

    public static Cheval getLeCheval(Connection cnx, int idCheval) {
        Cheval cheval = new Cheval();
        PreparedStatement requeteSql = null;
        ResultSet resultatRequete = null;
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT c.id as c_id, c.nom as c_nom, " +
                "cpere.id as cpere_id, cpere.nom as cpere_nom, " +
                "cmere.id as cmere_id, cmere.nom as cmere_nom, " +
                "r.libelle as r_nom, c.date_naissance as date_naissance " +
                "FROM cheval c " +
                "LEFT JOIN race r ON c.race_id = r.id " +
                "LEFT JOIN cheval cpere ON c.pere_id = cpere.id " +
                "LEFT JOIN cheval cmere ON c.mere_id = cmere.id " +
                "WHERE c.id = ? "
            );
            requeteSql.setInt(1, idCheval);
            resultatRequete = requeteSql.executeQuery();
            if (resultatRequete.next()) {
                cheval.setId(resultatRequete.getInt("c_id"));
                cheval.setNom(resultatRequete.getString("c_nom"));

                java.sql.Date sqlDate = resultatRequete.getDate("date_naissance");
                if (sqlDate != null) {
                    cheval.setDateNaissance(sqlDate.toLocalDate());
                }

                String raceNom = resultatRequete.getString("r_nom");
                if (raceNom != null) {
                    Race race = new Race();
                    race.setNom(raceNom);
                    cheval.setRace(race);
                }

                // Père (peut être null)
                int pereId = resultatRequete.getInt("cpere_id");
                if (!resultatRequete.wasNull()) {
                    Cheval pere = new Cheval();
                    pere.setId(pereId);
                    pere.setNom(resultatRequete.getString("cpere_nom"));
                    cheval.setChevalPere(pere);
                }

                // Mère (peut être null)
                int mereId = resultatRequete.getInt("cmere_id");
                if (!resultatRequete.wasNull()) {
                    Cheval mere = new Cheval();
                    mere.setId(mereId);
                    mere.setNom(resultatRequete.getString("cmere_nom"));
                    cheval.setChevalMere(mere);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLeCheval a généré une exception SQL");
        } finally {
            try { if (resultatRequete != null) resultatRequete.close(); } catch (SQLException e) {}
            try { if (requeteSql != null) requeteSql.close(); } catch (SQLException e) {}
        }
        return cheval;
    }

    public static boolean ajouterCheval(Connection cnx, Cheval cheval) {
        PreparedStatement requeteSql = null;
        try {
            requeteSql = cnx.prepareStatement(
                "INSERT INTO cheval (nom, sexe, codeSire, taille, poids, vendeur, date_naissance, race_id, pere_id, mere_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                PreparedStatement.RETURN_GENERATED_KEYS
            );
            requeteSql.setString(1, cheval.getNom());
            requeteSql.setString(2, cheval.getSexe());
            requeteSql.setString(3, cheval.getCodeSire());
            requeteSql.setString(4, cheval.getTaille());
            requeteSql.setString(5, cheval.getPoids());

            if (cheval.getVendeur() != 0) {
                requeteSql.setInt(6, cheval.getVendeur());
            } else {
                requeteSql.setNull(6, java.sql.Types.INTEGER);
            }

            if (cheval.getDateNaissance() != null) {
                requeteSql.setDate(7, java.sql.Date.valueOf(cheval.getDateNaissance()));
            } else {
                requeteSql.setNull(7, java.sql.Types.DATE);
            }

            requeteSql.setInt(8, cheval.getRace().getId());

            if (cheval.getChevalPere() != null) {
                requeteSql.setInt(9, cheval.getChevalPere().getId());
            } else {
                requeteSql.setNull(9, java.sql.Types.INTEGER);
            }

            if (cheval.getChevalMere() != null) {
                requeteSql.setInt(10, cheval.getChevalMere().getId());
            } else {
                requeteSql.setNull(10, java.sql.Types.INTEGER);
            }

            int result = requeteSql.executeUpdate();
            if (result == 1) {
                ResultSet rs = requeteSql.getGeneratedKeys();
                if (rs.next()) {
                    cheval.setId(rs.getInt(1));
                }
                return true;
            }
            return false;

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Erreur lors de l'ajout du cheval");
            return false;
        } finally {
            try { if (requeteSql != null) requeteSql.close(); } catch (SQLException e) {}
        }
    }
}