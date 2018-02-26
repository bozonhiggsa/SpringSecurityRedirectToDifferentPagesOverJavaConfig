<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Page for various users</title>
</head>
<body>
<h4>Hello <security:authentication property="principal.username" />!</h4>
<br/>

<c:url value="${pageContext.servletContext.contextPath}/logout.html" var="loginUrl"/>
<form action="${loginUrl}" method="post">
    <input type="hidden"
           name="${_csrf.parameterName}"
           value="${_csrf.token}"/>
    <button type="submit">Log Out</button>
</form>

</body>
</html>