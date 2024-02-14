
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import myClass.Recipe;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        String searchResults = "";

        List<Recipe> recipeList = (List<Recipe>) request.getAttribute("recipeList");

        if (recipeList != null && !recipeList.isEmpty()) {
            boolean found = false;
            for (Recipe r : recipeList) {
                if (r.getTitle().equals(query)) {
                    searchResults = "<p>Sample search results...</p>";
                    found = true;
                    break;
                }
            }
            if (!found) {
                searchResults = "<p>No Recipe Found</p>";
            }
        } else {
            searchResults = "<p>No recipe added to be searched</p>";
        }

        response.setContentType("text/html");
        response.getWriter().write(searchResults);
    }
}
