<%@page import="java.util.UUID"%>
<%@page import="org.hibernate.id.GUIDGenerator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<%
    UUID uuid = UUID.randomUUID();
    request.getSession().setAttribute("uuid", uuid);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500" rel="stylesheet">
        <style>
            <%@ include file="css/style.css"%>
        </style>
    </head>
    <body>

        <div class="content content-users">
            <div class="form-title">
                <h1>Shop</h1>
                <h2>Welcome ${logged_in.getUsername()}</h2>
                <p>Products in cart: ${productCount}</p>


                <c:if test="${empty logged_in}">
                    <a href="./index.jsp">Return to login</a> 
                </c:if>

                <c:if test="${!empty logged_in}">
                    <a href="./panel.jsp">Return to panel</a> 
                </c:if>
                    
                    <a href="./carts">Go to Cart</a> 
            </div>

            <div class="form-body">


                <c:forEach items="${allProducts}" var="product">   
                    <div class="product-box">
                        <table>
                            <tr>  <td><h3>${product.name}</h3></td></tr>
                            <tr>  <td>${product.manufactorId.getName()}</td></tr>
                            <tr>   <td>${product.stockQuantity}</td></tr>
                            <tr>    <td><img src="images/${product.imageUrl}" alt="ss"></td></tr>  
                            <tr><td><a href="?add=${product.id}">Add to cart</a></td></tr>
                        </table>
                    </div>
                </c:forEach>

            </div>            
        </div>
    </body>


</html>
