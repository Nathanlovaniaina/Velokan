<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gestion des employés | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/employe.css" rel="stylesheet">
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
                        </li>
                    </ul>
                </div>
            </nav>

            <main class="content">
                <div class="container-fluid p-0">
                    <div class="mb-3">
                        <h1 class="h3 d-inline align-middle">Gestion des employés</h1>
                    </div>

                    <!-- Messages -->
                    <c:if test="${not empty erreur}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${erreur}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty succes}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${succes}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                        </div>
                    </c:if>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">
                                        <c:choose>
                                            <c:when test="${not empty employe.id}">Modifier un employé</c:when>
                                            <c:otherwise>Ajouter un nouvel employé</c:otherwise>
                                        </c:choose>
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/employe/save" method="post">
                                        <input type="hidden" name="id" value="${employe.id}" />

                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <label for="id_poste" class="form-label">Poste :</label>
                                                <select name="id_poste" class="form-select" required>
                                                    <c:if test="${not empty employe.poste}">
                                                        <option value="${employe.poste.id}" selected>${employe.poste.nom}</option>
                                                    </c:if>
                                                    <c:forEach var="p" items="${postes}">
                                                        <c:if test="${employe.poste == null || p.id != employe.poste.id}">
                                                            <option value="${p.id}">${p.nom}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Numéro d'identification :</label>
                                                <input type="text" name="num_identification" class="form-control" value="${employe.numIdentification}" required />
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <label class="form-label">Nom :</label>
                                                <input type="text" name="nom" class="form-control" value="${employe.nom}" required />
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Prénom :</label>
                                                <input type="text" name="prenom" class="form-control" value="${employe.prenom}" required />
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <label class="form-label">Date de naissance :</label>
                                                <input type="date" name="date_naissance" class="form-control" value="${employe.dateNaissance}" />
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Contact :</label>
                                                <input type="text" name="contact" class="form-control" value="${employe.contact}" />
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <label class="form-label">Date d'embauche :</label>
                                                <input type="date" name="date_embauche" class="form-control" value="${employe.dateEmbauche}" required />
                                            </div>
                                        </div>

                                        <div class="d-flex justify-content-end">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-save me-1"></i> Enregistrer
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Liste des employés</h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover" id="employesTable">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Nom</th>
                                                    <th>Prénom</th>
                                                    <th>Poste</th>
                                                    <th>Salaire</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="e" items="${employes}">
                                                <tr>
                                                    <td>${e.id}</td>
                                                    <td>${e.nom}</td>
                                                    <td>${e.prenom}</td>
                                                    <td>
                                                        <c:forEach var="p" items="${postes}">
                                                            <c:if test="${p.id == e.getPoste().id}">${p.nom}</c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td>
                                                        <c:forEach var="p" items="${postes}">
                                                            <c:if test="${p.id == e.getPoste().id}">${p.salaire} Ar</c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td>
                                                        <a href="edit/?id=${e.id}" class="btn btn-sm btn-outline-primary me-1">
                                                            <i class="bi bi-pencil"></i>
                                                        </a>
                                                        <a href="delete?id=${e.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Confirmer la suppression ?')">
                                                            <i class="bi bi-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
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
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>

    <script>
    $(document).ready(function() {
        // Initialisation de DataTables
        $('#employesTable').DataTable({
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json'
            },
            responsive: true,
            columnDefs: [
                { orderable: false, targets: 5 } // Désactiver le tri sur la colonne Actions
            ]
        });
    });
    </script>
</body>
</html>