
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="th" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Rent Car Details</title>
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
            padding: 20px;
        }

        .container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .car-details {
            flex-basis: 50%;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .rental-info {
            flex-basis: 45%;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        h1 {
            color: #333;
            margin-top: 0;
        }

        table {
            margin-top: 20px;
            width: 100%;
            border-collapse: collapse;
        }

        td {
            padding: 10px;
            text-align: left;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        input[type="text"],
        input[type="date"] {
            width: 50%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-top: 5px;
        }

        .error-message {
            color: red;
        }

        input[type="submit"] {
            margin-top: 20px;
            padding: 8px 16px;
            background-color: #337ab7;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 14px;
            border-radius: 4px;
        }

        input[type="submit"]:hover {
            background-color: #286090;
        }
    </style>
</head>
<body>
<%--<div class="header">
    <span style="float: right">
    	<a style="background-color: black" href="?lang=en">en</a>  <a style="background-color: black" href="?lang=pt">pt</a> </a>
	</span>
</div>--%>
<div class="container">
    <!-- Car Details section omitted for brevity -->
    <div class="car-details">
        <h1><spring:message code="label.details"/></h1>
        <p><spring:message code="label.registration"/>: ${rentedCar.registrationNumber}</p>
        <p><spring:message code="label.make"/>: ${rentedCar.make}</p>
        <p><spring:message code="label.model"/>: ${rentedCar.model}</p>
        <p><spring:message code="label.year"/>: ${rentedCar.year}</p>
        <p><spring:message code="label.color"/>: ${rentedCar.color}</p>
        <p><spring:message code="label.rental_price"/>: ${rentedCar.rentalPrice}</p>
    </div>
    <div class="rental-info">
        <h2><spring:message code="label.dates"/></h2>

        <form action="processRental?${_csrf.parameterName}=${_csrf.token}" method="post" th:object="${rental}">

            <input type="hidden" name="rentedCar" value="${rentedCar.id}">
            <input type="hidden" name="userId" value="${userId}">

            <label for="startDate"><spring:message code="label.start_date"/>:</label>
            <input type="date" id="startDate" name="startDate" required>

            <label for="endDate"><spring:message code="label.return_date"/>:</label>
            <input type="date" id="endDate" name="endDate" required>
            <div id="errorMessage" class="error-message" style="display: none;"></div>
            <c:if test="${not empty startDateError}">
                <div class="error-message">${startDateError}</div>
            </c:if>
            <h2><spring:message code="label.card"/></h2>
            <table>
                <tr>
                    <td><label for="cardNumber"><spring:message code="label.card_number"/>:</label></td>
                    <td><input type="text" id="cardNumber" name="cardNumber" required></td>
                    <td>
                        <c:if test="${not empty cardNumberError}">
                            <div class="error-message">${cardNumberError}</div>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td><label for="expirationDate"><spring:message code="label.expiration_date"/></label></td>
                    <td><input type="text" id="expirationDate" name="expirationDate" required></td>
                    <td>
                        <c:if test="${not empty expirationDateError}">
                            <div class="error-message">${expirationDateError}</div>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td><label for="cvv"><spring:message code="label.cvv"/></label></td>
                    <td><input type="text" id="cvv" name="cvv" required></td>
                    <td>
                        <c:if test="${not empty cvvError}">
                            <div class="error-message">${cvvError}</div>
                        </c:if>
                    </td>
                    <td><div id="errorMessage1" class="error-message" style="display: none;"></div></td>
                </tr>
            </table>

            <input type="submit" value="<spring:message code="label.submit"/>">
        </form>
    </div>
</div>

<script>
    // Get the form element
    const form = document.querySelector('form');

    // Add a submit event listener to the form
    form.addEventListener('submit', function (event) {
        event.preventDefault(); // Prevent the form from submitting

        // Get the selected start and end dates from the form
        const startDate = new Date(document.getElementById('startDate').value);
        const endDate = new Date(document.getElementById('endDate').value);
        var today = new Date(Date.now());

        const expirationDate = document.getElementById('expirationDate').value;
        const currentMonth = today.getMonth() + 1;
        const currentYear = today.getFullYear() % 100;

        const expirationMonth = parseInt(expirationDate.substring(0, 2), 10);
        const expirationYear = parseInt(expirationDate.substring(3), 10);
        var valid;
        if (expirationYear > currentYear || (expirationYear === currentYear && expirationMonth >= currentMonth)) {
            valid = true;
        } else {
            valid = false;
        }
        if (endDate > startDate && endDate >= today && startDate >= today && valid ) {
            // Get the additional information from the form
            const cardNumber = document.getElementById('cardNumber').value;

            const cvv = document.getElementById('cvv').value;

            // Convert the dates to strings
            const startDateString = startDate.toISOString().slice(0, 10);
            const endDateString = endDate.toISOString().slice(0, 10);

            // Do something with the converted date strings and additional information
            console.log('Start Date:', startDateString);
            console.log('End Date:', endDateString);
            console.log('Card Number:', cardNumber);
            console.log('Card Expiration Date:', expirationDate);
            console.log('CVV:', cvv);
            console.log("aqui0!");
            // Submit the form or perform other actions
            form.submit();
        } else {
            if (endDate <= startDate){
                const errorMessage = document.getElementById('errorMessage');
                errorMessage.textContent = "<spring:message code="label.erro"/>";
                errorMessage.style.display = 'block';
                console.log("aqui1!");
                console.log(today);
                console.log(startDate);
            }
            else if(!valid){
                const errorMessage1 = document.getElementById('errorMessage1');
                errorMessage1.textContent = "<spring:message code="label.erro3"/>";
                errorMessage1.style.display = 'block';
            }
            else{
                const errorMessage = document.getElementById('errorMessage');
                errorMessage.textContent = "<spring:message code="label.erro2"/>";
                errorMessage.style.display = 'block';
                console.log("aqui2!");
            }
        }

    });
</script>
</body>
</html>

