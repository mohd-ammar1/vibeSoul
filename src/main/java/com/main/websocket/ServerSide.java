package com.main.websocket;

import com.main.servlets.Dbhandler;
import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;
import org.json.JSONObject;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

@ServerEndpoint("/serverside")
public class ServerSide {
	private Dbhandler dbhandler = new Dbhandler();
	private Dboperations dboperation = new Dboperations();
	private static final Set<Session> sessions = new CopyOnWriteArraySet<>();
	private static final Map<Session, String> usernames = new ConcurrentHashMap<>();
	private List<String> users;

	@OnOpen
	public void onOpen(Session session) throws IOException {
		JSONObject json = new JSONObject();
		String username = session.getRequestParameterMap().getOrDefault("user", List.of("Guest")).get(0);
		sessions.add(session);
		usernames.put(session, username);
		dboperation.online(session, username);
		users = new ArrayList<String>(usernames.values());
		json.put("type", "onlinelist");
		json.put("onlineUsers", users);
		// Broadcast to all
		for (Session s : sessions) {
			if (s.isOpen())
				s.getBasicRemote().sendText(json.toString());
		}
	}

	@OnMessage
	public void onMessage(String message, Session sender) throws IOException, SQLException {
		JSONObject obj = new JSONObject(message);
		String receiver = obj.getString("to");
		String rmessage = obj.getString("text");
		
		messageSaver(usernames.get(sender), receiver, rmessage);
		JSONObject json = new JSONObject();
		json.put("type", "message");
		json.put("from", usernames.get(sender));
		json.put("to", receiver);
		json.put("text", rmessage);

		// Send only to the specific user
		for (Map.Entry<Session, String> entry : usernames.entrySet()) {
			if (entry.getValue().equals(receiver) && entry.getKey().isOpen()) {
				entry.getKey().getBasicRemote().sendText(json.toString());
				}
		}
		
		ResultSet rs = dbhandler.selectData("select * from friendlist where user = ? and friend = ? ",usernames.get(sender),receiver);
		if(!rs.next()) {
			dboperation.addFriend(usernames.get(sender),receiver);
		}
	}

	@OnClose
	public void onClose(Session quitter) throws IOException {
		String username = usernames.get(quitter);
		  if (username != null) {
		        dboperation.offline(quitter, username);
		    } else {
		        System.out.println("Cannot remove online user: username is null for session " + quitter.getId());
		        dboperation.offline(quitter, null); // optional fallback if needed
		    }
		sessions.remove(quitter);
		usernames.remove(quitter);

		// Notify everyone the user left
		broadcastStatus(username, "disconnected");
	}

	@OnError
	public void onError(Session session, Throwable throwable) {
		dboperation.offline(session, usernames.get(session));
		sessions.remove(session);
		usernames.remove(session);
		System.out.println("WebSocket error: " + throwable.getMessage());
	}

	// Send status update (connected/disconnected)
	private void broadcastStatus(String username, String status) throws IOException {
		JSONObject json = new JSONObject();
		json.put("type", "status");
		json.put("user", username);
		json.put("status", status);

		for (Session s : sessions) {
			if (s.isOpen())
				s.getBasicRemote().sendText(json.toString());
		}
	}

	private void messageSaver(String sender, String receiver, String encryptedText) throws SQLException {
		int sid = senderId(sender);
		int rid = receiverId(receiver);
		boolean res = dbhandler.insertData(
				"INSERT INTO private_messages (sender_id, receiver_id, encrypted_text) VALUES (?, ?, ?)", sid, rid,
				encryptedText);
		if (!res) {
			System.out.println("Unable to Insert messages ");
		}
	}

	protected int senderId(String sender) throws SQLException {
		ResultSet rsender = dbhandler.selectData("select id from users where username = ? ", sender);
		if (rsender.next()) {
			return (rsender.getInt("id"));
		}
		return 0;
	}

	protected int receiverId(String receiver) throws SQLException {
		ResultSet rreceiver = dbhandler.selectData("select id from users where username = ? ", receiver);
		if (rreceiver.next()) {
			return (rreceiver.getInt("id"));
		}
		return 0;
	}
	protected String username(int id) throws SQLException{
		ResultSet rs  = dbhandler.selectData("select username from users where id = ? ", id);
		if(rs.next()) {
			return(rs.getString("username"));
		}
		return null;
	}
}
