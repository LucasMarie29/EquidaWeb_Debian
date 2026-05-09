package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Lieu;

public class DaoLieu {

    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    public static ArrayList<Lieu> getLesLieux(Connection cnx) {
        ArrayList<Lieu> lesLieux = new ArrayList<>();
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT id, ville, nbBoxes, commentaires FROM lieu ORDER BY ville"
            );
            resultatRequete = requeteSql.executeQuery();
            while (resultatRequete.next()) {
                Lieu l = new Lieu();
                l.setId(resultatRequete.getInt("id"));
                l.setVille(resultatRequete.getString("ville"));
                l.setNbBoxes(resultatRequete.getInt("nbBoxes"));
                l.setCommentaires(resultatRequete.getString("commentaires"));
                lesLieux.add(l);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLesLieux a généré une exception SQL");
        }
        return lesLieux;
    }

    public static Lieu getLieu(Connection cnx, int idLieu) {
        Lieu lieu = null;
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT id, ville, nbBoxes, commentaires FROM lieu WHERE id = ?"
            );
            requeteSql.setInt(1, idLieu);
            resultatRequete = requeteSql.executeQuery();
            if (resultatRequete.next()) {
                lieu = new Lieu();
                lieu.setId(resultatRequete.getInt("id"));
                lieu.setVille(resultatRequete.getString("ville"));
                lieu.setNbBoxes(resultatRequete.getInt("nbBoxes"));
                lieu.setCommentaires(resultatRequete.getString("commentaires"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLieu a généré une exception SQL");
        }
        return lieu;
    }
}