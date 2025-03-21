<%-- 
    Document   : welcome
    Created on : 10 thg 3, 2025, 23:23:17
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
                background: linear-gradient(135deg, #74ebd5, #acb6e5);
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
                margin: 0;
                padding: 20px;
                text-align: center;
            }

            .button-container {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
            }

            .button {
                background: #007bff;
                color: white;
                padding: 12px 20px;
                text-decoration: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: bold;
                transition: background 0.3s, transform 0.2s;
            }

            .button:hover {
                background: #0056b3;
                transform: scale(1.05);
            }

            h1 {
                color: #333;
                font-size: 28px;
                font-weight: bold;
                margin-bottom: 20px;
            }

            p {
                font-size: 18px;
                color: #555;
                margin-bottom: 15px;
            }

            .staff-list {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                width: 60%;
                max-width: 500px;
                text-align: left;
            }

            .staff-list h2 {
                font-size: 22px;
                color: #222;
                margin-bottom: 10px;
            }

            .staff-list ul {
                list-style: none;
                padding: 0;
            }

            .staff-list ul li {
                background: #f8f9fa;
                padding: 10px;
                margin: 5px 0;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <h1>Hello ${sessionScope.user.displayname}</h1>

        <div class="button-container">
            <a href="leaverequest/create" class="button">Create Leave Request</a>
            <a href="leaverequest/findbydept" class="button">Find by Department</a>
            <a href="leaverequest/management" class="button">Application List Managerment</a>
        </div>

        You need to report to ${sessionScope.user.e.manager.name}
        Your Direct Staffs: <br/>
        <c:forEach items="${sessionScope.user.e.directstaffs}" var="s" >
            ${s.name} <br/>
        </c:forEach>

        Your All Staffs: <br/>
        <c:forEach items="${sessionScope.user.e.staffs}" var="s" >
            ${s.name} <br/>
        </c:forEach>    
    </body>
</html>
