<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="myClass.Recipe" %>
<%@ page import="java.util.List" %>
<%@ page import="myClass.Recipe" %>
<%@ page import="myClass.Ingredient" %>
<%@ page import="java.net.URLDecoder" %>


<!DOCTYPE html>
<html>
    <head>
        <title>Simple Recipe App</title>
        <!--FONT AWESOME CDN-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- BOOTSTRAP CDNs -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <!-- LOCAL CSS LINK -->
        <link rel="stylesheet" href="./home_style.css" />
    </head>
    <body>
        <%
            if (session.getAttribute("userEmail") != null) {
        %>


        <div class="d-flex justify-content-around mb-4">
            <div class="navbar-text mr-3">
                <strong><%= session.getAttribute("userEmail")%></strong>
            </div>

            <div class="d-flex w-50">
                <input class="form-control me-2" id="searchInput" type="search" placeholder="Recipe Name to Search">
                <button class="btn btn-outline-success" id="searchButton" type="submit">Search</button>
            </div>
            <div class="row">
                <span class="col">
                    <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#recentRecipesModal">
                        <i class="fa-solid fa-clock-rotate-left"></i>
                    </button>
                </span>
                <span class="col">
                    <form action="LogoutServlet" method="get">
                        <button class="btn btn-outline-danger"><i class="fa-solid fa-power-off"></i></button>
                    </form>
                </span>
            </div>
        </div>
    <center><div id="searchResults"></div></center>

    <%
        String exceptionMsg = (String) session.getAttribute("exception");
        if (exceptionMsg != null && !exceptionMsg.isEmpty()) {
    %>
    <p class="alert alert-danger"><%= exceptionMsg%></p> 
    <%
        }
    %>
    <br>
    <hr class="border border-primary border-2">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-10 col-sm-8 mx-auto">
                <div class="card shadow align-items-center">
                    <div class="card-body d-flex flex-column col-md-9 col-sm-6 mb-4 mt-4">
                        <form action="AddRecipeServlet" method="post">
                            <%
                                String error = (String) request.getAttribute("error");
                                if (error != null && !error.isEmpty()) {
                            %>          
                            <p class="alert alert-danger"><%= error%></p>  
                            <%
                                }
                            %>
                            <div class="mb-4">
                                <h2>Create New Recipe</h2>
                            </div>
                            <div class="form-outline mb-4">
                                <label  for="title"  class="form-label">Recipe Title:</label>
                                <input type="text" id="title" name="title" class="form-control" required/>
                            </div>

                            <label class="form-label">Ingredients List:</label>
                            <div class="card-body">
                                <div id="ingredientsSection">
                                    <div class="form-outline mb-4 ingredient-container">
                                        <div class="d-flex justify-content-around">
                                            <div>
                                                <input type="text" name="ingredientName[]" class="form-control" placeholder="Name" required/>
                                            </div>
                                            <div>
                                                <input type="text" name="ingredientQuantity[]" class="form-control" placeholder="Quantity" required/>
                                            </div>
                                            <div>
                                                <button type="button" class="btn btn-outline-dark" onclick="removeIngredient(this)" disabled><i class="fa-solid fa-trash"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                    <!--SECTION WHERE INGREDIENTS WILL BE ADDED-->
                                </div>
                                <div><button type="button" class="btn btn-primary" onclick="addIngredient()"><i class="fa-solid fa-plus"></i> Add Ingredient</button></div>
                            </div>

                            <div class="form-outline mb-4">
                                <label class="form-label" for="steps">Steps:</label>
                                <textarea id="steps" name="steps" class="form-control" required></textarea>
                            </div>

                            <div class="card-body d-flex justify-content-center">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="veg" value="true" id="veg" checked>
                                    <label class="form-check-label" for="veg">
                                        Veg
                                    </label>
                                </div>
                                <div class="form-check ms-4">
                                    <input class="form-check-input" type="radio" name="veg" value="false" id="nonveg">
                                    <label class="form-check-label" for="nonveg">
                                        Non-Veg
                                    </label>
                                </div>
                            </div>

                            <center><button type="submit" id="submitButton" class="btn btn-outline-primary btn-block mb-2 sendbtn">Send</button></center>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <section id="my_card">
        <div class="row row-cols-1 row-cols-md-4 g-4">
            <%
                List<Recipe> recipeList = (List<Recipe>) request.getAttribute("recipeList");

                if (recipeList != null && !recipeList.isEmpty()) {
                    int modalCount = 1;
                    for (Recipe r : recipeList) {
                         String modalId = "recipeModel" + modalCount;
            %>
            <div class="col">
                <div class="card" style="width: 18rem;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <h5 class="card-title"><%= r.getTitle()%></h5>
                            <%
                                String iconName = r.getIsVeg() ? "fa-leaf" : "fa-drumstick-bite";
                                String circleColor = r.getIsVeg() ? "green" : "red";
                            %>
                            <i class="fa-solid <%= iconName %> align-self-center" style="color: <%= circleColor %>; font-size: smaller;"></i>
                        </div>
                        <p class="card-text">CHEF : <%= r.getAuth()%></p>
                        <button type="button" class="btn btn-outline-primary" onclick="setRecentRecipeCookie('<%= r.getTitle() %>')" data-bs-toggle="modal" data-bs-target="#<%= modalId %>">Read</button>

                        <!--MODEL1 for recipe View-->
                        <div class="modal fade" id="<%= modalId %>" tabindex="-1" aria-labelledby="<%= modalId %>Label" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <div class="d-flex">
                                            <i class="fa-solid <%= iconName %> align-self-center" style="color: <%= circleColor %>; font-size: smaller;"></i>
                                            <h5 class="modal-title ms-4" id="<%= modalId %>Label"><%= r.getTitle()%> by <%= r.getAuth()%></h5>
                                        </div>
                                    </div>
                                    <div class="modal-body">
                                        <h3>Ingredients :</h3>
                                        <ol>
                                            <%
                                            List<Ingredient> ingredientsList = r.getIngredients();
                                            if (ingredientsList != null && !ingredientsList.isEmpty()) {
                                                for (Ingredient i : ingredientsList) {
                                            %>
                                            <li><%= i.getName() %> - <%= i.getQuantity() %></li>
                                                <%
                                                        }
                                                    } else {
                                                %>
                                            <p>No ingredients found</p>
                                            <%
                                                }
                                            %>
                                        </ol>
                                        <hr>
                                        <h3>Steps :</h3>
                                        <p><%= r.getSteps()%></p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" onclick="navigateToURL()" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
                 modalCount++;
                }
            } else {
            %>
            <div class="card mt-4 messages_card">
                <div class="card-body">
                    <div class="row">
                        <h5 class="card-title col">No Recipes Made Yet</h5>
                    </div>
                    <p class="card-text">Try to Add New Recipes!</p>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </section>


    <% } else { %>
    <hr class="border border-primary border-2">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6 col-sm-6 mx-auto">
                <div class="card shadow align-items-center">
                    <div class="card-body d-flex flex-column col-md-9 col-sm-6 mb-4 mt-4">
                        <p><center>Please log in to access the chat page.</center></p>
                        <a class="btn btn-outline-primary btn-block" href="login.jsp">Login</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% }%>
    <hr class="border border-primary border-2">

    <!-- Modal2 for displaying cookies -->
    <div id="contentToRefresh">
        <div class="modal fade" id="recentRecipesModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="recentRecipesModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="recentRecipesModalLabel">Recently Viewed Recipes</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <% 
                            Cookie[] cookies = request.getCookies();
                            boolean foundRecipe = false;
                            if (cookies != null) {
                                for (Cookie cookie : cookies) {
                                    if (cookie.getName().equals("recentRecipe")) {
                                        String recentRecipe = URLDecoder.decode(cookie.getValue(), "UTF-8");
                                        if (recentRecipe != null && !recentRecipe.isEmpty()) {
                        %>
                        <p><%= response.encodeURL(recentRecipe) %></p>
                        <%
                                            foundRecipe = true;
                                        }
                                    }
                                }
                            }
                            if (!foundRecipe) {
                                // No recently viewed recipes
                        %>
                        <p>No recently viewed recipes</p>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Local Java Script-->
    <script src="script.js"></script>
</body>
</html>
