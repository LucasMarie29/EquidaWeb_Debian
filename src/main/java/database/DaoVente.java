package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Cheval;
import model.Vente;
import model.Lieu;
import model.Lot;

public class DaoVente {

    public static ArrayList<Vente> getLesVentes(Connection cnx) {
        ArrayList<Vente> lesVentes = new ArrayList<Vente>();
        PreparedStatement requeteSql = null;
        ResultSet resultatRequete = null;
        try {
            // LEFT JOIN car certaines ventes n'ont pas de lieu (lieu_id NULL)
            requeteSql = cnx.prepareStatement(
                "SELECT v.id as v_id, v.nom as v_nom, " +
                "l.id as l_id, l.ville as l_ville " +
                "FROM vente v " +
                "LEFT JOIN lieu l ON v.lieu_id = l.id"
            );
            resultatRequete = requeteSql.executeQuery();
            while (resultatRequete.next()) {
                Vente v = new Vente();
                v.setId(resultatRequete.getInt("v_id"));
                v.setNom(resultatRequete.getString("v_nom"));

                int lieuId = resultatRequete.getInt("l_id");
                if (!resultatRequete.wasNull()) {
                    Lieu l = new Lieu();
                    l.setId(lieuId);
                    l.setVille(resultatRequete.getString("l_ville"));
                    v.setLieu(l);
                }

                lesVentes.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLesVentes a généré une exception SQL");
        } finally {
            try { if (resultatRequete != null) resultatRequete.close(); } catch (SQLException e) {}
            try { if (requeteSql != null) requeteSql.close(); } catch (SQLException e) {}
        }
        return lesVentes;
    }

    public static Vente getLaVente(Connection cnx, int idVente) {
        Vente vente = null;
        PreparedStatement requeteSql = null;
        ResultSet resultatRequete = null;
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT v.id as v_id, v.nom as v_nom, dateDebutVente, dateFinVente, " +
                "dateDebutInscription, dateEnvoiMessage, objetMessage, corpsMessage, " +
                "l.id as l_id, l.ville as l_ville " +
                "FROM vente v " +
                "LEFT JOIN lieu l ON v.lieu_id = l.id " +
                "WHERE v.id = ? "
            );
            requeteSql.setInt(1, idVente);
            resultatRequete = requeteSql.executeQuery();
            if (resultatRequete.next()) {
                vente = new Vente();
                vente.setId(resultatRequete.getInt("v_id"));
                vente.setNom(resultatRequete.getString("v_nom"));
                vente.setDateDebutVente(resultatRequete.getDate("dateDebutVente"));
                vente.setDateFinVente(resultatRequete.getDate("dateFinVente"));
                vente.setDateDebutInscription(resultatRequete.getDate("dateDebutInscription"));
                vente.setDateEnvoiMessage(resultatRequete.getDate("dateEnvoiMessage"));
                vente.setObjetMessage(resultatRequete.getString("objetMessage"));
                vente.setCorpsMessage(resultatRequete.getString("corpsMessage"));

                int lieuId = resultatRequete.getInt("l_id");
                if (!resultatRequete.wasNull()) {
                    Lieu lieu = new Lieu();
                    lieu.setId(lieuId);
                    lieu.setVille(resultatRequete.getString("l_ville"));
                    vente.setLieu(lieu);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLaVente a généré une exception SQL");
        } finally {
            try { if (resultatRequete != null) resultatRequete.close(); } catch (SQLException e) {}
            try { if (requeteSql != null) requeteSql.close(); } catch (SQLException e) {}
        }
        return vente;
    }

    public static ArrayList<Lot> getLesLots(Connection cnx, int idVente) {
        ArrayList<Lot> lesLots = new ArrayList<Lot>();
        PreparedStatement requeteSql = null;
        ResultSet resultatRequete = null;
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT l.id as l_id, l.prixDepart, c.id as c_id, c.nom as c_nom " +
                "FROM lot l " +
                "INNER JOIN cheval c ON l.cheval_id = c.id " +
                "WHERE l.vente_id = ? "
            );
            requeteSql.setInt(1, idVente);
            resultatRequete = requeteSql.executeQuery();
            // while et non if : on récupère TOUS les lots
            while (resultatRequete.next()) {
                Lot lot = new Lot();
                lot.setId(resultatRequete.getInt("l_id"));
                lot.setPrixDepart(resultatRequete.getInt("prixDepart"));

                Cheval cheval = new Cheval();
                cheval.setId(resultatRequete.getInt("c_id"));
                cheval.setNom(resultatRequete.getString("c_nom"));
                lot.setCheval(cheval);

                lesLots.add(lot);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLesLots a généré une exception SQL");
        } finally {
            try { if (resultatRequete != null) resultatRequete.close(); } catch (SQLException e) {}
            try { if (requeteSql != null) requeteSql.close(); } catch (SQLException e) {}
        }
        return lesLots;
    }

    public static boolean ajouterVente(Connection cnx, Vente vente) {
        PreparedStatement requeteSql = null;
        try {
            requeteSql = cnx.prepareStatement(
                "INSERT INTO vente (nom, dateDebutVente, dateFinVente, dateDebutInscription, " +
                "dateEnvoiMessage, objetMessage, corpsMessage, lieu_id, categvente_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                PreparedStatement.RETURN_GENERATED_KEYS
            );
            requeteSql.setString(1, vente.getNom());

            if (vente.getDateDebutVente() != null) {
                requeteSql.setDate(2, new java.sql.Date(vente.getDateDebutVente().getTime()));
            } else {
                requeteSql.setNull(2, java.sql.Types.DATE);
            }

            if (vente.getDateFinVente() != null) {
                requeteSql.setDate(3, new java.sql.Date(vente.getDateFinVente().getTime()));
            } else {
                requeteSql.setNull(3, java.sql.Types.DATE);
            }

            if (vente.getDateDebutInscription() != null) {
                requeteSql.setDate(4, new java.sql.Date(vente.getDateDebutInscription().getTime()));
            } else {
                requeteSql.setNull(4, java.sql.Types.DATE);
            }

            if (vente.getDateEnvoiMessage() != null) {
                requeteSql.setDate(5, new java.sql.Date(vente.getDateEnvoiMessage().getTime()));
            } else {
                requeteSql.setNull(5, java.sql.Types.DATE);
            }

            requeteSql.setString(6, vente.getObjetMessage());
            requeteSql.setString(7, vente.getCorpsMessage());

            if (vente.getLieu() != null && vente.getLieu().getId() != 0) {
                requeteSql.setInt(8, vente.getLieu().getId());
            } else {
                requeteSql.setNull(8, java.sql.Types.INTEGER);
            }

            if (vente.getCategVente() != null && vente.getCategVente().getId() != 0) {
                requeteSql.setInt(9, vente.getCategVente().getId());
            } else {
                requeteSql.setNull(9, java.sql.Types.INTEGER);
            }

            int result = requeteSql.executeUpdate();
            if (result == 1) {
                ResultSet rs = requeteSql.getGeneratedKeys();
                if (rs.next()) {
                    vente.setId(rs.getInt(1));
                }
                return true;
            }
            return false;

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Erreur lors de l'ajout de la vente");
            return false;
        } finally {
            try { if (requeteSql != null) requeteSql.close(); } catch (SQLException e) {}
        }
    }
}