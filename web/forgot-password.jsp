<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Forgot Password</title>

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



.back{

text-align:center;
margin-top:25px;

}



.back a{

color:#00ffcc;
text-decoration:none;

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

<a href="Deshboard.jsp">Dashboard</a>

</div>

</div>



<div class="container">


<div class="box">


<h1>
🔐 Forgot Password
</h1>


<p>
Enter your registered email to receive OTP
</p>



<form action="${pageContext.request.contextPath}/ForgotPasswordServlet"
      method="post">


<div class="input-box">

<label>Email Address</label>

<input type="email"
name="email"
placeholder="Enter your email"
required>

</div>
    <button class="btn" type="submit">

Send OTP

</button>


</form>


<div class="back">

<a href="login.jsp">
← Back to Login
</a>

</div>


</div>


</div>


</body>

</html>