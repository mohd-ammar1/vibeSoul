package com.main.servlets.authhandlers;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.main.servlets.Dbhandler;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/availcheck")
public class Availcheck extends HttpServlet {
    Dbhandler db;
    public void init(){
        db = new Dbhandler(getServletContext());
    }
    @Override
    protected void doGet(HttpServletRequest request , HttpServletResponse response) throws IOException {
    String mail = request.getParameter("mail");
    String user = request.getParameter("user");
    if(mail != null && !mail.equals("")){
        try{
        ResultSet rs =  db.selectData("select * from users where email = ?", mail);
        if(rs.next()){
                rs.close();
                response.getWriter().write("Email is Already Connected With Another Account");
        }else{
                rs.close();
                response.getWriter().write("Email Available");
        }
    }catch(SQLException sqlexception){
        System.out.println("Error while checking Email Availiblity"+sqlexception.getMessage());
    }
        
    }

    if(user != null && !user.equals("")){
        try(ResultSet rs = db.selectData("select email from users where username =?",user)){
            if(rs.next()){
                 response.getWriter().write("Username not available");        
            }else{
                 response.getWriter().write("Username available");        
            }
        }catch(Exception exp){
            System.out.println("Error whle checking user availiblity: "+exp.getMessage());
        }
    }
}    
}
