package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.CategVente;

public class DaoCategVente {

    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    public static ArrayList<CategVente> getLesCategVentes(Connection cnx) {
        ArrayList<CategVente> lesCategs = new ArrayList<>();
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT id, libelle FROM categvente ORDER BY libelle"
            );
            resultatRequete = requeteSql.executeQuery();
            while (resultatRequete.next()) {
                CategVente c = new CategVente();
                c.setId(resultatRequete.getInt("id"));
                c.setLibelle(resultatRequete.getString("libelle"));
                lesCategs.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLesCategVentes a généré une exception SQL");
        }
        return lesCategs;
    }

    public static CategVente getCategVente(Connection cnx, int idCateg) {
        CategVente categ = null;
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT id, libelle FROM categvente WHERE id = ?"
            );
            requeteSql.setInt(1, idCateg);
            resultatRequete = requeteSql.executeQuery();
            if (resultatRequete.next()) {
                categ = new CategVente();
                categ.setId(resultatRequete.getInt("id"));
                categ.setLibelle(resultatRequete.getString("libelle"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getCategVente a généré une exception SQL");
        }
        return categ;
    }
}