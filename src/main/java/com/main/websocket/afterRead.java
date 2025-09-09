package com.main.websocket;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.main.servlets.Dbhandler;

@WebServlet("/afterRead")
public class afterRead extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Dbhandler db;

    public afterRead() {
        super();
        db = new Dbhandler();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String sender = request.getParameter("sender");
        String receiver = request.getParameter("receiver");

        if(sender == null || receiver == null) {
            out.print("{\"success\": false, \"message\": \"Sender or receiver missing\"}");
            return;
        }

        try {
            String sql = "UPDATE private_messages SET status = 'read' " +
                         "WHERE sender_id = (SELECT id FROM users WHERE username = ?) " +
                         "AND receiver_id = (SELECT id FROM users WHERE username = ?)";
            
            boolean updated = db.updateData(sql, sender, receiver);

            if(updated) {
                out.print("{\"success\": true}");
            } else {
                out.print("{\"success\": false, \"message\": \"No messages updated\"}");
            }
        } catch(Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Exception occurred\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Optionally allow GET
}
}