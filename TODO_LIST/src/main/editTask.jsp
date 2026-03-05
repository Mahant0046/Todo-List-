<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.todo.servlets.DBConnection" %>
<%
    HttpSession s = request.getSession();
    String username = (String) s.getAttribute("user");
    if (username == null) { response.sendRedirect("login.jsp"); return; }

    int taskId = Integer.parseInt(request.getParameter("task_id"));

    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM tasks WHERE id = ?");
    ps.setInt(1, taskId);
    ResultSet rs = ps.executeQuery();
    rs.next();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Task</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h2>Edit Task</h2>
        <form action="EditTaskServlet" method="post">
            <input type="hidden" name="task_id" value="<%= taskId %>">
            <input type="text" name="title" value="<%= rs.getString("title") %>" required>
            <textarea name="description" required><%= rs.getString("description") %></textarea>
            <input type="date" name="due_date" value="<%= rs.getString("due_date") %>" required>
            <button type="submit">Update Task</button>
        </form>
        <a href="dashboard.jsp"><button>Cancel</button></a>
    </div>
</body>
</html>
