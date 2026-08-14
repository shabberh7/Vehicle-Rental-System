<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    Boolean verified =
            (Boolean) session.getAttribute("otpVerified");

    Integer resetUserId =
            (Integer) session.getAttribute("resetUserId");

    if (verified == null || !verified || resetUserId == null) {

        response.sendRedirect(
                request.getContextPath()
                + "/forgot-password.jsp"
        );

        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Reset Password</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Poppins,sans-serif;
}

body{
background:linear-gradient(135deg,#141E30,#243B55);
color:white;
min-height:100vh;
}

.navbar{
height:75px;
display:flex;
justify-content:space-between;
align-items:center;
padding:0 40px;
background:rgba(255,255,255,.12);
backdrop-filter:blur(20px);
}

.logo{
font-size:30px;
font-weight:bold;
color:#00ffcc;
}

.navbar a{
color:white;
text-decoration:none;
margin-left:25px;
}

.navbar a:hover{
color:#00ffcc;
}

.container{
width:90%;
max-width:600px;
margin:70px auto;
}

.box{
background:rgba(255,255,255,.12);
backdrop-filter:blur(20px);
padding:45px;
border-radius:30px;
box-shadow:0 0 30px black;
}

.box h1{
text-align:center;
color:#00ffcc;
margin-bottom:15px;
}

.box p{
text-align:center;
color:#ddd;
margin-bottom:35px;
}

.input-box{
margin-bottom:25px;
}

.input-box label{
display:block;
margin-bottom:8px;
font-size:17px;
}

.input-box input{
width:100%;
padding:15px;
border:none;
outline:none;
border-radius:15px;
font-size:17px;
}

.input-box input:focus{
box-shadow:0 0 10px #00ffcc;
}

.btn{
width:100%;
padding:18px;
border:none;
border-radius:30px;
background:#00ffcc;
font-size:20px;
font-weight:bold;
cursor:pointer;
transition:.3s;
}

.btn:hover{
background:#00c7a3;
transform:scale(1.03);
}

.message{
padding:13px;
margin-bottom:20px;
border-radius:12px;
text-align:center;
}

.error{
background:rgba(255,0,0,.18);
color:#ff9999;
}

</style>


<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vehicle-theme.css">
</head>

<body>

<div class="navbar">

<div class="logo">
🚘 LuxeDrive
</div>

<div>
<a href="login.jsp">Login</a>
</div>

</div>

<div class="container">

<div class="box">

<h1>
🔐 Reset Password
</h1>

<p>
Create your new password
</p>

<%
    String error = request.getParameter("error");

    if ("empty".equals(error)) {
%>

<div class="message error">
Please fill both password fields.
</div>

<%
    } else if ("mismatch".equals(error)) {
%>

<div class="message error">
New Password and Confirm Password do not match.
</div>

<%
    } else if ("weak".equals(error)) {
%>

<div class="message error">
Password must contain at least 6 characters.
</div>

<%
    } else if ("same".equals(error)) {
%>

<div class="message error">
New password cannot be the same as old password.
</div>

<%
    } else if ("server".equals(error)) {
%>

<div class="message error">
Something went wrong. Please try again.
</div>

<%
    }
%>

<form action="${pageContext.request.contextPath}/ResetPasswordServlet"
      method="post"
      onsubmit="return validatePassword();">

<div class="input-box">

<label>New Password</label>

<input type="password"
       id="password"
       name="password"
       minlength="6"
       placeholder="Enter New Password"
       required>

</div>

<div class="input-box">

<label>Confirm Password</label>

<input type="password"
       id="confirmPassword"
       name="confirmPassword"
       minlength="6"
       placeholder="Confirm Password"
       required>

</div>

<button class="btn" type="submit">
Reset Password
</button>

</form>

</div>

</div>

<script>

function validatePassword(){

    let password =
        document.getElementById("password").value;

    let confirmPassword =
        document.getElementById("confirmPassword").value;

    if(password.length < 6){

        alert("Password must contain at least 6 characters.");

        return false;
    }

    if(password !== confirmPassword){

        alert("Password and Confirm Password do not match.");

        return false;
    }

    return true;
}

</script>

</body>

</html>