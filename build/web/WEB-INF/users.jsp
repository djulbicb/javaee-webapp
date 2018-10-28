<%-- 
    Document   : users
    Created on : May 31, 2018, 11:27:54 AM
    Author     : Bojan
--%>

<%@page import="java.util.UUID"%>
<%@page import="org.hibernate.id.GUIDGenerator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<%
    UUID uuid = UUID.randomUUID();
    request.getSession().setAttribute("uuid", uuid);
%>

<%    /*
    // Stop caching of pages
    // HTTP 1.1
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    // HTTP 1.0
    response.setHeader("Pragma", "no-cache");
    // Proxy server if used, so it expires, proxies
    
    response.setHeader("Expires", "0");*/
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
                <h1>Users</h1>
                <p>Register or edit users</p>


                <c:if test="${empty logged_in}">
                    <a href="./index.jsp">Return to login</a> 
                </c:if>

                <c:if test="${!empty logged_in}">
                    <a href="./panel.jsp">Return to panel</a> 
                </c:if>
            </div>

            <div class="form-body">
                <form class="user-form" action="./users" method="post">
                    <label for="id">Id:</label>
                    <input type="text" id="id" readonly="" name="id" placeholder="---"><br>
                    <label for="first_name">First name:</label>
                    <input type="text" id="first_name" name="first_name" placeholder="First name" ><br>
                    <label for="last_surname">Last name:</label>
                    <input type="text" id="last_surname" name="last_surname" placeholder="Last name"><br>
                    <label for="name">Username:</label>
                    <input type="text" id="username" name="username" placeholder="Username"><br>
                    <label for="password">Password:</label>
                    <input type="text" id="password" name="password" placeholder="Password"><br>
                    <label for="status">Status:</label><br>
                    <select name="status" id="status">
                        <option value="1">Master</option>
                        <option value="2">Pro</option>
                        <option value="3">Basic</option>
                    </select><br>
                    <input class="form-btn user-btn" type="submit" name="add" value="Add" onclick="return checkAdd()">  
                    <input class="form-btn user-btn" type="submit" name="update" value="Update" onclick="return checkUpdate()">
                    <input class="form-btn user-btn" type="submit" name="delete" value="Delete" onclick="return checkDelete() ">
                    <input class="form-btn user-btn" type="button" name="reset" value="Reset" onclick="resetField()">
                    <input type="hidden" name="form_id" value="${uuid}">
                </form>

                <div class="user-list">
                    <label for="user-list-form">All Users:</label>
                    <select class="user-list-form" id="user-list-form" size="26" onchange="fillFields()">
                        <c:forEach items="${allUsers}" var = "user">
                            <option
                                data-id = "${user.getId()}"
                                data-name = "${user.getFirstName()}"
                                data-surname = "${user.getLastSurname()}"
                                data-password = "${user.getPassword()}"
                                data-username = "${user.getUsername()}"
                                data-status = "${user.getStatus()}"
                                ><c:out value = "${user}"/></option>
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
                var tfName = document.getElementById("first_name");
                var tfSurname = document.getElementById("last_surname");
                var tfUsername = document.getElementById("username");
                var tfPassword = document.getElementById("password");
                var tfStatus = document.getElementById("status");

                tfName.value = selected.dataset.name;
                tfSurname.value = selected.dataset.surname;
                tfUsername.value = selected.dataset.username;
                tfPassword.value = selected.dataset.password;
                tfId.value = selected.dataset.id;

                var selStatus = document.getElementById('status');
                selStatus.value = selected.dataset.status;
            }

            function resetField() {
                var tfId = document.getElementById("id");
                var tfName = document.getElementById("first_name");
                var tfSurname = document.getElementById("last_surname");
                var tfUsername = document.getElementById("username");
                var tfPassword = document.getElementById("password");
                tfName.value = "";
                tfSurname.value = "";
                tfUsername.value = "";
                tfId.value = "";
                tfPassword.value = "";

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
                var tfName = document.getElementById("first_name");
                var tfSurname = document.getElementById("last_surname");
                var tfUsername = document.getElementById("username");
                var tfPassword = document.getElementById("password");
                var tfStatus = document.getElementById("status");

                if (tfName.value === "" || tfSurname.value === "" || tfUsername.value === "" || tfPassword.value === "" || tfStatus.value === "") {
                    alert("Please enter name, surname, password, status anc clik update again");
                    return false;
                }
                return true;
            }

            function checkAdd() {
                var tfId = document.getElementById("id");
                var tfName = document.getElementById("first_name");
                var tfSurname = document.getElementById("last_surname");
                var tfUsername = document.getElementById("username");
                var tfPassword = document.getElementById("password");
                var tfStatus = document.getElementById("status");

                if (tfName.value === "" || tfSurname.value === "" || tfUsername.value === "" || tfPassword.value === "" || tfStatus.value === "") {
                    alert("Please enter name, surname, password, status anc clik add again");
                    return false;
                }
                return true;
            }
        </script>     


    </body>
</html>
