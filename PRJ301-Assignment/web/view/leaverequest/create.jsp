<%-- 
    Document   : create
    Created on : 8 thg 3, 2025, 01:01:15
    Author     : NITRO 5
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello ${sessionScope.user.displayname}</h1>
        <form action="create" method="POST">
            Title: <input type="text" name="title"/> <br/>
            Reason: <textarea name="reason"></textarea> <br/>
            From: <input type="date" name="from"/> <br/>
            To: <input type="date" name="to"/> <br/>
            <input type="submit" name="Send"/>
        </form>
    </body>
</html>
