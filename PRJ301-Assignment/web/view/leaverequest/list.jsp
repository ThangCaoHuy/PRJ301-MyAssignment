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
        <script src="../js/control/pagger.js" type="text/javascript"></script>
        <link href="../css/control/pagger.css" rel="stylesheet" type="text/css"/>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: linear-gradient(135deg, #ff9a9e, #fad0c4);
                display: flex;
                flex-direction: column;
                align-items: center;
                height: 100vh;
                margin: 0;
                padding: 20px;
            }

            h1 {
                color: #333;
                margin-bottom: 20px;
                font-size: 28px;
                font-weight: bold;
            }

            .button-container {
                width: 80%;
                display: flex;
                flex-direction: column;
                align-items: flex-start;
                margin-bottom: 10px;
            }

            .create-button {
                background: #28a745;
                color: white;
                padding: 12px 25px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background 0.3s, transform 0.2s;
                text-decoration: none;
                font-size: 16px;
                font-weight: bold;
                align-self: flex-start;
                margin-bottom: 15px;
                margin-left: 10%; /* Căn chỉnh theo bảng */
            }

            .create-button:hover {
                background: #218838;
                transform: scale(1.05);
            }

            form {
                width: 80%;
                text-align: left;
                margin-bottom: 30px;
                align-self: flex-start;
                margin-left: 10%; /* Căn chỉnh theo bảng */
            }

            select {
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ccc;
                width: 180px;
                display: block;
                font-size: 16px;
                cursor: pointer;
                margin-top: 10px;
            }

            select:hover {
                border-color: #888;
            }

            table {
                width: 80%;
                border-collapse: collapse;
                background: white;
                box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
                border-radius: 10px;
                overflow: hidden;
                margin-top: 30px;
            }

            table, th, td {
                border: 1px solid #ddd;
            }

            th, td {
                padding: 14px;
                text-align: center;
                font-size: 16px;
            }

            th {
                background: #ff758c;
                color: white;
                font-weight: bold;
                text-transform: uppercase;
            }

            tr:nth-child(even) {
                background: #f8f8f8;
            }

            tr:hover {
                background: #ffccd5;
                transition: background 0.3s;
            }
        </style>
    </head>
    <body>
        <a href="create" class="create-button">+ Create Application</a> 
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
        <div id="toppagger" class="pagger"></div>
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
        <div id="botpagger" class="pagger"></div>
        <script>
            renderPagger('toppagger',${requestScope.pageindex}, 2,${requestScope.totalpage});
            renderPagger('botpagger',${requestScope.pageindex}, 2,${requestScope.totalpage});
        </script>
    </body>
</html>
