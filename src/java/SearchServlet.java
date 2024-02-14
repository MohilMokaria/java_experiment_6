
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import myClass.Recipe;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        String searchResults = "";
        HttpSession session = request.getSession();

        List<Recipe> recipeList = (List<Recipe>) session.getAttribute("recipeList");

        if (recipeList != null && !recipeList.isEmpty()) {
            StringBuilder resultBuilder = new StringBuilder();
            boolean found = false;
            for (Recipe r : recipeList) {
                if (r.getTitle().toLowerCase().contains(query.toLowerCase())) {
                    resultBuilder.append("<p>").append(r.getTitle()).append("</p>");
                    found = true;
                }
            }
            if (found) {
                searchResults = "<html><body>" + resultBuilder.toString() + "</body></html>";
            } else {
                searchResults = "<p>No Recipes Found</p>";
            }
        } else {
            searchResults = "<p>No recipe added to be searched</p>";
        }

        response.setContentType("text/html");
        response.getWriter().write(searchResults);
    }
}
