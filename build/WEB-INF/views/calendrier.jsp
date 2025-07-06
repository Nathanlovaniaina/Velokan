<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/base.jsp">
    <jsp:param name="title" value="Calendrier - Planification des plats" />
    <jsp:param name="activePage" value="calendar" />
    <jsp:param name="content" value="/WEB-INF/views/calendrier-content.jsp" />
    <jsp:param name="additionalCss" value="/resources/css/calendar.css" />
</jsp:include> 