<%-- 
    Document   : products
    Created on : May 31, 2018, 11:28:01 AM
    Author     : Bojan
--%>

<%@page import="java.util.UUID"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<%
    UUID produuid = UUID.randomUUID();
    request.getSession().setAttribute("produuid", produuid);
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Products</title>
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
                <p>Register or edit products</p>

                <c:if test="${!empty logged_in}">
                    <a href="./panel.jsp">Return to panel</a> 
                </c:if>
            </div>


            <div class="form-body">
                <form class="user-form" action="./products" method="post" enctype="multipart/form-data">
                    <label for="id">Id:</label>
                    <input type="text" id="id" readonly="" name="id" placeholder="---"><br>

                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" placeholder="Name of product" ><br>

                    <label for="listManufactors">Manufactors:</label>
                    <select name="listManufactors" id="listManufactors">
                        <c:forEach items="${listManufactors}" var="manuf">
                            <option value="${manuf.getId()}">${manuf.name}</option>
                        </c:forEach>
                    </select>

                    <label for="listCategorys">Category:</label>
                    <select name="listCategorys" id="listCategorys">
                        <c:forEach items="${listCategorys}" var="categ">
                            <option value="${categ.getId()}">${categ.getName()}</option>
                        </c:forEach>
                    </select>   

                    <label for="stock">Stock Quantity:</label>
                    <input type="number" id="stock" name="stock" value="5"><br>    

                    <label for="imageUrl">Upload image:</label><br>
                    <input class="form-btn user-btn" style="float: none;" type="file" name="imageUrl" id="imageUrl">
                    <br>
                    <input class="form-btn user-btn" type="submit" name="add" value="Add" onclick="return checkAdd()">
                    <input class="form-btn user-btn" type="submit" name="update" value="Update" onclick="return checkUpdate()">
                    <input class="form-btn user-btn" type="submit" name="delete" value="Delete" onclick="return checkDelete()">
                    <input class="form-btn user-btn" type="button" name="reset" value="Reset" onclick="resetField()">
                    <input type="hidden" name="form_id" value="${produuid}">
                </form>
                
                <div class="user-list">
                    <label for="user-list-form">All Products:</label>
                    <select class="user-list-form" id="user-list-form" size="27" onchange="fillFields()">
                        <c:forEach items="${allProducts}" var = "product">
                            <option
                                data-id = "${product.getId()}"
                                data-name = "${product.name}"
                                data-image = "${product.imageUrl}"
                                data-manufactor = "${product.manufactorId.id}"
                                data-category = "${product.categoryId.id}"
                                data-stock = "${product.stockQuantity}"
                                ><c:out value = "${product.name}"/></option>
                        </c:forEach>
                    </select>
                </div>



                <div style="clear: both;"></div>
            </div>
        </div>


        <script>
            function fillFields() {
                var sel = document.getElementById('user-list-form');
                var selected = sel.options[sel.selectedIndex];

                var tfId = document.getElementById("id");
                var tfName = document.getElementById("name");
                var tfListManufactors = document.getElementById("listManufactors");
                var tfListCategorys = document.getElementById("listCategorys");
                var tfStock = document.getElementById("stock");
                var tfImageUrl = document.getElementById("imageUrl");

                tfName.value = selected.dataset.name;
                tfListManufactors.value = selected.dataset.manufactor;
                tfListCategorys.value = selected.dataset.category;
                tfStock.value = selected.dataset.stock;
                tfId.value = selected.dataset.id;

                var selStatus = document.getElementById('status');
                selStatus.value = selected.dataset.status;
            }

            function resetField() {
                var tfId = document.getElementById("id");
                var tfName = document.getElementById("name");

                /*
                 var tfListManuf = document.getElementById("listManufactors");
                 var tfListCateg = document.getElementById("listCategorys");
                 var tfStock = document.getElementById("stock");*/
                tfName.value = "";

                tfId.value = "";

            }

            function checkDelete() {
                var selected = document.getElementById('user-list-form');

                if (selected.value === "") {
                    alert("Please select user from the list first and then delete");
                    return false;
                }
                return true;
            }


            function checkUpdate() {
                var tfId = document.getElementById("id");
                var tfName = document.getElementById("name");
                var tflistManufactors = document.getElementById("listManufactors");
                var tflistCategorys = document.getElementById("listCategorys");
                var tfstock = document.getElementById("stock");
                var tfimageUrl = document.getElementById("imageUrl");

                if (tfId.value === "" || tfName.value === "" || tflistManufactors.value === "" || tflistCategorys.value === "" || tfstock.value === "" || tfimageUrl.value === "") {
                    alert("Please first select product from the list and fill in name, surname, password, category, manufactor, stock and pick image");
                    return false;
                }
                return true;
            }

            function checkAdd() {
                var tfId = document.getElementById("id");
                var tfName = document.getElementById("name");
                var tflistManufactors = document.getElementById("listManufactors");
                var tflistCategorys = document.getElementById("listCategorys");
                var tfstock = document.getElementById("stock");
                var tfimageUrl = document.getElementById("imageUrl");

                if (tfName.value === "" || tflistManufactors.value === "" || tflistCategorys.value === "" || tfstock.value === "" || tfimageUrl.value === "") {
                    alert("Please fill in name, surname, password, category, manufactor, stock and pick image");
                    return false;
                }
                return true;
            }

        </script>                 
    </body>
</html>
