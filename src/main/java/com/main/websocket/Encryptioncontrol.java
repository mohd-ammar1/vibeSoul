package com.main.websocket;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/encryptioncontroll")
public class Encryptioncontrol extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Secret secret;

	@Override
	public void init() throws ServletException {
		super.init();
		secret = new Secret(); // initialize encryption/ decryption helper
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String result = "";
		String sender = request.getParameter("sender");
		String receiver = request.getParameter("receiver");
		String action = request.getParameter("action");
		String message = request.getParameter("message");

		if ("encrypt".equalsIgnoreCase(action)) {
			result = secret.encrypt(sender, receiver, message);
		} else if ("decrypt".equalsIgnoreCase(action)) {
			result = secret.decrypt(sender, receiver, message);
		}

		// Escape quotes for safety
		result = result.replace("\"", "\\\"");

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("{\"result\":\"" + result + "\"}");
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}
