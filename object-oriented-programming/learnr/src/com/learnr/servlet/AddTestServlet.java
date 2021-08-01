package com.learnr.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.learnr.util.DB;

/**
 * Servlet implementation class AddTestServlet
 */
@WebServlet("/AddTestServlet")
public class AddTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
        Connection conn = DB.getCon();
        Statement stmt = null;
        try {
		 //STEP 4: Execute a query
	      //System.out.println("Inserting records into the table...");
	      stmt = conn.createStatement();
	      String q1 = "Sdsd";
	      String q2 = "dfd";
	      String q3 = "ffdrequest.getParameter";
	      String q4 = "sds";
	      String q5 = "sdsdd"; //request.getParameter("q5");
	      
	      Integer id = Integer.parseInt(request.getParameter("id"));
	      
	      String sql = "INSERT INTO quiz " + "VALUES (1, '"+q1+"', '"+id+"')";
	      stmt.executeUpdate(sql);
	      sql = "INSERT INTO quiz " + "VALUES (1, '"+q2+"', '"+id+"')";
	      stmt.executeUpdate(sql);
	      sql = "INSERT INTO quiz " + "VALUES (1, '"+q3+"', '"+id+"')";
	      stmt.executeUpdate(sql);
	      sql = "INSERT INTO quiz " + "VALUES (1, '"+q4+"', '"+id+"')";
	      stmt.executeUpdate(sql);
	      sql = "INSERT INTO quiz " + "VALUES (1, '"+q5+"', '"+id+"')";
	      stmt.executeUpdate(sql);
	      //System.out.println("Inserted records into the table...");
	      response.sendRedirect("/admin.jsp");

	   }catch(SQLException se){
	      //Handle errors for JDBC
	      se.printStackTrace();
	   }catch(Exception e){
	      //Handle errors for Class.forName
	      e.printStackTrace();
	   }finally{
	      //finally block used to close resources
	      try{
	         if(stmt!=null)
	            conn.close();
	      }catch(SQLException se){
	      }// do nothing
	      try{
	         if(conn!=null)
	            conn.close();
	      }catch(SQLException se){
	         se.printStackTrace();
	      }//end finally try
	   }//end try
	}

}
