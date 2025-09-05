package com.main.servlets.authhandlers;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// Invalidate the session
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}

		// Clear any cookies if needed
		// You can add cookie clearing logic here if you want to remove remember-me
		// cookies

		// Redirect to login page with success message
		response.sendRedirect(request.getContextPath() + "/public/login.jsp?logout=success");
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// Also handle GET requests for logout (some users might use links)
		doPost(request, response);
	}
}
