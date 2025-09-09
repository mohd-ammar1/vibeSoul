package com.main.websocket;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import com.google.gson.Gson;

/**
 * Servlet implementation class userlist
 */
@WebServlet("/userlist")
public class userlist extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Dboperations dboperations;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userlist() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    public void init() {
    	dboperations = new Dboperations();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/** 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("username");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
		if (user == null) {
		    System.out.println("No username found in session!");
		    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		    response.getWriter().write("{\"error\":\"User not logged in\"}");
		    return;
		}

		Gson gson = new Gson();
		List <String> friends = dboperations.getFriendsList(user);
		System.out.println("friends"+friends);
		String json = gson.toJson(friends);
        response.getWriter().write(json);
	}

}
