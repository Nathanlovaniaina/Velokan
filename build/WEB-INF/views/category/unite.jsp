<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des unités</title>
</head>
<body>
<h2>Gestion des unités</h2>

<c:if test="${not empty succes}">
    <p style="color: green">${succes}</p>
</c:if>
<c:if test="${not empty erreur}">
    <p style="color: red">${erreur}</p>
</c:if>

<form action="/unite/save" method="post">
    <input type="hidden" name="id" value="${unite.id}"/>
    <label>Nom :</label>
    <input type="text" name="nom" value="${unite.nom}" required><br>
    <label>Symbole :</label>
    <input type="text" name="symbol" value="${unite.symbol}" required><br>
    <button type="submit">Enregistrer</button>
</form>

<h3>Liste des unités</h3>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Nom</th>
        <th>Symbole</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="unite" items="${unites}">
        <tr>
            <td>${unite.id}</td>
            <td>${unite.nom}</td>
            <td>${unite.symbol}</td>
            <td>
                <a href="/unite/edit?id=${unite.id}">Modifier</a>
                <a href="/unite/delete?id=${unite.id}">Supprimer</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>