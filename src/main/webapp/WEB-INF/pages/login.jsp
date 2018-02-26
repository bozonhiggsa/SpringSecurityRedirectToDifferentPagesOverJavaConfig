<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
    <title>My Login page</title>
    <fmt:setBundle basename="messages" />
    <fmt:message key="message.password" var="noPass" />
    <fmt:message key="message.username" var="noUser" />
    <fmt:message key="message.usernamePassword" var="noUserPassword" />
    <link href=<c:url value="${pageContext.servletContext.contextPath}/static/style.css"/> rel="stylesheet">
    <script type="text/javascript" src="<c:url value="${pageContext.servletContext.contextPath}/static/bootstrap.min.js" />"></script>
    <script type="text/javascript">
        function validate() {
            if (document.f.username.value == "" && document.f.password.value == "") {
                alert("${noUserPassword}");
                document.f.username.focus();
                return false;
            }
            if (document.f.username.value == "") {
                alert("${noUser}");
                document.f.username.focus();
                return false;
            }
            if (document.f.password.value == "") {
                alert("${noPass}");
                document.f.password.focus();
                return false;
            }
        }
    </script>
</head>
<body>
<c:url value="${pageContext.servletContext.contextPath}/login.html" var="loginUrl"/>
<form name="f" action="${loginUrl}" method="post" onsubmit="return validate();">
    <c:if test="${param.error != null}">
        <div>
            <h4>
                <spring:message code="message.badCredentials">
                </spring:message>
            </h4>
        </div>
    </c:if>
    <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION} and ${param.error == null}">
        <div>
            <h4>
                <spring:message code="message.logoutError">
                </spring:message>
            </h4>
        </div>
    </c:if>
    <c:if test="${param.logout == true}">
        <div>
            <h4>
                <spring:message code="message.logoutSucc">
                </spring:message>
            </h4>
        </div>
    </c:if>

    <table>
        <tr>
            <td><label for="username">Username:</label></td>
            <td><input type="text" id="username" name="username"></td>
        </tr>
        <tr>
            <td><label for="password">Password:</label></td>
            <td><input type="password" id="password" name="password" /></td>
        </tr>
        <tr>
            <td><label for="remember-me">Remember Me</label></td>
            <td><input type="checkbox" id="remember-me" name="remember-me" /></td>
        </tr>
        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}"/>
        <tr>
            <td><input type="submit" value="Sign In" /></td>
        </tr>
    </table>
</form>

<a href="?lang=en">English</a> |
<a href="?lang=ru_RU">Russian</a>

</body>
</html>