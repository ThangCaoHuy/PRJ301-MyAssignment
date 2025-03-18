<%-- 
    Document   : application_management.jsp
    Created on : 12 thg 3, 2025, 16:56:18
    Author     : NITRO 5
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Application Management</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 20px;
                padding: 20px;
            }
            h2 {
                text-align: center;
                color: #333;
            }
            .container {
                max-width: 900px;
                margin: 0 auto;
                background: #fff;
                padding: 20px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }
            .create-button {
                display: inline-block;
                background: #28a745;
                color: #fff;
                padding: 10px 15px;
                text-decoration: none;
                border-radius: 5px;
                margin-bottom: 15px;
                font-weight: bold;
            }
            .create-button:hover {
                background: #218838;
            }
            select {
                padding: 8px;
                border-radius: 5px;
                border: 1px solid #ccc;
                margin-bottom: 15px;
                width: 100%;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                margin-top: 10px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background: #007bff;
                color: white;
            }
            tr:nth-child(even) {
                background: #f9f9f9;
            }
            .action-buttons a, .action-buttons button {
                padding: 6px 10px;
                text-decoration: none;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 14px;
            }
            .view-btn {
                background: #17a2b8;
                color: white;
            }
            .view-btn:hover {
                background: #138496;
            }
            .delete-btn {
                background: #dc3545;
                color: white;
                margin-left: 5px;
            }
            .delete-btn:hover {
                background: #c82333;
            }
        </style>
        <script>
            function confirmDelete(requestId) {
                if (confirm("Are you sure you want to delete this request?")) {
                    document.getElementById('deleteForm-' + requestId).submit();
                }
            }
        </script>
    </head>
    <body>
        <h2>Application Management</h2>
        <a href="create" class="create-button">+ Create Application</a> 
        <form id="search" action="management" method="GET">
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
                <td>Title</td>
                <td>From</td>
                <td>To</td>
                <td>Created By</td>
                <td>Action</td>
            </tr>
            <c:forEach items="${requestScope.leaves}" var="l">
                <tr>
                    <td>${l.title}</td>
                    <td>${l.from}</td>
                    <td>${l.to}</td>
                    <td>${l.createdby.displayname}</td>
                    <td>
                        <a href="browse?id=${l.id}">View</a> | 
                        <form id="deleteForm-${l.id}" action="management" method="POST" style="display:inline;">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="requestId" value="${l.id}"/>
                            <button type="button" onclick="confirmDelete(${l.id})">Delete</button>
                        </form>
                    </td>
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
