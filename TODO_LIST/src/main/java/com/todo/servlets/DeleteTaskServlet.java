package com.todo.servlets;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class DeleteTaskServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("task_id"));

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("DELETE FROM tasks WHERE id=?");
            ps.setInt(1, taskId);
            
            if (ps.executeUpdate() > 0) {
            	response.setContentType("text/html");
                response.sendRedirect("dashboard.jsp");
            } else {
                response.getWriter().println("Failed to delete task");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
