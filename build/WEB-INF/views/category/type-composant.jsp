<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des types de composants</title>
</head>
<body>
<h2>Gestion des types de composants</h2>

<c:if test="${not empty succes}">
    <p style="color: green">${succes}</p>
</c:if>
<c:if test="${not empty erreur}">
    <p style="color: red">${erreur}</p>
</c:if>

<form action="${pageContext.request.contextPath}/type-composant/save" method="post">
    <input type="hidden" name="id" value="${typeComposant.id}"/>
    <label>Nom :</label>
    <input type="text" name="nom" value="${typeComposant.nom}" required><br>
    <button type="submit">Enregistrer</button>
</form>

<h3>Liste des types de composants</h3>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Nom</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="typeComposant" items="${typesComposants}">
        <tr>
            <td>${typeComposant.id}</td>
            <td>${typeComposant.nom}</td>
            <td>
                <a href="${pageContext.request.contextPath}/type-composant/edit?id=${typeComposant.id}">Modifier</a>
                <a href="${pageContext.request.contextPath}/type-composant/delete?id=${typeComposant.id}">Supprimer</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>