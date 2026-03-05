package com.todo.servlets;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AddTaskServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String dueDate = request.getParameter("due_date");

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("user");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("INSERT INTO tasks(title, description, due_date, user_id) VALUES(?, ?, ?, (SELECT id FROM users WHERE username=?))");
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, dueDate);
            ps.setString(4, username);
            
            if (ps.executeUpdate() > 0) {
                response.sendRedirect("dashboard.jsp");
            } else {
                response.getWriter().println("Failed to add task");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
