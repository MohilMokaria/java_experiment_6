
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/AddRecipeServlet")
public class AddRecipeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jdbcUri = getServletContext().getInitParameter("jdbcUri");
        String dbUri = getServletContext().getInitParameter("dbUri");
        String dbId = getServletContext().getInitParameter("dbId");
        String dbPass = getServletContext().getInitParameter("dbPass");

        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        HttpSession session = request.getSession();
        String auth = (String) session.getAttribute("userEmail");
        String title = request.getParameter("title");
        String[] ingredientNames = request.getParameterValues("ingredientName[]");
        String[] ingredientQuantities = request.getParameterValues("ingredientQuantity[]");
        String steps = request.getParameter("steps");

        List<String> ingredientNamesList = Arrays.asList(ingredientNames);
        List<String> ingredientQuantitiesList = Arrays.asList(ingredientQuantities);

        String vegParam = request.getParameter("veg");
        boolean isVeg = Boolean.parseBoolean(vegParam);

        try {
            Class.forName(jdbcUri);

            try (Connection con = DriverManager.getConnection(dbUri, dbId, dbPass)) {

                PreparedStatement ps1;
                PreparedStatement ps2;

                ps1 = con.prepareStatement("INSERT INTO recipe(auth, title, steps, isVeg) VALUES(?,?,?,?)", new String[]{"id"});
                ps1.setString(1, auth);
                ps1.setString(2, title);
                ps1.setString(3, steps);
                ps1.setBoolean(4, isVeg);

                int affectedRows = ps1.executeUpdate();

                if (affectedRows == 0) {
                    throw new SQLException("Creating recipe failed, no rows affected.");
                }

                try (ResultSet generatedKeys = ps1.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        ps2 = con.prepareStatement("INSERT INTO ingredients(recipeId, name, quantity) VALUES(?,?,?)");
                        int recipeId = generatedKeys.getInt(1);

                        // Batching for ingredient insertions
                        for (int i = 0; i < ingredientNamesList.size(); i++) {
                            ps2.setInt(1, recipeId);
                            ps2.setString(2, ingredientNamesList.get(i));
                            ps2.setString(3, ingredientQuantitiesList.get(i));
                            ps2.addBatch();
                        }
                        ps2.executeBatch();

                        response.sendRedirect("HomeServlet");
                    } else {
                        throw new SQLException("Creating recipe failed, no ID obtained.");
                    }
                }

            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            request.setAttribute("exception", ex.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
            rd.include(request, response);
        }
    }

}
