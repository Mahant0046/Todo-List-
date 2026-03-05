<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String username = (sessionObj != null) ? (String) sessionObj.getAttribute("user") : null;

    if (username == null) { 
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Add Task</title>
    <link rel="stylesheet" href="css/style.css">
    <script>
        function validateForm() {
            let title = document.getElementById("title").value.trim();
            let description = document.getElementById("description").value.trim();
            let dueDate = document.getElementById("due_date").value;
            let titleCount = document.getElementById("title-count");
            let descCount = document.getElementById("desc-count");

            titleCount.innerText = title.length + "/50";
            descCount.innerText = description.length + "/250";

            if (title.length < 3 || title.length > 50) {
                alert("Task title must be between 3 and 50 characters.");
                return false;
            }

            if (description.length < 10 || description.length > 250) {
                alert("Task description must be between 10 and 250 characters.");
                return false;
            }

            let today = new Date().toISOString().split('T')[0]; 
            if (dueDate < today) {
                alert("Due date cannot be in the past.");
                return false;
            }

            return true;
        }

        function updateCharCount() {
            document.getElementById("title-count").innerText = document.getElementById("title").value.length + "/50";
            document.getElementById("desc-count").innerText = document.getElementById("description").value.length + "/250";
        }
    </script>
</head>
<body>
    <div class="container">
        <h2><i class="fas fa-tasks"></i> Add New Task</h2>
        <form name="taskForm" action="AddTaskServlet" method="post" onsubmit="return validateForm()">
    <input type="hidden" name="username" value="<%= username %>">

    <div class="input-group">
        <input type="text" id="title" name="title" placeholder=" " required onkeyup="updateCharCount()">
        <label for="title">Task Title</label>
        <span class="char-count" id="title-count">0/50</span>
    </div>

    <div class="input-group">
        <textarea id="description" name="description" placeholder=" " required onkeyup="updateCharCount()"></textarea>
        <label for="description">Task Description</label>
        <span class="char-count" id="desc-count">0/250</span>
    </div>

    <div class="input-group">
        <input type="date" id="due_date" name="due_date" required>
        <label for="due_date">Due Date</label>
    </div>

    <button type="submit">Add Task</button>
</form>
        <a href="dashboard.jsp"><button class="back-btn">Back</button></a>
    </div>
</body>
</html>
