<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    String profileName =
            (String) request.getAttribute("profileName");

    String profileEmail =
            (String) request.getAttribute("profileEmail");

    String profileMobile =
            (String) request.getAttribute("profileMobile");

    String profileAddress =
            (String) request.getAttribute("profileAddress");

    Timestamp createdAt =
            (Timestamp) request.getAttribute("createdAt");

    String errorMessage =
            (String) request.getAttribute("errorMessage");

    String memberSince = "Not Available";

    if (createdAt != null) {
        SimpleDateFormat format =
                new SimpleDateFormat("dd MMMM yyyy");

        memberSince = format.format(createdAt);
    }

    if (profileName == null) {
        response.sendRedirect(
                request.getContextPath() + "/ProfileServlet"
        );

        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Profile</title>

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
    max-width:1200px;
    margin:40px auto;
}

.profile-box{
    display:grid;
    grid-template-columns:350px 1fr;
    gap:40px;
    background:rgba(255,255,255,.12);
    backdrop-filter:blur(20px);
    padding:40px;
    border-radius:30px;
    box-shadow:0 0 30px rgba(0,0,0,.5);
}

.left{
    text-align:center;
}

.profile-circle{
    width:220px;
    height:220px;
    margin:auto;
    border-radius:50%;
    border:6px solid #00ffcc;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#00ffcc,#00a88a);
    color:#141e30;
    font-size:80px;
    font-weight:bold;
    box-shadow:0 0 30px rgba(0,255,204,.45);
}

.left h2{
    margin-top:20px;
    font-size:30px;
    color:#00ffcc;
}

.left p{
    margin-top:10px;
    font-size:18px;
    color:#dfe6e9;
}

.right h1{
    color:#00ffcc;
    margin-bottom:30px;
}

.info{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:20px;
}

.card{
    background:rgba(255,255,255,.10);
    padding:20px;
    border-radius:18px;
}

.card h3{
    color:#00ffcc;
    margin-bottom:10px;
}

.card p{
    font-size:18px;
    word-break:break-word;
}

.btns{
    margin-top:40px;
    display:flex;
    gap:20px;
}

.btn{
    flex:1;
    padding:18px;
    border:none;
    border-radius:30px;
    font-size:18px;
    font-weight:bold;
    cursor:pointer;
    background:#00ffcc;
    color:#141e30;
    transition:.3s;
}

.btn:hover{
    background:#00c9a7;
    transform:scale(1.03);
}

.error-message{
    margin-bottom:25px;
    padding:16px;
    border-radius:15px;
    text-align:center;
    background:rgba(255,77,77,.18);
    border:1px solid #ff4d4d;
    color:#ff7676;
    font-weight:bold;
}

@media(max-width:900px){

    .navbar{
        flex-direction:column;
        gap:20px;
        text-align:center;
    }

    .navbar a{
        display:inline-block;
        margin:7px;
    }

    .profile-box{
        grid-template-columns:1fr;
    }

    .info{
        grid-template-columns:1fr;
    }
}

@media(max-width:550px){

    .btns{
        flex-direction:column;
    }

    .profile-circle{
        width:180px;
        height:180px;
        font-size:65px;
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

        <a href="<%= request.getContextPath() %>/login.jsp">
            Logout
        </a>

    </div>

</div>

<div class="container">

    <% if (errorMessage != null) { %>

        <div class="error-message">
            <%= errorMessage %>
        </div>

    <% } %>

    <div class="profile-box">

        <div class="left">

            <div class="profile-circle">
                <%= profileName.substring(0,1).toUpperCase() %>
            </div>

            <h2>
                <%= profileName %>
            </h2>

            <p>Premium Member</p>

        </div>

        <div class="right">

            <h1>My Profile</h1>

            <div class="info">

                <div class="card">
                    <h3>Full Name</h3>
                    <p><%= profileName %></p>
                </div>

                <div class="card">
                    <h3>Email</h3>
                    <p><%= profileEmail %></p>
                </div>

                <div class="card">
                    <h3>Mobile</h3>
                    <p><%= profileMobile %></p>
                </div>

                <div class="card">
                    <h3>Address</h3>

                    <p>
                        <%= profileAddress == null
                            || profileAddress.trim().isEmpty()
                            ? "Not Added"
                            : profileAddress
                        %>
                    </p>
                </div>

                <div class="card">
                    <h3>Member Since</h3>
                    <p><%= memberSince %></p>
                </div>

                <div class="card">
                    <h3>Account Status</h3>
                    <p>Active</p>
                </div>

            </div>

            <div class="btns">

                <button
                    type="button"
                    class="btn"
                   onclick="window.location.href=
'<%= request.getContextPath() %>/ProfileServlet?page=edit'"

                    Edit Profile

                </button>

                <button
                    type="button"
                    class="btn"
                    onclick="window.location.href=
                    '<%= request.getContextPath() %>/change-password.jsp'">

                    Change Password

                </button>

            </div>

        </div>

    </div>

</div>

</body>

</html>