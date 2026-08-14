<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Register Page</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    padding:30px 0;
    background:linear-gradient(135deg,#141e30,#243b55);
}

.register-box{
    width:420px;
    padding:35px;
    background:rgba(255,255,255,0.12);
    backdrop-filter:blur(15px);
    border-radius:25px;
    box-shadow:0 0 30px rgba(0,0,0,0.5);
    color:white;
}

h1{
    text-align:center;
    margin-bottom:25px;
    font-size:32px;
}

.input-box{
    margin-bottom:18px;
}

.input-box input,
.input-box textarea{
    width:100%;
    padding:14px;
    border:none;
    outline:none;
    border-radius:12px;
    font-size:16px;
}

.input-box textarea{
    height:85px;
    resize:none;
}

button{
    width:100%;
    padding:14px;
    border:none;
    border-radius:15px;
    background:#00ffcc;
    font-size:18px;
    font-weight:bold;
    cursor:pointer;
    transition:0.3s;
}

button:hover{
    background:#00b894;
    transform:scale(1.05);
}

p{
    text-align:center;
    margin-top:20px;
}

a{
    color:#00ffcc;
    text-decoration:none;
}

.error{
    color:#ff6b6b;
    font-size:13px;
    display:block;
    margin-top:5px;
}

.server-error{
    background:rgba(255,0,0,0.18);
    color:#ff8080;
    padding:10px;
    border-radius:10px;
    text-align:center;
    margin-bottom:18px;
}

</style>


<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vehicle-theme.css">
</head>

<body>

<div class="register-box">

<h1>Create Account</h1>

<%
    String error = request.getParameter("error");

    if(error != null){
%>

<div class="server-error">

<%
        if(error.equals("empty")){
            out.print("Please fill all required fields.");
        }
        else if(error.equals("emailExists")){
            out.print("This email is already registered.");
        }
        else if(error.equals("database")){
            out.print("Database connection failed.");
        }
        else if(error.equals("invalidName")){
            out.print("Please enter a valid name.");
        }
        else if(error.equals("invalidMobile")){
            out.print("Please enter a valid 10 digit mobile number.");
        }
        else if(error.equals("weakPassword")){
            out.print("Password must be at least 6 characters.");
        }
        else if(error.equals("passwordMismatch")){
            out.print("Passwords do not match.");
        }
        else{
            out.print("Registration failed. Please try again.");
        }
%>

</div>

<%
    }
%>

<form action="RegisterServlet"
      method="post"
      onsubmit="return checkRegister()">

<div class="input-box">

<input type="text"
       id="name"
       name="name"
       placeholder="Enter Full Name">

<span class="error" id="nameError"></span>

</div>

<div class="input-box">

<input type="text"
       id="mobile"
       name="mobile"
       maxlength="10"
       placeholder="Enter Mobile Number">

<span class="error" id="mobileError"></span>

</div>

<div class="input-box">

<input type="email"
       id="email"
       name="email"
       placeholder="Enter Email">

<span class="error" id="emailError"></span>

</div>

<div class="input-box">

<textarea id="address"
          name="address"
          placeholder="Enter Address"></textarea>

<span class="error" id="addressError"></span>

</div>

<div class="input-box">

<input type="password"
       id="password"
       name="password"
       placeholder="Create Password">

<span class="error" id="passwordError"></span>

</div>

<div class="input-box">

<input type="password"
       id="confirm"
       name="confirmPassword"
       placeholder="Confirm Password">

<span class="error" id="confirmError"></span>

</div>

<button type="submit">Register</button>

<p>
Already have account?
<a href="login.jsp">Login</a>
</p>

</form>

</div>

<script>

function checkRegister(){

    let name = document.getElementById("name").value.trim();
    let mobile = document.getElementById("mobile").value.trim();
    let email = document.getElementById("email").value.trim();
    let address = document.getElementById("address").value.trim();
    let password = document.getElementById("password").value;
    let confirm = document.getElementById("confirm").value;

    let valid = true;

    document.getElementById("nameError").innerHTML = "";
    document.getElementById("mobileError").innerHTML = "";
    document.getElementById("emailError").innerHTML = "";
    document.getElementById("addressError").innerHTML = "";
    document.getElementById("passwordError").innerHTML = "";
    document.getElementById("confirmError").innerHTML = "";

    if(name === ""){
        document.getElementById("nameError").innerHTML =
                "Name required";
        valid = false;
    }

    if(!/^[0-9]{10}$/.test(mobile)){
        document.getElementById("mobileError").innerHTML =
                "Enter valid 10 digit mobile number";
        valid = false;
    }

    if(email === ""){
        document.getElementById("emailError").innerHTML =
                "Email required";
        valid = false;
    }

    if(password.length < 6){
        document.getElementById("passwordError").innerHTML =
                "Minimum 6 characters required";
        valid = false;
    }

    if(confirm === ""){
        document.getElementById("confirmError").innerHTML =
                "Confirm password required";
        valid = false;
    }
    else if(password !== confirm){
        document.getElementById("confirmError").innerHTML =
                "Passwords do not match";
        valid = false;
    }

    return valid;
}

</script>

</body>
</html>