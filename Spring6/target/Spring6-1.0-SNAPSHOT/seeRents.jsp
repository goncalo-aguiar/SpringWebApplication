
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
  <title>List of Clients</title>
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
    /* CSS styles for list of clients page */
    body {
      font-family: Arial, sans-serif;
      background-color: #f2f2f2;
      margin: 0;
    }

    h1 {
      color: #333;
      text-align: center;
      padding: 20px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background-color: #fff;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    th, td {
      padding: 10px;
      text-align: left;
      border-bottom: 1px solid #ccc;
      line-height: 30px; /* Increase the line-height to increase row height */
    }

    thead th {
      background-color: #f8f8f8;
      font-weight: bold;
    }

    tbody tr:nth-child(even) {
      background-color: #f2f2f2;
    }

    .role-list {
      max-height: 200px;
      overflow-y: auto;
    }

    .assign-btn {
      padding: 2px 8px;
      background-color: #337ab7;
      color: #fff;
      border: none;
      cursor: pointer;
      text-decoration: none;

    }

    .assign-btn:hover {
      background-color: #286090;
    }
  </style>
  <script>
    function updateAssignRoleURL(clientId) {
      var selectElement = document.getElementById("role-" + clientId);
      var selectedRole = selectElement.options[selectElement.selectedIndex].value;
      var assignRoleURL = "/assignRole/" + clientId + "/" + selectedRole;
      document.getElementById("assignRoleLink-" + clientId).href = assignRoleURL;
    }
  </script>
</head>

<body>
<div class="header">
    <span style="float: right">
    	<a style="background-color: black" href="?lang=en">en</a>  <a style="background-color: black" href="?lang=pt">pt</a> </a>
	</span>
</div>
<h1><spring:message code="label.frase1234"/></h1>



  <table>
    <thead>
    <tr>
      <th><spring:message code="label.id_cliente"/></th>
      <th><spring:message code="label.login_cliente"/></th>
      <th><spring:message code="label.telefone"/></th>
      <th>Email</th>
      <th><spring:message code="label.registration"/></th>
      <th><spring:message code="label.model"/></th>
      <th><spring:message code="label.make"/></th>
      <th><spring:message code="label.start_date"/></th>
      <th><spring:message code="label.return_date"/></th>
      <th><spring:message code="label.action"/></th>

    </tr>
    </thead>
    <tbody>
    <c:forEach var="rental" items="${requestScope.rentals}">
      <tr>
        <td>${rental.id}</td>
        <td>${rental.client.login}</td>
        <td>${rental.client.telephone}</td>
        <td>${rental.client.email}</td>
        <td>${rental.car.registrationNumber}</td>
        <td>${rental.car.model}</td>
        <td>${rental.car.make}</td>
        <td>${rental.rentalDate}</td>
        <td>${rental.returnDate}</td>
        <td> <form:form method="post" action="cancelRent1" >
          <input type="hidden" name="rental" value="${rental.id}" />
          <input type="submit" value="<spring:message code="label.cancelar"/>" class="action-button" />
        </form:form></td>

      </tr>
    </c:forEach>
    </tbody>
  </table>

</body>

</html>








