<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/style.css">
    <script>
        function validateLoginForm() {
            let username = document.getElementById("username").value.trim();
            let password = document.getElementById("password").value;

            if (username.length < 3) {
                alert("Username must be at least 3 characters long.");
                return false;
            }

            if (password.length < 6) {
                alert("Password must be at least 6 characters long.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
    <div class="form-container">
        <h2>Login</h2>
        
        <%-- Display Error Message --%>
        <% String errorMessage = request.getParameter("error"); %>
        <% if (errorMessage != null) { %>
            <div class="error-message"><%= errorMessage %></div>
        <% } %>
        
        <form action="LoginServlet" method="post" onsubmit="return validateLoginForm()">
            <label>Username:</label>
            <input type="text" id="username" name="username" required>
            
            <label>Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">Login</button>
        </form>
         <p><a href="forgotPassword.jsp">Forgot Password?</a></p>
        <a href="register.jsp"><button class="back-btn">Create an account</button></a>
    </div>
</body>
</html>
