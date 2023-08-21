<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
  <title>Credit Card Information</title>
</head>
<body>
<h1>Credit Card Information</h1>

<h2>Add New Credit Card</h2>

<form:form method="post" action="addInfoCreditCard" modelAttribute="creditCard">
  <table>
    <tr>
      <td><form:hidden path="id"/></td>
    </tr>
    <tr>
      <td><form:label path="cardNumber">Registration Number</form:label></td>
      <td><form:input path="cardNumber"/></td>
      <td><form:errors path="cardNumber"/></td>
    </tr>
    <tr>
      <td><form:label path="expirationDate">Make</form:label></td>
      <td><form:input path="expirationDate"/></td>
      <td><form:errors path="expirationDate"/></td>
    </tr>
    <tr>
      <td><form:label path="cvv">Model</form:label></td>
      <td><form:input path="cvv" /></td>
      <td><form:errors path="cvv"/></td>
    </tr>
    <tr>
      <td><input type="hidden" name="userId" value="${pageContext.request.userPrincipal.name}" /></td>
    </tr>
  </table>

  <input type="submit" value="Add Car"/>
</form:form>

</body>
</html>

