<%-- 
    Document   : hints
    Created on : 15 Jun, 2020, 8:37:38 PM
    Author     : vinit
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <script type="text/javascript">
                  $(document).bind("contextmenu",function(e) {
                            e.preventDefault();
                            });
                            
                        var hit=15;
                        if(hit>=3)
                        {
                            document.getElementById("hint_show").innerHTML="!! HINTS !!";
                            document.getElementById("hb1").innerHTML="RAVI ";}
                          if(hit>=5)
                          {
                              document.getElementById("hb2").innerHTML="Jain";}  
                          if(hit>=7)
                          {
                              document.getElementById("hb3").innerHTML="HELLO";}
                     }
                     </script>
    </body>
</html>
