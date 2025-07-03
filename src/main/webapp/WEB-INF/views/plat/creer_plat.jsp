<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    String typeComposantId = request.getParameter("typeComposantId");
%>

<html>
<head>
    <title>Créer un plat</title>
</head>
<body>
    <h1>Créer un plat</h1>
    

    <!-- Formulaire de filtre (GET) -->
    <form method="get" action="${pageContext.request.contextPath}/plats/creer_plat">
        <label>Filtrer par type :</label>
        <select name="typeComposantId" onchange="this.form.submit()">
            <option value="">-- Tous les types --</option>
            <c:forEach items="${typesComposant}" var="type">
                <option value="${type.id}" ${param.typeComposantId == type.id ? 'selected' : ''}>
                    ${type.nom}
                </option>
            </c:forEach>
        </select>

    </form>

    <form method="get" action="${pageContext.request.contextPath}/plats/choix_quantite">
        <h2>Composants disponibles</h2>

        <c:forEach items="${composants}" var="composant">
            <c:if test="${empty param.typeComposantId || fn:trim(composant.typeComposant.id) == fn:trim(param.typeComposantId)}">
                <div>
                    <label>
                        <input type="checkbox" name="composants" value="${composant.id}">
                        ${composant.nom} (Type: ${composant.typeComposant.nom})
                    </label>
                </div>
            </c:if>
        </c:forEach>

        <br>
        <input type="submit" value="Valider la sélection">
    </form>
</body>
</html>
