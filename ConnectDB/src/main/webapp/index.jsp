<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: yunp
  Date: 2018/6/29
  Time: 4:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<%
    ResultSet resultSet = null;
    Connection connection = null;
    Statement queryStatement = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1/javaweb?useUnicode=true&characterEncoding=utf-8", "root", "");
%>
<html>
<head>
    <title>$Title$</title>
    <style>
        table form {
            margin: 0;
            display: inline-block;
        }
    </style>
    <script src="static/jquery-3.3.1.min.js"></script>
</head>
<body>

<form method="post">
    <input type="hidden" name="action" value="insert">
    <table>
        <tbody>
        <tr>
            <td>名字</td>
            <td><input type="text" required name="name"></td>
        </tr>
        <tr>
            <td>
                年龄
            </td>
            <td>
                <input type="number" required name="age">
            </td>
        </tr>
        <tr>
            <td><input type="submit" value="添加"></td>
        </tr>
        </tbody>
    </table>
</form>
<%
    if (request.getMethod().equals("POST")) {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("insert")) {
                String name = request.getParameter("name");
                String ageString = request.getParameter("age");
                int age = -1;
                try {
                    age = Integer.parseInt(ageString);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                if (name != null && age != -1) {
                    PreparedStatement insertStatement = connection.prepareStatement("INSERT INTO `user` (`name`, `age`) VALUES (?, ?)");
                    insertStatement.setString(1, name);
                    insertStatement.setInt(2, age);
                    insertStatement.execute();
                    insertStatement.close();
                }
            } else if (action.equals("delete")) {
                String idString = request.getParameter("id");
                int id = -1;
                try {
                    id = Integer.parseInt(idString);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                if (id != -1) {
                    PreparedStatement deleteStatement = connection.prepareStatement("DELETE FROM user WHERE id=?");
                    deleteStatement.setInt(1, id);
                    deleteStatement.execute();
                    deleteStatement.close();
                }
            } else if (action.equals("update")) {
                String idString = request.getParameter("id");
                String name = request.getParameter("name");
                String ageString = request.getParameter("age");
                int id = -1;
                int age = -1;
                try {
                    id = Integer.parseInt(idString);
                    age = Integer.parseInt(ageString);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                if (name != null && age != -1 && id != -1) {
                    PreparedStatement updateStatement = connection.prepareStatement("UPDATE `user` SET `name` = ?, `age` = ? WHERE `user`.`id` = ?;");
                    updateStatement.setString(1, name);
                    updateStatement.setInt(2, age);
                    updateStatement.setInt(3, id);
                    updateStatement.execute();
                }
            }
        }
    }
%>

<%
    //生成表格 >>>>>>>>>>>>>>>>
    queryStatement = connection.createStatement();
    resultSet = queryStatement.executeQuery("SELECT * FROM user WHERE id >0");
    if (resultSet != null) {
%>
<table border="1">
    <thead>
    <tr>
        <th>id</th>
        <th>名字</th>
        <th>年龄</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <%
        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String name = resultSet.getString("name");
            int age = resultSet.getInt("age");
    %>
    <tr class="user-row">
        <td><%out.print(id);%></td>
        <td><input class="user-name-input" type="text" value="<%out.print(name);%>"></td>
        <td><input class="user-age-input" type="text" value="<%out.print(age);%>"></td>
        <td>
            <form method="post" class="save-user-info-form">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="<%out.print(id);%>">
                <input class="user-name" type="hidden" name="name" value="<%out.print(name);%>">
                <input class="user-age" type="hidden" name="age" value="<%out.print(age);%>">
                <input type="submit" value="保存">
            </form>
            <form method="post" class="delete-user-info-form">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" value="<%out.print(resultSet.getInt("id"));%>">
                <input type="submit" value="删除">
            </form>
        </td>
    </tr>
    <%}%>
    </tbody>
</table>
<%
        queryStatement.close();
    }
    //<<<<<<<<<<<<<<<<<<<<<<<<<
%>
</body>
</html>
<%
        connection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.print("Cannot connect database.");
    }
%>


<script>
    $(".save-user-info-form").submit(function (e) {
        var thisJquery = $(this);
        var rowNodeJquery = thisJquery.parent().parent();
        var userNameInput = rowNodeJquery.find(".user-name-input");
        var userAgeInput = rowNodeJquery.find(".user-age-input");
        var userName = thisJquery.find(".user-name");
        var userAge = thisJquery.find(".user-age");
        userAge.val(userAgeInput.val());
        userName.val(userNameInput.val());
    });

    $(".delete-user-info-form").submit(function (e) {
        if (!confirm("你确定要删除该项数据吗？")) {
            e.preventDefault();
        }
    });
</script>
