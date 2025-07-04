<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ingrédients les plus utilisés</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f7f7f7; margin: 0; padding: 0; }
        .container { max-width: 900px; margin: 40px auto; background: #fff; border-radius: 12px; box-shadow: 0 2px 12px #ccc; padding: 32px 32px 24px 32px; }
        h2 { text-align: center; color: #1976d2; margin-bottom: 24px; letter-spacing: 1px; }
        h3 { color: #333; margin-top: 32px; margin-bottom: 12px; border-bottom: 1px solid #e0e0e0; padding-bottom: 4px; }
        form { display: flex; flex-wrap: wrap; gap: 16px; align-items: center; justify-content: center; margin-bottom: 24px; background: #f0f8ff; border-radius: 8px; padding: 16px 0; }
        form label { margin-right: 4px; font-weight: 500; }
        form input, form select { border: 1px solid #bdbdbd; border-radius: 4px; padding: 6px 10px; font-size: 1em; }
        form button { background: #1976d2; color: #fff; border: none; padding: 8px 18px; border-radius: 4px; cursor: pointer; font-weight: 500; transition: background 0.2s; }
        form button:hover { background: #125ea2; }
        .table-container { overflow-x: auto; }
        table { border-collapse: separate; border-spacing: 0; width: 100%; margin-top: 8px; background: #fafbfc; border-radius: 8px; overflow: hidden; box-shadow: 0 1px 4px #e0e0e0; }
        th, td { padding: 12px 14px; text-align: left; }
        th { background-color: #e3f2fd; color: #1976d2; font-weight: 600; border-bottom: 2px solid #bbdefb; }
        tr { transition: background 0.2s; }
        tr:hover { background: #f1f8ff; }
        .top1 { background: #fffde7 !important; font-weight: bold; color: #fbc02d; }
        .top2 { background: #e3f2fd !important; font-weight: bold; color: #1976d2; }
        .top3 { background: #e8f5e9 !important; font-weight: bold; color: #388e3c; }
        .empty-msg { text-align: center; color: #888; margin: 24px 0; font-size: 1.1em; }
        .total { text-align: right; color: #1976d2; font-weight: 500; margin-top: 8px; }
        .chart-section { margin-top: 32px; }
        @media (max-width: 600px) {
            .container { padding: 10px; }
            form { flex-direction: column; gap: 8px; }
            th, td { padding: 8px 6px; }
        }
    </style>
</head>
<body>
<div class="container">
<h2>Ingrédients les plus utilisés</h2>

<c:if test="${not empty succes}">
    <p style="color: green">${succes}</p>
</c:if>
<c:if test="${not empty erreur}">
    <p style="color: red">${erreur}</p>
</c:if>

<form action="${pageContext.request.contextPath}/composant/most-used" method="get">
    <label>Date début :</label>
    <input type="date" name="dateDebut" value="${not empty selectedDateDebut and fn:length(selectedDateDebut) >= 10 ? selectedDateDebut.substring(0,10) : ''}">
    <label>Date fin :</label>
    <input type="date" name="dateFin" value="${not empty selectedDateFin and fn:length(selectedDateFin) >= 10 ? selectedDateFin.substring(0,10) : ''}">
    <label>Type de composant :</label>
    <select name="typeId">
        <option value="">Tous les types</option>
        <c:forEach var="type" items="${types}">
            <option value="${type.id}" ${selectedTypeId == type.id ? 'selected' : ''}>${type.nom}</option>
        </c:forEach>
    </select>
    <button type="submit">Filtrer</button>
</form>

<h3>Classement des ingrédients</h3>
<div class="table-container">
<table>
    <tr>
        <th>Rang</th>
        <th>Nom</th>
        <th>Quantité utilisée</th>
    </tr>
    <c:choose>
        <c:when test="${not empty composantUsages}">
            <c:set var="total" value="0" />
            <c:forEach var="usage" items="${composantUsages}" varStatus="status">
                <c:set var="total" value="${total + usage.totalUtilise}" />
                <tr class="${status.index == 0 ? 'top1' : status.index == 1 ? 'top2' : status.index == 2 ? 'top3' : ''}">
                    <td>${status.index + 1}
                        <c:if test="${status.index == 0}">🥇</c:if>
                        <c:if test="${status.index == 1}">🥈</c:if>
                        <c:if test="${status.index == 2}">🥉</c:if>
                    </td>
                    <td>${usage.nom}</td>
                    <td>${usage.totalUtilise}</td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr><td colspan="3" class="empty-msg">Aucun ingrédient utilisé sur la période sélectionnée.</td></tr>
        </c:otherwise>
    </c:choose>
</table>
</div>
<c:if test="${not empty composantUsages}">
    <div class="total">Total ingrédients utilisés :
        <c:out value="${total}" />
    </div>
</c:if>

<div class="chart-section">
    <h3>Graphique</h3>
    <canvas id="usageChart"></canvas>
</div>

</div>
<script>
    const ctx = document.getElementById('usageChart').getContext('2d');
    const chart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [<c:forEach var="usage" items="${composantUsages}">'${usage.nom}',</c:forEach>],
            datasets: [{
                label: 'Quantité utilisée',
                data: [<c:forEach var="usage" items="${composantUsages}">${usage.totalUtilise},</c:forEach>],
                backgroundColor: [
                    <c:forEach var="usage" items="${composantUsages}" varStatus="status">
                        '${status.index == 0 ? "#ffe082" : status.index == 1 ? "#90caf9" : status.index == 2 ? "#a5d6a7" : "#bdbdbd"}',
                    </c:forEach>
                ],
                borderColor: '#1976d2',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false },
                title: { display: false }
            },
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
</script>
</body>
</html>