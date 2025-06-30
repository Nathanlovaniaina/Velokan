<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des commandes</title>
</head>
<body>
<h2>Gestion des commandes</h2>

<c:if test="${not empty succes}">
    <p style="color: green">${succes}</p>
</c:if>
<c:if test="${not empty erreur}">
    <p style="color: red">${erreur}</p>
</c:if>

<form action="${pageContext.request.contextPath}/commande/save" method="post">
    <input type="hidden" name="id" value="${commande.id}"/>
    <label>Entreprise :</label>
    <select name="entrepriseId" required>
        <option value="">Sélectionner une entreprise</option>
        <c:forEach var="entreprise" items="${entreprises}">
            <option value="${entreprise.id}" ${commande.entreprise.id == entreprise.id ? 'selected' : ''}>${entreprise.nom}</option>
        </c:forEach>
    </select><br>
    <label>Prix total :</label>
    <input type="number" name="prixTotal" value="${commande.prixTotal}" required><br>
    <label>Date/Heure prévue :</label>
    <input type="datetime-local" name="dateHeurePrevue" value="${commande.dateHeurePrevue}" required><br>
    <button type="submit">Enregistrer</button>
</form>

<h3>Liste des commandes</h3>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Entreprise</th>
        <th>Prix total</th>
        <th>Date/Heure prévue</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="commande" items="${commandes}">
        <tr>
            <td>${commande.id}</td>
            <td>${commande.entreprise.nom}</td>
            <td>${commande.prixTotal}</td>
            <td>${commande.dateHeurePrevue}</td>
            <td>
                <a href="${pageContext.request.contextPath}/commande/edit?id=${commande.id}">Modifier</a>
                <a href="${pageContext.request.contextPath}/commande/delete?id=${commande.id}">Supprimer</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>