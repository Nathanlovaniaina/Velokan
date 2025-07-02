<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Dashboard Suivi Dépenses</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.bootstrap5.min.css" rel="stylesheet">
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
    
    <style>
        .card-table {
            margin-bottom: 0;
        }
        .positive {
            color: #2e7d32;
        }
        .negative {
            color: #c62828;
        }
        .high-cost {
            background-color: #ffebee;
        }
        .medium-cost {
            background-color: #fff8e1;
        }
        .badge-cost {
            background-color: #ff5722;
            color: white;
        }
        .form-filter {
            background-color: #f8f9fa;
            padding: 1rem;
            border-radius: 0.25rem;
            margin-bottom: 1rem;
        }
        .chart-container {
            position: relative;
            height: 300px;
            margin-bottom: 2rem;
        }
        .dataTables_wrapper .dataTables_filter input {
            margin-left: 0.5em;
        }
        .dt-buttons .btn {
            margin-right: 5px;
        }
        /* Style pour les composants coûteux */
        .high-price {
            background-color: #ffebee !important;
            font-weight: bold;
            border-left: 4px solid #ff5722;
        }

        /* Style pour le badge de coût */
        .badge-cost {
            background-color: #ff5722;
            color: white;
            padding: 3px 6px;
            border-radius: 4px;
            font-size: 0.85em;
        }
    </style>
</head>

<body>
    <div class="wrapper">
        <nav id="sidebar" class="sidebar js-sidebar">
            <div class="sidebar-content js-simplebar">
                <a class="sidebar-brand" href="index.html">
                    <span class="align-middle">Suivi Dépenses</span>
                </a>

                <ul class="sidebar-nav">
                    <li class="sidebar-header">
                        Tableaux de bord
                    </li>
                    <li class="sidebar-item active">
                        <a class="sidebar-link" href="#">
                            <i class="align-middle" data-feather="pie-chart"></i> 
                            <span class="align-middle">Dashboard</span>
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
                    <h1 class="h3 mb-3"><strong>Suivi</strong> des Dépenses</h1>

                    <!-- Section Dépenses par Composant -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Dépenses par Composant</h5>
                                </div>
                                <div class="card-body">
                                    <div class="form-filter">
                                        <form id="composantForm" class="row g-3">
                                            <div class="col-md-2">
                                                <label class="form-label">De :</label>
                                                <input type="date" class="form-control" id="startDateComposant" name="startDate" value="2023-01-01" required>
                                            </div>
                                            <div class="col-md-2">
                                                <label class="form-label">À :</label>
                                                <input type="date" class="form-control" id="endDateComposant" name="endDate" value="2025-12-31" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">Catégorie :</label>
                                                <select class="form-select" id="categorieId" name="categorieId">
                                                    <option value="">Toutes les catégories</option>
                                                    <c:forEach items="${categories}" var="categorie">
                                                        <option value="${categorie.id}">${categorie.nom}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">Composant :</label>
                                                <select class="form-select" id="composantId" name="composantId">
                                                    <option value="">Tous les composants</option>
                                                    <c:forEach items="${composants}" var="composant">
                                                        <option value="${composant.id}">${composant.nom}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-2 align-self-end">
                                                <button type="submit" class="btn btn-primary">Afficher</button>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    <!-- Graphique Dépenses par Composant -->
                                    <div class="chart-container">
                                        <canvas id="depensesComposantChart"></canvas>
                                    </div>
                                    
                                    <div class="table-responsive">
                                        <table class="table table-hover my-0" id="tableDepensesComposant">
                                            <thead>
                                                <tr>
                                                    <th>Composant</th>
                                                    <th>Catégorie</th>
                                                    <th class="text-end">Quantité</th>
                                                    <th class="text-end">Montant Total</th>
                                                    <th class="text-end">Prix Moyen</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Données chargées via AJAX -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Section Évolution des Dépenses -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Évolution des Dépenses Mensuelles</h5>
                                </div>
                                <div class="card-body">
                                    <div class="form-filter">
                                        <form id="evolutionForm" class="row g-3">
                                            <div class="col-md-3">
                                                <label class="form-label">De :</label>
                                                <input type="date" class="form-control" id="startDateEvolution" name="startDate" value="2023-01-01" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">À :</label>
                                                <input type="date" class="form-control" id="endDateEvolution" name="endDate" value="2025-12-31" required>
                                            </div>
                                            <div class="col-md-2 align-self-end">
                                                <button type="submit" class="btn btn-primary">Afficher</button>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    <!-- Graphique Évolution -->
                                    <div class="chart-container">
                                        <canvas id="evolutionDepensesChart"></canvas>
                                    </div>
                                    
                                    <div class="table-responsive">
                                        <table class="table table-hover my-0" id="tableEvolutionDepenses">
                                            <thead>
                                                <tr>
                                                    <th>Mois</th>
                                                    <th>Année</th>
                                                    <th class="text-end">Dépenses</th>
                                                    <th class="text-end">Mois précédent</th>
                                                    <th class="text-end">Évolution</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Données chargées via AJAX -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Section Comparaison Consommation -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Comparaison Consommation (Théorique vs Réelle)</h5>
                                </div>
                                <div class="card-body">
                                    <div class="form-filter">
                                        <form id="comparaisonForm" class="row g-3">
                                            <div class="col-md-3">
                                                <label class="form-label">De :</label>
                                                <input type="date" class="form-control" id="startDateComparaison" name="startDate" value="2023-01-01" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">À :</label>
                                                <input type="date" class="form-control" id="endDateComparaison" name="endDate" value="2025-12-31" required>
                                            </div>
                                            <div class="col-md-2 align-self-end">
                                                <button type="submit" class="btn btn-primary">Afficher</button>
                                            </div>
                                        </form>
                                    </div>
                                    <!-- Graphique Comparaison Consommation -->
                                    <div class="chart-container">
                                        <canvas id="comparaisonConsommationChart"></canvas>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-hover my-0" id="tableComparaisonConsommation">
                                            <thead>
                                                <tr>
                                                    <th>Composant</th>
                                                    <th>Unité</th>
                                                    <th class="text-end">Quantité Théorique</th>
                                                    <th class="text-end">Quantité Réelle</th>
                                                    <th class="text-end">Différence</th>
                                                    <th class="text-end">% Écart</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Données chargées via AJAX -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <footer class="footer">
                <div class="container-fluid">
                    <div class="row text-muted">
                        <div class="col-6 text-start">
                            <p class="mb-0">
                                <strong>Suivi Dépenses</strong> &copy;
                            </p>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    // Variables pour stocker les instances de graphiques et DataTables
    let depensesComposantChart, evolutionDepensesChart, comparaisonConsommationChart;
    let tableDepensesComposant, tableEvolutionDepenses, tableComparaisonConsommation;
    
    $(document).ready(function() {
        // Initialisation des DataTables avec configuration commune
        function initDataTable(tableId, options = {}) {
            return $(tableId).DataTable({
                dom: '<"top"Bf>rt<"bottom"lip><"clear">',
                buttons: [
                    'copy', 'csv', 'excel', 'pdf', 'print'
                ],
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/fr-FR.json'
                },
                responsive: true,
                order: [],
                ...options
            });
        }

        function formatDate(dateStr) {
            if (!dateStr) return '';
            const date = new Date(dateStr);
            return date.toLocaleDateString('fr-FR');
        }

        function getEvolutionClass(evolution) {
            if (evolution === null || evolution === undefined) return '';
            return evolution > 0 ? 'positive' : (evolution < 0 ? 'negative' : '');
        }

        function getCostClass(montant, moyenne) {
            if (montant === null || montant === undefined) return '';
            return montant > moyenne * 1.5 ? 'high-cost' : (montant > moyenne ? 'medium-cost' : '');
        }

        // Initialisation des DataTables
        tableDepensesComposant = initDataTable('#tableDepensesComposant', {
            columns: [
                { data: 'composant' },
                { data: 'categorie' },
                { 
                    data: 'quantite_totale',
                    className: 'text-end',
                    render: function(data) {
                        return data != null ? parseFloat(data).toFixed(2) : '0.00';
                    }
                },
                { 
                    data: 'montant_total',
                    className: 'text-end',
                    render: function(data) {
                        return data != null ? parseFloat(data).toFixed(2) + ' €' : '0.00 €';
                    }
                },
                { 
                    data: 'prix_moyen_unitaire',
                    className: 'text-end',
                    render: function(data) {
                        return data != null ? parseFloat(data).toFixed(2) + ' €' : '0.00 €';
                    }
                }
            ]
        });

        tableEvolutionDepenses = initDataTable('#tableEvolutionDepenses', {
            columns: [
                { data: 'mois' },
                { data: 'annee' },
                { 
                    data: 'depenses_mensuelles',
                    className: 'text-end',
                    render: function(data) {
                        return data != null ? parseFloat(data).toFixed(2) + ' €' : '0.00 €';
                    }
                },
                { 
                    data: 'depenses_mois_precedent',
                    className: 'text-end',
                    render: function(data) {
                        return data != null ? parseFloat(data).toFixed(2) + ' €' : 'N/A';
                    }
                },
                { 
                    data: 'evolution_pct',
                    className: 'text-end',
                    render: function(data, type, row) {
                        const evolutionClass = getEvolutionClass(data);
                        const evolutionText = data !== null ? 
                            (data > 0 ? '+' : '') + parseFloat(data).toFixed(2) + '%' : 'N/A';
                        return '<span class="' + evolutionClass + '">' + evolutionText + '</span>';
                    }
                }
            ],
            order: [[1, 'desc'], [0, 'desc']] // Tri par année puis mois
        });

        // Ajout DataTable pour la comparaison consommation
        function initComparaisonTable() {
            tableComparaisonConsommation = $('#tableComparaisonConsommation').DataTable({
                dom: '<"top"Bf>rt<"bottom"lip><"clear">',
                buttons: [
                    'copy', 'csv', 'excel', 'pdf', 'print'
                ],
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/fr-FR.json'
                },
                responsive: true,
                order: [],
                columns: [
                    { data: 'composant' },
                    { data: 'unite', defaultContent: '' },
                    { 
                        data: 'quantite_theorique',
                        className: 'text-end',
                        render: function(data) {
                            return data != null ? parseFloat(data).toFixed(2) : '0.00';
                        }
                    },
                    { 
                        data: 'quantite_reelle',
                        className: 'text-end',
                        render: function(data) {
                            return data != null ? parseFloat(data).toFixed(2) : '0.00';
                        }
                    },
                    { 
                        data: 'difference',
                        className: 'text-end',
                        render: function(data) {
                            return data != null ? parseFloat(data).toFixed(2) : '0.00';
                        }
                    },
                    { 
                        data: 'pourcentage_ecart',
                        className: 'text-end',
                        render: function(data) {
                            return data != null ? parseFloat(data).toFixed(2) + ' %' : 'N/A';
                        }
                    }
                ]
            });
        }

        function updateDepensesComposantChart(labels, data) {
            const ctx = document.getElementById('depensesComposantChart').getContext('2d');
            
            if (depensesComposantChart) {
                depensesComposantChart.destroy();
            }
            
            depensesComposantChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Dépenses par Composant (€)',
                        data: data,
                        backgroundColor: 'rgba(54, 162, 235, 0.5)',
                        borderColor: 'rgba(54, 162, 235, 1)',
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
                                text: 'Montant (€)'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Composants'
                            }
                        }
                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    return context.dataset.label + ': ' + context.raw.toFixed(2) + ' €';
                                }
                            }
                        }
                    }
                }
            });
        }

        function updateEvolutionDepensesChart(labels, data) {
            const ctx = document.getElementById('evolutionDepensesChart').getContext('2d');
            
            if (evolutionDepensesChart) {
                evolutionDepensesChart.destroy();
            }
            
            evolutionDepensesChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Dépenses Mensuelles (€)',
                        data: data.map(item => item.depenses),
                        borderColor: 'rgba(75, 192, 192, 1)',
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderWidth: 2,
                        tension: 0.1,
                        fill: true
                    }, {
                        label: 'Mois Précédent (€)',
                        data: data.map(item => item.precedent || null),
                        borderColor: 'rgba(255, 159, 64, 1)',
                        backgroundColor: 'rgba(255, 159, 64, 0.2)',
                        borderWidth: 2,
                        borderDash: [5, 5],
                        tension: 0.1
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
                                text: 'Montant (€)'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Période'
                            }
                        }
                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    return context.dataset.label + ': ' + (context.raw ? context.raw.toFixed(2) + ' €' : 'N/A');
                                }
                            }
                        }
                    }
                }
            });
        }

        function updateComparaisonConsommationChart(labels, theorique, reelle) {
            const ctx = document.getElementById('comparaisonConsommationChart').getContext('2d');
            if (comparaisonConsommationChart) {
                comparaisonConsommationChart.destroy();
            }
            comparaisonConsommationChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: 'Quantité Théorique',
                            data: theorique,
                            backgroundColor: 'rgba(54, 162, 235, 0.5)'
                        },
                        {
                            label: 'Quantité Réelle',
                            data: reelle,
                            backgroundColor: 'rgba(255, 99, 132, 0.5)'
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: { display: true, text: 'Quantité' }
                        },
                        x: {
                            title: { display: true, text: 'Composants' }
                        }
                    }
                }
            });
        }

        function loadDepensesComposant(startDate, endDate, categorieId, composantId) {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/suiviDepenses/depenses-par-composant',
                method: 'GET',
                data: { 
                    startDate: startDate, 
                    endDate: endDate,
                    categorieId: categorieId || '',
                    composantId: composantId || ''
                },
                success: function(data) {
                    if (!data || data.length === 0) {
                        tableDepensesComposant.clear().draw();
                        tableDepensesComposant.row.add(['Aucune donnée trouvée', '', '', '', '']).draw();
                        updateDepensesComposantChart([], []);
                    } else {
                        // Trier par montant décroissant
                        data.sort((a, b) => (b.montant_total || 0) - (a.montant_total || 0));
                        
                        // Préparer les données pour le graphique (top 10)
                        const topData = data.slice(0, 10);
                        const labels = topData.map(item => item.composant || 'Inconnu');
                        const chartData = topData.map(item => item.montant_total || 0);
                        
                        updateDepensesComposantChart(labels, chartData);
                        tableDepensesComposant.clear().rows.add(data).draw();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Erreur AJAX:', status, error);
                    tableDepensesComposant.clear().draw();
                    tableDepensesComposant.row.add(['Erreur lors du chargement des données', '', '', '', '']).draw();
                }
            });
        }

        function loadEvolutionDepenses(startDate, endDate) {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/suiviDepenses/evolution-depenses-mensuelles',
                method: 'GET',
                data: { 
                    startDate: startDate, 
                    endDate: endDate
                },
                success: function(data) {
                    if (!data || data.length === 0) {
                        tableEvolutionDepenses.clear().draw();
                        tableEvolutionDepenses.row.add(['Aucune donnée trouvée', '', '', '', '']).draw();
                        updateEvolutionDepensesChart([], []);
                    } else {
                        // Trier par année puis mois
                        data.sort((a, b) => {
                            if (a.annee !== b.annee) return b.annee - a.annee;
                            return b.mois - a.mois;
                        });
                        
                        // Préparer les labels et données pour le graphique
                        const labels = data.map(item => `${item.mois}/${item.annee}`).reverse();
                        const chartData = data.map(item => ({
                            depenses: item.depenses_mensuelles || 0,
                            precedent: item.depenses_mois_precedent || null
                        })).reverse();
                        
                        updateEvolutionDepensesChart(labels, chartData);
                        tableEvolutionDepenses.clear().rows.add(data).draw();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Erreur AJAX:', status, error);
                    tableEvolutionDepenses.clear().draw();
                    tableEvolutionDepenses.row.add(['Erreur lors du chargement des données', '', '', '', '']).draw();
                }
            });
        }

        function loadComparaisonConsommation(startDate, endDate) {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/suiviDepenses/comparaison-consommation',
                method: 'GET',
                data: { startDate: startDate, endDate: endDate },
                success: function(data) {
                    if (!data || data.length === 0) {
                        tableComparaisonConsommation.clear().draw();
                        tableComparaisonConsommation.row.add(['Aucune donnée trouvée', '', '', '', '', '']).draw();
                        updateComparaisonConsommationChart([], [], []);
                    } else {
                        // Trier par plus grand écart absolu
                        data.sort((a, b) => Math.abs((b.pourcentage_ecart || 0)) - Math.abs((a.pourcentage_ecart || 0)));
                        // Top 10 pour le graphe
                        const topData = data.slice(0, 10);
                        const labels = topData.map(item => item.composant || 'Inconnu');
                        const theorique = topData.map(item => item.quantite_theorique || 0);
                        const reelle = topData.map(item => item.quantite_reelle || 0);
                        updateComparaisonConsommationChart(labels, theorique, reelle);
                        tableComparaisonConsommation.clear().rows.add(data).draw();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Erreur AJAX:', status, error);
                    tableComparaisonConsommation.clear().draw();
                    tableComparaisonConsommation.row.add(['Erreur lors du chargement des données', '', '', '', '', '']).draw();
                }
            });
        }

        // Chargement initial
        initComparaisonTable(); // <-- AJOUTE CETTE LIGNE AVANT loadComparaisonConsommation
        loadDepensesComposant($('#startDateComposant').val(), $('#endDateComposant').val(), $('#categorieId').val(), $('#composantId').val());
        loadEvolutionDepenses($('#startDateEvolution').val(), $('#endDateEvolution').val());
        loadComparaisonConsommation($('#startDateComparaison').val(), $('#endDateComparaison').val());

        // Gestion des formulaires
        $('#composantForm').submit(function(e) {
            e.preventDefault();
            loadDepensesComposant($('#startDateComposant').val(), $('#endDateComposant').val(), $('#categorieId').val(), $('#composantId').val());
        });

        $('#evolutionForm').submit(function(e) {
            e.preventDefault();
            loadEvolutionDepenses($('#startDateEvolution').val(), $('#endDateEvolution').val());
        });

        $('#comparaisonForm').submit(function(e) {
            e.preventDefault();
            loadComparaisonConsommation($('#startDateComparaison').val(), $('#endDateComparaison').val());
        });
    });
    </script>
</body>
</html>