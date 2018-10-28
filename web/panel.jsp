<%
    if (session.getAttribute("logged_in") == null) {
        response.sendRedirect("index.jsp");
    }
%>


<%
    // Stop caching of pages
    // HTTP 1.1
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    // HTTP 1.0
    response.setHeader("Pragma", "no-cache");
    // Proxy server if used, so it expires, proxies
    
    response.setHeader("Expires", "0");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panels</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500" rel="stylesheet">
        <style>
            <%@ include file="WEB-INF/css/style.css"%>
        </style>
    </head>
    <body>

        <div class="content">
            <div class="form-title">
                <h1>Welcome ${logged_in.getUsername()}</h1>
                <p>Pick option:</p>
            </div>


            <div class="form-body">
                <a class="form-btn" href="./users">Users</a>
                <a class="form-btn" href="./products">Products</a>
                <a class="form-btn" href="./shops">Shop</a>
                <a class="form-btn" href="./carts">Cart</a>
                <a class="form-btn" href="./transactions">Check previous transactions</a>
                <a class="form-btn" href="./logout">Logout</a>
            </div>

        </div>

    </body>
</html>
