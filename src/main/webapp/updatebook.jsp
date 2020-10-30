<%--
  Created by IntelliJ IDEA.
  User: Bexultan
  Date: 30.10.2020
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
<head>
    <title>Book</title>
    <script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function() {
            $("#update").click(function(){
                event.preventDefault();
                var isbn = $("#bookIsbn").val();
                var name = $("#bookName").val();
                var author = $("#bookAuthor").val();
                var copies = $("#bookCopies").val();
                $.ajax({
                    url: 'UpdateBookServlet',
                    type: 'POST',
                    data: {
                        isbn: isbn,
                        name: name,
                        author: author,
                        copies: copies
                    },
                    cache: false,
                    success: function (data) {
                        if (data === 'True') {
                            window.location.href="profile.jsp";
                        } else {
                            alert("Error occurred!");
                        }
                    }
                });
            });
            $("#delete").click(function(){
                event.preventDefault();
                var isbn = $("#bookIsbn").val();
                $.ajax({
                    url: 'DeleteBookServlet',
                    type: 'POST',
                    data: {
                        isbn: isbn},
                    cache: false,
                    success: function (data) {
                        if (data === 'True') {
                            window.location.href="profile.jsp";
                        } else {
                            alert("Error occurred!");
                        }
                    }
                });
            });
        });
    </script>
    <style>
        table {
            border-collapse: separate;
            border-spacing: 5px 10px;
        }
    </style>
</head>
<body>
<sql:query var="books" dataSource="jdbc/testdb">
    SELECT * FROM books where isbn = ?
    <sql:param value="${param['isbn']}"/>
</sql:query>
<center>
<table>
    <c:forEach var="book" items="${books.rows}" >
        <form>
            <tr>
                <td><input type="text" disabled="disabled" id="bookIsbn" value="<c:out value="${book.isbn}"/>"></td>
                <td><input type="text" id="bookName" value="<c:out value="${book.name}"/>"></td>
                <td><input type="text" id="bookAuthor" value="<c:out value="${book.author}"/>"></td>
                <td><input type="text" id="bookCopies" value="<c:out value="${book.copies}"/>"></td>
                <td><input type="submit" id="update" value="Update"></td>
                <td><input type="submit" id="delete" value="Delete"></td>
            </tr>
        </form>
    </c:forEach>
</table></center>
</body>
</html>
