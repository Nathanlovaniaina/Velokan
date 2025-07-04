<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Gestion des Postes</title>
</head>
<body>
    <h2>Formulaire plats</h2>
    <form action="${pageContext.request.contextPath}/plats/save" method="post">
        <input type="hidden" name="id" value="${plat.id}" />
        <label for="intitule">Nom du plat:</label>
        <input type="text" id="intitule" name="intitule" required>
        <br>
        <!-- Champ caché pour le prix -->
        <input type="hidden" name="prix" value="3000" />

        <!-- Champ caché pour la date du jour -->
        <input type="hidden" name="dateCreation" value="<%= java.time.LocalDate.now() %>" />

        <br><br>
        <input type="submit" value="Enregistrer le plat" />
    </form>
    
    <h2>Liste des plats</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                    <th>Prénom</th>
                    <th>Poste</th>
                    <th>Poste</th>
                    <th>Poste</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="e" items="${plats_montree}">
                <tr>
                    <td>${e.id}</td>
                    <td>${e.intitule}</td>
                    <td>${e.prix}</td>
                    <td>${e.dateCreation}</td>
                    <td>
                    <a href="edit/?id=${e.id}"><button>Modifier</button></a>
                    <a href="${pageContext.request.contextPath}/plats/delete/${e.id}" onclick="return confirm('Confirmer la suppression ?')">
                        <button>Supprimer</button>
                    </a>

                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <a href="${pageContext.request.contextPath}/plats/creer_plat">
            vers creation de plat
        </a>
</body>
</html>
