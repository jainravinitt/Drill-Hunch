
import com.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.scene.web.WebEvent;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author vinit
 */
public class controller extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void wrong(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, IOException {
        Connection con = null;
        PreparedStatement stmt = null;
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        //out.print("Hello "+n);  

        if (email != null) {
            try {
                con = DBConnection.getConnection();
                String sql = "update login set curhint = curhint + 1  where email =  '" + email + "'";
                stmt = con.prepareStatement(sql);
                int count = stmt.executeUpdate();
                String sql5 = "update login set wrong_hit = wrong_hit + 1  where email =  '" + email + "'";
                stmt = con.prepareStatement(sql5);
                int count5 = stmt.executeUpdate();
                session.setAttribute("message", "wrong");
                response.sendRedirect("newLayout.jsp?=" + email);
            } catch (SQLException sql) {
                request.setAttribute("error", sql);
                out.println(sql);
            }
        } else {
            out.println("NO EMAIL" + email);
        }
    }

    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        PrintWriter out = response.getWriter();
        //out.println("<h1>" + message + "</h1>");
        String submitted = request.getParameter("check");
        out.print("EMAIL " + request.getAttribute("flag"));
        
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        
        Connection con = null;
        PreparedStatement stmt = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        //String email=(String)session.getAttribute("email");
        try {Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        con = DBConnection.getConnection();
        try {

            stmt = con.prepareStatement("select * from login where email ='" + email + "' ");
        } catch (SQLException ex) {
            Logger.getLogger(controller.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            rs = stmt.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        int cur, pid = 0;
        try {
            while (rs.next()) {
                pid = rs.getInt(5);
            }
        } catch (SQLException ex) {
            Logger.getLogger(controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            stmt = con.prepareStatement("select * from solution where id = " + pid + "  ");
        } catch (SQLException ex) {
            Logger.getLogger(controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            rs = stmt.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        String answer = null;
        try {
            while (rs.next()) {
                answer = rs.getString(3);
            }
        } catch (SQLException ex) {
            Logger.getLogger(controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (!submitted.equals(answer)) {
            try {
                wrong(request, response);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(controller.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            // if(email != null)
            if (!email.equals(null)) {
                int chit = 0;
                try {
                    int x = 0;
                    Timestamp timestamp = new Timestamp(System.currentTimeMillis());
                    Timestamp t1 = null;
                    long milli;
                    stmt = con.prepareStatement("select * from login where email ='" + email + "' ");
                    rs = stmt.executeQuery();
                    while (rs.next()) {
                        pid = rs.getInt(5);
                    }
                    stmt = con.prepareStatement("select * from solution where id = " + pid + "  ");
                    rs = stmt.executeQuery();
                    while (rs.next()) {
                        answer = rs.getString(3);
                        t1 = rs.getTimestamp(7);
                    }
                    pid += 1;
                    stmt = con.prepareStatement("select * from solution where id = " + pid + "  ");
                    rs = stmt.executeQuery();
                    while (rs.next()) {
                        int f = rs.getInt(8);
                        if (f == 0) {
                            String set_f = "update solution set flag = flag+1 where id =  " + pid + " ";
                            String f_time = "update solution set first_time = '" + timestamp + "'  where id =  " + pid + "";
                            stmt = con.prepareStatement(set_f);
                            int count1 = stmt.executeUpdate();
                            stmt = con.prepareStatement(f_time);
                            int ti = stmt.executeUpdate();
                        }
                    }
                    milli = timestamp.getTime() - t1.getTime();
                    long seconds = (long) milli / 1000;
                    if (seconds <= 60) {
                        x = 100;
                    } else if (seconds > 60 && seconds <= 120) {
                        x = 50;
                    } else {
                        x = 30;
                    }
                    String time = "update login set last_submit = '" + timestamp + "'  where email =  '" + email + "'";
                    String time1 = "update login set cur_img_time = '" + timestamp + "'  where email =  '" + email + "'";
                    String sql = "update login set iid = iid + 1  where email =  '" + email + "'";
                    String sql1 = "update login set piid = piid + 1  where email =  '" + email + "'";
                    String sql2 = "update login set curhint = 0  where email =  '" + email + "'";
                    stmt = con.prepareStatement(sql1);
                    int count1 = stmt.executeUpdate();
                    stmt = con.prepareStatement(time1);
                    int ti = stmt.executeUpdate();
                    stmt = con.prepareStatement(sql2);
                    int count2 = stmt.executeUpdate();
                    stmt = con.prepareStatement("select * from login where email ='" + email + "' ");
                    rs = stmt.executeQuery();
                    stmt = con.prepareStatement(time);
                    int count40 = stmt.executeUpdate();
                    String sql3 = "update login set score = score +  " + x + "   where email =  '" + email + "'";
                    stmt = con.prepareStatement(sql3);
                    int count3 = stmt.executeUpdate();
                    session.setAttribute("message", "correct");               
                    response.sendRedirect("newLayout.jsp?=" + email);
                } catch (SQLException sql) {
                    request.setAttribute("error", sql);
                    out.println("dsfsg" + sql);
                }
            } else {
                response.sendRedirect("logout.jsp");
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "___";
    }// </editor-fold>

}
