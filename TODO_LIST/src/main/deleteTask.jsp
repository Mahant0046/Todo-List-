<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    HttpSession s = request.getSession();
    String username = (String) s.getAttribute("user");
    if (username == null) { response.sendRedirect("login.jsp"); return; }

    int taskId = Integer.parseInt(request.getParameter("task_id"));
%>

<html>
<head>
    <title>Delete Task</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h2>Are you sure you want to delete this task?</h2>
        <form action="DeleteTaskServlet" method="post">
            <input type="hidden" name="task_id" value="<%= taskId %>">
            <button type="submit" class="btn-danger">Delete</button>
        </form>
        <a href="dashboard.jsp"><button>Cancel</button></a>
    </div>
</body>
</html>
    