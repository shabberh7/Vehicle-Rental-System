<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>LuxeDrive | Login</title>

<style>

@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap');

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Montserrat',sans-serif;
}

body{
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    overflow:hidden;
    color:white;
    background:
        linear-gradient(
            90deg,
            rgba(3,10,20,0.97) 0%,
            rgba(3,10,20,0.90) 38%,
            rgba(3,10,20,0.45) 70%,
            rgba(3,10,20,0.30) 100%
        ),
        url("images/cars/bugatti.jpg") center/cover no-repeat;
    position:relative;
}

/* Background decorative glow */

body::before{
    content:"";
    position:absolute;
    width:500px;
    height:500px;
    border-radius:50%;
    background:rgba(0,255,204,0.16);
    filter:blur(110px);
    top:-180px;
    left:-150px;
}

body::after{
    content:"";
    position:absolute;
    width:450px;
    height:450px;
    border-radius:50%;
    background:rgba(0,119,255,0.17);
    filter:blur(120px);
    right:-150px;
    bottom:-180px;
}

.page-wrapper{
    width:100%;
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:flex-start;
    padding:50px 8%;
    position:relative;
    z-index:2;
}

.login-container{
    width:100%;
    max-width:480px;
}

.brand{
    display:flex;
    align-items:center;
    gap:13px;
    margin-bottom:24px;
}

.brand-icon{
    width:52px;
    height:52px;
    display:flex;
    justify-content:center;
    align-items:center;
    border-radius:15px;
    background:linear-gradient(135deg,#00ffcc,#00a8ff);
    color:#031018;
    font-size:25px;
    box-shadow:0 0 25px rgba(0,255,204,0.35);
}

.brand-name{
    font-size:28px;
    font-weight:800;
    letter-spacing:1px;
}

.brand-name span{
    color:#00ffcc;
}

.login-box{
    width:100%;
    padding:38px;
    background:rgba(7,18,31,0.72);
    border:1px solid rgba(255,255,255,0.13);
    backdrop-filter:blur(18px);
    -webkit-backdrop-filter:blur(18px);
    border-radius:26px;
    box-shadow:
        0 25px 70px rgba(0,0,0,0.55),
        inset 0 1px 0 rgba(255,255,255,0.08);
    animation:pageEntry 0.8s ease;
}

@keyframes pageEntry{
    from{
        opacity:0;
        transform:translateY(30px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

.login-header{
    margin-bottom:28px;
}

.login-header h1{
    font-size:36px;
    font-weight:800;
    margin-bottom:10px;
}

.login-header h1 span{
    color:#00ffcc;
}

.login-header p{
    color:#aab7c4;
    font-size:14px;
    line-height:1.6;
}

.input-box{
    position:relative;
    margin-bottom:18px;
}

.input-box label{
    display:block;
    margin-bottom:9px;
    font-size:13px;
    font-weight:600;
    color:#d8e2eb;
}

.input-wrapper{
    position:relative;
}

.input-icon{
    position:absolute;
    left:16px;
    top:50%;
    transform:translateY(-50%);
    font-size:18px;
    color:#00ffcc;
    pointer-events:none;
}

.input-box input{
    width:100%;
    padding:15px 48px 15px 48px;
    border:1px solid rgba(255,255,255,0.13);
    outline:none;
    border-radius:14px;
    font-size:14px;
    color:white;
    background:rgba(255,255,255,0.07);
    transition:0.3s;
}

.input-box input::placeholder{
    color:#8795a2;
}

.input-box input:focus{
    border-color:#00ffcc;
    background:rgba(255,255,255,0.10);
    box-shadow:0 0 0 4px rgba(0,255,204,0.10);
}

.password-toggle{
    position:absolute;
    right:15px;
    top:50%;
    transform:translateY(-50%);
    background:none;
    border:none;
    width:auto;
    padding:4px;
    color:#aebac5;
    font-size:17px;
    cursor:pointer;
}

.password-toggle:hover{
    color:#00ffcc;
    transform:translateY(-50%);
    background:none;
}

.form-row{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin:4px 0 22px;
    gap:15px;
}

.remember-box{
    display:flex;
    align-items:center;
    gap:8px;
    color:#b8c4ce;
    font-size:13px;
}

.remember-box input{
    accent-color:#00ffcc;
    cursor:pointer;
}

.forgot-link{
    color:#00ffcc;
    text-decoration:none;
    font-size:13px;
    font-weight:600;
}

.forgot-link:hover{
    text-decoration:underline;
}

.login-btn{
    width:100%;
    padding:15px;
    border:none;
    border-radius:14px;
    background:linear-gradient(90deg,#00ffcc,#00b7ff);
    color:#031018;
    font-size:16px;
    font-weight:800;
    cursor:pointer;
    transition:0.3s;
    box-shadow:0 10px 25px rgba(0,255,204,0.20);
}

.login-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 15px 32px rgba(0,255,204,0.32);
}

.login-btn:active{
    transform:translateY(0);
}

.divider{
    display:flex;
    align-items:center;
    gap:12px;
    margin:25px 0 20px;
    color:#7e8d99;
    font-size:12px;
}

.divider::before,
.divider::after{
    content:"";
    flex:1;
    height:1px;
    background:rgba(255,255,255,0.13);
}

.register-text{
    text-align:center;
    color:#aab6c1;
    font-size:14px;
}

.register-text a{
    color:#00ffcc;
    font-weight:700;
    text-decoration:none;
}

.register-text a:hover{
    text-decoration:underline;
}

.error-message,
.success-message{
    padding:12px 14px;
    border-radius:12px;
    text-align:center;
    margin-bottom:20px;
    font-size:13px;
    font-weight:600;
    animation:messageEntry 0.4s ease;
}

@keyframes messageEntry{
    from{
        opacity:0;
        transform:translateY(-10px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

.error-message{
    background:rgba(255,61,87,0.13);
    color:#ff8b9c;
    border:1px solid rgba(255,61,87,0.28);
}

.success-message{
    background:rgba(0,255,204,0.11);
    color:#35ffd7;
    border:1px solid rgba(0,255,204,0.25);
}

.bottom-text{
    margin-top:18px;
    text-align:center;
    color:#7e8d99;
    font-size:11px;
}

@media(max-width:700px){

    body{
        background:
            linear-gradient(rgba(3,10,20,0.88),rgba(3,10,20,0.92)),
            url("images/cars/bugatti.jpg") center/cover no-repeat;
        overflow:auto;
    }

    .page-wrapper{
        justify-content:center;
        padding:30px 18px;
    }

    .login-box{
        padding:28px 22px;
    }

    .login-header h1{
        font-size:30px;
    }

    .brand{
        justify-content:center;
    }

    .form-row{
        flex-direction:column;
        align-items:flex-start;
    }
}

</style>


<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vehicle-theme.css">
</head>

<body>

<div class="page-wrapper">

    <div class="login-container">

        <div class="brand">

            <div class="brand-icon">
                ?
            </div>

            <div class="brand-name">
                LUXE<span>DRIVE</span>
            </div>

        </div>

        <div class="login-box">

            <div class="login-header">

                <h1>
                    Welcome <span>Back</span>
                </h1>

                <p>
                    Login to explore premium vehicles and manage your luxury
                    rental experience.
                </p>

            </div>

            <%
                String error = request.getParameter("error");
                String success = request.getParameter("success");

                if(success != null && success.equals("registered")){
            %>

            <div class="success-message">
                ? Registration successful. Please login to continue.
            </div>

            <%
                }

                if(error != null){
            %>

            <div class="error-message">

                <%
                    if(error.equals("empty")){
                        out.print("Please fill in all required fields.");
                    }
                    else if(error.equals("invalid")){
                        out.print("Invalid email address or password.");
                    }
                    else{
                        out.print("Server error. Please try again.");
                    }
                %>

            </div>

            <%
                }
            %>

            <form action="LoginServlet"
                  method="post"
                  onsubmit="return loginCheck()">

                <div class="input-box">

                    <label for="email">
                        Email Address
                    </label>

                    <div class="input-wrapper">

                        <span class="input-icon">
                            ?
                        </span>

                        <input type="email"
                               id="email"
                               name="email"
                               placeholder="Enter your email address"
                               autocomplete="email">

                    </div>

                </div>

                <div class="input-box">

                    <label for="password">
                        Password
                    </label>

                    <div class="input-wrapper">

                        <span class="input-icon">
                            ?
                        </span>

                        <input type="password"
                               id="password"
                               name="password"
                               placeholder="Enter your password"
                               autocomplete="current-password">

                        <button type="button"
                                class="password-toggle"
                                onclick="togglePassword()"
                                id="toggleButton">
                            ?
                        </button>

                    </div>

                </div>

                <div class="form-row">

                    <label class="remember-box">

                        <input type="checkbox"
                               name="remember">

                        Remember me

                    </label>

                    <a href="forgot-password.jsp"
                       class="forgot-link">
                        Forgot Password?
                    </a>

                </div>

                <button type="submit"
                        class="login-btn">
                    LOGIN TO LUXEDRIVE
                </button>

                <div class="divider">
                    NEW TO LUXEDRIVE?
                </div>

                <div class="register-text">

                    Don't have an account?

                    <a href="register.jsp">
                        Create Account
                    </a>

                </div>

            </form>

        </div>

        <div class="bottom-text">
             2026 LuxeDrive. Premium journeys begin here.
        </div>

    </div>

</div>

<script>

function loginCheck(){

    let email = document.getElementById("email").value.trim();
    let password = document.getElementById("password").value.trim();

    if(email === "" && password === ""){

        alert("Please enter email and password.");
        return false;
    }

    if(email === ""){

        alert("Please enter your email address.");
        document.getElementById("email").focus();
        return false;
    }

    if(password === ""){

        alert("Please enter your password.");
        document.getElementById("password").focus();
        return false;
    }

    return true;
}

function togglePassword(){

    let passwordInput =
        document.getElementById("password");

    let toggleButton =
        document.getElementById("toggleButton");

    if(passwordInput.type === "password"){

        passwordInput.type = "text";
        toggleButton.innerHTML = "?";
    }
    else{

        passwordInput.type = "password";
        toggleButton.innerHTML = "?";
    }
}

</script>

</body>
</html>