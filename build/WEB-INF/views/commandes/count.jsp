<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Nombre de Commandes | VELONKAN</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/count.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                    <i class="bi bi-list"></i>
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
                    <div class="page-header">
                        <h1 class="h3 d-inline align-middle">Statistiques des Commandes</h1>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Recherche de commandes</h5>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/commandes/count" method="get">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Date de début (AAAA-MM-JJ)</label>
                                                    <input type="date" id="date" name="date" class="form-control" required pattern="\d{4}-\d{2}-\d{2}">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Date de fin (AAAA-MM-JJ, optionnel)</label>
                                                    <input type="date" id="endDate" name="endDate" class="form-control" pattern="\d{4}-\d{2}-\d{2}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-search me-1"></i> Vérifier
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <c:if test="${isSingleDay}">
                        <c:if test="${not empty nombreCommandes}">
                            <div class="row">
                                <div class="col-12">
                                    <div class="result-container">
                                        <p>Nombre de commandes pour le <strong>${date}</strong> : <strong>${nombreCommandes}</strong></p>
                                    </div>
                                    
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="card-title mb-0">Visualisation des données</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="chart-container">
                                                <canvas id="ordersChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <script>
                                        const ctx = document.getElementById('ordersChart').getContext('2d');
                                        new Chart(ctx, {
                                            type: 'bar',
                                            data: {
                                                labels: ['${date}'],
                                                datasets: [{
                                                    label: 'Nombre de Commandes',
                                                    data: [${nombreCommandes}],
                                                    backgroundColor: 'rgba(0, 126, 93, 0.2)',
                                                    borderColor: '#007e5d',
                                                    borderWidth: 1
                                                }]
                                            },
                                            options: {
                                                responsive: true,
                                                maintainAspectRatio: false,
                                                scales: {
                                                    y: {
                                                        beginAtZero: true,
                                                        title: {
                                                            display: true,
                                                            text: 'Nombre de Commandes'
                                                        }
                                                    },
                                                    x: {
                                                        title: {
                                                            display: true,
                                                            text: 'Date'
                                                        }
                                                    }
                                                }
                                            }
                                        });
                                    </script>
                                </div>
                            </div>
                        </c:if>
                    </c:if>
                    
                    <c:if test="${not isSingleDay}">
                        <c:if test="${not empty orderDataList}">
                            <div class="row">
                                <div class="col-12">
                                    <div class="result-container">
                                        <p>Résultats pour la période du <strong>${startDate}</strong> au <strong>${endDate}</strong></p>
                                    </div>
                                    
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="card-title mb-0">Détails par jour</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>Date</th>
                                                            <th>Nombre de commandes</th>
                                                            <th>Évolution</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="orderData" items="${orderDataList}">
                                                            <tr>
                                                                <td>${orderData.date}</td>
                                                                <td>${orderData.count}</td>
                                                                <td class="${orderData.evolution == 'A évolué' ? 'evolution-positive' : orderData.evolution == 'A diminué' ? 'evolution-negative' : 'evolution-neutral'}">
                                                                    ${orderData.evolution}
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="card-title mb-0">Visualisation des données</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="chart-container">
                                                <canvas id="ordersChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <script>
                                        const labels = [
                                            <c:forEach var="orderData" items="${orderDataList}" varStatus="status">
                                                "${orderData.date}"<c:if test="${!status.last}">,</c:if>
                                            </c:forEach>
                                        ];
                                        const data = [
                                            <c:forEach var="orderData" items="${orderDataList}" varStatus="status">
                                                ${orderData.count}<c:if test="${!status.last}">,</c:if>
                                            </c:forEach>
                                        ];
                                        const ctx = document.getElementById('ordersChart').getContext('2d');
                                        new Chart(ctx, {
                                            type: 'bar',
                                            data: {
                                                labels: labels,
                                                datasets: [{
                                                    label: 'Nombre de Commandes',
                                                    data: data,
                                                    backgroundColor: 'rgba(0, 126, 93, 0.2)',
                                                    borderColor: '#007e5d',
                                                    borderWidth: 1
                                                }]
                                            },
                                            options: {
                                                responsive: true,
                                                maintainAspectRatio: false,
                                                scales: {
                                                    y: {
                                                        beginAtZero: true,
                                                        title: {
                                                            display: true,
                                                            text: 'Nombre de Commandes'
                                                        }
                                                    },
                                                    x: {
                                                        title: {
                                                            display: true,
                                                            text: 'Date'
                                                        }
                                                    }
                                                }
                                            }
                                        });
                                    </script>
                                </div>
                            </div>
                        </c:if>
                    </c:if>
                    
                    <c:if test="${not empty error}">
                        <div class="row">
                            <div class="col-12">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <div class="row">
                        <div class="col-12">
                            <a href="${pageContext.request.contextPath}/" class="d-inline-flex align-items-center">
                                <i class="bi bi-arrow-left me-2"></i> Retour à l'accueil
                            </a>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sidebar toggle functionality
        document.addEventListener('DOMContentLoaded', function() {
            const sidebarToggle = document.querySelector('.js-sidebar-toggle');
            const sidebar = document.querySelector('.js-sidebar');
            
            if (sidebarToggle && sidebar) {
                sidebarToggle.addEventListener('click', function() {
                    sidebar.classList.toggle('collapsed');
                });
            }
        });
    </script>
</body>
</html>