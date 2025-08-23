package com.main.servlets.authhandlers;

import com.main.servlets.Dbhandler;
import java.io.IOException;
import at.favre.lib.crypto.bcrypt.BCrypt;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServlet;

@WebServlet("/signupservlet")
public class SignupServlet extends HttpServlet {
    Dbhandler db;

    @Override
    public void init() {
        db = new Dbhandler(getServletContext());
         }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String plainPassString = request.getParameter("password");
            String hashedPassword = BCrypt.withDefaults().hashToString(12, plainPassString.toCharArray());
            boolean insert =  db.insertData("INSERT INTO users (email, username, passhash) VALUES (?, ?, ?)", email,username,hashedPassword);
                if(insert){
                        response.sendRedirect("public/signup.jsp?insert=pass");
                    }else{
                    response.sendRedirect("public/signup.jsp?insert=fail");
                }
        }
}
