<%--
  Created by IntelliJ IDEA.
  User: Bexultan
  Date: 28.10.2020
  Time: 17:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function() {
            $("#login").click(function(){
                event.preventDefault();
                var name = $("#name").val();
                var password = $("#password").val();
                $.ajax({
                    url: 'LoginServlet',
                    type: 'POST',
                    data: {
                        name: name,
                        password: password},
                    cache: false,
                    success: function (data) {
                        if (data === 'True') {
                            alert("You signed in!");
                            window.location.href = "profile.jsp";
                        } else {
                            alert("Error occurred!");
                        }
                    }
                });
            });
        });
    </script>
</head>
<body>
<header>The assignment was done by Turgunov Bexultan, Omirzak Yerkanat and Social Adlet.</header>
<center>
    <div class="container">
        <div class="box">
            <img id="logo" src="https://r4.education/wp-content/uploads/2019/08/aitu.png">
            <form action="">
                <div><input type="text" id="name" placeholder="username"></div><br>
                <div><input type="password" id="password" placeholder="password"></div><br>
                <div><button type="submit" id="login">Login</button>
                </div>
            </form>
        </div>
    </div>
</center>
<footer>The assignment was done by Turgunov Bexultan, Omirzak Yerkanat and Social Adlet.</footer>
</body>
</html>
