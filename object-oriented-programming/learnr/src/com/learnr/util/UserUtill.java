/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learnr.util;
import com.learnr.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASAP
 */
public class UserUtill {
    public static int addUser(User u1,String sql){
        int i = 0;
        Connection con = DB.getCon();
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, u1.getId());
            ps.setString(2, u1.getFname());
            ps.setString(3, u1.getLname());
            ps.setString(4, u1.getPasswd());
            ps.setString(5, u1.getEmail());
            
           i= ps.executeUpdate();

                        
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return i;
    }
    
     public static ResultSet loginUser(User user,String sql) {
    
    Connection con = DB.getCon();
    
    ResultSet rs = null;
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPasswd());
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
 
    return rs;
}
     public static int updateUser(User user,String sql){
     int i = 0;
     Connection con = DB.getCon();
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1, user.getId());
            ps.setString(2, user.getFname());
            ps.setString(3, user.getLname());
            ps.setString(4, user.getPasswd());
            ps.setString(5, user.getEmail());
            
            i = ps.executeUpdate();
            
            
        } catch (SQLException ex) {
            Logger.getLogger(UserUtill.class.getName()).log(Level.SEVERE, null, ex);
        }
     return i;
     }
}     
    
    
        
      
    
    
    
       
    
//  public static void main(String [] args){
//    
//    User u2 = new User();
//    u2.setFirstName("akith");
//    u2.setLastName("malli");
//    
//    u2.setPassword("121");
//    u2.setEmail("akitha@");
//    u2.setId("3");
//    String sql ="update user set firstName=?,lastName=?,email=?,password=?,gender=?  where Uid=?";
//    
//   UserUtill.updateUser(u2, sql);}
//    
//    
//}
     
    
    
    

