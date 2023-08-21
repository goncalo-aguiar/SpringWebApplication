<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search Page</title>

    <style>
        /* CSS styles from the first JSP file */
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

        h3 {
            color: #333;
        }

        /* Additional styles for the search page */
        h1 {
            color: #333;
        }

        #searchForm {
            text-align: left;
            margin-top: 50px;
        }

        #loginInput {
            padding: 6px;
            margin-right: 10px;
            font-size: 16px;
        }

        #searchForm input[type="submit"] {
            padding: 6px 12px;
            background-color: #337ab7;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        #searchForm input[type="submit"]:hover {
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
<h1><spring:message code="label.search2"/></h1>

<form id="searchForm" method="get">
    <input id="loginInput" type="text" name="login" placeholder="<spring:message code="label.search3"/>">
    <input type="submit" value="<spring:message code="label.search4"/>">
</form>

<script>
    document.getElementById("searchForm").addEventListener("submit", function(event) {
        event.preventDefault(); // Prevent the form from submitting normally
        var loginValue = document.getElementById("loginInput").value;
        var url = "/search/" + encodeURIComponent(loginValue);
        window.location.href = url;
    });
</script>
</body>
</html>

