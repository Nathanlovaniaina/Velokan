<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Composants</title>
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
            gap: 2rem;
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
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
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

        .form-input, .form-select {
            padding: 1rem 1.25rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
            background: var(--white);
        }

        .form-input:focus, .form-select:focus {
            outline: none;
            border-color: var(--primary-green);
            box-shadow: 0 0 0 3px rgba(0, 126, 93, 0.1);
        }

        .form-input::placeholder {
            color: var(--text-light);
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

        .btn-secondary {
            background: linear-gradient(135deg, var(--secondary-yellow), #e6b020);
            color: var(--text-dark);
            box-shadow: 0 4px 15px rgba(248, 200, 40, 0.3);
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(248, 200, 40, 0.4);
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

        /* Actions rapides */
        .quick-actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-top: 2rem;
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

        /* Responsive */
        @media (max-width: 768px) {
            .header-container {
                padding: 1rem;
                flex-direction: column;
                gap: 1rem;
            }

            .nav-links {
                gap: 1rem;
            }

            .main-container {
                padding: 1rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .quick-actions {
                flex-direction: column;
            }

            .table-container {
                overflow-x: auto;
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
            </nav>
        </div>
    </header>

    <main class="main-container">
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-seedling"></i>
                Gestion des Composants
            </h1>
            <p class="page-subtitle">
                Gérez vos ingrédients et composants alimentaires avec facilité
            </p>
        </div>

        <c:if test="${not empty succes}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i>
                ${succes}
            </div>
        </c:if>

        <div class="card">
            <h2 class="card-title">
                <i class="fas fa-plus-circle"></i>
                ${empty composant.id ? 'Ajouter un nouveau' : 'Modifier le'} composant
            </h2>
            <form action="save" method="post">
                <input type="hidden" name="id" value="${composant.id}">
                
                <div class="form-grid">
                    <div class="form-group">
                        <label for="nom" class="form-label">
                            <i class="fas fa-tag"></i>
                            Nom du composant
                        </label>
                        <input type="text" 
                               id="nom" 
                               name="nom" 
                               value="${composant.nom}" 
                               class="form-input"
                               required 
                               placeholder="Ex: Carotte, Tomate, Basilic...">
                    </div>
                    
                    <div class="form-group">
                        <label for="idType" class="form-label">
                            <i class="fas fa-layer-group"></i>
                            Type de composant
                        </label>
                        <select id="idType" name="idType" class="form-select" required>
                            <option value="">-- Sélectionnez un type --</option>
                            <c:forEach items="${typesComposant}" var="type">
                                <option value="${type.id}" ${composant.typeComposant != null && composant.typeComposant.id == type.id ? 'selected' : ''}>
                                    ${type.nom}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="idUnite" class="form-label">
                            <i class="fas fa-balance-scale"></i>
                            Unité de mesure
                        </label>
                        <select id="idUnite" name="idUnite" class="form-select" required>
                            <option value="">-- Sélectionnez une unité --</option>
                            <c:forEach items="${unites}" var="unite">
                                <option value="${unite.id}" ${composant.unite != null && composant.unite.id == unite.id ? 'selected' : ''}>
                                    ${unite.symbol} (${unite.nom})
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i>
                    Enregistrer le composant
                </button>
            </form>
        </div>

        <div class="card">
            <h2 class="card-title">
                <i class="fas fa-list"></i>
                Liste des composants (${not empty composants ? composants.size() : 0})
            </h2>
            
            <c:if test="${empty composants}">
                <div class="empty-state">
                    <i class="fas fa-box-open"></i>
                    <h3>Aucun composant disponible</h3>
                    <p>Commencez par ajouter votre premier composant alimentaire</p>
                </div>
            </c:if>
            
            <c:if test="${not empty composants}">
                <div class="table-container">
                    <table class="table">
                        <thead class="table-header">
                            <tr>
                                <th><i class="fas fa-hashtag"></i> ID</th>
                                <th><i class="fas fa-tag"></i> Nom</th>
                                <th><i class="fas fa-layer-group"></i> Type</th>
                                <th><i class="fas fa-balance-scale"></i> Unité</th>
                                <th><i class="fas fa-cogs"></i> Actions</th>
                            </tr>
                        </thead>
                        <tbody class="table-body">
                            <c:forEach items="${composants}" var="comp">
                                <tr>
                                    <td><strong>#${comp.id}</strong></td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 0.5rem;">
                                            <i class="fas fa-carrot" style="color: var(--primary-green);"></i>
                                            ${comp.nom}
                                        </div>
                                    </td>
                                    <td>
                                        <span style="background: var(--light-green); color: var(--primary-green); padding: 0.25rem 0.75rem; border-radius: 12px; font-size: 0.875rem; font-weight: 500;">
                                            ${comp.typeComposant.nom}
                                        </span>
                                    </td>
                                    <td>
                                        <code style="background: var(--light-yellow); color: var(--text-dark); padding: 0.25rem 0.5rem; border-radius: 6px;">
                                            ${comp.unite.symbol}
                                        </code>
                                        ${comp.unite.nom}
                                    </td>
                                    <td class="table-actions">
                                        <a href="edit?id=${comp.id}" class="action-btn action-edit">
                                            <i class="fas fa-edit"></i>
                                            Modifier
                                        </a>
                                        <a href="delete?id=${comp.id}" 
                                           class="action-btn action-delete" 
                                           onclick="return confirm('⚠️ Êtes-vous sûr de vouloir supprimer le composant \"${comp.nom}\" ?')">
                                            <i class="fas fa-trash"></i>
                                            Supprimer
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
            
            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/type_composant/" class="btn btn-secondary">
                    <i class="fas fa-plus"></i>
                    Nouveau type de composant
                </a>
                <a href="${pageContext.request.contextPath}/unite/" class="btn btn-secondary">
                    <i class="fas fa-ruler"></i>
                    Nouvelle unité de mesure
                </a>
            </div>
        </div>
    </main>

    <script>
        // Animation d'entrée pour les cartes
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.card');
            cards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
                card.style.animation = 'slideInUp 0.6s ease forwards';
            });
        });

        // Animation CSS pour l'entrée des cartes
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideInUp {
                from {
                    transform: translateY(30px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>