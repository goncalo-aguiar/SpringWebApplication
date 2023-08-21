<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
<h1><spring:message code="label.clients_lista"/></h1>


<form action="" method="post" id="assignRoleForm">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <table>
        <thead>
        <tr>
            <th><spring:message code="label.id_cliente"/></th>
            <th><spring:message code="label.first_name"/></th>
            <th><spring:message code="label.last_name"/></th>
            <th>Email</th>
            <th><spring:message code="label.telefone"/></th>
            <th><spring:message code="label.role"/></th>
            <th><spring:message code="label.action"/></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="client" items="${requestScope.clients}">
            <tr>
                <td>${client.id}</td>
                <td>${client.firstName}</td>
                <td>${client.lastName}</td>
                <td>${client.email}</td>
                <td>${client.telephone}</td>
                <td>${client.appUserRole}</td>
                <td>
                    <div class="role-list">
                        <select name="role" id="role-${client.id}" onchange="updateAssignRoleURL(${client.id})">
                            <c:forEach var="role" items="${requestScope.availableRoles}">
                                <option value="${role.role}">${role.role}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <a href="/assignRole/${client.id}/ADMIN" id="assignRoleLink-${client.id}" class="assign-btn">Assign</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</form>
</body>

</html>








