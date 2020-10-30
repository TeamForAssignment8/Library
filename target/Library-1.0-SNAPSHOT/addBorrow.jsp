<%--
  Created by IntelliJ IDEA.
  User: Bexultan
  Date: 30.10.2020
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>New book</title>
    <script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function() {
            $("#adding").click(function(){
                event.preventDefault();
                var isbn = $("#isbn").val();
                var id = $("#id").val();
                var copies = $("#copies").val();
                $.ajax({
                    url: 'BorrowBookServlet',
                    type: 'POST',
                    data: {
                        isbn: isbn,
                        id: id,
                        copies: copies
                    },
                    cache: false,
                    success: function (data) {
                        if (data === 'True') {
                            alert("New book has been added!");
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
<center>
<h2>New Book to student's borrowed books' list</h2>
<form>
    <table>
        <tr><td>Isbn:</td><td><input type="text" id="isbn"></td></tr>
        <tr><td>Id:</td><td><input type="text" id="id"></td></tr>
        <tr><td>Copies:</td><td><input type="text" id="copies"></td></tr>
        <tr><td><input type="submit" id="adding" value="Add"></td></tr>
    </table>
</form></center>
</body>
</html>
