<%-- 
    Document   : popup
    Created on : 4 Jul, 2020, 3:42:52 PM
    Author     : vinit
--%>
<%@page import="com.DBConnection"%>
<%@page import="java.sql.Timestamp" isErrorPage="true"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String email=(String)session.getAttribute("email");
   if(email==null){
       response.sendRedirect("login.jsp");
   }  
    Connection con = null;
    PreparedStatement stmt,stmt1 = null,stmt2=null;
    ResultSet rs=null ,rs1 = null;
    String hint1=null,hint2=null,hint3=null,image =null,ap=null;;
    int hitt=0,nhitt=0,score=0,piid=0;
       try{ 
          con = DBConnection.getConnection();
     }
       catch(Exception e){
       
     out.println("ERROR IN  "+e);
       }
       try{
                int x=1;
                Timestamp timestamp = new Timestamp(System.currentTimeMillis());
                String set="update login set first_login = first_login+1  where email =  '" +email + "'" ;
                String time1="update login set cur_img_time = '"+timestamp+"'  where email =  '" +email + "'" ;
                stmt=con.prepareStatement("select * from login where email ='" + email + "' ");  
                stmt2=con.prepareStatement("select * from login order by score ");  
                rs=stmt2.executeQuery(); 
                int flag=0;
                  rs=stmt.executeQuery();            
                  while(rs.next()){
                  flag=rs.getInt(11);
                }
                if(flag==0)
                {
                        stmt=con.prepareStatement(set);
                        int count4=stmt.executeUpdate();
                        stmt=con.prepareStatement(time1);
                        int count5=stmt.executeUpdate();
                }
     stmt=con.prepareStatement("select * from login where email ='" + email + "' ");  
     rs=stmt.executeQuery(); 
       }
       catch(Exception e){
           
     out.println("ERROR "+e);
       }
      try{ 
          
     while(rs.next()){
     
         piid = rs.getInt(5);
     hitt=rs.getInt(6);
     score=rs.getInt(4);
     
     }
        }
     catch(Exception e){
     out.println("SORRYY"+e);   
      }
      try{
          Integer s= piid;
      stmt=con.prepareStatement("select * from solution where id = " +s+ " ");  
     //stmt=con.prepareStatement("select * from solution where id = 1 ");  
     rs=stmt.executeQuery(); 
      }
     catch(Exception e){
         out.println("E3"+e);
       }
     try{
     while(rs.next()){
       hint1=rs.getString(4);
       hint2=rs.getString(5);
       hint3=rs.getString(6);
    }
   }
   catch(Exception e )
   {
     out.println("ERROR IN ABOfakj"+score);
   }   
%>
<!DOCTYPE html>
<link rel="stylesheet" href="style_popup1.css">
<!-- Overlay -->
<div class="overlay" id="overlay"></div>
<h1  class="s3-btn" name="Open" onclick="popupOpen();"  > HINTS</h1>
<!-- Pop up -->
<div class="popup" id="popup" style="display:none;">
  <div class="popup-inner">
      <input type="button" name="Close" class="s3-btn-close" onclick="popupClose();" value="&times;">
    <h2 style="font-size: 26px; color: wheat; margin: 5px; ">Hints will be shown here</h2>
    <% if (hitt >=3){ %>
        <p style="font-size: 22px; margin: 7px; "><%=hint1%></p>
    <%}%>
    <% if (hitt >=5){ %>
        <p style="font-size: 22px; margin: 7px; "><%=hint2%></p>
    <%}%>
    <% if (hitt >=7){ %>
        <p style="font-size: 22px; margin: 7px; "><%=hint3%></p>
    <%}%>
</div>
</div>

<!-- Popup Button -->

<script type='text/javascript'>
// Popup Open
function popupOpen(){
    document.getElementById("popup").style.display="block";
    document.getElementById("overlay").style.display="block";
	}
// Popup Close
	function popupClose(){
    document.getElementById("popup").style.display="none";
    document.getElementById("overlay").style.display="none";
	}
</script>