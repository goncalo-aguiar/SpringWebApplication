<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<html>
<head>
    <title>Home Page</title>

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
        /* CSS styles for rent-a-car app */
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0; /* Add margin reset to body */
        }

        h3 {
            color: #333;
        }

        table.data {
            width: 100%;
            border-collapse: collapse;
        }

        table.data th,
        table.data td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }

        table.data th {
            background-color: #f8f8f8;
            font-weight: bold;
        }

        table.data tr.data-row:nth-child(even) {
            background-color: #f2f2f2;
        }

        .action-button {
            padding: 6px 12px;
            background-color: #337ab7;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        .action-button:hover {
            background-color: #286090;
        }

        /* Additional styles for centering and enlarging welcome message and username */
        .welcome-container {
            text-align: center;
            margin-top: -15px; /* Adjust the margin-top value as needed */
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .welcome-message {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .username {
            font-size: 20px;
            color: #666;
            margin-top: -15px;
        }

        .logout-button {
            padding: 6px 12px;
            background-color: #d9534f;
            color: #fff;
            border: none;
            cursor: pointer;
            text-decoration: none; /* Remove underline */
            display: inline-block; /* Adjust display to inline-block */
            margin-top: 5px; /* Add margin-top for spacing */
        }

        .logout-button:hover {
            background-color: #c9302c;
        }
    </style>
</head>

<body>
<div class="header">
    <span style="float: right">
    	<a style="background-color: black" href="?lang=en">en</a>  <a style="background-color: black" href="?lang=pt">pt</a> </a>
	</span>
</div>
<script>
    function formSubmit() {
        document.getElementById("logoutForm").submit();
    }

    function rentSubmit() {
        document.getElementById("rentingForm").submit();
    }

    function addCreditCard() {
        window.location.href = "/addCreditCard?userId=${pageContext.request.userPrincipal.name}";
    }
</script>

<!-- CSRF for log out -->
<form action="/logout" method="post" id="logoutForm">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>

<br/>
<!-- Centered welcome message and username -->
<div class="welcome-container">
    <div class="welcome-message"><spring:message code="label.welcome"/></div>
    <div class="username">${pageContext.request.userPrincipal.name}</div>
    <button class="logout-button" onclick="formSubmit()"><spring:message code="label.logout"/></button>
    <sec:authorize access="hasAuthority('ADMIN')">
        <a href="/seeClients"><spring:message code="label.roles"/></a>
    </sec:authorize>
    <sec:authorize access="hasAnyAuthority('ADMIN','MANAGER')">
        <a href="/addCar"><spring:message code="label.addCar"/></a>
    </sec:authorize>
    <sec:authorize access="hasAnyAuthority('ADMIN','MANAGER')">
        <a href="/seeRents"><spring:message code="label.seeRents"/></a>
    </sec:authorize>
    <sec:authorize access="hasAnyAuthority('ADMIN','MANAGER')">
        <a href="/searchClient"><spring:message code="label.search"/></a>
    </sec:authorize>

</div>

<h2><spring:message code="label.cars1"/></h2>

<table class="data">
    <tr>
        <th><spring:message code="label.make"/></th>
        <th><spring:message code="label.model"/></th>
        <th><spring:message code="label.year"/></th>
        <th><spring:message code="label.color"/></th>
        <th><spring:message code="label.rental_price"/></th>
        <th><spring:message code="label.available"/></th>
        <th><spring:message code="label.action"/></th>
    </tr>
    <c:forEach items="${cars}" var="car">
        <tr class="data-row">
            <td>${car.make}</td>
            <td>${car.model}</td>
            <td>${car.year}</td>
            <td>${car.color}</td>
            <td>${car.rentalPrice}</td>
            <td>${car.available}</td>
            <td>
                <form:form method="post" action="rent" >
                    <input type="hidden" name="carId" value="${car.id}" />
                    <input type="hidden" name="userId" value="${pageContext.request.userPrincipal.name}" />
                    <input type="submit" value="<spring:message code="label.alugar"/>" class="action-button" />
                </form:form>
                <sec:authorize access="hasAnyAuthority('ADMIN','MANAGER')">
                    <form:form method="post" action="deleteCar" >
                        <input type="hidden" name="carId" value="${car.id}" />
                        <input type="submit" value="<spring:message code="label.delete"/>" class="button" />
                    </form:form>
                </sec:authorize>
            </td>
        </tr>
    </c:forEach>
</table>

<h2><spring:message code="label.cars2"/></h2>

<table class="data">
    <tr>
        <th><spring:message code="label.make"/></th>
        <th><spring:message code="label.model"/></th>
        <th><spring:message code="label.year"/></th>
        <th><spring:message code="label.color"/></th>
        <th><spring:message code="label.rental_price"/></th>
        <th><spring:message code="label.start_date"/></th>
        <th><spring:message code="label.return_date"/></th>
        <th><spring:message code="label.card_number"/></th>
        <th><spring:message code="label.action"/></th>
    </tr>
    <c:forEach items="${rentedCars}" var="rental">
        <tr class="data-row">
            <td>${rental.car.make}</td>
            <td>${rental.car.model}</td>
            <td>${rental.car.year}</td>
            <td>${rental.car.color}</td>
            <td>${rental.car.rentalPrice}</td>
            <td>${rental.rentalDate}</td>
            <td>${rental.returnDate}</td>
            <td>${rental.cardNumber}</td>
            <td>
            <form:form method="post" action="cancelRent" >
                <input type="hidden" name="rental" value="${rental.id}" />
                <input type="submit" value="<spring:message code="label.cancelar"/>" class="action-button" />
            </form:form>
            <form:form method="post" action="generatePdf" >
                <input type="hidden" name="rental" value="${rental.id}" />
                <input type="submit" value="<spring:message code="label.pdf"/>" class="action-button" />
            </form:form>
            </td>
        </tr>
    </c:forEach>
</table>

</body>

</html>






