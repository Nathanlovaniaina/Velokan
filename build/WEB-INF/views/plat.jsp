<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des plats</title>
</head>
<body>
<h2>Gestion des plats</h2>

<c:if test="${not empty succes}">
    <p style="color: green">${succes}</p>
</c:if>
<c:if test="${not empty erreur}">
    <p style="color: red">${erreur}</p>
</c:if>

<form action="${pageContext.request.contextPath}/plat/save" method="post">
    <input type="hidden" name="id" value="${plat.id}"/>
    <label>Intitulé :</label>
    <input type="text" name="intitule" value="${plat.intitule}" required><br>
    <label>Prix :</label>
    <input type="number" name="prix" value="${plat.prix}" required><br>
    <button type="submit">Enregistrer</button>
</form>

<h3>Filtrer par date de création</h3>
<form action="${pageContext.request.contextPath}/plat/since-date" method="get">
    <label>Date :</label>
    <input type="date" name="date" value="${selectedDate}"><br>
    <button type="submit">Filtrer</button>
</form>

<h3>Liste des plats (Total: ${totalPlats})</h3>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Intitulé</th>
        <th>Prix</th>
        <th>Date de création</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="plat" items="${plats}">
        <tr>
            <td>${plat.id}</td>
            <td>${plat.intitule}</td>
            <td>${plat.prix}</td>
            <td>${plat.dateCreation}</td>
            <td>
                <a href="${pageContext.request.contextPath}/plat/edit?id=${plat.id}">Modifier</a>
                <a href="${pageContext.request.contextPath}/plat/delete?id=${plat.id}">Supprimer</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>