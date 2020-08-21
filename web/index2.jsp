<%@page import="javax.swing.JOptionPane"%>
<html>
    <head>
        <title>Login System</title>
    </head>
 
    <body>
        <%
            String email=request.getParameter("email");
            if(email!=null){
                response.sendRedirect("index1.jsp?");
            }else{
                
            }
            
        %>
      
    </body>
</html>