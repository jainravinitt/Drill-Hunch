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
<%  String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp?reg=login");
    }
    Connection con = null;
    PreparedStatement stmt, stmt1 = null, stmt2 = null;
    ResultSet rs = null, rs1 = null;
    String hint1 = null, hint2 = null, hint3 = null, image = null, ap = null,sol="not";
    int hitt = 0, nhitt = 0, score = 0, piid = 0;
    try {
             con = DBConnection.getConnection();
    } catch (Exception e) {
        out.println("ERROR IN  " + e);
    }
    try {
        int x = 1;
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        String set = "update login set first_login = first_login+1  where email =  '" + email + "'";
        String time1 = "update login set cur_img_time = '" + timestamp + "'  where email =  '" + email + "'";
        stmt = con.prepareStatement("select * from login where email ='" + email + "' ");
        stmt2 = con.prepareStatement("select * from login order by score ");
        rs = stmt2.executeQuery();
        int flag = 0;
        rs = stmt.executeQuery();
        while (rs.next()) {
            flag = rs.getInt(11);
        }
        if (flag == 0) {
            stmt = con.prepareStatement(set);
            int count4 = stmt.executeUpdate();
            stmt = con.prepareStatement(time1);
            int count5 = stmt.executeUpdate();
        }
        stmt = con.prepareStatement("select * from login where email ='" + email + "' ");
        rs = stmt.executeQuery();
    } catch (Exception e) {

        out.println("ERROR " + e);
    }
    try {
        while (rs.next()) {
            piid = rs.getInt(5);
            hitt = rs.getInt(6);
            score = rs.getInt(4);
        }
    } catch (Exception e) {
        out.println("SORRYY" + e);
    }
    try {
        Integer s = piid;
        stmt = con.prepareStatement("select * from solution where id = " + s + " ");
        rs = stmt.executeQuery();
    } catch (Exception e) {
        out.println("E3" + e);
    }
    try {
        while (rs.next()) {
            image = rs.getString(1);
            hint1 = rs.getString(4);
            hint2 = rs.getString(5);
            hint3 = rs.getString(6);
        }
    } catch (Exception e) {
        out.println("ERROR IN ABOfakj" + score);
    }
    
     if(session.getAttribute("message")=="wrong" ||
              session.getAttribute("message")=="correct"){
     }else{ 
         session.setAttribute("message", "none");
     }   
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%--<meta http-equiv="X-UA-Compatible" content="ie-edge">--%>
        <!--<script src="https://kit.fontawesome.com/11acc5a5c1.js" crossorigin="anonymous"></script> -->
        <title>Smash&Leap!</title>
         <link rel="shortcut icon" href="images/icon.png">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/css?family=Cookie" rel="stylesheet">
        <link rel="stylesheet" href="style_newLayout.css">
        
    </head>
    <body><div id="rc_logo">
            <a href="#home" title="Logo">SMASH&LEAP</a> <!-- Swap this placeholder out for your logo image -->
        </div>  
        <div class="rc_nav" id="centered_nav">
            <a href="#rules" title="rules">Rules</a>
            <a href="#leaderboard" title="leaderboard">LeaderBoard</a>
            <a href="#contact" title="conatctus">Contact US</a>
        <a href="logout.jsp" title="logout" style="font-size: 26px;"><i class="fa  fa-sign-out" aria-hidden="true"></i></a>
            
            <a href="javascript:void(0);" title="Menu" style="font-size:18px;" class="icon" onclick="myFunction()">&#9776;</a>
        </div>  
            <jsp:include page="popup.jsp"/>
        <% if( session.getAttribute("message")=="none") {
         %><div id="check_case" style="height: 50px;"> </div>
             <%}%>
        <%  if( session.getAttribute("message")=="wrong") {
            session.removeAttribute("message"); %>
            <jsp:include page="solution.jsp"/>
        <%} else if(session.getAttribute("message")=="correct"){
            session.removeAttribute("message");%>
             <jsp:include page="solutionCorrect.jsp"/>
        <% }%>
        <div class="rc_content">
            <div class="col-lg-11" >
                <div id="img" >
                    <img id="img1" src="" alt="picture" border="2">
                    <script>
                               document.getElementById("img1").src = "images/"+"<%=image%>";             //"; //.png";
                    </script>
                    <form fontsize="100"  action="controller" style="margin-top:20px"  method="post" >
                        <input type="text" placeholder="Type Your Answer Here"  name="check"  autocomplete="off" onkeyup="this.value = this.value.toLowerCase();">
                        <p><a id="wrong" ></a></p>
                        <button class="sub-btn"  type="submit" value="submit" id="button" style="margin-top:-5px;">SUBMIT</button>
                        <%-- <button class="log-btn"  type="button"> <a href="logout.jsp" style="text-decoration:none;color:black;">Log out</button>--%>
                         <br><br>
                            <%--    <li><a href="https://www.facebook.com/groups/2021885708031024/" target="_blank"><i class="fa fa-facebook-official" aria-hidden="true"></i></a></li>
                                <li><a href="https://mail.google.com/mail/u/0/#inbox" target="_blank"><i class="fa fa-envelope" aria-hidden="true"></i></a></li>
                                <li><a href="http://localhost/snl.version19.in/leaderboard.php" target="_blank"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>--%>
                        </form>
                </div>
            </div>
                        </div>
            <%--
                <jsp:include page="footer.jsp"/>
            --%>
            <div id="score_board"style="position:fixed ; right: 0; bottom:0; background-color:tomato ; padding:20px;"  ><h1 style="font-size:26px; margin:0; color:white; " >Points:     <%=score%></h1></div>
    </body>
</html>
<script type='text/javascript'>
    function myFunction() {
        var x = document.getElementById("centered_nav");
        if (x.className === "rc_nav") {
            x.className += " responsive";
        } else {
            x.className = "rc_nav";
        }
    }

function keyPressed(){
var key = event.keyCode || event.charCode || event.which ;
return key;
}



</script>
