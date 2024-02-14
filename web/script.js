function disableButton() {
    document.getElementById("submitButton").disabled = true;
}

function refreshPage() {
    location.reload();
}

function setRecentRecipeCookie(recipeName) {
    // Retrieve the existing cookie value
    var existingCookie = getCookie("recentRecipe");

    // Check if the recipeName already exists in the cookie
    if (existingCookie && existingCookie.includes(recipeName)) {
        return; // Exit function if the recipeName already exists
    }

    // Append the new recipe name to the existing value
    var updatedValue = existingCookie ? existingCookie + "," + recipeName : recipeName;

    // Set the cookie with the updated value
    document.cookie = "recentRecipe=" + encodeURIComponent(updatedValue) + "; max-age=" + (24 * 60 * 60);
}

// Function to retrieve cookie value by name
function getCookie(name) {
    var cookies = document.cookie.split(';');
    for (var i = 0; i < cookies.length; i++) {
        var cookie = cookies[i].trim();
        if (cookie.indexOf(name + "=") === 0) {
            return decodeURIComponent(cookie.substring(name.length + 1));
        }
    }
    return null;
}


function navigateToURL() {
    var currentURL = window.location.href;
    window.location.href = currentURL;
}

function addIngredient() {
    var container = document.getElementById('ingredientsSection');
    var newIngredient = document.createElement('div');
    newIngredient.className = 'form-outline mb-4 ingredient-container';
    newIngredient.innerHTML = `
            <div class="d-flex justify-content-around">
                <div>
                    <input type="text" name="ingredientName[]" class="form-control" placeholder="Name" required/>
                </div>
                <div>
                    <input type="text" name="ingredientQuantity[]" class="form-control" placeholder="Quantity" required/>
                </div>
                <div>
                    <button type="button" class="btn btn-outline-danger" onclick="removeIngredient(this)"><i class="fa-solid fa-trash"></i></button>
                </div>
            </div>
        `;
    container.appendChild(newIngredient);
}

document.getElementById('searchButton').addEventListener('click', function (event) {
    event.preventDefault(); // Prevent the default form submission behavior

    var searchInput = document.getElementById('searchInput').value;

    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'SearchServlet?query=' + encodeURIComponent(searchInput), true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                var response = xhr.responseText;
                // Update the DOM with the search results
                document.getElementById('searchResults').innerHTML = response;
            } else {
                console.error('Error:', xhr.status);
            }
        }
    };
    xhr.send();
});


