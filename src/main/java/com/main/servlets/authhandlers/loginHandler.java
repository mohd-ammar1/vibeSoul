package com.main.servlets.authhandlers;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.main.servlets.Dbhandler;
import com.main.websocket.Dboperations;

import at.favre.lib.crypto.bcrypt.BCrypt;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/loginhandler")
public class loginHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Dbhandler db;
	private Dboperations dboperation;
	private ResultSet rs;

	@Override
	public void init() {
		db = new Dbhandler();
		dboperation = new Dboperations();
	}

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String choice = request.getParameter("remme");
			rs = db.selectData("select passhash from users where username = ?", username);
			if (rs.next()) {
				String passhash = rs.getString("passhash");
				if (passChecker(password, passhash)) {
					HttpSession session = request.getSession();
					session.setAttribute("username", username);
					session.setAttribute("password", password);
					System.out.println("Session-username :" + session.getAttribute("username"));
					Cookie usernameCookie = new Cookie("username", username);
					response.addCookie(usernameCookie);
					if ("on".equals(choice)) {
						usernameCookie.setMaxAge(30 * 60 * 60 * 24);
					}
					response.sendRedirect(request.getContextPath() + "/authorised/chatPage.jsp");
				} else {
					response.sendRedirect(request.getContextPath() + "/public/login.jsp?user=unverified");
				}
			} else {
				response.sendRedirect(request.getContextPath() + "/public/login.jsp?user=unknown");
			}

		} catch (SQLException ex) {
			response.sendRedirect(request.getContextPath() + "/public/login.jsp?error=" + ex.getMessage());
			System.out.println("Error While Fetching Data: " + ex.getMessage());
		}

	}

	private boolean passChecker(String password, String passhash) {
		return BCrypt.verifyer().verify(password.toCharArray(), passhash).verified;
	}

}
