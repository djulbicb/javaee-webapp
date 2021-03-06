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
        <title>Transactions</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500" rel="stylesheet">
        <style>
            <%@ include file="css/style.css"%>
            <%@ include file="css/extra.css"%>
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
            </div>

            <div class="form-body">


                <c:forEach items="${listOrders}" var="order">   
                    <div class="product-box order-table">
                        <table>
                            <tr><td><h3>OrderID: ${order.getId()}</h3></td></tr>
                            <tr><td>Time of order: ${order.getCreatedAt()}</td></tr>
                            <tr><td>&nbsp;</td></tr>
                            <tr><td><h4>Items Ordered:</h4></td></tr>
                            <hr>
                            <tr><td>
                                    <table class="orders">
                                        <c:forEach items="${order.getOrderdetailCollection()}"  var="orderDetail">
                                            <tr><td>Product: ${orderDetail.getProductName()} Amount: ${orderDetail.getAmount()}</td></tr>
                                            
                                            
                                        </c:forEach>
                                    </table>
                                </td></tr>
                        </table>
                    </div>
                </c:forEach>

            </div>            
        </div>
    </body>

