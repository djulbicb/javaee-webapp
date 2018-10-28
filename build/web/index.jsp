<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Index</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500" rel="stylesheet">
        <style>
            <%@ include file="WEB-INF/css/style.css"%>
        </style>
    </head>
    <body>

        <div class="content">
            <div class="form-title">
                <h1>Login to web shop</h1>
                <p>Enter username and password</p>
            </div>
            <div class="form-body">
                <form action="login" method="post">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" placeholder="Username" required=""><br>
                    <label for="password">Password:</label>
                    <input type="text" id="password" name="password" placeholder="Password" required=""><br>
                    <input class="form-btn" type="submit" value="Sign in">
                </form>
                <hr>
                <p>Don't have account?</p>
                <form action="./users" method="post">
                    <input class="form-btn" type="submit" value="Register">
                </form>
            </div>



        </div>

    </body>
</html>
