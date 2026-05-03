package servlet;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import database.DaoCheval;
import database.DaoRace;
import database.DaoVendeur;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

import java.time.LocalDate;

@WebServlet(name = "chevalServlet", value = "/cheval-servlet/*")
public class ChevalServlet extends HttpServlet {

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
            ArrayList<Cheval> lesChevaux = DaoCheval.getLesChevaux(cnx);
            request.setAttribute("pLesChevaux", lesChevaux);
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/list.jsp").forward(request, response);
        }
        if ("/show".equals(path)) {
            try {
                int idCheval = Integer.parseInt(request.getParameter("idCheval"));
                Cheval leCheval = DaoCheval.getLeCheval(cnx, idCheval);
                ArrayList<ChevalCourse> lesChevauxCourses = DaoCheval.getLesCoursesByCheval(cnx, idCheval);

                if (leCheval != null) {
                    request.setAttribute("pLeCheval", leCheval);
                    System.out.println("taille liste = " + lesChevauxCourses.size());
                    request.setAttribute("pLesCoursesChevaux", lesChevauxCourses);
                    ArrayList<Vendeur> lesVendeurs = DaoVendeur.getLesVendeurs(cnx);
                    request.setAttribute("pLesVendeurs", lesVendeurs);
                    
                    this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/show.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/cheval-servlet/lister");
                }
            } catch (NumberFormatException e) {
                System.out.println("Erreur : l'id du cheval n'est pas un nombre valide");
                response.sendRedirect(request.getContextPath() + "/cheval-servlet/lister");
            }

        }

        if ("/add".equals(path)) {
            ArrayList<Race> lesRaces = DaoRace.getLesRaces(cnx);
            ArrayList<Cheval> lesChevaux = DaoCheval.getLesChevaux(cnx);
            ArrayList<Vendeur> lesVendeurs = DaoVendeur.getLesVendeurs(cnx);
            request.setAttribute("pLesRaces", lesRaces);
            request.setAttribute("pLesChevaux", lesChevaux);
            request.setAttribute("pLesVendeurs", lesVendeurs);
            System.out.println("Nombre de chevaux récupérés : " + lesChevaux.size());
            this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/add.jsp").forward(request, response);
        }

        if ("/edit".equals(path)) {
            try {
                int idCheval = Integer.parseInt(request.getParameter("idCheval"));
                Cheval leCheval = DaoCheval.getLeCheval(cnx, idCheval);
                request.setAttribute("pLeCheval", leCheval);
                request.setAttribute("pLesRaces", DaoRace.getLesRaces(cnx));
                request.setAttribute("pLesChevaux", DaoCheval.getLesChevaux(cnx));
                request.setAttribute("pLesVendeurs", DaoVendeur.getLesVendeurs(cnx));
                this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/edit.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/cheval-servlet/list");
            }
        }

        if ("/delete".equals(path)) {
            try {
                int idCheval = Integer.parseInt(request.getParameter("idCheval"));
                DaoCheval.supprimerCheval(cnx, idCheval);
                response.sendRedirect(request.getContextPath() + "/cheval-servlet/list");
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/cheval-servlet/list");
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();

        if ("/add".equals(path)) {
            try {
                // Récupération des données du formulaire
                String nom = request.getParameter("nom");
                String dateNaissanceStr = request.getParameter("dateNaissance");
                int raceId = Integer.parseInt(request.getParameter("race"));
                String sexe = request.getParameter("sexe");
                String codeSire = request.getParameter("codeSire");
                String taille = request.getParameter("taille");
                String poids = request.getParameter("poids");
                int vendeurId = Integer.parseInt(request.getParameter("vendeur"));
                
                        

                // Création d'un nouveau cheval
                Cheval nouveauCheval = new Cheval();
                nouveauCheval.setNom(nom);
                nouveauCheval.setSexe(sexe);
                nouveauCheval.setCodeSire(codeSire);
                nouveauCheval.setTaille(taille);
                nouveauCheval.setPoids(poids);
                nouveauCheval.setVendeur(vendeurId);
                
                
                Cheval pere = null;
                String pereIdStr = request.getParameter("pere_id");
                if (pereIdStr != null && !pereIdStr.trim().isEmpty()) {
                    pere = new Cheval();
                    pere.setId(Integer.parseInt(pereIdStr));
                }
                
                Cheval mere = null;
                String mereIdStr = request.getParameter("mere_id");
                if (mereIdStr != null && !mereIdStr.trim().isEmpty()) {
                    mere = new Cheval();
                    mere.setId(Integer.parseInt(mereIdStr));
                }

                nouveauCheval.setChevalPere(pere);
                nouveauCheval.setChevalMere(mere);

                

                if (dateNaissanceStr != null && !dateNaissanceStr.isEmpty()) {
                    LocalDate dateNaissance = LocalDate.parse(dateNaissanceStr);
                    nouveauCheval.setDateNaissance(dateNaissance);
                }


                Race race = DaoRace.getRaceById(cnx, raceId);
                
                
                if (race != null) {
                    nouveauCheval.setRace(race);
                } else {
                    throw new Exception("La race sélectionnée n'existe pas");
                }

                // Tentative d'ajout en base de données
                if (DaoCheval.ajouterCheval(cnx, nouveauCheval)) {
                    // Redirection vers la page de consultation du cheval nouvellement créé
                    response.sendRedirect(request.getContextPath() + "/cheval-servlet/show?idCheval=" + nouveauCheval.getId());
                } else {
                    throw new Exception("Erreur lors de l'enregistrement du cheval");
                }

            } catch (NumberFormatException e) {
                request.setAttribute("message", "Erreur : " + e.getMessage());
                request.setAttribute("pLesRaces", DaoRace.getLesRaces(cnx));
                request.setAttribute("pLesChevaux", DaoCheval.getLesChevaux(cnx));
                request.setAttribute("pLesVendeurs", DaoVendeur.getLesVendeurs(cnx)); // ✅
                this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/add.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("message", "Erreur : " + e.getMessage());
                request.setAttribute("pLesRaces", DaoRace.getLesRaces(cnx));
                request.setAttribute("pLesChevaux", DaoCheval.getLesChevaux(cnx));
                request.setAttribute("pLesVendeurs", DaoVendeur.getLesVendeurs(cnx)); // ✅
                this.getServletContext().getRequestDispatcher("/WEB-INF/views/cheval/add.jsp").forward(request, response);
            }
        }

        if ("/edit".equals(path)) {
            try {
                int idCheval = Integer.parseInt(request.getParameter("idCheval"));
                String nom = request.getParameter("nom");
                String sexe = request.getParameter("sexe");
                String codeSire = request.getParameter("codeSire");
                String taille = request.getParameter("taille");
                String poids = request.getParameter("poids");
                String dateNaissanceStr = request.getParameter("dateNaissance");
                int raceId = Integer.parseInt(request.getParameter("race"));

                Cheval cheval = new Cheval();
                cheval.setId(idCheval);
                cheval.setNom(nom);
                cheval.setSexe(sexe);
                cheval.setCodeSire(codeSire);
                cheval.setTaille(taille);
                cheval.setPoids(poids);

                if (dateNaissanceStr != null && !dateNaissanceStr.isEmpty()) {
                    cheval.setDateNaissance(LocalDate.parse(dateNaissanceStr));
                }

                String vendeurIdStr = request.getParameter("vendeur");
                if (vendeurIdStr != null && !vendeurIdStr.isEmpty()) {
                    cheval.setVendeur(Integer.parseInt(vendeurIdStr));
                }

                String pereIdStr = request.getParameter("pere_id");
                if (pereIdStr != null && !pereIdStr.isEmpty()) {
                    Cheval pere = new Cheval();
                    pere.setId(Integer.parseInt(pereIdStr));
                    cheval.setChevalPere(pere);
                }

                String mereIdStr = request.getParameter("mere_id");
                if (mereIdStr != null && !mereIdStr.isEmpty()) {
                    Cheval mere = new Cheval();
                    mere.setId(Integer.parseInt(mereIdStr));
                    cheval.setChevalMere(mere);
                }

                Race race = DaoRace.getRaceById(cnx, raceId);
                cheval.setRace(race);

                if (DaoCheval.modifierCheval(cnx, cheval)) {
                    response.sendRedirect(request.getContextPath() + "/cheval-servlet/show?idCheval=" + idCheval);
                } else {
                    throw new Exception("Erreur lors de la modification");
                }

            } catch (Exception e) {
                request.setAttribute("message", "Erreur : " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/cheval-servlet/list");
            }
        }
    }

    public void destroy() {
    }
}