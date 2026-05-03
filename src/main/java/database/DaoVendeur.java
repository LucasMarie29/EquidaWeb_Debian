package database;

import model.Vendeur;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Connection;


public class DaoVendeur {
    public static ArrayList<Vendeur> getLesVendeurs(Connection cnx) {
        ArrayList<Vendeur> lesVendeurs = new ArrayList<>();
        try {
            PreparedStatement req = cnx.prepareStatement(
                    "SELECT v.id, v.nom FROM vendeur v "

            );
            ResultSet rs = req.executeQuery();
            while (rs.next()) {
                Vendeur v = new Vendeur();
                v.setId(rs.getInt("id"));
                v.setNom(rs.getString("nom"));
                lesVendeurs.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lesVendeurs;
    }
}
