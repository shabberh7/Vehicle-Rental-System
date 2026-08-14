<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    String savedOtp =
            (String) session.getAttribute("resetOtp");

    Long otpExpiry =
            (Long) session.getAttribute("resetOtpExpiry");

    Boolean showOtpAlert =
            (Boolean) session.getAttribute("showOtpAlert");

    if (savedOtp == null || otpExpiry == null) {
        response.sendRedirect("forgot-password.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>OTP Verification</title>

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
margin-bottom:20px;
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
font-size:20px;
text-align:center;
letter-spacing:8px;
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
padding:12px;
margin-bottom:20px;
border-radius:12px;
text-align:center;
}

.error{
background:rgba(255,0,0,.18);
color:#ff8a8a;
}

</style>


<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vehicle-theme.css">
</head>

<body>

<%
    if (Boolean.TRUE.equals(showOtpAlert)) {
%>

<script>
    alert("Your OTP is: <%= savedOtp %>\nOTP is valid for 5 minutes.");
</script>

<%
        session.removeAttribute("showOtpAlert");
    }
%>

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
🔑 OTP Verification
</h1>

<p>
Enter the OTP shown in the notification
</p>

<%
    String error = request.getParameter("error");

    if ("invalid".equals(error)) {
%>

<div class="message error">
Invalid OTP. Please enter the correct OTP.
</div>

<%
    } else if ("expired".equals(error)) {
%>

<div class="message error">
OTP expired. Please generate a new OTP.
</div>

<%
    }
%>

<form action="${pageContext.request.contextPath}/VerifyOtpServlet"
      method="post">

<div class="input-box">

<label>Enter OTP</label>

<input type="text"
       name="otp"
       maxlength="6"
       minlength="6"
       pattern="[0-9]{6}"
       inputmode="numeric"
       placeholder="******"
       required>

</div>

<button class="btn" type="submit">
Verify OTP
</button>

</form>

</div>

</div>

</body>

</html>