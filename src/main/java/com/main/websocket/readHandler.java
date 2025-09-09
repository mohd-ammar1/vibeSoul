package com.main.websocket;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import org.json.JSONArray;
import org.json.JSONObject;
import com.main.servlets.Dbhandler;

@WebServlet("/readHandler")
public class readHandler extends HttpServlet {
       private static final long serialVersionUID = 1L;
       private Dbhandler dbhandler;
       private ServerSide serverside;
       public void init() {
    	   dbhandler = new Dbhandler();
    	 serverside = new ServerSide();
       }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        String username = (String) request.getSession().getAttribute("username");
        int id =0;
		try {
			id = serverside.senderId(username);
		} catch (SQLException e) {
		
			e.printStackTrace();
		}
        
        if (id == 0) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.write("{\"error\":\"User not logged in\"}");
            return;
        }
        String query = "SELECT sender_id, COUNT(*) AS unread_count " +
                       "FROM private_messages " +
                       "WHERE status = 'sent' AND receiver_id = ? " +
                       "GROUP BY sender_id";

        try(ResultSet rs = dbhandler.selectData(query, id))  {
        	
            JSONArray resultArray = new JSONArray();

            while (rs.next()) {
            	String sender = serverside.username(rs.getInt("sender_id"));
                JSONObject obj = new JSONObject();
                obj.put("sender_name", sender);
                obj.put("unread_count", rs.getInt("unread_count"));
                resultArray.put(obj);
            }
            JSONObject responseJson = new JSONObject();
            responseJson.put("unread_messages", resultArray);

            out.write(responseJson.toString());

        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"error\":\"Database error\"}");
        }
    }
}
