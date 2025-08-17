import java.io.*;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.sql.*;

public class contactServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle GET request
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                PrintWriter out = response.getWriter();
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");

            try(Connection con = DriverManager.getConnection()){
                    
            }catch(SQLException exp){
                
            }


    }
}