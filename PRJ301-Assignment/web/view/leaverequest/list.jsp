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
