<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des détails des plats</title>
</head>
<body>
<h2>Gestion des détails des plats</h2>

<c:if test="${not empty succes}">
    <p style="color: green">${succes}</p>
</c:if>
<c:if test="${not empty erreur}">
    <p style="color: red">${erreur}</p>
</c:if>

<form action="/details-plat/save" method="post">
    <input type="hidden" name="id" value="${detailsPlat.id}"/>
    <label>Plat :</label>
    <select name="platId" required>
        <option value="">Sélectionner un plat</option>
        <c:forEach var="plat" items="${plats}">
            <option value="${plat.id}" ${detailsPlat.plat.id == plat.id ? 'selected' : ''}>${plat.intitule}</option>
        </c:forEach>
    </select><br>
    <label>Composant :</label>
    <select name="composantId" required>
        <option value="">Sélectionner un composant</option>
        <c:forEach var="composant" items="${composants}">
            <option value="${composant.id}" ${detailsPlat.composant.id == composant.id ? 'selected' : ''}>${composant.nom}</option>
        </c:forEach>
    </select><br>
    <label>Quantité :</label>
    <input type="number" step="0.01" name="quantite" value="${detailsPlat.quantite}" required><br>
    <button type="submit">Enregistrer</button>
</form>

<h3>Liste des détails des plats</h3>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Plat</th>
        <th>Composant</th>
        <th>Quantité</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="detailsPlat" items="${detailsPlats}">
        <tr>
            <td>${detailsPlat.id}</td>
            <td>${detailsPlat.plat.intitule}</td>
            <td>${detailsPlat.composant.nom}</td>
            <td>${detailsPlat.quantite}</td>
            <td>
                <a href="/details-plat/edit?id=${detailsPlat.id}">Modifier</a>
                <a href="/details-plat/delete?id=${detailsPlat.id}">Supprimer</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>