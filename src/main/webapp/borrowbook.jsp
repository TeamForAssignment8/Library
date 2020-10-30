<%--
  Created by IntelliJ IDEA.
  User: Bexultan
  Date: 30.10.2020
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
<head>
    <title>Borrow book</title>
    <script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function() {
            $("#adding").click(function(){
                event.preventDefault();
                var isbn = $("#isbn").val();
                var id = $("#userid").val();
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
                            window.location.href = "profile.jsp";
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
    <c:forEach var="book" items="${books.rows}">
    <tr>
        <td><input type="text" disabled="disabled" id="userid" value="<c:out value='${sessionScope.id}'/>"></td>
        <td><input type="text" disabled="disabled" id="isbn" value="<c:out value="${book.isbn}"/>"></td>
        <td><input type="text" disabled="disabled" id="name" value="<c:out value="${book.name}"/>"></td>
        <td><input type="text" disabled="disabled" id="author" value="<c:out value="${book.author}"/>"></td>
        <td><input type="text" disabled="disabled" id="copies" value="<c:out value="${book.copies}"/>"></td>
        <td><input type="submit" id="adding" value="Borrow"></td>
    </tr>
    </c:forEach>
</table></center>
</body>
</html>
