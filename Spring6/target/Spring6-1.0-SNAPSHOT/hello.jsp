<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
    <title>Rent a car!</title>
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
            flex-direction: column;
            margin-top: -100px;
        }

        h3 {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 40px;
        }

        .button {
            display: inline-block;
            padding: 20px 40px;
            font-size: 24px;
            background-color: #337ab7;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 0 10px;
            text-decoration: none;
        }

        .button:hover {
            background-color: #286090;
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
    <h3><spring:message code="label.frase1"/></h3>
    <div class="button-container">
        <a href="/login" class="button"><spring:message code="label.login"/></a>
        <a href="/registerPage" class="button"><spring:message code="label.register"/></a>
    </div>
</div>
</body>
</html>



