package com.main.websocket;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;

import org.json.*;

@WebServlet(description = "used to fetch id of current user on chatpage", urlPatterns = { "/Fetchelper" })
public class Fetchelper extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Fetchelper() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		StringBuilder jsonBuilder = new StringBuilder();
		try (BufferedReader reader = request.getReader()) {
			String line;
			while ((line = reader.readLine()) != null) {
				jsonBuilder.append(line);
			}
		}
		String jsonString = jsonBuilder.toString();

		JSONObject obj = new JSONObject(jsonString);
		String currentuser = obj.getString("cusername");
		int id = 0;
		try {
			id = new ServerSide().senderId(currentuser);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		JSONObject responseobj = new JSONObject();

		responseobj.put("userid", id);
		response.setContentType("application/json");
		response.getWriter().write(responseobj.toString());
	}

}
