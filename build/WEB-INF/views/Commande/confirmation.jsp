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
    <link href="${pageContext.request.contextPath}/resources/css/confirmationCommande.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
</head>

<body>
    <div class="wrapper">
        <!-- Sidebar -->
        <nav id="sidebar" class="sidebar js-sidebar">
    <div class="sidebar-content js-simplebar">
        <a class="sidebar-brand" href="index.html">
            <span class="align-middle"><span style="color: #006a4d;">VELON</span><span style="color: #f8c828;">KAN</span></span>
        </a>

        <!-- Tableau de bord -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Tableau de bord
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/suivi/recette">
                    <span class="align-middle">Suivi de recette</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/suivi/depense">
                    <span class="align-middle">Suivi de dépense</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/suivi/benefice">
                    <span class="align-middle">Suivi de bénéfice</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/commandes/count">
                    <span class="align-middle">Évolution de Commandes</span>
                </a>
            </li>
        </ul>

        <!-- Commandes -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Commandes
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/commande/form">
                    <i class="align-middle" data-feather="shopping-cart"></i> 
                    <span class="align-middle">Nouvelle Commande</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/plats/">
                    <i class="align-middle" data-feather="coffee"></i>
                    <span class="align-middle">Plats</span>
                </a>
            </li>
        </ul>

        <!-- Gestion des ressources -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Ressources Humaines
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/employe/">
                    <i class="align-middle" data-feather="users"></i>
                    <span class="align-middle">Employés</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/employe/paiement_salaire">
                    <i class="align-middle" data-feather="dollar-sign"></i>
                    <span class="align-middle">Paiement salaire</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/poste/">
                    <i class="align-middle" data-feather="briefcase"></i>
                    <span class="align-middle">Postes</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/mvtcontrat/create">
                    <i class="align-middle" data-feather="file-text"></i>
                    <span class="align-middle">Contrats</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/penalite/">
                    <i class="align-middle" data-feather="alert-circle"></i>
                    <span class="align-middle">Pénalités</span>
                </a>
            </li>
        </ul>

        <!-- Gestion des stocks -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Gestion des stocks
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/listStock/">
                    <i class="align-middle" data-feather="box"></i>
                    <span class="align-middle">Stocks</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/composant/">
                    <i class="align-middle" data-feather="cpu"></i>
                    <span class="align-middle">Composants</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/type_composant/">
                    <i class="align-middle" data-feather="layers"></i>
                    <span class="align-middle">Types de composants</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/unite/">
                    <i class="align-middle" data-feather="divide-square"></i>
                    <span class="align-middle">Unités</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/categories/">
                    <i class="align-middle" data-feather="grid"></i>
                    <span class="align-middle">Catégories</span>
                </a>
            </li>
        </ul>

        <!-- Administration -->
        <ul class="sidebar-nav">
            <li class="sidebar-header">
                Administration
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/entreprise/create">
                    <i class="align-middle" data-feather="home"></i>
                    <span class="align-middle">Créer entreprise</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a class="sidebar-link" href="${pageContext.request.contextPath}/depense/">
                    <i class="align-middle" data-feather="credit-card"></i>
                    <span class="align-middle">Dépenses</span>
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
                    <div class="mb-3">
                        <h1 class="h3 d-inline align-middle">Confirmation de Commande</h1>
                    </div>
                    
                    <div class="row">
                        <div class="col-12 col-lg-8 mx-auto">
                            <div class="card confirmation-card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Détails de la commande</h5>
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
                                                    <i class="bi bi-egg-fried me-2 fs-4 text-secondary"></i>
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
                                                        <i class="bi bi-cash-coin fs-3 text-secondary me-3"></i>
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