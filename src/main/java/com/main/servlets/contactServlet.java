package com.main.servlets;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/contactServlet")  // this is the URL your form will use
public class contactServlet extends HttpServlet {
    Dbhandler db;

    @Override
    public void init() {
        db = new Dbhandler(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        boolean res = db.insertData(
            "INSERT INTO contact(name, email, subject, message) VALUES (?,?,?,?)",
            name, email, subject, message
        );

        if(res){
            response.sendRedirect(request.getContextPath() + "/public/contact.jsp?insert=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/public/contact.jsp?insert=false");
        }
    }
}
