package com.learnr.servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.learnr.model.Admin;
import com.learnr.model.User;
import com.learnr.util.AdminUtil;
import com.learnr.util.UserUtill;

/**
 * Servlet implementation class logservlet1
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String userType = request.getParameter("userType");
        
        if(userType. equals("Teacher")){
        
        String email=(request.getParameter("email"));
        String passwd=(request.getParameter("passwd"));
        
        if(email.equals(null)||email==""||passwd.equals(null)||passwd==""){
            request.setAttribute("msg", "All fields are required");
            getServletContext().getRequestDispatcher("/signin.jsp").forward(request, response);
        }
         
        else{
        Admin admin = new Admin();
        admin.setEmail(email);
        admin.setPasswd(passwd);
        
        String sql ="select * from admin where email=? and passwd=?";
        
        HttpSession session = request.getSession();
        ResultSet rs =AdminUtil.loginAdmin(admin, sql);
            try {
                if(rs.next()){
                    session.setAttribute("admin", admin);
                    request.setAttribute("msg", "login Successfully");
                    getServletContext().getRequestDispatcher("/admin.jsp").forward(request, response);
                }
                else{
                  getServletContext().getRequestDispatcher("/signin.jsp").forward(request, response);  
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        
        }
        
        }else if(userType.equals("Student")){
        String email=(request.getParameter("email"));
        String passwd=(request.getParameter("passwd"));
        
        if(email.equals(null)||email==""||passwd.equals(null)||passwd==""){
            request.setAttribute("msg", "All fields are required");
            getServletContext().getRequestDispatcher("/signin.jsp").forward(request, response);
        }
         
        else{
       User user = new User();
        user.setEmail(email);
        user.setPasswd(passwd);
        
        String sql ="select * from user where email=? and passwd=?";
        
         HttpSession session = request.getSession();
        ResultSet rs =UserUtill.loginUser(user, sql);
            try {
                if(rs.next()){
                    session.setAttribute("id", rs.getString(1));
                    session.setAttribute("fname", rs.getString(2));
                    session.setAttribute("lname", rs.getString(3));
                    session.setAttribute("email", rs.getString(4));
                    session.setAttribute("passwd", rs.getString(5));
                    request.setAttribute("msg", "Successfully logged");
                    getServletContext().getRequestDispatcher("/user.jsp").forward(request, response);
                }
                else{
                   request.setAttribute("msg", "Sorry, invalid credentials. Please try again or Sign Up."); 
                  getServletContext().getRequestDispatcher("/signin.jsp").forward(request, response);  
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        
        
        
        }
    }
}
}