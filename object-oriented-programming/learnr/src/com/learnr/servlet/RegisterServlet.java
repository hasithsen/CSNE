package com.learnr.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.learnr.model.User;
import com.learnr.util.UserUtill;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		   String id = (request.getParameter("id"));
	       String fname = (request.getParameter("fname"));
	       String lname= (request.getParameter("lname"));
	       String passwd = (request.getParameter("passwd"));
	       String email = (request.getParameter("email"));
	       
	       if (email == "" || email == null || passwd == "" || passwd == null)  {
	    	   request.setAttribute("msg", "Please note all fields are required.");
	    	   getServletContext().getRequestDispatcher("/signup.jsp").forward(request, response);
	       }
	       
	       User user = new User();
	       
           user.setId(id);
	       user.setFname(fname);
	       user.setLname(lname);
	       user.setPasswd(passwd);
	       user.setEmail(email);
	       
	       String sql ="insert into student values(?, ?, ?, ?, ?)";
	       int i = UserUtill.addUser(user, sql);
	       
	       if(i!=0){
	           System.out.println("values added successfully");
	           request.setAttribute("msg", "Registration Successsfull..Please login  ");
	           getServletContext().getRequestDispatcher("/dashboard.jsp").forward(request, response);
	       }
	       else{
	           System.out.println("values not added");
	       }
	   
	}

}

