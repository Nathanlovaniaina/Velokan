<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Modifier Commande - Cantine</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commande.css">
  <style>
    .container { 
      max-width: 800px; 
      margin: 0 auto; 
      padding: 24px; 
    }
    .page-title { 
      font-size: 32px; 
      font-weight: 700; 
      color: #007e5d; 
      margin-bottom: 24px; 
    }
    .form-group { 
      margin-bottom: 24px; 
    }
    .form-label { 
      display: block; 
      font-size: 14px; 
      font-weight: 600; 
      color: #007e5d; 
      margin-bottom: 8px; 
      text-transform: uppercase; 
      letter-spacing: 0.5px; 
    }
    .form-input, .form-select { 
      width: 100%; 
      padding: 14px 18px; 
      border: 2px solid #e2e8f0; 
      border-radius: 10px; 
      font-size: 14px; 
      transition: all 0.2s ease; 
      background: #f8fffe; 
    }
    .form-input:focus, .form-select:focus { 
      outline: none; 
      border-color: #007e5d; 
      box-shadow: 0 0 0 3px rgba(0, 126, 93, 0.1); 
    }
    .detail-item { 
      display: flex; 
      justify-content: space-between; 
      margin-bottom: 16px; 
      padding: 16px; 
      background: linear-gradient(135deg, #f8fffe 0%, #f0f9f6 100%); 
      border-radius: 12px; 
      border: 1px solid #e6f7f2; 
      transition: all 0.2s ease; 
    }
    .detail-item:hover { 
      transform: translateX(4px); 
      border-color: #007e5d; 
    }
    .detail-item div { 
      flex: 1; 
      margin-right: 10px; 
    }
    .detail-item div:last-child { 
      margin-right: 0; 
    }
    .form-actions { 
      margin-top: 24px; 
      display: flex; 
      gap: 12px; 
    }
    .btn { 
      padding: 14px 28px; 
      border-radius: 10px; 
      font-size: 14px; 
      font-weight: 600; 
      cursor: pointer; 
      transition: all 0.2s ease; 
      border: none; 
      text-decoration: none; 
      display: inline-flex; 
      align-items: center; 
      justify-content: center; 
      text-transform: uppercase; 
      letter-spacing: 0.5px; 
    }
    .btn-primary { 
      background: linear-gradient(135deg, #007e5d 0%, #005d44 100%); 
      color: white; 
    }
    .btn-primary:hover { 
      transform: translateY(-2px); 
      box-shadow: 0 6px 20px rgba(0, 126, 93, 0.3); 
    }
    .btn-secondary { 
      background: #f8c828; 
      color: #2d3748; 
      border: 2px solid #f8c828; 
    }
    .btn-secondary:hover { 
      background: #e6b422; 
      transform: translateY(-2px); 
      box-shadow: 0 6px 20px rgba(248, 200, 40, 0.3); 
    }
    .error-message { 
      color: #dc2626; 
      font-size: 14px; 
      margin-bottom: 16px; 
      padding: 12px; 
      background: #fee2e2; 
      border-radius: 10px; 
      border-left: 4px solid #dc2626; 
    }
    @media (max-width: 768px) {
      .detail-item { 
        flex-direction: column; 
        gap: 16px; 
      }
      .detail-item div { 
        margin-right: 0; 
      }
      .form-actions { 
        flex-direction: column; 
      }
      .btn { 
        width: 100%; 
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <h1 class="page-title">Modifier Commande #00${commande.id}</h1>

    <c:if test="${not empty error}">
      <div class="error-message">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/commande/update" method="post" onsubmit="return validateForm()">
      <input type="hidden" name="id" value="${commande.id}">
      <input type="hidden" name="dateDebut" value="${dateDebut}">
      <input type="hidden" name="dateFin" value="${dateFin}">

      <div class="form-group">
        <label class="form-label">Entreprise</label>
        <select name="idEntreprise" class="form-select" required>
          <option value="">Sélectionner une entreprise</option>
          <c:forEach var="entreprise" items="${entreprises}">
            <option value="${entreprise.id}" ${entreprise.id == commande.entreprise.id ? 'selected' : ''}>
              ${entreprise.nom}
            </option>
          </c:forEach>
        </select>
      </div>

      <div class="form-group">
        <label class="form-label">Date et Heure Prévue</label>
        <input type="datetime-local" name="dateHeurePrevue" class="form-input" 
               value="<fmt:formatDate value='${commande.dateHeurePrevue}' pattern='yyyy-MM-dd\'T\'HH:mm'/>" required>
      </div>

      <div class="form-group">
        <label class="form-label">Détails de la Commande</label>
        <c:forEach var="detail" items="${commande.details}" varStatus="status">
          <div class="detail-item">
            <input type="hidden" name="details[${status.index}].id" value="${detail.id}">
            <div>
              <label class="form-label">Plat</label>
              <select name="details[${status.index}].idPlat" class="form-select" required>
                <option value="">Sélectionner un plat</option>
                <c:forEach var="plat" items="${plats}">
                  <option value="${plat.id}" ${detail.plat != null && plat.id == detail.plat.id ? 'selected' : ''}>
                    ${plat.intitule} (Prix: ${plat.prix}€, Créé: <fmt:formatDate value="${plat.dateCreation}" pattern="dd/MM/yyyy"/>)
                  </option>
                </c:forEach>
              </select>
            </div>
            <div>
              <label class="form-label">Quantité</label>
              <input type="number" name="details[${status.index}].quantite" class="form-input" 
                     value="${detail.quantite}" min="1" required>
            </div>
            <div>
              <label class="form-label">Prix Unitaire</label>
              <input type="number" name="details[${status.index}].prixUnitaire" class="form-input" 
                     value="${detail.prixUnitaire}" min="0" step="1" required>
            </div>
          </div>
        </c:forEach>
      </div>

      <div class="form-actions">
        <button type="submit" class="btn btn-primary">Enregistrer</button>
        <a href="${pageContext.request.contextPath}/commande/?dateDebut=${dateDebut}&dateFin=${dateFin}" 
           class="btn btn-secondary">Annuler</a>
      </div>
    </form>
  </div>
  <script>
    function validateForm() {
      const entreprise = document.querySelector('select[name="idEntreprise"]');
      const dateHeure = document.querySelector('input[name="dateHeurePrevue"]');
      const platSelects = document.querySelectorAll('select[name^="details["][name$="].idPlat"]');
      if (!entreprise.value) {
        alert('Veuillez sélectionner une entreprise.');
        return false;
      }
      if (!dateHeure.value) {
        alert('Veuillez spécifier une date et heure prévue.');
        return false;
      }
      for (let select of platSelects) {
        if (!select.value) {
          alert('Veuillez sélectionner un plat pour tous les détails.');
          return false;
        }
      }
      return true;
    }
  </script>
</body>
</html>