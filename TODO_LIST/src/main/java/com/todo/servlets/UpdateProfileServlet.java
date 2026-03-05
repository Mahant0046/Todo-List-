package com.todo.servlets;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("user");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        try {
            Connection conn = DBConnection.getConnection();
            String query;
            PreparedStatement ps;
            
            if (password != null && !password.isEmpty()) {
                String encryptedPassword = PasswordEncryption.encryptPassword(password);
                query = "UPDATE users SET email=?, phone=?, password=? WHERE username=?";
                ps = conn.prepareStatement(query);
                ps.setString(1, email);
                ps.setString(2, phone);
                ps.setString(3, encryptedPassword);
                ps.setString(4, username);
            } else {
                query = "UPDATE users SET email=?, phone=? WHERE username=?";
                ps = conn.prepareStatement(query);
                ps.setString(1, email);
                ps.setString(2, phone);
                ps.setString(3, username);
            }

            int result = ps.executeUpdate();
            if (result > 0) {
                session.setAttribute("email", email);
                session.setAttribute("phone", phone);
                response.sendRedirect("profile.jsp");
            } else {
                response.getWriter().println("Profile Update Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
