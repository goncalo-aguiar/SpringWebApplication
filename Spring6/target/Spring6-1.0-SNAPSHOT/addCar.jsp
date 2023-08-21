<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
  <title>Add a Car Page</title>
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

    .main-block {
      width: 50%;
      margin: 20px auto;
      background-color: #fff;
      border: 1px solid #ccc;
      border-radius: 10px;
      padding: 20px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    td {
      padding: 10px;
      text-align: left;
    }

    .form-label {
      font-weight: bold;
    }

    .form-input {
      width: 100%;
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    .form-checkbox {
      margin-top: 5px;
    }

    .form-submit {
      padding: 8px 16px;
      background-color: #337ab7;
      color: #fff;
      border: none;
      cursor: pointer;
      font-size: 14px;
      border-radius: 4px;
    }

    .form-submit:hover {
      background-color: #286090;
    }

    .error {
      color: red;
    }
  </style>
</head>
<body>

<div class="header">
    <span style="float: right">
    	<a style="background-color: black" href="?lang=en">en</a>  <a style="background-color: black" href="?lang=pt">pt</a> </a>
	</span>
</div>
<div class="main-block">
  <h1><spring:message code="label.car_info"/></h1>
  <form:form method="post" action="addInfoCar" modelAttribute="Car">
    <table>
      <tr>
        <td class="form-label"><form:hidden path="id"/></td>
      </tr>
      <tr>
        <td class="form-label"><form:label path="registrationNumber"><spring:message code="label.registration"/></form:label></td>
        <td><form:input path="registrationNumber" class="form-input"/></td>
        <td><form:errors path="registrationNumber" cssClass="error"/></td>
      </tr>
      <tr>
        <td class="form-label"><form:label path="make"><spring:message code="label.make"/></form:label></td>
        <td><form:input path="make" class="form-input"/></td>
        <td><form:errors path="make" cssClass="error"/></td>
      </tr>
      <tr>
        <td class="form-label"><form:label path="model"><spring:message code="label.model"/></form:label></td>
        <td><form:input path="model" class="form-input"/></td>
        <td><form:errors path="model" cssClass="error"/></td>
      </tr>
      <tr>
        <td class="form-label"><form:label path="year"><spring:message code="label.year"/></form:label></td>
        <td><form:input path="year" class="form-input"/></td>
        <td><form:errors path="year" cssClass="error"/></td>
      </tr>
      <tr>
        <td class="form-label"><form:label path="color"><spring:message code="label.color"/></form:label></td>
        <td><form:input path="color" class="form-input"/></td>
        <td><form:errors path="color" cssClass="error"/></td>
      </tr>
      <tr>
        <td class="form-label"><form:label path="rentalPrice"><spring:message code="label.rental_price"/></form:label></td>
        <td><form:input path="rentalPrice" class="form-input"/></td>
        <td><form:errors path="rentalPrice" cssClass="error"/></td>
      </tr>
      <tr>
        <td class="form-label"><form:label path="available"><spring:message code="label.available"/></form:label></td>
        <td><form:checkbox path="available" class="form-checkbox"/></td>
        <td><form:errors path="available" cssClass="error"/></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="submit" value="<spring:message code="label.adicionar"/>" class="form-submit"/>
        </td>
      </tr>
    </table>
  </form:form>
</div>

</body>
</html>
