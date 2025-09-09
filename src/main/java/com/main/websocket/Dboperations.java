package com.main.websocket;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

	public void addFriend(String user, String friend) {
		boolean res = dbhandler.insertData("INSERT INTO friendlist (user, friend, status) VALUES (?, ?, ?)", user,
				friend, "Accepted");
		if (!res) {
			System.out.println("unable to add " + friend + " for user " + user);
		}
	}

	public List<String> getFriendsList(String currentUser) {
		List<String> friends = new ArrayList<>();
		try {
			ResultSet rs = dbhandler.selectData("select friend from friendlist where user = ?", currentUser);
			while (rs.next()) {

				friends.add(rs.getString("friend"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return friends; // Return the list of friends
	}

}
