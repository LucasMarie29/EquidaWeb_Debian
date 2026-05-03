package database;


import static database.DaoVente.resultatRequete;
import model.Cheval;
import model.Race;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.ChevalCourse;
import model.Course;
import model.Lot;

public class DaoCheval {
    Connection cnx;
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    public static ArrayList<Cheval> getLesChevaux(Connection cnx) {
        ArrayList<Cheval> lesChevaux = new ArrayList<Cheval>();
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT c.id as c_id, c.nom as c_nom, " +
                "r.id as r_id, r.nom as r_nom " +
                "FROM cheval c " +
                "INNER JOIN race r ON c.race_id = r.id"
            );
            resultatRequete = requeteSql.executeQuery();
            while (resultatRequete.next()) {
                Cheval c = new Cheval();
                c.setId(resultatRequete.getInt("c_id"));
                c.setNom(resultatRequete.getString("c_nom"));
                Race r = new Race();
                r.setId(resultatRequete.getInt("r_id"));
                r.setNom(resultatRequete.getString("r_nom"));
                c.setRace(r);
                lesChevaux.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLesChevaux a généré une exception SQL");
        }
        return lesChevaux;
    }
    
    public static ArrayList<ChevalCourse> getLesCoursesByCheval(Connection cnx, int idCheval) {
        ArrayList<ChevalCourse> lesCoursesChevaux = new ArrayList<ChevalCourse>();
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT c.id as c_id, co.id as co_id, c.nom as c_nom, co.nom as co_nom, cc.position as cc_position, cc.temps as cc_temps " +
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
            System.out.println("La requête de getLesChevaux a généré une exception SQL");
        }
        return lesCoursesChevaux;
    }
    
    

    public static Cheval getLeCheval(Connection cnx, int idCheval) {
        Cheval cheval = new Cheval();
        try {
            requeteSql = cnx.prepareStatement(
                    "SELECT c.id as c_id, c.nom as c_nom, c.sexe, c.codeSire, c.taille, c.poids, " +
                            "cpere.id as cpere_id, cpere.nom as cpere_nom, " +
                            "cmere.id as cmere_id, cmere.nom as cmere_nom, " +
                            "r.id as r_id, r.nom as r_nom, " +
                            "c.date_naissance as date_naissance, " +
                            "cl.nom as vendeur_nom, v.id as vendeur_id " +
                            "FROM cheval c " +
                            "INNER JOIN race r ON c.race_id = r.id " +
                            "LEFT JOIN cheval cpere ON c.pere_id = cpere.id " +
                            "LEFT JOIN cheval cmere ON c.mere_id = cmere.id " +
                            "LEFT JOIN vendeur v ON c.vendeur = v.id " +
                            "LEFT JOIN client cl ON v.id = cl.id " +
                            "WHERE c.id = ?"
            );
            requeteSql.setInt(1, idCheval);
            resultatRequete = requeteSql.executeQuery();
            if (resultatRequete.next()) {
                
                cheval = new Cheval();
                cheval.setId(resultatRequete.getInt("c_id"));
                cheval.setNom(resultatRequete.getString("c_nom"));
                cheval.setSexe(resultatRequete.getString("sexe"));
                cheval.setCodeSire(resultatRequete.getString("codeSire"));
                cheval.setTaille(resultatRequete.getString("taille"));
                cheval.setPoids(resultatRequete.getString("poids"));

                java.sql.Date sqlDate = resultatRequete.getDate("date_naissance");
                if (sqlDate != null) {
                    cheval.setDateNaissance(sqlDate.toLocalDate());
                }
                
                Cheval pere = new Cheval();
                pere.setId(resultatRequete.getInt("cpere_id"));
                pere.setNom(resultatRequete.getString("cpere_nom"));
                cheval.setChevalPere(pere);
                
                Cheval mere = new Cheval();
                mere.setId(resultatRequete.getInt("cmere_id"));
                mere.setNom(resultatRequete.getString("cmere_nom"));
                cheval.setChevalMere(mere);

                
                Race race = new Race();
                race.setNom(resultatRequete.getString("r_nom"));

                int vendeurId = resultatRequete.getInt("vendeur_id");
                if (!resultatRequete.wasNull()) {
                    cheval.setVendeur(vendeurId);
                }
                
                cheval.setRace(race);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLeCheval a généré une exception SQL");
        }
        return cheval;
    }
    /**
     * Ajoute un nouveau cheval dans la base de données
     * @param cnx La connexion active à la base de données
     * @param cheval Le cheval à ajouter
     * @return boolean true si l'ajout a réussi, false sinon
     */
    public static boolean ajouterCheval(Connection cnx, Cheval cheval) {
    try {
        requeteSql = cnx.prepareStatement(
            "INSERT INTO cheval (nom, sexe, codeSire, taille, poids, vendeur, date_naissance, race_id, pere_id, mere_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            PreparedStatement.RETURN_GENERATED_KEYS
        );
        requeteSql.setString(1, cheval.getNom());
        
        requeteSql.setString(2, cheval.getSexe());
        
        requeteSql.setString(3, cheval.getCodeSire());
        
        requeteSql.setString(4, cheval.getTaille());
        
        requeteSql.setString(5, cheval.getPoids());
        
        requeteSql.setInt(6, cheval.getVendeur());
        
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
    }
}

    public static boolean modifierCheval(Connection cnx, Cheval cheval) {
        try {
            requeteSql = cnx.prepareStatement(
                    "UPDATE cheval SET nom=?, sexe=?, codeSire=?, taille=?, poids=?, " +
                            "date_naissance=?, race_id=?, pere_id=?, mere_id=?, vendeur=? WHERE id=?"
            );
            requeteSql.setString(1, cheval.getNom());
            requeteSql.setString(2, cheval.getSexe());
            requeteSql.setString(3, cheval.getCodeSire());
            requeteSql.setString(4, cheval.getTaille());
            requeteSql.setString(5, cheval.getPoids());

            if (cheval.getDateNaissance() != null) {
                requeteSql.setDate(6, java.sql.Date.valueOf(cheval.getDateNaissance()));
            } else {
                requeteSql.setNull(6, java.sql.Types.DATE);
            }

            requeteSql.setInt(7, cheval.getRace().getId());

            if (cheval.getChevalPere() != null) {
                requeteSql.setInt(8, cheval.getChevalPere().getId());
            } else {
                requeteSql.setNull(8, java.sql.Types.INTEGER);
            }

            if (cheval.getChevalMere() != null) {
                requeteSql.setInt(9, cheval.getChevalMere().getId());
            } else {
                requeteSql.setNull(9, java.sql.Types.INTEGER);
            }

            if (cheval.getVendeur() != 0) {
                requeteSql.setInt(10, cheval.getVendeur());
            } else {
                requeteSql.setNull(10, java.sql.Types.INTEGER);
            }

            requeteSql.setInt(11, cheval.getId());

            return requeteSql.executeUpdate() == 1;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean supprimerCheval(Connection cnx, int idCheval) {
        try {
            requeteSql = cnx.prepareStatement("DELETE FROM cheval WHERE id=?");
            requeteSql.setInt(1, idCheval);
            return requeteSql.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}