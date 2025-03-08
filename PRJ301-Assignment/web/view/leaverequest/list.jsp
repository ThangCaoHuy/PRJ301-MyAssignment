<%-- 
    Document   : list
    Created on : 8 thg 3, 2025, 23:40:09
    Author     : NITRO 5
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>      
        <style>
            body {
                font-family: Arial, sans-serif;
                background: linear-gradient(135deg, #ff9a9e, #fad0c4);
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            h1 {
                color: #333;
                margin-bottom: 20px;
            }

            form {
                margin-bottom: 20px;
                width: 80%;
                text-align: left;
            }

            select {
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ccc;
                width: 150px;
                display: block;
            }

            table {
                width: 80%;
                border-collapse: collapse;
                background: white;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                border-radius: 10px;
                overflow: hidden;
            }

            table, th, td {
                border: 1px solid #ddd;
            }

            th, td {
                padding: 12px;
                text-align: center;
            }

            th {
                background: #ff758c;
                color: white;
            }

            tr:nth-child(even) {
                background: #f2f2f2;
            }

            tr:hover {
                background: #ffccd5;
                transition: 0.3s;
            }
        </style>
    </head>
    <body>
        <form id="search" action="findbydept" method="GET">
            <select name="did" onchange="document.getElementById('search').submit();">
                <option value="-1">---Select All---</option>
                <c:forEach items="${requestScope.depts}" var="d">
                    <option
                        <c:if test="${d.id eq param.did}">
                            selected="selected"
                        </c:if>
                        value="${d.id}">${d.name}</option>
                </c:forEach>
            </select>
        </form>
        <table border="1px">
            <tr>
                <td>Id</td>
                <td>Title</td>
                <td>Reason</td>
                <td>From</td>
                <td>To</td>
                <td>Created By</td>
                <td>Created Date</td>
                <td>Status</td>
            </tr>
            <c:forEach items="${requestScope.leaves}" var="l">
                <tr>
                    <td>${l.id}</td>
                    <td>${l.title}</td>
                    <td>${l.reason}</td>
                    <td>${l.from}</td>
                    <td>${l.to}</td>
                    <td>${l.createdby.displayname}</td>
                    <td>${l.createddate}</td>
                    <td>${l.status eq 0?"In Progress":(l.status eq 1)?"Rejected":"Accepted"}</td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
