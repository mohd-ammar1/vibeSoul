package com.main.websocket;

import com.main.servlets.Dbhandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Msghandler")
public class Msghandler extends HttpServlet {
	private Dbhandler dbhandler;
	private static final long serialVersionUID = 1L; 
	public Msghandler() {
		super();
	}

	public void init() {
		dbhandler = new Dbhandler();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Message> messages = new ArrayList<Message>();
		StringBuilder jsonBuilder = new StringBuilder();
		try(BufferedReader reader = request.getReader()){
			String line;
			while((line = reader.readLine())!= null) {
				jsonBuilder.append(line);
			}
		}
		String jsonString = jsonBuilder.toString();
		
		JSONObject obj = new JSONObject(jsonString);
		
		String sender = obj.getString("sender");
		String receiver = obj.getString("receiver");
		
		try {
			ServerSide server = new ServerSide();
			int senderid = server.senderId(sender);
			int receiverid = server.receiverId(receiver);
			ResultSet rs = dbhandler.selectData(
					"SELECT * FROM private_messages WHERE (sender_id = ? AND receiver_id = ?)OR "
					+ "(sender_id = ? AND receiver_id = ?) "
					+ "ORDER BY sent_at ASC",senderid,receiverid,receiverid,senderid);
					Secret secret = new Secret();
			while (rs.next()) {
				Message message = new Message(rs.getInt("message_id"), rs.getInt("sender_id"), rs.getInt("receiver_id"),
						secret.decrypt(sender,receiver,rs.getString("encrypted_text")), rs.getTimestamp("sent_at"));
				messages.add(message);
			}
		} catch (SQLException sql) {
			System.out.println(sql.getMessage());
		}
		JSONArray jsonarray = new JSONArray();
		for(Message msg : messages) {
			JSONObject json = new JSONObject();
			json.put("message_id", msg.getMsgId());
			json.put("sender_id", msg.getSenderId());
			json.put("receiver_id", msg.getReceiverId());
			json.put("msgText", msg.getMsgtxt());
			json.put("sent_at", msg.getTimeSent());
			jsonarray.put(json);
		}
		
		response.setContentType("application/json");
		response.getWriter().write(jsonarray.toString());
	}
}
