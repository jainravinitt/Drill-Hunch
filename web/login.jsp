<%@page import="com.DBConnection"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
   <!-- <meta  charset="utf-8" meta name="viewport" content="width=device-width, initial-scale=1.0"/>  -->
        
</head>
<div class="login"  >
    <link rel="stylesheet" href="stylelogin.css">
    <% 
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs=null;
     try{
          con = DBConnection.getConnection();
        }
        catch(Exception e)
     {         out.print("sf"+e);
     }
     String email=(String)session.getAttribute("email");
        if(email!=null){
              response.sendRedirect("newLayout.jsp?"+email);
        }
        String status=request.getParameter("status");
        
        if(status!=null){
        	if(status.equals("false")){
        		   out.print("Incorrect login details!");	           		
        	}
        	else{
        		out.print("Some error occurred!");
        	}
        }
        %>
     <h1>Login</h1>
    <form method="post" action="loginRequestHandler.jsp" >
        <input type="email" name="email" placeholder="Username" required="required" />          
        <input type="password" name="password" placeholder="Password" required="required" />
        <button type="submit" value="Login"  class="btn btn-primary btn-block btn-large">Let me in.</button>
      <%--   <p><a  href="registration.jsp" <p>Register</p> </a> </p>--%>
    </form>
</div>