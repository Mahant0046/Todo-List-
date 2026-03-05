package com.todo.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle null values safely
        String username = request.getParameter("username") != null ? request.getParameter("username").trim() : "";
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
        String password = request.getParameter("password") != null ? request.getParameter("password").trim() : "";
        String phone = request.getParameter("phone") != null ? request.getParameter("phone").trim() : "";

        // Validate inputs
        if (username.isEmpty() || password.isEmpty() || email.isEmpty() || phone.isEmpty()) {
            response.sendRedirect("register.jsp?error=All fields are required.");
            return;
        }

        // Encrypt password
        String encryptedPassword = PasswordEncryption.encryptPassword(password);
        if (encryptedPassword == null) {
            response.sendRedirect("register.jsp?error=Password encryption failed.");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            // Check if username or email already exists
            PreparedStatement checkUser = conn.prepareStatement("SELECT * FROM users WHERE username=? OR email=?");
            checkUser.setString(1, username);
            checkUser.setString(2, email);
            ResultSet rs = checkUser.executeQuery();

            if (rs.next()) {
                response.sendRedirect("register.jsp?error=Username or Email already exists.");
                return;
            }

            // Insert new user
            PreparedStatement ps = conn.prepareStatement("INSERT INTO users(username, password, email, phone) VALUES(?, ?, ?, ?)");
            ps.setString(1, username);
            ps.setString(2, encryptedPassword);
            ps.setString(3, email);
            ps.setString(4, phone);
            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("login.jsp?message=Registration successful! Please login.");
            } else {
                response.sendRedirect("register.jsp?error=Registration failed. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Database error. Please try again.");
        }
    }
}
