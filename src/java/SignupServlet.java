
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String jdbcUri = getServletContext().getInitParameter("jdbcUri");
        String dbUri = getServletContext().getInitParameter("dbUri");
        String dbId = getServletContext().getInitParameter("dbId");
        String dbPass = getServletContext().getInitParameter("dbPass");

        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        String email = request.getParameter("mail");
        String pass1 = request.getParameter("pass1");

        try {
            Class.forName(jdbcUri);

            try (Connection con = DriverManager.getConnection(dbUri, dbId, dbPass)) {
                PreparedStatement ps1 = con.prepareStatement("SELECT * FROM chatusers WHERE mail=?");
                ps1.setString(1, email);

                ResultSet rs = ps1.executeQuery();

                if (rs.next()) {
                    String error = "User already registered with <br>" + email;
                    request.setAttribute("error", error);
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                    rd.include(request, response);
                } else {
                    PreparedStatement ps2 = con.prepareStatement("INSERT INTO chatusers(mail, pass) values(?,?)");
                    ps2.setString(1, email);
                    ps2.setString(2, pass1);

                    int i = ps2.executeUpdate();
                    response.sendRedirect("./login.jsp");
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("exception", ex.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.include(request, response);
        }
    }
}
