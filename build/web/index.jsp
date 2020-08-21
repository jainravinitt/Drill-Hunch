<%-- 
    Document   : index
    Created on : 15 Jun, 2020, 9:09:37 PM
    Author     : vinit
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*"%>  
  
<%  
    out.print("RAVIO");
String s=request.getParameter("val");  
if(s==null || s.trim().equals("")){  
out.print("Please enter id");  
}else{  
int id=Integer.parseInt(s);  
out.print(id);  
try{  
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection  con = DriverManager.getConnection ("jdbc:derby://localhost:1527/mydb","root", "root");  
         
PreparedStatement ps=con.prepareStatement("select * from emp where id ='" + id + "' " );  
//ps.setInt(1,id);  
ResultSet rs=ps.executeQuery();  
while(rs.next()){  
out.print(rs.getInt(1)+" "+rs.getString(2));  
}  
con.close();  
}catch(Exception e){e.printStackTrace();}  
}  
%>  