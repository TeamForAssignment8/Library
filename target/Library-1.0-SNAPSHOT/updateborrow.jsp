<%--
  Created by IntelliJ IDEA.
  User: Bexultan
  Date: 30.10.2020
  Time: 17:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
<head>
    <title>Borrowed books</title>
    <script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function() {
            $("#delete").click(function(){
                event.preventDefault();
                var isbn = $("#bookIsbn").val();
                var id = $("#id").val();
                $.ajax({
                    url: 'DeleteBorrowServlet',
                    type: 'POST',
                    data: {
                        isbn: isbn,
                        id: id
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
    SELECT * FROM borrow where isbn = ? and id = ?
    <sql:param value="${param['isbn']}"/>
    <sql:param value="${param['id']}"/>
</sql:query>
<center>
<table>
    <c:forEach var="book" items="${books.rows}" >
        <form>
            <tr>
                <td><input type="text" disabled="disabled" id="bookIsbn" value="<c:out value="${book.isbn}"/>"></td>
                <td><input type="text" disabled="disabled" id="id" value="<c:out value="${book.id}"/>"></td>
                <td><input type="submit" id="delete" value="Delete"></td>
            </tr>
        </form>
    </c:forEach>
</table></center>
</body>
</html>
