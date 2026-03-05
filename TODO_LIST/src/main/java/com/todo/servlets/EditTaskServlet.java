package com.todo.servlets;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class EditTaskServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("task_id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String dueDate = request.getParameter("due_date");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("UPDATE tasks SET title=?, description=?, due_date=? WHERE id=?");
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, dueDate);
            ps.setInt(4, taskId);
            
            if (ps.executeUpdate() > 0) {
            	response.setContentType("text/html");
                response.sendRedirect("dashboard.jsp");
            } else {
                response.getWriter().println("Failed to update task");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
