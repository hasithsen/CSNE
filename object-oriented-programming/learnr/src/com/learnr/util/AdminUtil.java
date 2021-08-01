
package com.learnr.util;

import com.learnr.model.Admin;
import com.learnr.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class AdminUtil {
    
    public static ResultSet loginAdmin(Admin admin,String sql) {
    
    Connection con = DB.getCon();
    
    ResultSet rs = null;
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, admin.getEmail());
            ps.setString(2, admin.getPasswd());
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
 
    return rs;
}
    
    public static ArrayList<User> getUserLsit(){
          ArrayList<User> al = new ArrayList<User>();
          Connection con = DB.getCon();
          Statement state = null;
          
        try {
            state = con.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(UserUtill.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            ResultSet rs = state.executeQuery("select * from student");
            while(rs.next()){
                User user = new User();
                user.setId(rs.getString("id"));
                user.setFname(rs.getString("fname"));
                user.setLname(rs.getString("lname"));
                user.setEmail(rs.getString("email"));
                user.setPasswd(rs.getString("passwd"));
                
                al.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserUtill.class.getName()).log(Level.SEVERE, null, ex);
        }
        return al;
        }
    
    public static int removeUser(User user){
  
    Connection con = DB.getCon();
    int i = 0;
        try {
            Statement state = con.createStatement();
            i = state.executeUpdate("delete from student where id="+user.getId()+"");
            
            
        } catch (SQLException ex) {
            Logger.getLogger(AdminUtil.class.getName()).log(Level.SEVERE, null, ex);
        }
    
    
    return i;
    }
    
     public static ArrayList<Admin> getAdminLsit(){
          ArrayList<Admin> al = new ArrayList<Admin>();
          Connection con = DB.getCon();
          Statement state = null;
          
        try {
            state = con.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(UserUtill.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            ResultSet rs = state.executeQuery("select * from teacher");
            while(rs.next()){
                Admin ad = new Admin();
                ad.setEmail(rs.getString("email"));
                ad.setPasswd(rs.getString("passwd"));
             
                al.add(ad);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserUtill.class.getName()).log(Level.SEVERE, null, ex);
        }
        return al;
        }
     
      public static int addAdmin(Admin ad,String sql){
        int i = 0;
        Connection con = DB.getCon();
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, ad.getEmail());
            ps.setString(2, ad.getPasswd());
            ps.setString(3, ad.getName());
            
           i= ps.executeUpdate();

                        
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return i;
    }
	

    /*public static void main(String [] args){
         User user = new User();
         user.setId("003");
         AdminUtil.removeUser(user);
          
       
}*/
     
}
    
    
    

