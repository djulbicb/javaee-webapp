<%@page import="java.util.UUID"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500" rel="stylesheet">
        <style>
            <%@ include file="css/style.css"%>
        </style>
    </head>
    <body>
        <div class="content content-users">
            <div class="form-title">
                <h1>Products</h1>
                <h2>Welcome ${logged_in.getUsername()}</h2>
                 <p>Products in cart: ${productCount}</p>

                <c:if test="${!empty logged_in}">
                    <a href="./panel.jsp">Return to panel</a> 
                </c:if>
     
                <a href="./checkout">Checkout</a> 
            </div>

               
                

            <div class="form-body">

                <c:forEach items="${allCartProducts}" var="prodOrder">
                    <div class="product-box">
                        <table>
                            <tr>  <td><h3>${prodOrder.getName()}</h3></td></tr>
                            <tr>  <td>${prodOrder.getManufactor()}</td></tr>
                            <tr>   <td>Amount: ${prodOrder.getStock()}</td></tr>
                            <tr>    <td><img src="images/${prodOrder.getUrl()}" alt="ss"></td></tr>  
                            <tr><td><a href="?remove=${prodOrder.getId()}">Remove from cart</a></td></tr>
                        </table>
                    </div>
                </c:forEach>


            </div>
        </div>




    </body>
</html>
