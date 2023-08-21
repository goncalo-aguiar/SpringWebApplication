
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Confirmation Page</title>
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

    </style>
</head>
<body>
<div class="header">
    <span style="float: right">
    	<a style="background-color: black" href="?lang=en">en</a>  <a style="background-color: black" href="?lang=pt">pt</a> </a>
	</span>
</div>
<h3><spring:message code="label.carRented"/> </h3>
<form action="/index" method="get" id="logoutForm">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>


</body>

<script>
    function formSubmit() {
        document.getElementById("logoutForm").submit();
    }
</script>
</html>