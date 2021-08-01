 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learnr.util;

import com.mysql.jdbc.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


/**
 *
 * @author asap
 */
public class DB {
	public static Connection getCon() {
            Connection con = null;
		try {
                    
			Class.forName("com.mysql.jdbc.Driver");
			con = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/learnr","root", "m0sf3t");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
		
	}

	
    
}
