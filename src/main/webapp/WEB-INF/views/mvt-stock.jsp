<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des mouvements de stock</title>
</head>
<body>
<h2>Gestion des mouvements de stock</h2>

<c:if test="${not empty succes}">
    <p style="color: green">${succes}</p>
</c:if>
<c:if test="${not empty erreur}">
    <p style="color: red">${erreur}</p>
</c:if>

<form action="/mvt-stock/save" method="post">
    <input type="hidden" name="id" value="${mvtStock.id}"/>
    <label>Composant :</label>
    <select name="composantId" required>
        <option value="">Sélectionner un composant</option>
        <c:forEach var="composant" items="${composants}">
            <option value="${composant.id}" ${mvtStock.composant.id == composant.id ? 'selected' : ''}>${composant.nom}</option>
        </c:forEach>
    </select><br>
    <label>Type de mouvement (0=Entrée, 1=Sortie) :</label>
    <input type="number" name="typeMvt" value="${mvtStock.typeMvt}" required><br>
    <label>Quantité :</label>
    <input type="number" step="0.01" name="quantite" value="${mvtStock.quantite}" required><br>
    <label>Date du mouvement :</label>
    <input type="date" name="dateMvt" value="${mvtStock.dateMvt}" required><br>
    <label>Date de péremption :</label>
    <input type="date" name="datePeremption" value="${mvtStock.datePeremption}"><br>
    <button type="submit">Enregistrer</button>
</form>

<h3>Liste des mouvements de stock</h3>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Composant</th>
        <th>Type</th>
        <th>Quantité</th>
        <th>Date mouvement</th>
        <th>Date péremption</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="mvtStock" items="${mvtStocks}">
        <tr>
            <td>${mvtStock.id}</td>
            <td>${mvtStock.composant.nom}</td>
            <td>${mvtStock.typeMvt}</td>
            <td>${mvtStock.quantite}</td>
            <td>${mvtStock.dateMvt}</td>
            <td>${mvtStock.datePeremption}</td>
            <td>
                <a href="/mvt-stock/edit?id=${mvtStock.id}">Modifier</a>
                <a href="/mvt-stock/delete?id=${mvtStock.id}">Supprimer</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>