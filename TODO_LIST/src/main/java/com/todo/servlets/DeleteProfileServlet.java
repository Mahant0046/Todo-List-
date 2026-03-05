package com.todo.servlets;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class DeleteProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("user");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE username=?");
            ps.setString(1, username);
            int result = ps.executeUpdate();

            if (result > 0) {
                session.invalidate();
                response.setContentType("text/html");
                response.sendRedirect("register.jsp");
            } else {
                response.getWriter().println("Failed to delete profile");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
