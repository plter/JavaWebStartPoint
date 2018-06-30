<%--
  Created by IntelliJ IDEA.
  User: yunp
  Date: 2018/6/29
  Time: 3:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8">
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("name");
    String ageString = request.getParameter("age");
    int age = 0;
    if (ageString != null) {
        age = Integer.parseInt(ageString);
    }

    out.print(String.format("Your name is %s,and your age is %d", name, age));

%>
</body>
</html>
