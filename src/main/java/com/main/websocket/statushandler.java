package com.main.websocket;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONObject;
import com.main.servlets.Dbhandler;

/**
 * Servlet implementation class statushandler
 */
@WebServlet(description = "Checks if a friend is online or not", urlPatterns = { "/statushandler" })
public class statushandler extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Dbhandler dbhandler;

    public statushandler() {
        super();
        dbhandler = new Dbhandler();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type and encoding
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Prepare JSON object
        JSONObject json = new JSONObject();

        // Get username from request
        String username = request.getParameter("username");
        // Validate username
        if (username == null || username.trim().isEmpty()) {
            json.put("success", false);
            json.put("message", "Username is missing or empty");
            sendResponse(response, json);
            return;
        }

        // Database operation
        ResultSet rs = null;
        try {
            // Query to check if the user is online
            rs = dbhandler.selectData("SELECT * FROM onlineUsers WHERE username = ?", username);

            if (rs != null && rs.next()) {
                json.put("success", true);
                json.put("username", username);
                json.put("status", "online");
            } else {
                json.put("success", true);
                json.put("username", username);
                json.put("status", "offline");
            }

        } catch (SQLException e) {
            System.out.println("Error while fetching status: " + e.getMessage());
            e.printStackTrace();
            json.put("success", false);
            json.put("message", "Database error occurred");
        } finally {
            // Ensure the ResultSet is closed
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.out.println("Failed to close ResultSet: " + e.getMessage());
                }
            }
        }

        // Send final JSON response
        sendResponse(response, json);
    }

    // Helper method to send JSON response
    private void sendResponse(HttpServletResponse response, JSONObject json) throws IOException {
        try (PrintWriter out = response.getWriter()) {
            out.print(json.toString());
            out.flush();
        }
    }
}
