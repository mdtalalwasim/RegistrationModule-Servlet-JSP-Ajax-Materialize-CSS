
package com.user.register;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Md. Talal Wasim
 */

@MultipartConfig 
//this servlet handle multipart form...like string, image, file, audio, video etc,,
//so we must inform that... using mention @MultipartConfig annotation...
public class Register extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet Register</title>");            
//            out.println("</head>");
//            out.println("<body>");
            
            //getting all the incoming details from the request...
            String name = request.getParameter("user_name");
            String password = request.getParameter("user_password");
            String email = request.getParameter("user_email");
            Part part = request.getPart("image");
            String fileName = part.getSubmittedFileName();//fetch the file name
            //out.println(fileName);
            
//            out.println(name);
//            out.println(password);
//            out.println(email);
            

            //bd connection...
            try {
                
                //3sec thread will sleep, before starting JDBC Operation...
                //because, loading.../ Please wait...
                //will show for 3sec to users when click submit button/sent the request to backend.
                Thread.sleep(3000);
                
                
                //JDBC connection for insert all the credential into database...
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_register", "root", "wasim");
                
                //query...
                String q = "insert into user_tbl(name,password,email,imageName) values(?,?,?,?)";
                //String q = "insert into user_tbl(name,password,email) values(?,?,?)";
                
                PreparedStatement pstmt = con.prepareStatement(q);
                pstmt.setString(1, name);
                pstmt.setString(2, password);
                pstmt.setString(3, email);
                pstmt.setString(4, fileName); //just storing the image file name. not image in DB.
                
                pstmt.executeUpdate();
                
                //code for image upload into folder not db...
                //Start -code for image upload
                
                InputStream is = part.getInputStream();
                byte []dataForImage = new byte[is.available()];
                
                is.read(dataForImage);
                
                //ProjectWorkspaceName\UserRegister\build\web\img\fileName.jpg..png..gif..etc
                String path = request.getRealPath("/")+"img"+File.separator+fileName;
                
                
                //out.println(path);//for see the full path...
                
                FileOutputStream fos = new FileOutputStream(path);
                fos.write(dataForImage);        
                fos.close();
                
                //end code for image upload
                //out.println("WASIM");
                out.println("done");
                
            } catch (Exception e) {
                e.printStackTrace();
                out.println("error");
            }
            
            
//            out.println("</body>");
//            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
