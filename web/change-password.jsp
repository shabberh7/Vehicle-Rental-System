<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String error = request.getParameter("error");
    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Change Password</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Poppins,Arial,sans-serif;
}

body{
    background:linear-gradient(135deg,#141E30,#243B55);
    color:white;
    min-height:100vh;
}

.navbar{
    min-height:75px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:15px 40px;
    background:rgba(255,255,255,.12);
    backdrop-filter:blur(20px);
}

.logo{
    font-size:30px;
    font-weight:bold;
    color:#00ffcc;
}

.navbar a{
    text-decoration:none;
    color:white;
    margin-left:25px;
    transition:.3s;
}

.navbar a:hover{
    color:#00ffcc;
}

.container{
    width:90%;
    max-width:600px;
    margin:60px auto;
}

.box{
    background:rgba(255,255,255,.12);
    backdrop-filter:blur(20px);
    padding:40px;
    border-radius:30px;
    box-shadow:0 0 30px rgba(0,0,0,.6);
}

.box h1{
    text-align:center;
    color:#00ffcc;
    margin-bottom:30px;
}

.input-box{
    margin-bottom:25px;
}

.input-box label{
    display:block;
    margin-bottom:8px;
    font-size:17px;
    font-weight:bold;
}

.password-field{
    position:relative;
}

.input-box input{
    width:100%;
    padding:15px 50px 15px 15px;
    border:2px solid transparent;
    outline:none;
    border-radius:15px;
    font-size:17px;
}

.input-box input:focus{
    border-color:#00ffcc;
    box-shadow:0 0 15px rgba(0,255,204,.25);
}

.show-btn{
    position:absolute;
    right:15px;
    top:50%;
    transform:translateY(-50%);
    border:none;
    background:none;
    cursor:pointer;
    font-size:20px;
}

.message{
    padding:13px;
    border-radius:12px;
    margin-bottom:22px;
    text-align:center;
    font-weight:bold;
}

.error{
    background:rgba(255,70,70,.25);
    border:1px solid #ff5c5c;
    color:#ffdede;
}

.success{
    background:rgba(0,255,170,.20);
    border:1px solid #00ffcc;
    color:#bfffee;
}

.btn{
    width:100%;
    padding:18px;
    border:none;
    border-radius:30px;
    background:#00ffcc;
    color:#141e30;
    font-size:20px;
    font-weight:bold;
    cursor:pointer;
    transition:.3s;
}

.btn:hover{
    background:#00c7a3;
    transform:scale(1.03);
}

@media(max-width:650px){

    .navbar{
        flex-direction:column;
        gap:16px;
        text-align:center;
    }

    .navbar a{
        display:inline-block;
        margin:5px;
    }

    .box{
        padding:25px;
    }
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

        <a href="<%= request.getContextPath() %>/Deshboard.jsp">
            Dashboard
        </a>

        <a href="<%= request.getContextPath() %>/ProfileServlet">
            Profile
        </a>

        <a href="<%= request.getContextPath() %>/MyBookingsServlet">
            Bookings
        </a>

    </div>

</div>

<div class="container">

    <div class="box">

        <h1>🔐 Change Password</h1>

        <% if ("empty".equals(error)) { %>

            <div class="message error">
                Sabhi fields bharna zaroori hai.
            </div>

        <% } else if ("wrongold".equals(error)) { %>

            <div class="message error">
                Old password galat hai.
            </div>

        <% } else if ("same".equals(error)) { %>

            <div class="message error">
                New password old password jaisa nahi hona chahiye.
            </div>

        <% } else if ("notmatch".equals(error)) { %>

            <div class="message error">
                New password aur confirm password match nahi kar rahe.
            </div>

        <% } else if ("weak".equals(error)) { %>

            <div class="message error">
                Password minimum 8 characters ka hona chahiye.
            </div>

        <% } else if ("server".equals(error)) { %>

            <div class="message error">
                Server error. Dobara try karo.
            </div>

        <% } %>

        <% if ("changed".equals(success)) { %>

            <div class="message success">
                Password successfully change ho gaya.
            </div>

        <% } %>

        <form
            action="<%= request.getContextPath() %>/ChangePasswordServlet"
            method="post"
            onsubmit="return validatePassword()">

            <div class="input-box">

                <label>Old Password</label>

                <div class="password-field">

                    <input
                        type="password"
                        id="oldPassword"
                        name="oldPassword"
                        placeholder="Enter Old Password"
                        required>

                    <button
                        type="button"
                        class="show-btn"
                        onclick="togglePassword('oldPassword',this)">
                        👁
                    </button>

                </div>

            </div>

            <div class="input-box">

                <label>New Password</label>

                <div class="password-field">

                    <input
                        type="password"
                        id="newPassword"
                        name="newPassword"
                        placeholder="Minimum 8 characters"
                        minlength="8"
                        required>

                    <button
                        type="button"
                        class="show-btn"
                        onclick="togglePassword('newPassword',this)">
                        👁
                    </button>

                </div>

            </div>

            <div class="input-box">

                <label>Confirm New Password</label>

                <div class="password-field">

                    <input
                        type="password"
                        id="confirmPassword"
                        name="confirmPassword"
                        placeholder="Confirm New Password"
                        minlength="8"
                        required>

                    <button
                        type="button"
                        class="show-btn"
                        onclick="togglePassword('confirmPassword',this)">
                        👁
                    </button>

                </div>

            </div>

            <button class="btn" type="submit">
                Change Password
            </button>

        </form>

    </div>

</div>

<script>

function validatePassword(){

    let oldPassword =
        document.getElementById("oldPassword").value;

    let newPassword =
        document.getElementById("newPassword").value;

    let confirmPassword =
        document.getElementById("confirmPassword").value;

    if(oldPassword.trim() === ""
            || newPassword.trim() === ""
            || confirmPassword.trim() === ""){

        alert("Sabhi fields bharo");
        return false;
    }

    if(newPassword.length < 8){

        alert("New password minimum 8 characters ka hona chahiye");
        return false;
    }

    if(oldPassword === newPassword){

        alert("New password old password jaisa nahi hona chahiye");
        return false;
    }

    if(newPassword !== confirmPassword){

        alert("New password aur confirm password match nahi kar rahe");
        return false;
    }

    return true;
}

function togglePassword(inputId,button){

    let input = document.getElementById(inputId);

    if(input.type === "password"){

        input.type = "text";
        button.innerHTML = "🙈";

    }else{

        input.type = "password";
        button.innerHTML = "👁";
    }
}

</script>

</body>

</html>