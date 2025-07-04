<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Quantité des composants</title>
</head>
<body>

<h2>Quantité et unité pour chaque composant sélectionné</h2>

<c:if test="${empty composants}">
    <p style="color:red;">Aucun composant sélectionné. <a href="${pageContext.request.contextPath}/plats/creer_plat">Retour</a></p>
</c:if>

<c:if test="${not empty composants}">
    <form method="post" action="${pageContext.request.contextPath}/plats/inserer_details_plat">
        <label>Nom du plat :</label>
        <select name="nomPlat" required>
            <option value="">-- Sélectionner un plat --</option>
            <c:forEach var="p" items="${plats_montree}">
                <option value="${p.intitule}">${p.intitule}</option>
            </c:forEach>
        </select>
        <br><br>


        <!-- Transmettre les composants sélectionnés sous forme de champs hidden -->
        <c:forEach var="comp" items="${composants}">
            <input type="hidden" name="composantsSelectionnes" value="${comp.id}" />
        </c:forEach>

        <table border="1" cellpadding="8">
            <tr>
                <th>Composant</th>
                <th>Quantité</th>
                <th>Unité</th>
            </tr>

            <c:forEach var="comp" items="${composants}">
                <tr>
                    <td>${comp.nom}</td>
                    <td>
                        <input type="number" name="quantite_${comp.id}" step="0.01" min="0" required>
                    </td>
                    <td>
                        <select name="unite_${comp.id}">
                            <option value="kg">kg</option>
                            <option value="g">g</option>
                            <option value="L">L</option>
                            <option value="ml">ml</option>
                            <option value="pc">pc</option>
                        </select>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <br>
        <button type="submit">Enregistrer le plat</button>
    </form>
</c:if>

</body>
</html>
<c:if test="${not empty detailsPlats}">
    <h3>Détails du plat sélectionné :</h3>
    <table border="1" cellpadding="6">
        <tr>
            <th>Nom du plat</th>
            <th>Composant</th>
            <th>Quantité</th>
        </tr>
        <c:forEach var="dp" items="${detailsPlats}">
            <tr>
                <td>${dp.plat.intitule}</td>
                <td>${dp.composant.nom}</td>
                <td>${dp.quantite} ${dp.unite}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

