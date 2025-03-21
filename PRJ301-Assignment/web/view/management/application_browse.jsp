<%-- 
    Document   : application_browse
    Created on : 13 thg 3, 2025, 00:00:28
    Author     : NITRO 5
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Leave Request</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 20px;
                padding: 20px;
            }
            .container {
                max-width: 600px;
                margin: 0 auto;
                background: #fff;
                padding: 20px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                text-align: center;
            }
            .title {
                font-size: 22px;
                font-weight: bold;
                color: #333;
                margin-bottom: 15px;
            }
            .detail {
                text-align: left;
                margin-bottom: 20px;
            }
            .detail p {
                font-size: 16px;
                margin: 5px 0;
            }
            .buttons {
                display: flex;
                justify-content: center;
                gap: 10px;
            }
            .btn {
                padding: 10px 15px;
                border: none;
                cursor: pointer;
                font-size: 16px;
                border-radius: 5px;
                color: #fff;
                text-decoration: none;
            }
            .approve-btn {
                background: #28a745;
            }
            .approve-btn:hover {
                background: #218838;
            }
            .reject-btn {
                background: #dc3545;
            }
            .reject-btn:hover {
                background: #c82333;
            }
        </style>
    </head>
    <body>
        <h2>Application Browse</h2>
        <div class="container">
            <div class="title">Leave Request Details</div>
            <div class="detail">
                <p><strong>Title:</strong> ${leaveRequest.title}</p>
                <p><strong>From:</strong> ${leaveRequest.from}</p>
                <p><strong>To:</strong> ${leaveRequest.to}</p>
                <p><strong>Reason:</strong> ${leaveRequest.reason}</p>
                <p><strong>Created By:</strong> ${leaveRequest.createdby.displayname}</p>
                <p><strong>Status:</strong> 
                    <c:choose>
                        <c:when test="${leaveRequest.status eq 0}">In Progress</c:when>
                        <c:when test="${leaveRequest.status eq 1}">Rejected</c:when>
                        <c:when test="${leaveRequest.status eq 2}">Approved</c:when>
                    </c:choose>
                </p>
            </div>
            <c:if test="${leaveRequest.status eq 0}">
                <form action="browse" method="POST">
                    <input type="hidden" name="requestId" value="${leaveRequest.id}">
                    <div class="buttons">
                        <button type="submit" name="action" value="approve">Approve</button>
                        <button type="submit" name="action" value="reject">Reject</button>
                    </div>
                </form>
            </c:if>
        </div>

    </body>
</html>
