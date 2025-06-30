<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des composants</title>
</head>
<body>
<h2>Gestion des composants</h2>

<c:if test="${not empty succes}">
    <p style="color: green">${succes}</p>
</c:if>
<c:if test="${not empty erreur}">
    <p style="color: red">${erreur}</p>
</c:if>

<form action="${pageContext.request.contextPath}/composant/save" method="post">
    <input type="hidden" name="id" value="${composant.id}"/>
    <label>Nom :</label>
    <input type="text" name="nom" value="${composant.nom}" required><br>
    <label>Type :</label>
    <select name="typeId" required>
        <option value="">Sélectionner un type</option>
        <c:forEach var="type" items="${types}">
            <option value="${type.id}" ${composant.typeComposant.id == type.id ? 'selected' : ''}>${type.nom}</option>
        </c:forEach>
    </select><br>
    <label>Unité :</label>
    <select name="uniteId" required>
        <option value="">Sélectionner une unité</option>
        <c:forEach var="unite" items="${unites}">
            <option value="${unite.id}" ${composant.unite.id == unite.id ? 'selected' : ''}>${unite.nom}</option>
        </c:forEach>
    </select><br>
    <button type="submit">Enregistrer</button>
</form>

<h3>Liste des composants</h3>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Nom</th>
        <th>Type</th>
        <th>Unité</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="composant" items="${composants}">
        <tr>
            <td>${composant.id}</td>
            <td>${composant.nom}</td>
            <td>${composant.typeComposant.nom}</td>
            <td>${composant.unite.nom}</td>
            <td>
                <a href="${pageContext.request.contextPath}/composant/edit?id=${composant.id}">Modifier</a>
                <a href="${pageContext.request.contextPath}/composant/delete?id=${composant.id}">Supprimer</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>