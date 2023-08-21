<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <title>Register Page</title>
    <script src="https://www.google.com/recaptcha/api.js"></script>
    <style>
        .header {
            background-color: black;
            padding: 10px;
            color: #fff;
            overflow: hidden;
        }

        .header a {
            color: #fff;
            text-decoration: none;
            margin-right: 10px;
        }
        /* CSS styles for the page */
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        #register-box {
            width: 600px;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h3 {
            text-align: center;
            color: #333;
            margin-top: 0;
            margin-bottom: 20px;
        }

        form {
            margin-top: 20px;
        }

        table {
            width: 100%;
        }

        td {
            padding: 5px;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 50%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 50%;
            padding: 8px;
            background-color: #337ab7;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #286090;
        }

        .error {
            color: #a94442;
            margin-top: 5px;
            margin-right: 10px; /* Add space to the right */
        }
    </style>
</head>
<body>
<div class="header">
    <span style="float: right">
    	<a style="background-color: black" href="?lang=en">en</a>  <a style="background-color: black" href="?lang=pt">pt</a> </a>
	</span>
</div>
<div class="container">
    <div id="register-box">
        <h3><spring:message code="label.frase2"/></h3>
        <form:form method="post" action="addAppUser" modelAttribute="AppUser">
            <table>
                <tr>
                    <td><form:hidden path="id"/></td>
                </tr>
                <tr>
                    <td><form:label path="login"><spring:message code="label.username"/></form:label></td>
                    <td><form:input path="login" style="width: 50%"/></td>
                </tr>
                <c:if test="${not empty errorMessage}">
                    <p style="color: red;">${errorMessage}</p>
                </c:if>
                <tr>
                    <td></td>
                    <td colspan="2"><form:errors path="login" cssClass="error"/></td>
                </tr>
                <tr>
                    <td><form:label path="password"><spring:message code="label.password"/></form:label></td>
                    <td><form:input type="password" path="password" style="width: 50%" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td colspan="2"><form:errors path="password" cssClass="error"/></td>
                </tr>
                <tr>
                    <td><form:label path="firstName"><spring:message code="label.firstname"/></form:label></td>
                    <td><form:input path="firstName" style="width: 50%" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td colspan="2"><form:errors path="firstName" cssClass="error"/></td>
                </tr>
                <tr>
                    <td><form:label path="lastName"><spring:message code="label.lastname"/></form:label></td>
                    <td><form:input path="lastName" style="width: 50%" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td colspan="2"><form:errors path="lastName" cssClass="error"/></td>
                </tr>
                <tr>
                    <td><form:label path="email">Email:</form:label></td>
                    <td><form:input path="email"  style="width: 50%"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td colspan="2"><form:errors path="email" cssClass="error"/></td>
                </tr>
                <tr>
                    <td><form:label path="telephone"><spring:message code="label.telephone"/></form:label></td>
                    <td><form:input path="telephone" style="width: 50%" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td colspan="2"><form:errors path="telephone" cssClass="error"/></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <div class="g-recaptcha" data-sitekey="6Le8bnwlAAAAAOt9ABkjYaYipNStknIIRLqHf5Gi"></div>
                    </td>
                </tr>


                <tr>
                    <td colspan="2">
                        <input type="submit" value="<spring:message code="label.registar"/>"/>
                    </td>
                </tr>
            </table>
        </form:form>
        <!-- Add the error message display -->
        <c:if test="${not empty requestScope['javax.servlet.error.exception']}">
            <div class="error">
                    ${requestScope['javax.servlet.error.exception']}
            </div>
        </c:if>
    </div>
</div>
</body>
</html>


