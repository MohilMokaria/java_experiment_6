package myClass;

import java.util.List;

public class Recipe {

    private Integer id;
    private String auth;
    private String title;
    private List<Ingredient> ingredients;
    private String steps;
    private Boolean isVeg;

    public Recipe() {
    }

    // Parameterized constructor
    public Recipe(Integer id, String auth, String title, List<Ingredient> ingredients, String steps, Boolean isVeg) {
        this.id = id;
        this.auth = auth;
        this.title = title;
        this.ingredients = ingredients;
        this.steps = steps;
        this.isVeg = isVeg;
    }

    public Integer getId() {
        return this.id;
    }

    public String getAuth() {
        return this.auth;
    }

    public String getTitle() {
        return this.title;
    }

    public String getSteps() {
        return this.steps;
    }

    public Boolean getIsVeg() {
        return this.isVeg;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setAuth(String auth) {
        this.auth = auth;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setSteps(String steps) {
        this.steps = steps;
    }

    public void setIsVeg(Boolean isVeg) {
        this.isVeg = isVeg;
    }

    public List<Ingredient> getIngredients() {
        return ingredients;
    }

    public void setIngredients(List<Ingredient> ingredients) {
        this.ingredients = ingredients;
    }
}
