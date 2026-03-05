package com.todo.servlets;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ForgotPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String newPassword = request.getParameter("new_password");
        String encryptedPassword = PasswordEncryption.encryptPassword(newPassword);

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement checkUser = conn.prepareStatement("SELECT * FROM users WHERE username=?");
            checkUser.setString(1, username);
            ResultSet rs = checkUser.executeQuery();

            if (rs.next()) { // Username exists
                PreparedStatement updatePassword = conn.prepareStatement("UPDATE users SET password=? WHERE username=?");
                updatePassword.setString(1, encryptedPassword);
                updatePassword.setString(2, username);
                int result = updatePassword.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("login.jsp?message=Password reset successful. Please log in.");
                } else {
                    response.getWriter().println("Failed to update password.");
                }
            } else {
                response.getWriter().println("Username not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
