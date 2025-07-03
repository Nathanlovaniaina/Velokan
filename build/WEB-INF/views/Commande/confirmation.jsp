<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Confirmation de Commande | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #28a745 !important;  /* Vert comme couleur primaire */
            --secondary-color: #FF8C00 !important;  /* Orange comme couleur secondaire */
            --primary-light: #e8f5e9 !important;  /* Vert très clair */
            --secondary-light: #fff3e0 !important; /* Orange très clair */
            --dark-color: #2c3e50 !important;
            --light-color: #f8f9fa !important;
            --danger-color: #e74c3c !important;
            --success-color: #2ecc71 !important;
        }
        
        body {
            font-family: 'Inter', sans-serif !important;
            color: var(--dark-color) !important;
        }

        .wrapper {
            background: var(--primary-light) !important;
        }
        
        /* Sidebar styling - Utilisation de la couleur primaire (vert) */
        #sidebar {
            background-color: var(--primary-color) !important;
            color: white !important;
        }
        
        .sidebar-brand {
            color: white !important;
            font-weight: 600 !important;
            background-color: rgba(0, 0, 0, 0.1) !important;
        }
        
        .sidebar-item.active .sidebar-link {
            color: var(--primary-color) !important;
            background-color: white !important;
        }
        
        .sidebar-link {
            color: rgba(255, 255, 255, 0.8) !important;
        }
        
        .sidebar-link:hover {
            color: white !important;
            background-color: rgba(255, 255, 255, 0.1) !important;
        }
        
        /* Navbar styling */
        .navbar-bg {
            background-color: white !important;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1) !important;
        }
        
        .sidebar-toggle {
            color: var(--primary-color) !important;
        }
        
        /* Card styling */
        .card {
            border: none !important;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05) !important;
            border-radius: 10px !important;
            overflow: hidden !important;
        }
        
        .card-header {
            background-color: white !important;
            border-bottom: none !important;
            padding: 1rem 1.5rem !important;
        }

        .card-title {
            color: var(--primary-color) !important;
            font-size: 20px;
        }
        
        /* Button styling - Primaire en vert, secondaire en orange */
        .btn-primary {
            background-color: var(--primary-color) !important;
            border-color: var(--primary-color) !important;
        }
        
        .btn-primary:hover {
            background-color: #218838 !important;
            border-color: #218838 !important;
        }
        
        .btn-outline-primary {
            color: var(--primary-color) !important;
            border-color: var(--primary-color) !important;
        }
        
        .btn-outline-primary:hover {
            background-color: var(--primary-color) !important;
            color: white !important;
        }
        
        /* Bouton secondaire en orange */
        .btn-secondary {
            background-color: var(--secondary-color) !important;
            border-color: var(--secondary-color) !important;
            color: white !important;
        }
        
        .btn-secondary:hover {
            background-color: #e67e00 !important;
            border-color: #e67e00 !important;
            color: white !important;
        }
        
        /* Custom styles */
        .confirmation-card {
            border: 1px solid #dee2e6 !important;
            border-radius: 0.375rem !important;
        }
        
        .plat-item {
            padding: 0.75rem 1.25rem !important;
            margin-bottom: 0.5rem !important;
            background-color: #f8f9fa !important;
            border-left: 4px solid var(--secondary-color) !important;  /* Bordure orange */
            border-radius: 0.25rem !important;
        }
        
        .header-section {
            border-bottom: 2px solid var(--primary-color) !important;  /* Bordure verte */
            padding-bottom: 1rem !important;
            margin-bottom: 1.5rem !important;
        }
        
        .info-label {
            font-weight: 600 !important;
            color: var(--dark-color) !important;
            min-width: 180px !important;
            display: inline-block !important;
        }
        
        .total-price {
            background-color: var(--secondary-light) !important;  /* Fond orange très clair */
            padding: 1rem !important;
            border-radius: 0.375rem !important;
            margin-top: 1.5rem !important;
            border: 1px solid rgba(255, 140, 0, 0.2) !important;
        }
        
        /* Alert styling */
        .alert-danger {
            background-color: rgba(231, 76, 60, 0.1) !important;
            border-color: rgba(231, 76, 60, 0.2) !important;
            color: var(--dark-color) !important;
        }

        /* Badge styling - en orange */
        .badge.bg-primary {
            background-color: var(--secondary-color) !important;
        }

        /* Icon colors */
        .text-primary {
            color: var(--primary-color) !important;  /* Icônes en vert */
        }
        
        .text-secondary {
            color: var(--secondary-color) !important;  /* Icônes en orange */
        }
        
        /* Style pour le montant en Ariary */
        .currency-ariary {
            font-weight: bold;
        }
        .currency-ariary:after {
            content: " Ar";
            font-weight: normal;
        }
    </style>
</head>

<body>
    <div class="wrapper">
        <!-- Sidebar -->
        <nav id="sidebar" class="sidebar js-sidebar">
            <div class="sidebar-content js-simplebar">
                <a class="sidebar-brand" href="index.html">
                    <span class="align-middle">VELONKAN</span>
                </a>
                <ul class="sidebar-nav">
                    <li class="sidebar-header">
                        Commandes
                    </li>
                    <li class="sidebar-item active">
                        <a class="sidebar-link" href="#">
                            <i class="align-middle" data-feather="shopping-cart"></i> 
                            <span class="align-middle">Confirmation</span>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="main">
            <nav class="navbar navbar-expand navbar-light navbar-bg">
                <a class="sidebar-toggle js-sidebar-toggle">
                    <i class="hamburger align-self-center"></i>
                </a>

                <div class="navbar-collapse collapse">
                    <ul class="navbar-nav navbar-align">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-bs-toggle="dropdown">
                                <span class="text-dark">Administrateur</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <main class="content">
                <div class="container-fluid p-0">
                    <div class="row">
                        <div class="col-12 col-lg-8 mx-auto">
                            <div class="card confirmation-card">
                                <div class="card-header">
                                    <h2 class="h4 mb-0">Confirmation de Commande</h2>
                                </div>
                                
                                <div class="card-body">
                                    <!-- Affichage du message d'erreur -->
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            <i class="bi bi-exclamation-triangle me-2"></i>
                                            <c:out value="${error}"/>
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                                        </div>
                                    </c:if>
                                    <c:choose>
                                        <c:when test="${not empty entreprise}">
                                            <!-- Section Informations -->
                                            <div class="mb-4 header-section">
                                                <div class="d-flex align-items-center mb-3">
                                                    <i class="bi bi-building me-2 fs-4 text-primary"></i>
                                                    <h3 class="h5 mb-0">Informations Générales</h3>
                                                </div>
                                                
                                                <div class="ps-4">
                                                    <p class="mb-2">
                                                        <span class="info-label">Entreprise :</span>
                                                        <span class="fw-bold"><c:out value="${entreprise.nom}"/></span>
                                                    </p>
                                                    <p class="mb-2">
                                                        <span class="info-label">Date de livraison :</span>
                                                        <span class="fw-bold"><c:out value="${dateLivraison}"/></span>
                                                    </p>
                                                    <p class="mb-0">
                                                        <span class="info-label">Commentaires :</span>
                                                        <span><c:out value="${not empty commentaires ? commentaires : 'Aucun'}"/></span>
                                                    </p>
                                                </div>
                                            </div>
                                            
                                            <!-- Section Plats -->
                                            <div class="mb-4">
                                                <div class="d-flex align-items-center mb-3">
                                                    <i class="bi bi-egg-fried me-2 fs-4 text-secondary"></i> <!-- Icône en orange -->
                                                    <h3 class="h5 mb-0">Plats Commandés</h3>
                                                </div>
                                                
                                                <div class="ps-4">
                                                    <ul class="list-unstyled">
                                                        <c:forEach items="${plats}" var="plat" varStatus="loop">
                                                            <li class="plat-item d-flex justify-content-between align-items-center">
                                                                <div>
                                                                    <span class="fw-bold"><c:out value="${plat.nom}"/></span>
                                                                    <span class="text-muted ms-2">(x<c:out value="${plat.quantite}"/>)</span>
                                                                </div>
                                                                <span class="badge bg-primary rounded-pill">#${loop.index + 1}</span>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                    
                                                    <div class="mt-3 text-end">
                                                        <span class="text-muted me-2">Total plats :</span>
                                                        <span class="fw-bold fs-5"><c:out value="${totalPlats}"/></span>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Section Prix Total -->
                                            <div class="total-price">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div class="d-flex align-items-center">
                                                        <i class="bi bi-cash-coin fs-3 text-secondary me-3"></i> <!-- Icône en orange -->
                                                        <div>
                                                            <h4 class="h6 mb-1">Montant total à payer</h4>
                                                            <p class="small text-muted mb-0">TVA incluse</p>
                                                        </div>
                                                    </div>
                                                    <div class="text-end">
                                                        <span class="fw-bold fs-2 text-secondary currency-ariary">
                                                            <fmt:formatNumber value="${prixTotal}" type="number"/>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Boutons d'action -->
                                            <div class="d-flex justify-content-between border-top pt-3 mt-4">
                                                <a href="<c:url value='/commande/form'/>" class="btn btn-outline-secondary">
                                                    <i class="bi bi-arrow-left me-1"></i> Retour
                                                </a>
                                                <a href="<c:url value='/commande/insert'/>" class="btn btn-primary">
                                                    <i class="bi bi-check-circle me-1"></i> Valider la commande
                                                </a>
                                            </div>
                                        </c:when>
                                        
                                        <c:otherwise>
                                            <!-- Aucune donnée -->
                                            <div class="text-center py-5">
                                                <i class="bi bi-exclamation-triangle fs-1 text-warning"></i>
                                                <h3 class="h5 mt-3">Aucune donnée de commande disponible</h3>
                                                <p class="text-muted">La session a peut-être expiré ou aucune commande n'a été passée.</p>
                                                <a href="<c:url value='/commande/form'/>" class="btn btn-primary mt-2">
                                                    <i class="bi bi-arrow-left me-1"></i> Retour au formulaire
                                                </a>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
</body>
</html>