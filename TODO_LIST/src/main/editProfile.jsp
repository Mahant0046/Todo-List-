<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession, java.sql.*, com.todo.servlets.DBConnection" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String username = (sessionObj != null) ? (String) sessionObj.getAttribute("user") : null;

    if (username == null) { 
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String email = "";

    try {
        conn = DBConnection.getConnection();
        ps = conn.prepareStatement("SELECT email FROM users WHERE username=?");
        ps.setString(1, username);
        rs = ps.executeQuery();

        if (rs.next()) {
            email = rs.getString("email");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>

<html>
<head>
    <title>Edit Profile</title>
    <link rel="stylesheet" href="css/style.css">
    <script>
        function validateForm() {
            let email = document.forms["editProfileForm"]["email"].value;
            let password = document.forms["editProfileForm"]["new_password"].value;
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            if (!email.match(emailPattern)) {
                alert("Please enter a valid email address.");
                return false;
            }

            if (password.length > 0 && password.length < 6) {
                alert("Password must be at least 6 characters long.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Edit Profile</h2>
        <form name="editProfileForm" action="UpdateProfileServlet" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="username" value="<%= username %>">
            <label>Email:</label>
            <input type="email" name="email" value="<%= email %>" required>
            <label>New Password:</label>
            <input type="password" name="new_password" placeholder="Enter new password">
            <button type="submit">Update Profile</button>
        </form>
        <a href="profile.jsp"><button>Back to Profile</button></a>
    </div>
</body>
</html>
