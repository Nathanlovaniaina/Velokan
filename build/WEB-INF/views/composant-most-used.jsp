<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ingrédients les plus utilisés</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid black; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .sort-link { text-decoration: none; color: blue; }
        canvas { max-width: 600px; margin-top: 20px; }
    </style>
</head>
<body>
<h2>Ingrédients les plus utilisés</h2>

<c:if test="${not empty succes}">
    <p style="color: green">${succes}</p>
</c:if>
<c:if test="${not empty erreur}">
    <p style="color: red">${erreur}</p>
</c:if>

<form action="${pageContext.request.contextPath}/composant/most-used" method="get">
    <label>Date début :</label>
    <input type="datetime-local" name="dateDebut" value="${selectedDateDebut}"><br>
    <label>Date fin :</label>
    <input type="datetime-local" name="dateFin" value="${selectedDateFin}"><br>
    <label>Type de composant :</label>
    <select name="typeId">
        <option value="">Tous les types</option>
        <c:forEach var="type" items="${types}">
            <option value="${type.id}" ${selectedTypeId == type.id ? 'selected' : ''}>${type.nom}</option>
        </c:forEach>
    </select><br>
    <button type="submit">Filtrer</button>
</form>

<h3>Classement des ingrédients</h3>
<table>
    <tr>
        <th>Nom</th>
        <th>Quantité utilisée</th>
    </tr>
    <c:forEach var="usage" items="${composantUsages}">
        <tr>
            <td>${usage.nom}</td>
            <td>${usage.totalUtilise}</td>
        </tr>
    </c:forEach>
</table>

<h3>Graphique</h3>
<canvas id="usageChart"></canvas>

<script>
    const ctx = document.getElementById('usageChart').getContext('2d');
    const chart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [<c:forEach var="usage" items="${composantUsages}">'${usage.nom}',</c:forEach>],
            datasets: [{
                label: 'Quantité utilisée',
                data: [<c:forEach var="usage" items="${composantUsages}">${usage.totalUtilise},</c:forEach>],
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
</script>
</body>
</html>