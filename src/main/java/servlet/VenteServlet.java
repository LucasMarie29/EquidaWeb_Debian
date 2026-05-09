package servlet;

import java.io.*;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import database.DaoLieu;
import database.DaoCategVente;
import database.DaoVente;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.CategVente;
import model.Lieu;
import model.Lot;
import model.Vente;

@WebServlet(name = "venteServlet", value = "/vente-servlet/*")
public class VenteServlet extends HttpServlet {

    Connection cnx;

    @Override
    public void init() {
        ServletContext servletContext = getServletContext();
        cnx = (Connection) servletContext.getAttribute("connection");
        try {
            System.out.println("INIT SERVLET=" + cnx.getSchema());
        } catch (SQLException ex) {
            Logger.getLogger(VenteServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String path = request.getPathInfo();
        System.out.println("PathInfo: " + path);

        if ("/list".equals(path)) {
            request.setAttribute("pLesVentes", DaoVente.getLesVentes(cnx));
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/list.jsp").forward(request, response);
        }

        else if ("/show".equals(path)) {
            try {
                int idVente = Integer.parseInt(request.getParameter("idVente"));
                Vente laVente = DaoVente.getLaVente(cnx, idVente);
                if (laVente != null) {
                    request.setAttribute("pLaVente", laVente);
                    request.setAttribute("pLesLots", DaoVente.getLesLots(cnx, idVente));
                    this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/show.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
            }
        }

        else if ("/add".equals(path)) {
            request.setAttribute("pLesLieux", DaoLieu.getLesLieux(cnx));
            request.setAttribute("pLesCategVentes", DaoCategVente.getLesCategVentes(cnx));
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/add.jsp").forward(request, response);
        }

        else if ("/edit".equals(path)) {
            try {
                int idVente = Integer.parseInt(request.getParameter("idVente"));
                Vente laVente = DaoVente.getLaVente(cnx, idVente);
                if (laVente != null) {
                    request.setAttribute("pLaVente", laVente);
                    request.setAttribute("pLesLieux", DaoLieu.getLesLieux(cnx));
                    request.setAttribute("pLesCategVentes", DaoCategVente.getLesCategVentes(cnx));
                    this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/edit.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
            }
        }

        else if ("/delete".equals(path)) {
            try {
                int idVente = Integer.parseInt(request.getParameter("idVente"));
                DaoVente.supprimerVente(cnx, idVente);
                response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/vente-servlet/list");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();

        if ("/add".equals(path)) {
            try {
                Vente v = buildVenteFromRequest(request);
                if (DaoVente.ajouterVente(cnx, v)) {
                    response.sendRedirect(request.getContextPath() + "/vente-servlet/show?idVente=" + v.getId());
                } else {
                    throw new Exception("Erreur lors de l'enregistrement");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("message", "Erreur : " + e.getMessage());
                request.setAttribute("pLesLieux", DaoLieu.getLesLieux(cnx));
                request.setAttribute("pLesCategVentes", DaoCategVente.getLesCategVentes(cnx));
                this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/add.jsp").forward(request, response);
            }
        }

        else if ("/edit".equals(path)) {
            try {
                int idVente = Integer.parseInt(request.getParameter("idVente"));
                Vente v = buildVenteFromRequest(request);
                v.setId(idVente);
                if (DaoVente.modifierVente(cnx, v)) {
                    response.sendRedirect(request.getContextPath() + "/vente-servlet/show?idVente=" + idVente);
                } else {
                    throw new Exception("Erreur lors de la modification");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("message", "Erreur : " + e.getMessage());
                try {
                    request.setAttribute("pLaVente", DaoVente.getLaVente(cnx, Integer.parseInt(request.getParameter("idVente"))));
                } catch (Exception ignored) {}
                request.setAttribute("pLesLieux", DaoLieu.getLesLieux(cnx));
                request.setAttribute("pLesCategVentes", DaoCategVente.getLesCategVentes(cnx));
                this.getServletContext().getRequestDispatcher("/WEB-INF/views/vente/edit.jsp").forward(request, response);
            }
        }
    }

    private Vente buildVenteFromRequest(HttpServletRequest request) throws Exception {
        Vente v = new Vente();
        v.setNom(request.getParameter("nom"));
        v.setObjetMessage(request.getParameter("objetMessage"));
        v.setCorpsMessage(request.getParameter("corpsMessage"));
        v.setDateDebutVente(parseDate(request.getParameter("dateDebutVente")));
        v.setDateFinVente(parseDate(request.getParameter("dateFinVente")));
        v.setDateDebutInscription(parseDate(request.getParameter("dateDebutInscription")));
        v.setDateEnvoiMessage(parseDate(request.getParameter("dateEnvoiMessage")));

        String lieuIdStr = request.getParameter("lieu_id");
        if (lieuIdStr == null || lieuIdStr.isEmpty()) throw new Exception("Le lieu est obligatoire");
        Lieu lieu = new Lieu();
        lieu.setId(Integer.parseInt(lieuIdStr));
        v.setLieu(lieu);

        String categIdStr = request.getParameter("categVente_id");
        if (categIdStr != null && !categIdStr.isEmpty()) {
            CategVente categ = new CategVente();
            categ.setId(Integer.parseInt(categIdStr));
            v.setCategVente(categ);
        }
        return v;
    }

    private Date parseDate(String dateStr) {
        if (dateStr != null && !dateStr.isEmpty()) {
            return Date.valueOf(dateStr);
        }
        return null;
    }

    public void destroy() {}
}