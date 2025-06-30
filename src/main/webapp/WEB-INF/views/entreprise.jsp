<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des entreprises</title>
</head>
<body>
<h2>Gestion des entreprises</h2>

<c:if test="${not empty succes}">
    <p style="color: green">${succes}</p>
</c:if>
<c:if test="${not empty erreur}">
    <p style="color: red">${erreur}</p>
</c:if>

<form action="${pageContext.request.contextPath}/entreprise/save" method="post">
    <input type="hidden" name="id" value="${entreprise.id}"/>
    <label>Nom :</label>
    <input type="text" name="nom" value="${entreprise.nom}" required><br>
    <label>Adresse :</label>
    <input type="text" name="adresse" value="${entreprise.adresse}" required><br>
    <label>Latitude :</label>
    <input type="number" step="0.01" name="latitude" value="${entreprise.latitude}" required><br>
    <label>Longitude :</label>
    <input type="number" step="0.01" name="longitude" value="${entreprise.longitude}" required><br>
    <label>Date de début de contrat :</label>
    <input type="date" name="debutDateContrat" value="${entreprise.debutDateContrat}" required><br>
    <button type="submit">Enregistrer</button>
</form>

<h3>Liste des entreprises</h3>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Nom</th>
        <th>Adresse</th>
        <th>Latitude</th>
        <th>Longitude</th>
        <th>Date de début de contrat</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="entreprise" items="${entreprises}">
        <tr>
            <td>${entreprise.id}</td>
            <td>${entreprise.nom}</td>
            <td>${entreprise.adresse}</td>
            <td>${entreprise.latitude}</td>
            <td>${entreprise.longitude}</td>
            <td>${entreprise.debutDateContrat}</td>
            <td>
                <a href="${pageContext.request.contextPath}/entreprise/edit?id=${entreprise.id}">Modifier</a>
                <a href="${pageContext.request.contextPath}/entreprise/delete?id=${entreprise.id}">Supprimer</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>