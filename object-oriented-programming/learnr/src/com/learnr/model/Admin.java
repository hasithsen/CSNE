
package com.learnr.model;

/**
 *
 * @author ASAP	
 */
public class Admin {
    
    private String name;
    private String email;
    private String passwd;
    
    public void setPasswd(String passwd){
    
        this.passwd = passwd;
    }
    public String getPasswd(){
        return passwd;
    }
    
    public void setName(String name){
        this.name = name;
    }
    
    public String getName(){
        return name;
      }
    public void setEmail(String email){
           this.email = email;
    }
    public String getEmail(){
        return email;
    }
    
}
