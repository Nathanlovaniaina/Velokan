<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Nombre de Commandes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* General container styling */
        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
            background-color: #f8f8f8;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        /* Heading styling */
        h1 {
            font-family: 'Arial', sans-serif;
            color: #007e5d; /* Green */
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.2rem;
        }

        /* Form styling */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
            display: block;
        }

        .form-control {
            border-radius: 4px;
            border: 1px solid #ccc;
            padding: 10px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #007e5d; /* Green */
            box-shadow: 0 0 5px rgba(0, 126, 93, 0.3);
        }

        /* Button styling */
        .btn-primary {
            background-color: #007e5d; /* Green */
            border: none;
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #005c43; /* Darker green */
        }

        /* Error message */
        .text-danger {
            color: #dc3545;
            font-weight: bold;
            text-align: center;
            margin-top: 15px;
        }

        /* Result display */
        .result-container {
            margin-top: 20px;
            padding: 15px;
            background-color: #f8c828; /* Yellow background */
            border-radius: 6px;
            text-align: center;
            font-size: 1.1rem;
            color: #007e5d; /* Green text */
            font-weight: bold;
        }

        /* Table styling for date range */
        .table {
            margin-top: 20px;
            width: 100%;
            border-collapse: collapse;
        }

        .table th, .table td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }

        .table th {
            background-color: #007e5d;
            color: white;
        }

        .table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .table .evolution-positive {
            color: #28a745;
            font-weight: bold;
        }

        .table .evolution-negative {
            color: #dc3545;
            font-weight: bold;
        }

        .table .evolution-neutral {
            color: #6c757d;
            font-weight: bold;
        }

        /* Chart container */
        .chart-container {
            position: relative;
            margin: 30px auto;
            padding: 15px;
            background-color: #f8c828; /* Yellow background */
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            min-height: 300px;
        }

        canvas#ordersChart {
            width: 100% !important;
            max-width: 800px;
            height: 400px !important;
            display: block;
            margin: 0 auto;
        }

        /* Back link */
        a {
            display: inline-block;
            margin-top: 20px;
            color: #007e5d; /* Green */
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        /* Responsive adjustments */
        @media (max-width: 576px) {
            .container {
                margin: 20px;
                padding: 15px;
            }

            h1 {
                font-size: 1.8rem;
            }

            .btn-primary {
                width: 100%;
            }

            .table th, .table td {
                font-size: 0.9rem;
                padding: 8px;
            }

            canvas#ordersChart {
                height: 250px !important;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Nombre de Commandes</h1>
        <form action="${pageContext.request.contextPath}/commandes/count" method="get">
            <div class="form-group">
                <label for="date">Date de début (AAAA-MM-JJ):</label>
                <input type="date" id="date" name="date" class="form-control" required pattern="\d{4}-\d{2}-\d{2}">
            </div>
            <div class="form-group">
                <label for="endDate">Date de fin (AAAA-MM-JJ, optionnel):</label>
                <input type="date" id="endDate" name="endDate" class="form-control" pattern="\d{4}-\d{2}-\d{2}">
            </div>
            <button type="submit" class="btn btn-primary">Vérifier</button>
        </form>
        <c:if test="${isSingleDay}">
            <c:if test="${not empty nombreCommandes}">
                <div class="result-container">
                    <p>Nombre de commandes pour le <strong>${date}</strong> : <strong>${nombreCommandes}</strong></p>
                </div>
                <div class="chart-container">
                    <canvas id="ordersChart"></canvas>
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
            </c:if>
        </c:if>
        <c:if test="${not isSingleDay}">
            <c:if test="${not empty orderDataList}">
                <div class="result-container">
                    <p>Résultats pour la période du <strong>${startDate}</strong> au <strong>${endDate}</strong></p>
                </div>
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
                <div class="chart-container">
                    <canvas id="ordersChart"></canvas>
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
            </c:if>
        </c:if>
        <c:if test="${not empty error}">
            <p class="text-danger">${error}</p>
        </c:if>
        <a href="${pageContext.request.contextPath}/">Retour à l'accueil</a>
    </div>
</body>
</html>