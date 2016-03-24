package mytranslator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * Created by hsenid on 3/14/16.
 */
public class Login extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request,
                       HttpServletResponse response) throws IOException, SecurityException, ServletException {

        /*new obj creation of Translation class*/
        Translation translate = null;

        response.setContentType("text/html");

        String username = request.getParameter("txtUn"); // get the name entered by user's input
        String password = request.getParameter("txtPw"); //get the password entered by user's input

        /**
         * sql - query for the data extraction from tbl_user and compare with user's input name and password
         * password is compared after hashing
         */

        String sql = "select usrName, usrPass from tbl_user where usrName=\"" + username + "\" and usrPass=md5(\"" + password + "\");";
        ResultSet rs = null;
        Connection con;
        Statement st = null;

        try {
            con = Database.getConn();
            st = con.createStatement();
            rs = st.executeQuery(sql);

            if (rs.first()) {
                try {

                    /**
                    Setting session by user name
                    */

                    HttpSession session =request.getSession();
                    session.setAttribute("sessionname",username);

                    /*
                    * get the languages to an array list as langlist
                    * set attribute of the langlist as 'list'
                    * */

                    translate = new Translation();
                    ArrayList<String> langlist = translate.getLangs();
                    request.setAttribute("list", langlist);


                    // send result to the translate page
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/logintranslate.jsp");
                    rd.forward(request, response);
                } catch (Exception e) {
                    throw new ServletException(e);
                }
            } else {
                request.setAttribute("errorMessage", "Invalid credentials. Try again !");
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
                rd.forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (st != null) { // is statement not null?
                try {
                    st.close(); // closing statement
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (rs != null) { // is result set still having value?
                try {
                    rs.close(); // closing resultset
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
