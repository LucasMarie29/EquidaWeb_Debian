<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Equida</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
          crossorigin="anonymous">
    <style>
        body { padding-top: 60px; background-color: #fafafa; }

        .hero {
            padding: 64px 0 48px;
            text-align: center;
            border-bottom: 1px solid #e8e8e8;
            margin-bottom: 0;
        }
        .hero .label-small {
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            color: #999;
            margin-bottom: 12px;
        }
        .hero h1 {
            font-size: 28px;
            font-weight: 400;
            color: #1a1a1a;
            margin: 0 0 10px;
        }
        .hero p {
            font-size: 15px;
            color: #666;
            margin: 0;
        }

        .sections-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            border-bottom: 1px solid #e8e8e8;
        }
        .section-block {
            padding: 36px 40px;
            border-right: 1px solid #e8e8e8;
        }
        .section-block:last-child { border-right: none; }
        .section-block .section-label {
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            color: #999;
            margin-bottom: 14px;
        }
        .section-link {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 14px;
            background: #fff;
            border: 1px solid #e8e8e8;
            border-radius: 8px;
            text-decoration: none;
            color: #1a1a1a;
            font-size: 14px;
            margin-bottom: 8px;
            transition: border-color 0.15s, background 0.15s;
        }
        .section-link:hover {
            border-color: #bbb;
            background: #f5f5f5;
            text-decoration: none;
            color: #1a1a1a;
        }
        .section-link .arrow { color: #bbb; }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
        }
        .stat-block {
            padding: 28px 32px;
            text-align: center;
            border-right: 1px solid #e8e8e8;
        }
        .stat-block:last-child { border-right: none; }
        .stat-block .stat-number {
            font-size: 28px;
            font-weight: 400;
            color: #1a1a1a;
            margin: 0 0 4px;
        }
        .stat-block .stat-label {
            font-size: 12px;
            color: #999;
            margin: 0;
        }

        .main-card {
            background: #fff;
            border: 1px solid #e8e8e8;
            border-radius: 12px;
            overflow: hidden;
            margin: 32px auto;
            max-width: 960px;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container">
    <div class="main-card">

        <div class="hero">
            <p class="label-small">Système de gestion</p>
            <h1>Ventes aux enchères de chevaux</h1>
            <p>Gérez vos chevaux et vos ventes en un seul endroit.</p>
        </div>

        <div class="sections-grid">
            <div class="section-block">
                <p class="section-label">Chevaux</p>
                <a href="cheval-servlet/list" class="section-link">
                    Liste des chevaux <span class="arrow">→</span>
                </a>
                <a href="cheval-servlet/add" class="section-link">
                    Ajouter un cheval <span class="arrow">+</span>
                </a>
            </div>
            <div class="section-block">
                <p class="section-label">Ventes</p>
                <a href="vente-servlet/list" class="section-link">
                    Liste des ventes <span class="arrow">→</span>
                </a>
                <a href="vente-servlet/add" class="section-link">
                    Ajouter une vente <span class="arrow">+</span>
                </a>
            </div>
        </div>


    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>