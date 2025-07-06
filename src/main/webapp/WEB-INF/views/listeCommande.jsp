<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Gestion des Commandes - Cantine</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commande.css">
</head>
<body>
  <div class="container">
    <div class="header">
      <h1 class="page-title">Listes des Commandes</h1>
      <div class="date-info">${currentDate}</div>
    </div>

    <div class="stats-summary">
      <div class="stat-card">
        <span class="stat-number">${commandes.size()}</span>
        <span class="stat-label">Total commandes</span>
      </div>
      <div class="stat-card">
        <span class="stat-number">${totalPortions}</span>
        <span class="stat-label">Portions totales</span>
      </div>
    </div>

    <div class="filters-section">
      <form action="${pageContext.request.contextPath}/commande/" method="get" class="filters-grid">
        <div class="filter-group">
          <label class="filter-label">Date debut</label>
          <input type="date" name="dateDebut" class="filter-input" value="${dateDebut}">
        </div>
        
        <div class="filter-group">
          <label class="filter-label">Date fin</label>
          <input type="date" name="dateFin" class="filter-input" value="${dateFin}">
        </div>
        
        <div class="filter-actions">
          <button type="submit" class="btn btn-primary">Filtrer</button>
          <button type="button" class="btn btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/commande/'">Reinitialiser</button>
        </div>
      </form>
    </div>
    
    <div class="orders-list">
      <c:forEach var="commande" items="${commandes}">
        <div class="order-card">
          <div class="card-content">
            <div class="card-header">
              <div class="order-main-info">
                <div class="order-id">Commande #00${commande.id}</div>
              </div>
              <div class="status-badge">${commande.entreprise.nom}</div>
            </div>
            <div class="order-details">
              <c:set var="platsVus" value="" />
              <c:set var="quantiteTotale" value="0" />
              <c:set var="prixTotalCommande" value="0" />
              <c:forEach var="detail" items="${commande.details}">
                <c:if test="${!fn:contains(platsVus, detail.plat.id)}">
                  <c:set var="quantiteParPlat" value="0" />
                  <c:forEach var="detail2" items="${commande.details}">
                    <c:if test="${detail2.plat.id == detail.plat.id}">
                      <c:set var="quantiteParPlat" value="${quantiteParPlat + detail2.quantite}" />
                      <c:set var="prixTotalCommande" value="${prixTotalCommande + (detail2.quantite * detail2.prixUnitaire)}" />
                    </c:if>
                  </c:forEach>
                  <c:set var="quantiteTotale" value="${quantiteTotale + quantiteParPlat}" />
                  <div class="detail-item">
                    <div class="detail-label">Image</div>
                    <div class="detail-value"><img src="${pageContext.request.contextPath}/images/${detail.plat.image}" alt="${detail.plat.intitule}" style="max-width: 100px; max-height: 100px;"></div>
                  </div>
                  <div class="detail-item">
                    <div class="detail-label">Plat</div>
                    <div class="detail-value plat-name">${detail.plat.intitule} (Prix: ${detail.plat.prix}€, Créé: <fmt:formatDate value="${detail.plat.dateCreation}" pattern="dd/MM/yyyy"/>)</div>
                  </div>
                  <div class="detail-item">
                    <div class="detail-label">Quantite</div>
                    <div class="detail-value quantity-highlight">${quantiteParPlat} Plats</div>
                  </div>
                  <div class="detail-item">
                    <div class="detail-label">Prix Unitaire</div>
                    <div class="detail-value">${detail.prixUnitaire}</div>
                  </div>
                  <c:set var="platsVus" value="${platsVus},${detail.plat.id}" />
                </c:if>
              </c:forEach>
              <div class="detail-item">
                <div class="detail-label">Date & Heure Prevue</div>
                <div class="detail-value datetime-value"><fmt:formatDate value="${commande.dateHeurePrevue}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
              </div>
              <div class="prix-total">
                <a href="delete?id=${commande.id}&dateDebut=${dateDebut}&dateFin=${dateFin}" onclick="return confirm('Confirmer la suppression ?')" class="btn btn-danger">Supprimer</a>
                <a href="edit/?id=${commande.id}" class="btn btn-danger">Modifier</a>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
      <c:if test="${empty commandes}">
        <div class="empty-state">
          <div class="empty-icon"></div>
          <div class="empty-title">Aucune commande trouvee</div>
        </div>
      </c:if>
    </div>
  </div>
</body>
</html>