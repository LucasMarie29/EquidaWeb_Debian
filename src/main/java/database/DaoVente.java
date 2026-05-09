package database;

import static database.DaoCheval.requeteSql;
import static database.DaoCheval.resultatRequete;
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
    Connection cnx;
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;


    public static ArrayList<Vente> getLesVentes(Connection cnx) {
        ArrayList<Vente> lesVentes = new ArrayList<Vente>();
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT v.id as v_id, v.nom as v_nom, " +
                "l.id as l_id, l.ville as l_ville " +
                "FROM vente v " +
                "INNER JOIN lieu l ON v.lieu_id = l.id"
            );
            resultatRequete = requeteSql.executeQuery();
            while (resultatRequete.next()) {
                Vente v = new Vente();
                v.setId(resultatRequete.getInt("v_id"));
                v.setNom(resultatRequete.getString("v_nom"));
                Lieu l = new Lieu();
                l.setId(resultatRequete.getInt("l_id"));
                l.setVille(resultatRequete.getString("l_ville"));
                v.setLieu(l);
                lesVentes.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLesVentes a généré une exception SQL");
        }
        return lesVentes;
    }
    
    public static Vente getLaVente(Connection cnx, int idVente) {
        Vente vente = null;
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT v.id as v_id, v.nom as v_nom, dateDebutVente, dateFinVente, dateDebutInscription, dateEnvoiMessage, objetMessage, corpsMessage " +
                ", l.id as l_id, l.ville as l_ville " +
                "FROM vente v " +
                "INNER JOIN lieu l ON v.lieu_id = l.id " +
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
                
                Lieu lieu = new Lieu();
                lieu.setId(resultatRequete.getInt("l_id"));
                lieu.setVille(resultatRequete.getString("l_ville"));
                vente.setLieu(lieu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de getLaVente a généré une exception SQL");
        }
        return vente;
    }
    public static ArrayList<Lot> getLesLots(Connection cnx, int idVente) {
        
        ArrayList<Lot> lesLots = new ArrayList<Lot>();
        try {
            requeteSql = cnx.prepareStatement(
                "SELECT l.id as l_id, prixDepart, c.id as c_id, c.nom as c_nom, v.id as v_id " +
                "FROM lot l " +
                "INNER JOIN cheval c ON l.cheval_id = c.id " +
                "INNER JOIN vente v ON l.vente_id = v.id " +
                "WHERE v.id = ? "
                
            );
            requeteSql.setInt(1, idVente);
            resultatRequete = requeteSql.executeQuery();
            if (resultatRequete.next()) {
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
            System.out.println("La requête de getLeLot a généré une exception SQL");
        }
        return lesLots;
        
    }

    public static boolean ajouterVente(Connection cnx, Vente vente) {
    try {
        requeteSql = cnx.prepareStatement(
            "INSERT INTO vente (nom, dateDebutVente, dateFinVente, dateDebutInscription, dateEnvoiMessage, objetMessage, corpsMessage, lieu_id, categVente_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
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
        
        requeteSql.setInt(8, vente.getLieu().getId());
 /*       
        if (vente.getLieu() != null && vente.getLieu().getId() != -1) {
            requeteSql.setInt(8, vente.getLieu().getId());
        } else {
            requeteSql.setNull(8, java.sql.Types.INTEGER);
        }
*/
        if (vente.getCategVente() != null && vente.getCategVente().getId() != -1) {
            requeteSql.setInt(9, vente.getCategVente().getId());
        } else {
            requeteSql.setNull(9, java.sql.Types.INTEGER);
        }
        
        
        int result = requeteSql.executeUpdate();
        
        if (result == 1) {
            // Récupération de l'id auto-généré
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
    }
}

    public static boolean modifierVente(Connection cnx, Vente vente) {
        try {
            requeteSql = cnx.prepareStatement(
                "UPDATE vente SET nom=?, dateDebutVente=?, dateFinVente=?, dateDebutInscription=?, " +
                "dateEnvoiMessage=?, objetMessage=?, corpsMessage=?, lieu_id=?, categvente_id=? " +
                "WHERE id=?"
            );
            requeteSql.setString(1, vente.getNom());

            requeteSql.setDate(2, vente.getDateDebutVente() != null ? new java.sql.Date(vente.getDateDebutVente().getTime()) : null);
            requeteSql.setDate(3, vente.getDateFinVente() != null ? new java.sql.Date(vente.getDateFinVente().getTime()) : null);
            requeteSql.setDate(4, vente.getDateDebutInscription() != null ? new java.sql.Date(vente.getDateDebutInscription().getTime()) : null);
            requeteSql.setDate(5, vente.getDateEnvoiMessage() != null ? new java.sql.Date(vente.getDateEnvoiMessage().getTime()) : null);

            requeteSql.setString(6, vente.getObjetMessage());
            requeteSql.setString(7, vente.getCorpsMessage());
            requeteSql.setInt(8, vente.getLieu().getId());

            if (vente.getCategVente() != null) {
                requeteSql.setInt(9, vente.getCategVente().getId());
            } else {
                requeteSql.setNull(9, java.sql.Types.INTEGER);
            }

            requeteSql.setInt(10, vente.getId());

            return requeteSql.executeUpdate() == 1;

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Erreur lors de la modification de la vente");
            return false;
        }
    }

    public static boolean supprimerVente(Connection cnx, int idVente) {
        try {
            requeteSql = cnx.prepareStatement("DELETE FROM vente WHERE id = ?");
            requeteSql.setInt(1, idVente);
            return requeteSql.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Erreur lors de la suppression de la vente");
            return false;
        }
    }
}
