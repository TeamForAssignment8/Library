<%--
  Created by IntelliJ IDEA.
  User: Bexultan
  Date: 30.10.2020
  Time: 19:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    response.setContentType("text/html");
    HttpSession httpSession = request.getSession(true);
    httpSession.removeAttribute("name");
    httpSession.removeAttribute("id");
    httpSession.removeAttribute("type");
    httpSession.setMaxInactiveInterval(0);
    httpSession.invalidate();
    response.sendRedirect("index.jsp");
%>
</body>
</html>
