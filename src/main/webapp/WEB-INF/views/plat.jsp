<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des plats</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .composition-row { margin-bottom: 10px; }
        .error { color: red; }
        .success { color: green; }
        table { width: 100%; }
        th, td { padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
    <script>
        function addCompositionRow() {
            const container = document.getElementById('compositions-container');
            const row = document.createElement('div');
            row.className = 'composition-row row g-2 align-items-center';
            row.innerHTML = `
                <div class="col-md-5">
                    <select name="composantIds" class="form-select" required>
                        <option value="">Sélectionner un composant</option>
                        <c:forEach var="composant" items="${composants}">
                            <option value="${composant.id}">${composant.nom} (${composant.unite.symbol})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <input type="number" step="0.01" name="quantites" class="form-control" placeholder="Quantité" required min="0.01">
                </div>
                <div class="col-md-3">
                    <button type="button" class="btn btn-danger" onclick="removeCompositionRow(this)">Supprimer</button>
                </div>
            `;
            container.appendChild(row);
        }

        function removeCompositionRow(button) {
            button.parentElement.parentElement.remove();
        }

        function validateForm() {
            const rows = document.getElementsByClassName('composition-row');
            if (rows.length === 0) {
                alert('Veuillez ajouter au moins un composant.');
                return false;
            }
            for (let row of rows) {
                const select = row.querySelector('select[name="composantIds"]');
                const input = row.querySelector('input[name="quantites"]');
                if (!select.value || !input.value || input.value <= 0) {
                    alert('Veuillez sélectionner un composant et entrer une quantité valide.');
                    return false;
                }
            }
            return true;
        }
    </script>
</head>
<body>
<div class="container mt-4">
    <h2>Gestion des plats</h2>

    <c:if test="${not empty succes}">
        <p class="success">${succes}</p>
    </c:if>
    <c:if test="${not empty erreur}">
        <p class="error">${erreur}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/plat/save" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="id" value="${plat.id}"/>
        <div class="mb-3">
            <label class="form-label">Intitulé :</label>
            <input type="text" name="intitule" value="${plat.intitule}" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Prix :</label>
            <input type="number" name="prix" value="${plat.prix}" class="form-control" required min="0">
        </div>

        <h3>Compositions</h3>
        <div id="compositions-container">
            <c:forEach var="composition" items="${plat.compositions}">
                <div class="composition-row row g-2 align-items-center">
                    <div class="col-md-5">
                        <select name="composantIds" class="form-select" required>
                            <option value="">Sélectionner un composant</option>
                            <c:forEach var="composant" items="${composants}">
                                <option value="${composant.id}" ${composition.composant.id == composant.id ? 'selected' : ''}>${composant.nom} (${composant.unite.symbol})</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <input type="number" step="0.01" name="quantites" value="${composition.quantite}" class="form-control" required min="0.01">
                    </div>
                    <div class="col-md-3">
                        <button type="button" class="btn btn-danger" onclick="removeCompositionRow(this)">Supprimer</button>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="mb-3">
            <button type="button" class="btn btn-primary" onclick="addCompositionRow()">Ajouter un composant</button>
        </div>
        <button type="submit" class="btn btn-success">Enregistrer</button>
    </form>

    <h3 class="mt-4">Filtrer par date de création</h3>
    <form action="${pageContext.request.contextPath}/plat/since-date" method="get" class="mb-4">
        <div class="mb-3">
            <label class="form-label">Date :</label>
            <input type="date" name="date" value="${selectedDate}" class="form-control">
        </div>
        <button type="submit" class="btn btn-primary">Filtrer</button>
    </form>

    <h3>Liste des plats (Total: ${totalPlats})</h3>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Intitulé</th>
                <th>Prix</th>
                <th>Date de création</th>
                <th>Compositions</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="plat" items="${plats}">
                <tr>
                    <td>${plat.id}</td>
                    <td>${plat.intitule}</td>
                    <td>${plat.prix}</td>
                    <td>${plat.dateCreation}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty plat.compositions}">
                                <c:forEach var="composition" items="${plat.compositions}">
                                    ${composition.composant.nom}: ${composition.quantite} ${composition.composant.unite.symbol}<br>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                Aucun composant
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/plat/edit?id=${plat.id}" class="btn btn-sm btn-warning">Modifier</a>
                        <a href="${pageContext.request.contextPath}/plat/delete?id=${plat.id}" class="btn btn-sm btn-danger">Supprimer</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>