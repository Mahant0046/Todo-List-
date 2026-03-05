<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession s = request.getSession();
    String username = (String) s.getAttribute("user");
    if (username == null) { response.sendRedirect("login.jsp"); return; }
%>

<html>
<head>
    <title>Profile</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h2>Profile</h2>
        <p><strong>Username:</strong> <%= username %></p>
        <a href="editProfile.jsp"><button>Edit Profile</button></a>
        <a href="dashboard.jsp"><button>Back</button></a>
        <form action="DeleteProfileServlet" method="post" onsubmit="return confirm('Are you sure you want to delete your profile?');">
            <button type="submit" class="btn-danger">Delete Profile</button>
        </form>
    </div>
</body>
</html>
