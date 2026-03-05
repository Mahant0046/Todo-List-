<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.todo.servlets.DBConnection" %>
<%
    HttpSession s = request.getSession();
    String username = (String) s.getAttribute("user");
    if (username == null) { response.sendRedirect("login.jsp"); return; }

    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM tasks WHERE user_id = (SELECT id FROM users WHERE username=?)");
    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();
%>

<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h2>Welcome, <%= username %>!</h2>
        <a href="addTask.jsp"><button>Add Task</button></a>
        <a href="profile.jsp"><button>Profile</button></a>
        <a href="LogoutServlet"><button>Logout</button></a>
        <h3>Your Tasks</h3>
        <ul>
            <% while (rs.next()) { %>
                <li><%= rs.getString("title") %> - <%= rs.getString("description") %> (Due: <%= rs.getString("due_date") %>) 
                <a href="editTask.jsp?task_id=<%= rs.getInt("id") %>">Edit</a> | 
                <a href="DeleteTaskServlet?task_id=<%= rs.getInt("id") %>">Delete</a></li>
            <% } %>
        </ul>
    </div>
</body>
</html>
