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
        <style>
            body {
                font-family: Arial, sans-serif;
                background: linear-gradient(135deg, #43cea2, #185a9d);
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            h1 {
                color: #185a9d;
                margin-bottom: 20px;
            }

            .container {
                background: white;
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                width: 400px;
                text-align: center;
            }

            input[type="text"],
            textarea,
            input[type="date"] {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            textarea {
                height: 100px;
            }

            input[type="submit"] {
                background: #43cea2;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 5px;
                width: calc(100% - 20px);
                cursor: pointer;
                transition: background 0.3s;
                display: block;
                margin: 10px auto 0;
            }

            input[type="submit"]:hover {
                background: #185a9d;
            }
        </style>
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
