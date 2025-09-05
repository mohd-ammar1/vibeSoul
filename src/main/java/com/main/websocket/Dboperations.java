package com.main.websocket;

import com.main.servlets.Dbhandler;

import jakarta.websocket.Session;

public class Dboperations {
	public Dbhandler dbhandler;
	
	public Dboperations() {
		dbhandler = new Dbhandler();
	}

	public void online(Session session, String username) {
		String sessionId = session.getId(); // get unique session id
		boolean res = dbhandler.insertData(
				"INSERT INTO onlineUsers (username, session_id, last_active) VALUES (?, ?, ?)", username, sessionId,
				new java.sql.Timestamp(System.currentTimeMillis()));
		if (!res) {
			System.out.println("Unable to update table for online user");
		}
	}

	public void offline(Session session, String username) {
		String sessionId = session.getId(); // get unique session id
		boolean res = dbhandler.deleteData("DELETE FROM onlineUsers WHERE session_id = ? AND username = ?", sessionId,
				username);
		if (!res) {
			System.out.println("Unable to delete " + username + " from online table after logout");
		}
	}

}
