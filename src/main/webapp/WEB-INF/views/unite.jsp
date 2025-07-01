<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Unités r</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-green: #007e5d;
            --secondary-yellow: #f8c828;
            --light-green: #e8f5f0;
            --dark-green: #005c43;
            --light-yellow: #fef6d9;
            --background: #f8fffe;
            --white: #ffffff;
            --text-dark: #2c3e50;
            --text-light: #718096;
            --shadow: 0 10px 25px rgba(0, 126, 93, 0.1);
            --shadow-hover: 0 15px 35px rgba(0, 126, 93, 0.15);
            --border-radius: 16px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, var(--background) 0%, var(--light-green) 100%);
            color: var(--text-dark);
            line-height: 1.6;
            min-height: 100vh;
        }

        /* Header modernisé */
        .header {
            background: var(--white);
            backdrop-filter: blur(20px);
            box-shadow: 0 4px 20px rgba(0, 126, 93, 0.08);
            position: sticky;
            top: 0;
            z-index: 100;
            border-bottom: 1px solid rgba(0, 126, 93, 0.1);
        }

        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .logo-container {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--primary-green), var(--secondary-yellow));
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
        }

        .logo-container::before {
            content: '';
            position: absolute;
            inset: 2px;
            background: var(--white);
            border-radius: 14px;
        }

        .logo-container i {
            font-size: 1.8rem;
            color: var(--primary-green);
            z-index: 1;
        }

        .brand-text {
            display: flex;
            flex-direction: column;
        }

        .brand-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-green);
            margin: 0;
        }

        .brand-subtitle {
            font-size: 0.875rem;
            color: var(--text-light);
            margin: 0;
        }

        .nav-links {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            text-decoration: none;
            color: var(--text-dark);
            font-weight: 500;
            transition: var(--transition);
            position: relative;
        }

        .nav-link:hover {
            background: var(--light-green);
            color: var(--primary-green);
            transform: translateY(-2px);
        }

        /* Container principal */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        .page-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--primary-green);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }

        .page-subtitle {
            font-size: 1.125rem;
            color: var(--text-light);
            max-width: 600px;
            margin: 0 auto;
        }

        /* Messages de succès */
        .success-message {
            background: linear-gradient(135deg, var(--light-green), var(--light-yellow));
            border: 2px solid var(--secondary-yellow);
            border-radius: var(--border-radius);
            padding: 1rem 1.5rem;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-weight: 500;
            color: var(--primary-green);
            animation: slideInDown 0.5s ease;
        }

        @keyframes slideInDown {
            from { transform: translateY(-20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        /* Cards modernisées */
        .card {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 2rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(0, 126, 93, 0.1);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-green), var(--secondary-yellow));
        }

        .card:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-4px);
        }

        .card-title {
            font-size: 1.375rem;
            font-weight: 700;
            color: var(--primary-green);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        /* Formulaires */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-label {
            font-weight: 600;
            color: var(--primary-green);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-input {
            padding: 1rem 1.25rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
            background: var(--white);
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary-green);
            box-shadow: 0 0 0 3px rgba(0, 126, 93, 0.1);
        }

        .form-input::placeholder {
            color: var(--text-light);
        }

        .form-help {
            font-size: 0.875rem;
            color: var(--text-light);
            margin-top: 0.5rem;
        }

        /* Boutons */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem 2rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            justify-content: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-green), var(--dark-green));
            color: var(--white);
            box-shadow: 0 4px 15px rgba(0, 126, 93, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 126, 93, 0.4);
        }

        /* Tableau modernisé */
        .table-container {
            background: var(--white);
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            border: 1px solid rgba(0, 126, 93, 0.1);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table-header {
            background: linear-gradient(135deg, var(--primary-green), var(--dark-green));
            color: var(--white);
        }

        .table-header th {
            padding: 1.25rem 1.5rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .table-body tr {
            transition: var(--transition);
            border-bottom: 1px solid #f1f5f9;
        }

        .table-body tr:hover {
            background: var(--light-green);
        }

        .table-body td {
            padding: 1.25rem 1.5rem;
            font-weight: 500;
        }

        .table-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            transition: var(--transition);
        }

        .action-edit {
            color: var(--primary-green);
            background: var(--light-green);
        }

        .action-edit:hover {
            background: var(--primary-green);
            color: var(--white);
        }

        .action-delete {
            color: #dc2626;
            background: #fef2f2;
        }

        .action-delete:hover {
            background: #dc2626;
            color: var(--white);
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            color: var(--text-light);
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--primary-green);
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        /* Unit badges */
        .unit-symbol {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 50px;
            height: 30px;
            background: var(--secondary-yellow);
            color: var(--text-dark);
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.875rem;
            margin-right: 0.75rem;
        }

        .unit-name {
            color: var(--text-light);
            font-size: 0.875rem;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 2rem;
            padding: 1rem;
            background: var(--white);
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 126, 93, 0.05);
        }

        .breadcrumb a {
            color: var(--text-light);
            text-decoration: none;
            transition: var(--transition);
        }

        .breadcrumb a:hover {
            color: var(--primary-green);
        }

        .breadcrumb .current {
            color: var(--primary-green);
            font-weight: 600;
        }

        /* Units showcase */
        .units-showcase {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .unit-card {
            background: var(--light-green);
            border: 1px solid rgba(0, 126, 93, 0.2);
            border-radius: 12px;
            padding: 1rem;
            text-align: center;
            transition: var(--transition);
        }

        .unit-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 126, 93, 0.1);
        }

        .unit-card-symbol {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-green);
            margin-bottom: 0.5rem;
        }

        .unit-card-name {
            font-size: 0.875rem;
            color: var(--text-light);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header-container {
                padding: 1rem;
                flex-direction: column;
                gap: 1rem;
            }

            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }

            .main-container {
                padding: 1rem;
            }

            .page-title {
                font-size: 2rem;
                flex-direction: column;
                gap: 0.5rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .table-container {
                overflow-x: auto;
            }

            .units-showcase {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-container">
            <div class="logo-section">
                <div class="logo-container">
                    <i class="fas fa-utensils"></i>
                </div>
                <div class="brand-text">
                    <h1 class="brand-title">Anaran'ny app</h1>
                    <p class="brand-subtitle">Gestion intelligente des ingrédients</p>
                </div>
            </div>
            <nav class="nav-links">
                <a href="${pageContext.request.contextPath}" class="nav-link">
                    <i class="fas fa-home"></i>
                    Accueil
                </a>
                <a href="${pageContext.request.contextPath}/composant/" class="nav-link">
                    <i class="fas fa-seedling"></i>
                    Composants
                </a>
            </nav>
        </div>
    </header>

    <main class="main-container">
        <%-- <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}">
                <i class="fas fa-home"></i>
                Accueil
            </a>
            <i class="fas fa-chevron-right"></i>
            <a href="${pageContext.request.contextPath}/composant/">Composants</a>
            <i class="fas fa-chevron-right"></i>
            <span class="current">Unités de mesure</span>
        </div> --%>

        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-balance-scale"></i>
                Gestion des Unités de Mesure
            </h1>
            <p class="page-subtitle">
                Définissez les unités de mesure pour vos ingrédients : poids, volume, quantité...
                            </p>
        </div>

        <c:if test="${not empty succes}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i>
                <span>${succes}</span>
            </div>
        </c:if>

        <div class="card">
            <h2 class="card-title">
                <i class="fas ${empty unite.id ? 'fa-plus-circle' : 'fa-edit'}"></i>
                ${empty unite.id ? 'Ajouter une nouvelle' : 'Modifier cette'} unité
            </h2>
            
            <form action="save" method="post" class="form-grid">
                <input type="hidden" name="id" value="${unite.id}">
                
                <div class="form-group">
                    <label for="nom" class="form-label">
                        <i class="fas fa-tag"></i>
                        Nom de l'unité
                    </label>
                    <input type="text" id="nom" name="nom" value="${unite.nom}" required 
                           class="form-input" placeholder="Ex: Kilogramme, Litre, Pièce...">
                    <p class="form-help">Le nom complet de l'unité de mesure</p>
                </div>
                
                <div class="form-group">
                    <label for="symbol" class="form-label">
                        <i class="fas fa-abacus"></i>
                        Symbole
                    </label>
                    <input type="text" id="symbol" name="symbol" value="${unite.symbol}" required 
                           class="form-input" maxlength="5" placeholder="Ex: kg, L, pce...">
                    <p class="form-help">Symbole court (5 caractères max)</p>
                </div>
                
                <div class="form-group" style="grid-column: 1 / -1;">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        ${empty unite.id ? 'Créer cette unité' : 'Mettre à jour'}
                    </button>
                </div>
            </form>
        </div>

        <div class="card">
            <h2 class="card-title">
                <i class="fas fa-list-ul"></i>
                Liste des Unités Disponibles
            </h2>
            
            <c:choose>
                <c:when test="${empty unites}">
                    <div class="empty-state">
                        <i class="fas fa-balance-scale-right"></i>
                        <h3>Aucune unité disponible</h3>
                        <p>Commencez par ajouter votre première unité de mesure</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <%-- <div class="units-showcase">
                        <c:forEach items="${unites}" var="unite">
                            <div class="unit-card">
                                <div class="unit-card-symbol">${unite.symbol}</div>
                                <div class="unit-card-name">${unite.nom}</div>
                            </div>
                        </c:forEach>
                    </div> --%>
                    
                    <div class="table-container" style="margin-top: 2rem;">
                        <table class="table">
                            <thead class="table-header">
                                <tr>
                                    <th>ID</th>
                                    <th>Détails</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody class="table-body">
                                <c:forEach items="${unites}" var="unite">
                                    <tr>
                                        <td>#${unite.id}</td>
                                        <td>
                                            <div style="display: flex; align-items: center;">
                                                <span class="unit-symbol">${unite.symbol}</span>
                                                <span class="unit-name">${unite.nom}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="table-actions">
                                                <a href="edit?id=${unite.id}" class="action-btn action-edit">
                                                    <i class="fas fa-edit"></i>
                                                    Modifier
                                                </a>
                                                <a href="delete?id=${unite.id}" 
                                                   class="action-btn action-delete"
                                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer l\\'unité ${unite.nom} (${unite.symbol}) ?')">
                                                    <i class="fas fa-trash-alt"></i>
                                                    Supprimer
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</body>
</html>