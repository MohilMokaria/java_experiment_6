
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import myClass.Ingredient;
import myClass.Recipe;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String jdbcUri = getServletContext().getInitParameter("jdbcUri");
        String dbUri = getServletContext().getInitParameter("dbUri");
        String dbId = getServletContext().getInitParameter("dbId");
        String dbPass = getServletContext().getInitParameter("dbPass");

        response.setContentType("text/html");
        HttpSession session = request.getSession();
        List<Recipe> recipeList = new ArrayList<>();

        try {
            Class.forName(jdbcUri);

            try (Connection con = DriverManager.getConnection(dbUri, dbId, dbPass)) {

                PreparedStatement ps;

                ps = con.prepareStatement("SELECT recipe.id, recipe.auth, recipe.title, recipe.steps, recipe.isVeg, ingredients.name AS ingNames, ingredients.quantity AS ingQuantity FROM recipe LEFT JOIN ingredients ON recipe.id = ingredients.recipeId GROUP BY recipe.id, recipe.auth, recipe.title, recipe.steps, recipe.isVeg, ingredients.name, ingredients.quantity");

                try (ResultSet rs = ps.executeQuery()) {
                    int currentRecipeId = -1; // Initialize with an invalid ID
                    Recipe recipe = null;

                    while (rs.next()) {
                        int recipeId = rs.getInt("id");

                        if (recipeId != currentRecipeId) {
                            // If the recipe ID changes, create a new Recipe object
                            if (recipe != null) {
                                // Add the previously created recipe to the list
                                recipeList.add(recipe);
                            }
                            // Create a new Recipe object
                            String auth = rs.getString("auth");
                            String title = rs.getString("title");
                            String steps = rs.getString("steps");
                            boolean isVeg = rs.getBoolean("isVeg");
                            recipe = new Recipe(recipeId, auth, title, new ArrayList<>(), steps, isVeg);
                            currentRecipeId = recipeId;
                        }

                        // Retrieve ingredient details and add them to the recipe
                        String ingredientName = rs.getString("ingNames");
                        String ingredientQuantity = rs.getString("ingQuantity");
                        if (ingredientName != null && ingredientQuantity != null) {
                            Ingredient ingredient = new Ingredient(ingredientName, ingredientQuantity);
                            recipe.getIngredients().add(ingredient);
                        }
                    }

                    // Add the last recipe to the list (if any)
                    if (recipe != null) {
                        recipeList.add(recipe);
                    }
                }

                session.setAttribute("recipeList", recipeList);
                RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
                rd.forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("exception", ex.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
            rd.include(request, response);
        }
    }
}
