<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des Mouvements de Contrat | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/mvtcontrat.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" rel="stylesheet">
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
            <!-- Navbar -->
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
                            <div class="dropdown-menu dropdown-menu-end">
                                <a class="dropdown-item" href="#"><i class="bi bi-person align-middle me-2"></i> Profil</a>
                                <a class="dropdown-item" href="#"><i class="bi bi-gear align-middle me-2"></i> Paramètres</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right align-middle me-2"></i> Déconnexion</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>

            <main class="content">
                <div class="container-fluid p-0">
                    <div class="content-header">
                        <h1 class="h3 d-inline align-middle">Gestion des Mouvements de Contrat</h1>
                        <c:if test="${not empty entreprise}">
                            <p class="text-muted mb-0 mt-2">Entreprise : ${entreprise.nom}</p>
                        </c:if>
                    </div>

                    <c:if test="${not empty message}">
                        <div class="alert ${message.contains('Erreur') ? 'alert-danger' : 'alert-success'} alert-dismissible fade show" role="alert">
                            ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <ul class="nav nav-tabs card-header-tabs">
                                        <li class="nav-item">
                                            <a class="nav-link ${param.tab != 'list' ? 'active' : ''}" data-bs-toggle="tab" href="#create-tab">Créer Mouvement</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link ${param.tab == 'list' ? 'active' : ''}" data-bs-toggle="tab" href="#list-tab">Liste des Mouvements</a>
                                        </li>
                                        <li class="nav-item ms-auto">
                                            <a href="${pageContext.request.contextPath}/entreprise/list?tab=list" class="btn btn-outline-primary btn-sm">
                                                <i class="bi bi-arrow-left me-1"></i> Retour aux Entreprises
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="card-body">
                                    <div class="tab-content">
                                        <!-- Onglet Création -->
                                        <div id="create-tab" class="tab-pane fade ${param.tab != 'list' ? 'show active' : ''}">
                                            <form action="${pageContext.request.contextPath}/mvtcontrat/save" method="post">
                                                <input type="hidden" name="id" value="${mvtContrat.id}">
                                                
                                                <div class="row mb-3">
                                                    <div class="col-md-6">
                                                        <label for="entrepriseNom" class="form-label">Entreprise</label>
                                                        <c:choose>
                                                            <c:when test="${not empty entreprise}">
                                                                <input type="hidden" name="entrepriseNom" value="${entreprise.nom}">
                                                                <input type="text" class="form-control" value="${entreprise.nom}" disabled>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <select id="entrepriseNom" name="entrepriseNom" class="form-select" required>
                                                                    <option value="">Sélectionnez une entreprise</option>
                                                                    <c:forEach items="${entreprises}" var="ent">
                                                                        <option value="${ent.nom}" ${mvtContrat.entreprise != null && mvtContrat.entreprise.nom == ent.nom ? 'selected' : ''}>
                                                                            ${ent.nom}
                                                                        </option>
                                                                    </c:forEach>
                                                                </select>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    
                                                    <div class="col-md-6">
                                                        <label for="typeMvt" class="form-label">Type</label>
                                                        <select id="typeMvt" name="typeMvt" class="form-select" required>
                                                            <option value="">Sélectionnez un type</option>
                                                            <option value="0" ${mvtContrat.typeMvt == 0 ? 'selected' : ''}>Début</option>
                                                            <option value="1" ${mvtContrat.typeMvt == 1 ? 'selected' : ''}>Fin</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                
                                                <div class="row mb-4">
                                                    <div class="col-md-6">
                                                        <label for="dateMvt" class="form-label">Date</label>
                                                        <input type="date" id="dateMvt" name="dateMvt" class="form-control"
                                                               value="<fmt:formatDate value='${mvtContrat.dateMvt}' pattern='yyyy-MM-dd'/>" required>
                                                    </div>
                                                </div>
                                                
                                                <div class="d-flex justify-content-end">
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="bi bi-save me-1"></i> ${mvtContrat.id != null ? 'Mettre à jour' : 'Enregistrer'} le mouvement
                                                    </button>
                                                </div>
                                            </form>
                                        </div>

                                        <!-- Onglet Liste -->
                                        <div id="list-tab" class="tab-pane fade ${param.tab == 'list' ? 'show active' : ''}">
                                            <!-- Filtre par date -->
                                            <div class="row mb-4">
                                                <div class="col-md-6">
                                                    <form action="${pageContext.request.contextPath}/mvtcontrat/list" method="get" class="card p-3">
                                                        <input type="hidden" name="tab" value="list">
                                                        <c:if test="${not empty entreprise}">
                                                            <input type="hidden" name="entrepriseId" value="${entreprise.id}">
                                                        </c:if>
                                                        <div class="mb-3">
                                                            <label for="fromDate" class="form-label">Afficher les entreprises avec contrats actifs à partir de :</label>
                                                            <input type="date" id="fromDate" name="fromDate" class="form-control"
                                                                   value="<fmt:formatDate value='${fromDate}' pattern='yyyy-MM-dd'/>">
                                                        </div>
                                                        <button type="submit" class="btn btn-primary">
                                                            <i class="bi bi-funnel me-1"></i> Filtrer
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>

                                            <!-- Afficher les entreprises avec contrats actifs -->
                                            <c:if test="${not empty activeEntreprises}">
                                                <div class="card mb-4">
                                                    <div class="card-header">
                                                        <h5 class="card-title mb-0">Entreprises avec contrats actifs à partir du <fmt:formatDate value="${fromDate}" pattern="dd/MM/yyyy"/></h5>
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Nom de l'Entreprise</th>
                                                                        <th>Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="ent" items="${activeEntreprises}">
                                                                        <tr>
                                                                            <td>${ent.nom}</td>
                                                                            <td>
                                                                                <a href="${pageContext.request.contextPath}/mvtcontrat/list?entrepriseId=${ent.id}&tab=list" 
                                                                                   class="btn btn-sm btn-outline-primary">
                                                                                    <i class="bi bi-eye me-1"></i> Voir les mouvements
                                                                                </a>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>

                                            <div class="card">
                                                <div class="card-header">
                                                    <h5 class="card-title mb-0">Liste des mouvements existants</h5>
                                                </div>
                                                <div class="card-body">
                                                    <c:choose>
                                                        <c:when test="${empty mvtContrats}">
                                                            <div class="text-center py-5">
                                                                <i class="bi bi-info-circle" style="font-size: 3rem; color: var(--primary-color);"></i>
                                                                <h4 class="mt-3">Aucun mouvement de contrat enregistré</h4>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="table-responsive">
                                                                <table class="table table-hover">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Entreprise</th>
                                                                            <th>Type</th>
                                                                            <th>Date</th>
                                                                            <th>Actions</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <c:forEach var="mvt" items="${mvtContrats}">
                                                                            <tr>
                                                                                <td>${mvt.entreprise.nom}</td>
                                                                                <td>
                                                                                    <span class="badge ${mvt.typeMvt == 0 ? 'bg-success' : 'bg-danger'}">
                                                                                        ${mvt.typeMvt == 0 ? 'Début' : 'Fin'}
                                                                                    </span>
                                                                                </td>
                                                                                <td><fmt:formatDate value="${mvt.dateMvt}" pattern="dd/MM/yyyy"/></td>
                                                                                <td>
                                                                                    <div class="d-flex gap-2">
                                                                                        <a href="${pageContext.request.contextPath}/mvtcontrat/edit/${mvt.id}<c:if test='${not empty entreprise}'>?entrepriseId=${entreprise.id}</c:if>" 
                                                                                           class="btn btn-sm btn-outline-primary">
                                                                                            <i class="bi bi-pencil"></i> Modifier
                                                                                        </a>
                                                                                        <a href="${pageContext.request.contextPath}/mvtcontrat/delete/${mvt.id}<c:if test='${not empty entreprise}'>?entrepriseId=${entreprise.id}</c:if>" 
                                                                                           class="btn btn-sm btn-outline-danger" 
                                                                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce mouvement ?')">
                                                                                            <i class="bi bi-trash"></i> Supprimer
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
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>

    <script>
    $(document).ready(function() {
        // Initialisation de Select2 pour les selects
        $('.form-select').select2({
            theme: 'bootstrap-5',
            width: '100%'
        });
        
        // Gestion des onglets
        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            const tabName = $(e.target).attr('href').substring(1);
            // Mettre à jour l'URL sans recharger la page
            const url = new URL(window.location.href);
            url.searchParams.set('tab', tabName.replace('-tab', ''));
            window.history.pushState({}, '', url);
        });
        
        // Au chargement de la page, activer le bon onglet
        const urlParams = new URLSearchParams(window.location.search);
        const currentTab = urlParams.get('tab') || 'create';
        $(`a[href="#${currentTab}-tab"]`).tab('show');
        
        // Initialisation du toggle de la sidebar
        $('.js-sidebar-toggle').click(function() {
            $('.js-sidebar').toggleClass('collapsed');
            $('.main').toggleClass('sidebar-collapsed');
        });
    });
    </script>
</body>
</html>