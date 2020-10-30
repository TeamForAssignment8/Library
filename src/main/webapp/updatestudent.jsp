<%--
  Created by IntelliJ IDEA.
  User: Bexultan
  Date: 30.10.2020
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
<head>
    <title>Student</title>
    <script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function() {
            $("#update").click(function () {
                event.preventDefault();
                var id = $("#studentId").val();
                var name = $("#studentName").val();
                var password = $("#studentPassword").val();
                $.ajax({
                    url: 'UpdateStudentServlet',
                    type: 'POST',
                    data: {
                        id: id,
                        name: name,
                        password: password
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
            $("#delete").click(function () {
                event.preventDefault();
                var id = $("#studentId").val();
                $.ajax({
                    url: 'DeleteStudentServlet',
                    type: 'POST',
                    data: {
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
<sql:query var="students" dataSource="jdbc/testdb">
    SELECT * FROM students where id = ?
    <sql:param value="${param['id']}"/>
</sql:query>
<center>
<table>
    <c:forEach var="student" items="${students.rows}" >
        <form>
            <tr>
                <td><input type="text" disabled="disabled" id="studentId" value="<c:out value="${student.id}"/>"></td>
                <td><input type="text" id="studentName" value="<c:out value="${student.name}"/>"></td>
                <td><input type="text" id="studentPassword" value="<c:out value="${student.password}"/>"></td>
                <td><input type="submit" id="update" value="Update"></td>
                <td><input type="submit" id="delete" value="Delete"></td>
            </tr>
        </form>
    </c:forEach>
</table></center>
</body>
</html>
