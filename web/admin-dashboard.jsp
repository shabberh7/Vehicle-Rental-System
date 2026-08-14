<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Admin Dashboard</title>


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

background:rgba(255,255,255,0.12);

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

max-width:1200px;

margin:40px auto;

}



.heading{

text-align:center;

font-size:42px;

color:#00ffcc;

margin-bottom:40px;

}



.cards{

display:grid;

grid-template-columns:repeat(auto-fit,minmax(250px,1fr));

gap:30px;

}



.card{

background:rgba(255,255,255,0.12);

backdrop-filter:blur(20px);

padding:35px;

border-radius:25px;

text-align:center;

box-shadow:0 0 25px black;

transition:.3s;

}



.card:hover{

transform:translateY(-10px);

}



.icon{

font-size:50px;

margin-bottom:20px;

}



.card h2{

color:#00ffcc;

margin-bottom:15px;

}



.card p{

font-size:17px;

color:#ddd;

}



.btn{

display:inline-block;

margin-top:20px;

padding:14px 30px;

background:#00ffcc;

color:black;

text-decoration:none;

border-radius:30px;

font-weight:bold;

transition:.3s;

}



.btn:hover{

background:#00c7a3;

transform:scale(1.05);

}


</style>



<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vehicle-theme.css">
</head>


<body>


<div class="navbar">


<div class="logo">

🚘 LuxeDrive Admin

</div>


<div>

<a href="Deshboard.jsp">User Panel</a>

<a href="login.jsp">Logout</a>

</div>


</div>


<div class="container">


<h1 class="heading">

👑 Admin Dashboard

</h1>


<div class="cards">


<div class="card">

<div class="icon">
🚘
</div>

<h2>Add Vehicle</h2>

<p>
Add new luxury cars to rental system.
</p>

<a href="add-vehicle.jsp" class="btn">
Open
</a>

</div>


<div class="card">

<div class="icon">
🚗
</div>

<h2>Manage Vehicles</h2>

<p>
Update or delete vehicle details.
</p>

<a href="manage-vehicles.jsp" class="btn">
Open
</a>

</div>
    <div class="card">

<div class="icon">
📋
</div>

<h2>Manage Bookings</h2>

<p>
Check customer bookings and status.
</p>

<a href="<%= request.getContextPath() %>/admin-booking.jsp">
    open 
</a>
</div>



<div class="card">

<div class="icon">
👥
</div>

<h2>Manage Users</h2>

<p>
View registered users details.
</p>

<a href="manage-users.jsp" class="btn">
Open
</a>

</div>



<div class="card">

<div class="icon">
📊
</div>

<h2>Reports</h2>

<p>
View rental system reports.
</p>

<a href="#" class="btn">
Open
</a>

</div>



</div>

</div>


</body>

</html>