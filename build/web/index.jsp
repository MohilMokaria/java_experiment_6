<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    
    <script>
        function validator(){
            var emailRegex = /^[^\s@]+@[^\s@]+\.[a-z]{2,}$/i;
            var email = document.getElementById("mail").value;
            var pass1 = document.getElementById("pass1").value;
            var pass2 = document.getElementById("pass2").value;
            
            if(!emailRegex.test(email)){
                alert("Invalid Email !");
                return false;
            }
                       
            if(pass1 !== pass2){
                alert("Password Doesn't Match ! Try Again");
                return false;
            }
            
            if(pass1.length < 6 || pass1.length > 12 ){
                alert("Password must be 6 to 12 characters long !");
                return false;
            }
            
            document.getElementById("regform").submit();
            return true;
        }
    </script>
    
</head>
<body>
    
    <form id="regform" action="SignupServlet" method="post" onsubmit="return validator()">
        <h1>User Sign-up Form</h1>
        <% 
            String error = (String) request.getAttribute("error");
            if(error != null && !error.isEmpty()){
        %>
                <p class="alert alert-danger"><%= error %></p> 
        <%
            } 
        %>
        <label for="mail">Email ID : </label>
        <input type="email" id="mail" name="mail" autofocus required>
        
        <label for="pass1">New Password : </label>
        <input type="password" id="pass1" name="pass1" required>
        
        <label for="pass2">Confirm Password : </label>
        <input type="password" id="pass2" name="pass2" required>

        <center><button type="submit">Sign-up</button></center>
        
        <p>Already Signed-up? <a href="./login.jsp">Login</a></p>
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
