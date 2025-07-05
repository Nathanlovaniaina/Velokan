
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Gestion des Stocks en Alerte - Cantine</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commande.css">
  <style>
    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 20px;
    }
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }
    .page-title {
      font-size: 24px;
      font-weight: 700;
      color: #1f2937;
    }
    .date-info {
      font-size: 16px;
      color: #6b7280;
    }
    .stats-summary {
      display: flex;
      gap: 20px;
      margin-bottom: 20px;
    }
    .stat-card {
      background: white;
      padding: 10px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      text-align: center;
    }
    .stat-number {
      font-size: 20px;
      font-weight: 700;
      color: #007e5d;
    }
    .stat-label {
      font-size: 14px;
      color: #6b7280;
    }
    .table-container {
      margin-bottom: 40px;
    }
    .table-title {
      font-size: 18px;
      font-weight: 600;
      color: #1f2937;
      margin-bottom: 10px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      border-radius: 8px;
      overflow: hidden;
    }
    th, td {
      padding: 12px;
      text-align: left;
      border-bottom: 1px solid #e5e7eb;
    }
    th {
      background: #f3f4f6;
      font-weight: 600;
      color: #1f2937;
      text-transform: uppercase;
      font-size: 12px;
    }
    td {
      font-size: 14px;
      color: #1f2937;
    }
    .quantity-highlight {
      color: #007e5d;
      font-weight: 700;
    }
    .datetime-value {
      color: #f8c828;
      font-weight: 600;
    }
    .alert-quantity {
      color: #dc2626;
      font-weight: 700;
    }
    .empty-state {
      text-align: center;
      padding: 20px;
      font-size: 16px;
      color: #6b7280;
    }
    .empty-icon::before {
      content: '📋';
      font-size: 24px;
      display: block;
      margin-bottom: 8px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1 class="page-title">Stocks en Alerte</h1>
      <div class="date-info">${currentDate}</div>
    </div>

    <div class="stats-summary">
      <div class="stat-card">
        <span class="stat-number">${stocksConservation.size()}</span>
        <span class="stat-label">Stocks en alerte (Conservation)</span>
      </div>
      <div class="stat-card">
        <span class="stat-number">${totalQuantiteConservation}</span>
        <span class="stat-label">Quantite totale (Conservation)</span>
      </div>
      <div class="stat-card">
        <span class="stat-number">${stocksQuantite.size()}</span>
        <span class="stat-label">Stocks en alerte (Quantite)</span>
      </div>
      <div class="stat-card">
        <span class="stat-number">${totalQuantiteQuantite}</span>
        <span class="stat-label">Quantite totale (Quantite)</span>
      </div>
    </div>

    <div class="table-container">
      <div class="table-title">Alertes de Conservation</div>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Composant</th>
            <th>Quantite</th>
            <th>Date Creation</th>
            <th>Nombres de jour de conservation</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="stock" items="${stocksConservation}">
            <tr>
              <td>Stock #00${stock.id}</td>
              <td>${stock.composant.nom}</td>
              <td class="quantity-highlight">${stock.quantiteStock} ${stock.composant.unite.symbol} </td>
              <td class="datetime-value"><fmt:formatDate value="${stock.dateCreation}" pattern="yyyy-MM-dd"/></td>
              <td>${stock.nombreJourConservation} jours</td>
            </tr>
          </c:forEach>
          <c:if test="${empty stocksConservation}">
            <tr>
              <td colspan="6" class="empty-state">
                <span class="empty-icon"></span>
                Aucun stock en alerte de conservation
              </td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>

    <div class="table-container">
      <div class="table-title">Alertes de Quantite (Seuil: 10% de 100 unites)</div>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Composant</th>
            <th>Quantite</th>
            <th>Date Creation</th>
            <th>Nombre de jours de conservation</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="stock" items="${stocksQuantite}">
            <tr>
              <td>Stock #00${stock.id}</td>
              <td>${stock.composant.nom}</td>
              <td class="alert-quantity">${stock.quantiteStock} ${stock.composant.unite.symbol} </td>
              <td class="datetime-value"><fmt:formatDate value="${stock.dateCreation}" pattern="yyyy-MM-dd"/></td>
              <td>${stock.nombreJourConservation} jours</td>
            </tr>
          </c:forEach>
          <c:if test="${empty stocksQuantite}">
            <tr>
              <td colspan="6" class="empty-state">
                <span class="empty-icon"></span>
                Aucun stock en alerte de quantite
              </td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</body>
</html>
