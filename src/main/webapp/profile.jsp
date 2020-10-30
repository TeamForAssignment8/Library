<%--
  Created by IntelliJ IDEA.
  User: Bexultan
  Date: 29.10.2020
  Time: 18:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
<head>
    <title>Profile page</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        a {
            background: #57CDFA;
            text-decoration: none;
            color: black;
            margin: 50px 20px;
            padding: 5px;
            border-radius: 3px;
            border: 1px solid deepskyblue;
        }
        table {
            border-collapse: separate;
            border-spacing: 5px 10px;
        }
    </style>
</head>
<body>
<div style="width: 80vw; margin-left: 10vw; display: grid;">
    <div style="display: flex; justify-content: space-around;">
        <h1><c:out value="${sessionScope.name}"/></h1>
        <h2><a href="logout.jsp">Log out</a></h2>
    </div>
    <hr>
<c:if test="${sessionScope.type == 'admin'}">
    <div>
        <sql:query var="students" dataSource="jdbc/testdb">
            SELECT * FROM students
        </sql:query>
        <div>
            <h2>Students</h2>
            <br>
            <a href="addStudent.jsp">Add new student</a>
        </div>
            <c:forEach var="student" items="${students.rows}" >
                <table>
                <tr>
                    <td><input type="text" disabled="disabled" id="studentId" value="<c:out value="${student.id}"/>"></td>
                    <td><input type="text" disabled="disabled" id="studentName" value="<c:out value="${student.name}"/>"></td>
                    <td><input type="text" disabled="disabled" id="studentPassword" value="<c:out value="${student.password}"/>"></td>
                    <td><a href="updatestudent.jsp?id=<c:out value="${student.id}"/>">Modify</a></td>
                </tr>
                <sql:query var="bbooks" dataSource="jdbc/testdb">
                    SELECT * FROM borrow where id = ?
                    <sql:param value="${student.id}"/>
                </sql:query>
                    <c:forEach var="bbook" items="${bbooks.rows}" >
                        <table>
                            <tr>
                                <td><input type="text" disabled="disabled" value="<c:out value="${bbook.isbn}"/>"></td>
                                <td><a href="updateborrow.jsp?isbn=<c:out value="${bbook.isbn}"/>&&id=<c:out value="${student.id}"/>">Modify</a></td>
                            </tr>
                        </table>
                    </c:forEach>
                </table>
            </c:forEach>
    </div>
    <hr>
    <div>
        <sql:query var="books" dataSource="jdbc/testdb">
            SELECT * FROM books
        </sql:query>
        <div>
            <h2>Books</h2>
            <br>
            <a href="addBook.jsp">Add new book</a>
            <a href="addBorrow.jsp">Add new book to students borrowed books' list</a>
        </div>
        <br>
        <table>
            <c:forEach var="book" items="${books.rows}">
                <tr>
                    <td><input type="text" disabled="disabled" value="<c:out value="${book.isbn}"/>"></td>
                    <td><input type="text" disabled="disabled" value="<c:out value="${book.name}"/>"></td>
                    <td><input type="text" disabled="disabled" value="<c:out value="${book.author}"/>"></td>
                    <td><input type="text" disabled="disabled" value="<c:out value="${book.copies}"/>"></td>
                    <td><a href="updatebook.jsp?isbn=<c:out value="${book.isbn}"/>">Modify</a></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</c:if>
<c:if test="${sessionScope.type == 'student'}">
    <sql:query var="borrowedBooks" dataSource="jdbc/testdb">
        SELECT * FROM borrow where id = ?
        <sql:param value="${sessionScope.id}"/>
    </sql:query>
    <div>
        <h2>Borrowed books</h2>
    </div>
        <c:forEach var="bbook" items="${borrowedBooks.rows}" >
            <sql:query var="book" dataSource="jdbc/testdb">
                SELECT * FROM books where isbn = ?
                <sql:param value="${bbook.isbn}"/>
            </sql:query>
            <c:forEach var="b" items="${book.rows}" >
                <table>
                    <tr>
                        <td><c:out value="${b.isbn}"/></td>
                        <td><c:out value="${b.name}"/></td>
                        <td><c:out value="${b.author}"/></td>
                    </tr>
                </table>
            </c:forEach>
        </c:forEach>
    <sql:query var="books" dataSource="jdbc/testdb">
        SELECT * FROM books
    </sql:query>
    <div>
        <h2>Books</h2>
    </div>
    <table>
        <c:forEach var="book" items="${books.rows}" >
        <tr>
            <td><input type="text" disabled="disabled" name="userid" value="<c:out value='${sessionScope.id}'/>"></td>
            <td><input type="text" disabled="disabled" name="isbn" value="<c:out value="${book.isbn}"/>"></td>
            <td><input type="text" disabled="disabled" name="name" value="<c:out value="${book.name}"/>"></td>
            <td><input type="text" disabled="disabled" name="author" value="<c:out value="${book.author}"/>"></td>
            <td><a href="borrowbook.jsp?isbn=<c:out value="${book.isbn}"/>">Borrow</a></td>
        </tr>
        </c:forEach>
    </table>
</c:if>
</div>
</body>
</html>
