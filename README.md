# Equida — Application de gestion de ventes équines

## Présentation

Equida est une application web Java EE (Jakarta EE) de gestion de ventes aux enchères de chevaux. Elle permet de consulter, ajouter, modifier et supprimer des chevaux, des ventes et leurs lots associés, tout en gérant les courses et les résultats.

---

## Stack technique

| Couche | Technologie |
|---|---|
| Langage | Java |
| Serveur d'application | Jakarta EE (Servlets + JSP) |
| Base de données | MariaDB 11.3 (port 3307) |
| Driver JDBC | `org.mariadb.jdbc.Driver` |
| Frontend | Bootstrap 3.3.7 + jQuery 1.12.4 |
| Vue | JSP (Java Server Pages) |

---

## Prérequis

- Java JDK 11 ou supérieur
- Serveur d'application compatible Jakarta EE (ex : Apache Tomcat 10+)
- MariaDB démarré sur `127.0.0.1:3307`
- Driver MariaDB JDBC dans le classpath du projet
- phpMyAdmin (optionnel, pour administrer la base)

---

## Installation et configuration

### 1. Base de données

Créer la base de données `equida` dans MariaDB, puis exécuter le script SQL fourni (`equida_complet.sql`) depuis phpMyAdmin ou en ligne de commande :

```sql
CREATE DATABASE equida CHARACTER SET utf8mb4;
```

Puis importer le fichier `equida_complet.sql` — il crée toutes les tables et insère les données de démonstration.

**Paramètres de connexion par défaut :**

```
Hôte     : 127.0.0.1
Port     : 3307
Base     : equida
Utilisateur : root
Mot de passe : (vide)
```

Pour modifier ces paramètres, éditer les deux fichiers suivants :

- `src/database/Connexionbdd.java` — ligne `DriverManager.getConnection(...)`
- `src/database/ConnexionServlet.java` — ligne `DriverManager.getConnection(...)`

### 2. Déploiement

Importer le projet dans votre IDE (IntelliJ, Eclipse, NetBeans), configurer le serveur Tomcat, puis démarrer l'application. La connexion à la base est initialisée automatiquement au démarrage du contexte via `ConnexionServlet`.

---

## Structure du projet

```
src/
├── database/
│   ├── Connexionbdd.java       # Utilitaire de connexion JDBC (usage standalone)
│   ├── ConnexionServlet.java   # Listener Jakarta EE — ouvre/ferme la connexion au démarrage
│   ├── DaoCheval.java          # DAO : opérations CRUD sur les chevaux
│   ├── DaoRace.java            # DAO : lecture des races
│   ├── DaoVendeur.java         # DAO : lecture des vendeurs
│   └── DaoVente.java           # DAO : opérations sur les ventes et les lots
│
├── model/
│   ├── Cheval.java
│   ├── Race.java
│   ├── Vendeur.java
│   ├── Vente.java
│   ├── Lieu.java
│   ├── Lot.java
│   ├── Course.java
│   └── ChevalCourse.java
│
WEB-INF/
├── views/
│   ├── header.jsp
│   └── ...                     # Autres vues JSP
└── web.xml                     # Configuration des servlets et du listener
```

---

## Base de données — Schéma simplifié

```
pays          ←── client ──→ vendeur
                     │
                     └──→ acheteur
                              │
                              └──→ enchere ──→ lot ──→ cheval ──→ race
                                                │              ↗ (père/mère)
                                              vente
                                                │
                                     lieu ──→ vente ←── categvente

cheval ←── chevalcourse ──→ course
```

**Tables principales :**

- `pays` — référentiel des pays (code ISO 3 lettres)
- `client` — base commune vendeurs/acheteurs
- `vendeur` — hérite de `client`, représente les propriétaires vendeurs
- `acheteur` — hérite de `client`, avec formation spécialisée
- `race` — races de chevaux (Pur-sang, Arabe, Selle français…)
- `cheval` — fiche complète du cheval (sexe, taille, poids, généalogie père/mère)
- `course` — épreuves hippiques
- `chevalcourse` — résultats (position, temps) par cheval et par course
- `lieu` — lieux de vente avec nombre de boxes
- `categvente` — catégories de vente (enchères publiques, privée, online…)
- `vente` — ventes planifiées avec dates et message d'information
- `lot` — chevaux mis en vente dans une vente donnée (avec prix de départ)
- `enchere` — offres des acheteurs sur les lots

---

## Fonctionnalités disponibles

### Chevaux
- Lister tous les chevaux avec leur race (`getLesChevaux`)
- Afficher le détail d'un cheval : sexe, taille, poids, date de naissance, race, vendeur, père et mère (`getLeCheval`)
- Consulter les résultats de courses d'un cheval (`getLesCoursesByCheval`)
- Ajouter un cheval (`ajouterCheval`)
- Modifier un cheval (`modifierCheval`)
- Supprimer un cheval (`supprimerCheval`)

### Ventes
- Lister toutes les ventes avec leur lieu (`getLesVentes`)
- Afficher le détail d'une vente : dates, message, lieu (`getLaVente`)
- Afficher les lots d'une vente avec le nom du cheval et le prix de départ (`getLesLots`)
- Ajouter une vente (`ajouterVente`)

### Races
- Lister toutes les races (`getLesRaces`)
- Récupérer une race par son id (`getRaceById`)

### Vendeurs
- Lister tous les vendeurs (`getLesVendeurs`)

---

## Architecture — Patron MVC

L'application suit le patron **MVC (Modèle - Vue - Contrôleur)** :

- **Modèle** : classes Java dans le package `model` (Cheval, Vente, Lot, etc.)
- **Vue** : pages JSP dans `WEB-INF/views` (ex : `show.jsp` pour le détail d'une vente)
- **Contrôleur** : Servlets Jakarta EE qui reçoivent les requêtes HTTP, appellent les DAO, et transmettent les données aux JSP via les attributs de requête (`request.setAttribute`)
- **DAO** : classes du package `database` qui encapsulent toutes les requêtes SQL via `PreparedStatement`

**Exemple de flux pour l'affichage d'une vente :**

```
Navigateur → GET /vente-servlet/show?idVente=1
           → Servlet VenteServlet
               → DaoVente.getLaVente(cnx, 1)
               → DaoVente.getLesLots(cnx, 1)
               → request.setAttribute("pLaVente", vente)
               → request.setAttribute("pLesLots", lesLots)
           → forward vers show.jsp
           → Affichage Bootstrap
```

---

## URLs principales (conventions observées)

| URL | Action |
|---|---|
| `/vente-servlet/list` | Liste des ventes |
| `/vente-servlet/show?idVente=X` | Détail d'une vente |
| `/cheval-servlet/show?idCheval=X` | Détail d'un cheval |

---

## Données de démonstration

Le script SQL fourni insère :

- 15 pays, 20 races, 15 lieux, 10 catégories de vente
- 50 clients (20 vendeurs + 30 acheteurs)
- 60 chevaux (dont 30 avec généalogie père/mère renseignée)
- 20 courses avec 60 résultats
- 15 ventes, 60 lots, 60 enchères

---

## Points d'attention

- La colonne `lot_numLot` dans la table `enchere` référence la colonne `id` de la table `lot` (nom de FK à ne pas confondre).
- La connexion est partagée via le `ServletContext` (attribut `"connection"`) — toutes les Servlets y accèdent via `getServletContext().getAttribute("connection")`.
- Les chevaux avec généalogie (`pere_id`, `mere_id`) doivent être insérés **après** leurs parents — le script SQL respecte cet ordre.
- Le champ `vendeur` dans la table `cheval` est une FK vers `vendeur.id`, pas vers `client.id` directement.
