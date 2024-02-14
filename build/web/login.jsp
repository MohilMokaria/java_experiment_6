<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <!-- BOOTSTRAP CDNs -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <!-- LOCAL CSS LINK -->
    <link rel="stylesheet" href="./index_styles.css"/>
</head>
<body>
    <form id="regform" action="LoginServlet" method="post">
        <h1>User Login Form</h1>
        <% 
            String error = (String) request.getAttribute("error");
            if(error != null && !error.isEmpty()){
        %>          
            <p class="alert alert-danger"><%= error %></p>  
        <%
            } 
        %>
        <label for="mail">Email ID : </label>
        <input type="email" id="mail" name="mail" value="mohil@mail.com" required>

        <label for="pass">Your Password : </label>
        <input type="password" id="pass" name="pass" value="12345678" required>

        <center><button type="submit" autofocus>Login</button></center>
        
        <p>Don't have a account? <a href="./index.jsp">Sign-up</a></p>
        <% 
            String exceptionMsg = (String) request.getAttribute("exception");
            if(exceptionMsg != null && !exceptionMsg.isEmpty()){
        %>
                <p class="alert alert-danger"><%= exceptionMsg %></p> 
        <%
            } 
        %>
    </form>
</body>
</html>
