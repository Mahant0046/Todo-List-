<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="css/style.css">
    <script>
        function validateRegisterForm() {
            let username = document.getElementById("username").value.trim();
            let email = document.getElementById("email").value.trim();
            let password = document.getElementById("password").value;
            let confirmPassword = document.getElementById("confirmPassword").value;
            let phone = document.getElementById("phone").value;
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            let passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
;

            if (username.length < 3) {
                alert("Username must be at least 3 characters long.");
                return false;
            }

            if (!email.match(emailPattern)) {
                alert("Please enter a valid email address.");
                return false;
            }

            if (!password.match(passwordPattern)) {
                alert("Password must be at least 6 characters long and include letters and numbers.");
                return false;
            }

            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }

            if (!phone.match(/^[0-9]{10}$/)) {
                alert("Phone number must be 10 digits.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
     <div class="container">
        <h2>Create an Account</h2>

        <%-- Display Error Message --%>
        <% String errorMessage = request.getParameter("error"); %>
        <% if (errorMessage != null) { %>
            <div class="error-message"><%= errorMessage %></div>
        <% } %>

        <form action="RegisterServlet" method="post">
            <div class="input-group">
                <input type="text" name="username" placeholder="Username" required>
            </div>
            <div class="input-group">
                <input type="email" name="email" placeholder="Email Address" required>
            </div>
            <div class="input-group">
                <input type="text" name="phone" placeholder="Phone Number" required>
            </div>
            <div class="input-group">
                <input type="password" name="password" placeholder="Password" required>
            </div>
            <button type="submit">Register</button>
        </form>
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</body>
</html>
