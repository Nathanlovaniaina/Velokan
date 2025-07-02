<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>Dashboard Suivi Bénéfices</title>
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.bootstrap5.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
    <style>
        .form-filter { background-color: #f8f9fa; padding: 1rem; border-radius: 0.25rem; margin-bottom: 1rem; }
        .chart-container { position: relative; height: 300px; margin-bottom: 2rem; }
        .dataTables_wrapper .dataTables_filter input { margin-left: 0.5em; }
        .dt-buttons .btn { margin-right: 5px; }
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
        <main class="content">
            <div class="container-fluid p-0">
                <h1 class="h3 mb-3"><strong>Suivi</strong> des Bénéfices</h1>

                <!-- Section Bénéfice Net -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Bénéfice Net</h5>
                            </div>
                            <div class="card-body">
                                <div class="form-filter">
                                    <form id="beneficeForm" class="row g-3">
                                        <div class="col-md-3">
                                            <label class="form-label">De :</label>
                                            <input type="date" class="form-control" id="startDateBenefice" name="startDate" value="2023-01-01" required>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">À :</label>
                                            <input type="date" class="form-control" id="endDateBenefice" name="endDate" value="2025-12-31" required>
                                        </div>
                                        <div class="col-md-2 align-self-end">
                                            <button type="submit" class="btn btn-primary">Afficher</button>
                                        </div>
                                    </form>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <div class="alert alert-success" id="revenuTotal">Revenu total : -- €</div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="alert alert-danger" id="coutTotal">Coût total : -- €</div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="alert alert-info" id="beneficeNet">Bénéfice net : -- €</div>
                                    </div>
                                </div>
                                <div class="chart-container">
                                    <canvas id="beneficeNetChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Section Revenus par Entreprise -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Revenus par Entreprise</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover my-0" id="tableRevenusEntreprise">
                                        <thead>
                                            <tr>
                                                <th>Entreprise</th>
                                                <th class="text-end">Revenu (€)</th>
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

                <!-- Section Bénéfices par Plat -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Bénéfices par Plat</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover my-0" id="tableBeneficesPlat">
                                        <thead>
                                            <tr>
                                                <th>Plat</th>
                                                <th class="text-end">Total vendus</th>
                                                <th class="text-end">Revenu total (€)</th>
                                                <th class="text-end">Coût total (€)</th>
                                                <th class="text-end">Bénéfice (€)</th>
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

                <!-- Section Salaires Versés -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Salaires Versés</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover my-0" id="tableSalairesVerses">
                                        <thead>
                                            <tr>
                                                <th>Total Salaires Versés (€)</th>
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

                <!-- Section Bilan Journalier -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Bilan Journalier</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover my-0" id="tableBilanJournalier">
                                        <thead>
                                            <tr>
                                                <th>Jour</th>
                                                <th class="text-end">Revenu (€)</th>
                                                <th class="text-end">Coût (€)</th>
                                                <th class="text-end">Bénéfice (€)</th>
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
    </div>
</div>
<script>
let beneficeNetChart, tableRevenusEntreprise, tableBeneficesPlat, tableSalairesVerses, tableBilanJournalier;

function initDataTable(tableId, options = {}) {
    return $(tableId).DataTable({
        dom: '<"top"Bf>rt<"bottom"lip><"clear">',
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
        language: { url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/fr-FR.json' },
        responsive: true,
        order: [],
        ...options
    });
}

function updateBeneficeNetChart(revenu, cout, benefice) {
    const ctx = document.getElementById('beneficeNetChart').getContext('2d');
    if (beneficeNetChart) beneficeNetChart.destroy();
    beneficeNetChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Revenu', 'Coût', 'Bénéfice Net'],
            datasets: [{
                label: 'Montant (€)',
                data: [revenu, cout, benefice],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.5)',
                    'rgba(255, 99, 132, 0.5)',
                    'rgba(75, 192, 192, 0.5)'
                ],
                borderColor: [
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 99, 132, 1)',
                    'rgba(75, 192, 192, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: { beginAtZero: true, title: { display: true, text: 'Montant (€)' } }
            }
        }
    });
}

function loadBeneficeNet(startDate, endDate) {
    $.get('${pageContext.request.contextPath}/api/suiviBenefices/benefice-net', { startDate, endDate }, function(data) {
        if (data && data.length > 0) {
            const d = data[0];
            $('#revenuTotal').text('Revenu total : ' + d.total_revenu.toFixed(2) + ' €');
            $('#coutTotal').text('Coût total : ' + d.total_cout.toFixed(2) + ' €');
            $('#beneficeNet').text('Bénéfice net : ' + d.benefice_net.toFixed(2) + ' €');
            updateBeneficeNetChart(d.total_revenu, d.total_cout, d.benefice_net);
        } else {
            $('#revenuTotal').text('Revenu total : -- €');
            $('#coutTotal').text('Coût total : -- €');
            $('#beneficeNet').text('Bénéfice net : -- €');
            updateBeneficeNetChart(0, 0, 0);
        }
    });
}

function loadRevenusEntreprise(startDate, endDate) {
    $.get('${pageContext.request.contextPath}/api/suiviBenefices/revenus-par-entreprise', { startDate, endDate }, function(data) {
        tableRevenusEntreprise.clear().rows.add(data).draw();
    });
}

function loadBeneficesPlat(startDate, endDate) {
    $.get('${pageContext.request.contextPath}/api/suiviBenefices/benefices-par-plat', { startDate, endDate }, function(data) {
        tableBeneficesPlat.clear().rows.add(data).draw();
    });
}

function loadSalairesVerses(startDate, endDate) {
    $.get('${pageContext.request.contextPath}/api/suiviBenefices/salaires-verses', { startDate, endDate }, function(data) {
        tableSalairesVerses.clear().rows.add(data).draw();
    });
}

function loadBilanJournalier(startDate, endDate) {
    $.get('${pageContext.request.contextPath}/api/suiviBenefices/bilan-journalier', { startDate, endDate }, function(data) {
        tableBilanJournalier.clear().rows.add(data).draw();
    });
}

$(document).ready(function() {
    tableRevenusEntreprise = initDataTable('#tableRevenusEntreprise', {
        columns: [
            { data: 'entreprise' },
            { data: 'revenu', className: 'text-end', render: data => data != null ? data.toFixed(2) + ' €' : '0.00 €' }
        ]
    });
    tableBeneficesPlat = initDataTable('#tableBeneficesPlat', {
        columns: [
            { data: 'plat' },
            { data: 'total_vendus', className: 'text-end' },
            { data: 'revenu_total', className: 'text-end', render: data => data != null ? data.toFixed(2) + ' €' : '0.00 €' },
            { data: 'cout_total', className: 'text-end', render: data => data != null ? data.toFixed(2) + ' €' : '0.00 €' },
            { data: 'benefice', className: 'text-end', render: data => data != null ? data.toFixed(2) + ' €' : '0.00 €' }
        ]
    });
    tableSalairesVerses = initDataTable('#tableSalairesVerses', {
        columns: [
            { data: 'total_salaire', className: 'text-end', render: data => data != null ? data.toFixed(2) + ' €' : '0.00 €' }
        ]
    });
    tableBilanJournalier = initDataTable('#tableBilanJournalier', {
        columns: [
            { data: 'jour' },
            { data: 'revenu_journalier', className: 'text-end', render: data => data != null ? data.toFixed(2) + ' €' : '0.00 €' },
            { data: 'cout_journalier', className: 'text-end', render: data => data != null ? data.toFixed(2) + ' €' : '0.00 €' },
            { data: 'benefice_journalier', className: 'text-end', render: data => data != null ? data.toFixed(2) + ' €' : '0.00 €' }
        ]
    });

    // Chargement initial
    const startDate = $('#startDateBenefice').val();
    const endDate = $('#endDateBenefice').val();
    loadBeneficeNet(startDate, endDate);
    loadRevenusEntreprise(startDate, endDate);
    loadBeneficesPlat(startDate, endDate);
    loadSalairesVerses(startDate, endDate);
    loadBilanJournalier(startDate, endDate);

    $('#beneficeForm').submit(function(e) {
        e.preventDefault();
        const startDate = $('#startDateBenefice').val();
        const endDate = $('#endDateBenefice').val();
        loadBeneficeNet(startDate, endDate);
        loadRevenusEntreprise(startDate, endDate);
        loadBeneficesPlat(startDate, endDate);
        loadSalairesVerses(startDate, endDate);
        loadBilanJournalier(startDate, endDate);
    });
});
</script>
</body>
</html>