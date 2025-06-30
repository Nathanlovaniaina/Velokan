<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des stocks</title>
</head>
<body>
<h2>Gestion des stocks</h2>

<c:if test="${not empty succes}">
    <p style="color: green">${succes}</p>
</c:if>
<c:if test="${not empty erreur}">
    <p style="color: red">${erreur}</p>
</c:if>

<form action="${pageContext.request.contextPath}/stock/save" method="post">
    <input type="hidden" name="id" value="${stock.id}"/>
    <label>Composant :</label>
    <select name="composantId" required>
        <option value="">Sélectionner un composant</option>
        <c:forEach var="composant" items="${composants}">
            <option value="${composant.id}" ${stock.composant.id == composant.id ? 'selected' : ''}>${composant.nom}</option>
        </c:forEach>
    </select><br>
    <label>Date de création :</label>
    <input type="date" name="dateCreation" value="${stock.dateCreation}" required><br>
    <label>Quantité en stock :</label>
    <input type="number" step="0.01" name="qtteStock" value="${stock.qtteStock}" required><br>
    <label>Jours de conservation :</label>
    <input type="number" name="nombreJourConservation" value="${stock.nombreJourConservation}" required><br>
    <button type="submit">Enregistrer</button>
</form>

<h3>Liste des stocks</h3>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Composant</th>
        <th>Date de création</th>
        <th>Quantité</th>
        <th>Jours de conservation</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="stock" items="${stocks}">
        <tr>
            <td>${stock.id}</td>
            <td>${stock.composant.nom}</td>
            <td>${stock.dateCreation}</td>
            <td>${stock.qtteStock}</td>
            <td>${stock.nombreJourConservation}</td>
            <td>
                <a href="${pageContext.request.contextPath}/stock/edit?id=${stock.id}">Modifier</a>
                <a href="${pageContext.request.contextPath}/stock/delete?id=${stock.id}">Supprimer</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>