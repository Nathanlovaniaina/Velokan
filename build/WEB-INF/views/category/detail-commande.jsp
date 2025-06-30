<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des détails des commandes</title>
</head>
<body>
<h2>Gestion des détails des commandes</h2>

<c:if test="${not empty succes}">
    <p style="color: green">${succes}</p>
</c:if>
<c:if test="${not empty erreur}">
    <p style="color: red">${erreur}</p>
</c:if>

<form action="${pageContext.request.contextPath}/detail-commande/save" method="post">
    <input type="hidden" name="id" value="${detailCommande.id}"/>
    <label>Commande :</label>
    <select name="commandeId" required>
        <option value="">Sélectionner une commande</option>
        <c:forEach var="commande" items="${commandes}">
            <option value="${commande.id}" ${detailCommande.commande.id == commande.id ? 'selected' : ''}>${commande.id}</option>
        </c:forEach>
    </select><br>
    <label>Plat :</label>
    <select name="platId" required>
        <option value="">Sélectionner un plat</option>
        <c:forEach var="plat" items="${plats}">
            <option value="${plat.id}" ${detailCommande.plat.id == plat.id ? 'selected' : ''}>${plat.intitule}</option>
        </c:forEach>
    </select><br>
    <label>Quantité :</label>
    <input type="number" name="quantite" value="${detailCommande.quantite}" required><br>
    <label>Prix unitaire :</label>
    <input type="number" name="prixUnitaire" value="${detailCommande.prixUnitaire}" required><br>
    <button type="submit">Enregistrer</button>
</form>

<h3>Liste des détails des commandes</h3>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Commande</th>
        <th>Plat</th>
        <th>Quantité</th>
        <th>Prix unitaire</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="detailCommande" items="${detailsCommandes}">
        <tr>
            <td>${detailCommande.id}</td>
            <td>${detailCommande.commande.id}</td>
            <td>${detailCommande.plat.intitule}</td>
            <td>${detailCommande.quantite}</td>
            <td>${detailCommande.prixUnitaire}</td>
            <td>
                <a href="${pageContext.request.contextPath}/detail-commande/edit?id=${detailCommande.id}">Modifier</a>
                <a href="${pageContext.request.contextPath}/detail-commande/delete?id=${detailCommande.id}">Supprimer</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>