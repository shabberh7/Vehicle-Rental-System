<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String profileName =
            (String) request.getAttribute("profileName");

    String profileEmail =
            (String) request.getAttribute("profileEmail");

    String profileMobile =
            (String) request.getAttribute("profileMobile");

    String profileAddress =
            (String) request.getAttribute("profileAddress");

    if (profileName == null) {

        response.sendRedirect(
                request.getContextPath()
                + "/ProfileServlet?page=edit"
        );

        return;
    }

    if (profileEmail == null) {
        profileEmail = "";
    }

    if (profileMobile == null) {
        profileMobile = "";
    }

    if (profileAddress == null) {
        profileAddress = "";
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Edit Profile</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
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
    box-shadow:0 0 25px rgba(0,0,0,.5);
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
    max-width:900px;
    margin:50px auto;
}

.box{
    background:rgba(255,255,255,.12);
    backdrop-filter:blur(20px);
    padding:40px;
    border-radius:30px;
    box-shadow:0 0 30px rgba(0,0,0,.5);
}

.box h1{
    text-align:center;
    color:#00ffcc;
    margin-bottom:35px;
}

.input-box{
    margin-bottom:22px;
}

.input-box label{
    display:block;
    margin-bottom:8px;
    font-size:17px;
    font-weight:bold;
}

.input-box input,
.input-box textarea{
    width:100%;
    padding:15px;
    border:2px solid transparent;
    outline:none;
    border-radius:15px;
    font-size:17px;
    transition:.3s;
}

.input-box input:focus,
.input-box textarea:focus{
    border-color:#00ffcc;
    box-shadow:0 0 15px rgba(0,255,204,.3);
}

.input-box input[readonly]{
    background:#dfe6e9;
    color:#636e72;
    cursor:not-allowed;
}

textarea{
    resize:none;
    height:120px;
}

.btn-row{
    display:flex;
    gap:20px;
    margin-top:30px;
}

.btn{
    flex:1;
    padding:17px;
    border:none;
    border-radius:30px;
    font-size:18px;
    font-weight:bold;
    cursor:pointer;
    transition:.3s;
}

.save-btn{
    background:#00ffcc;
    color:#141e30;
}

.save-btn:hover{
    background:#00c9a7;
    transform:scale(1.03);
}

.cancel-btn{
    background:rgba(255,255,255,.14);
    color:white;
    border:1px solid rgba(255,255,255,.35);
}

.cancel-btn:hover{
    background:rgba(255,255,255,.25);
    transform:scale(1.03);
}

@media(max-width:700px){

    .navbar{
        flex-direction:column;
        gap:18px;
        text-align:center;
    }

    .navbar a{
        display:inline-block;
        margin:6px;
    }

    .box{
        padding:25px;
    }

    .btn-row{
        flex-direction:column;
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

        <a href="<%= request.getContextPath() %>/VehicleServlet">
            Vehicles
        </a>

        <a href="<%= request.getContextPath() %>/MyBookingsServlet">
            My Bookings
        </a>

        <a href="<%= request.getContextPath() %>/ProfileServlet">
            Profile
        </a>

    </div>

</div>

<div class="container">

    <div class="box">

        <h1>Edit Profile</h1>

        <form
            action="<%= request.getContextPath() %>/EditProfileServlet"
            method="post"
            onsubmit="return validateProfileForm()">

            <div class="input-box">

                <label>Full Name</label>

                <input
                    type="text"
                    id="name"
                    name="name"
                    value="<%= profileName %>"
                    maxlength="50"
                    required>

            </div>

            <div class="input-box">

                <label>Email</label>

                <input
                    type="email"
                    name="email"
                    value="<%= profileEmail %>"
                    readonly>

            </div>

            <div class="input-box">

                <label>Mobile Number</label>

                <input
                    type="text"
                    id="mobile"
                    name="mobile"
                    value="<%= profileMobile %>"
                    maxlength="10"
                    required>

            </div>

            <div class="input-box">

                <label>Address</label>

                <textarea
                    id="address"
                    name="address"
                    maxlength="250"
                    required><%= profileAddress %></textarea>

            </div>

            <div class="btn-row">

                <button
                    type="submit"
                    class="btn save-btn">

                    Save Profile

                </button>

                <button
                    type="button"
                    class="btn cancel-btn"
                    onclick="window.location.href=
                    '<%= request.getContextPath() %>/ProfileServlet'">

                    Cancel

                </button>

            </div>

        </form>

    </div>

</div>

<script>

function validateProfileForm(){

    let name =
        document.getElementById("name").value.trim();

    let mobile =
        document.getElementById("mobile").value.trim();

    let address =
        document.getElementById("address").value.trim();

    let namePattern = /^[A-Za-z ]+$/;

    let mobilePattern = /^[0-9]{10}$/;

    if(name === ""){

        alert("Name enter karo");
        return false;
    }

    if(!namePattern.test(name)){

        alert("Name me sirf alphabets aur spaces allowed hain");
        return false;
    }

    if(!mobilePattern.test(mobile)){

        alert("Mobile number exactly 10 digits ka hona chahiye");
        return false;
    }

    if(address === ""){

        alert("Address enter karo");
        return false;
    }

    return true;
}

</script>

</body>

</html>