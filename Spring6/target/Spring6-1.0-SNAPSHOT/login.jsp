<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
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
        /* CSS styles for login page */
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

        #login-box {
            width: 300px;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h3 {
            text-align: left; /* Align "Login" text to the left */
            color: #333;
            margin-top: 0;
        }

        .error {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #a94442;
            background-color: #f2dede;
            border-color: #ebccd1;
        }

        .msg {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #31708f;
            background-color: #d9edf7;
            border-color: #bce8f1;
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
        input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"],
        .register-button {
            width: 100%;
            padding: 8px;
            background-color: #337ab7;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover,
        .register-button:hover {
            background-color: #286090;
        }

        .register-button {
            width: 96%; /* Adjust the width to make it slightly smaller */
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
    <div id="login-box">
        <h3 style="margin-bottom: 20px;">Login:</h3> <!-- Added margin-bottom to create spacing between "Login" and the form -->
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <c:if test="${not empty msg}">
            <div class="msg">${msg}</div>
        </c:if>
        <form name='loginForm' action="<c:url value='/login'/>" method='POST'>
            <table>
                <tr>
                    <td><spring:message code="label.username"/></td>
                    <td><input type='text' name='login' value=''></td>
                </tr>
                <tr>
                    <td><spring:message code="label.password"/></td>
                    <td><input type='password' name='password'></td>
                </tr>
                <tr>
                    <td colspan='2'><input name="submit" type="submit" value="<spring:message code="label.submit"/>"></td>
                </tr>
            </table>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form>
        <div style="text-align: center;">
            <button class="register-button" onclick="location.href='/registerPage'"><spring:message code="label.no_account"/></button>
        </div>
    </div>
</div>
</body>
</html>
