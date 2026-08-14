<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Manage Bookings</title>


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
max-width:1300px;
margin:40px auto;

}



.heading{

text-align:center;
font-size:42px;
color:#00ffcc;
margin-bottom:40px;

}



.table-box{

background:rgba(255,255,255,.12);

backdrop-filter:blur(20px);

padding:30px;

border-radius:25px;

box-shadow:0 0 30px black;

overflow-x:auto;

}



table{

width:100%;
border-collapse:collapse;

}



th{

background:#00ffcc;
color:black;
padding:15px;
font-size:17px;

}



td{

padding:15px;
text-align:center;
border-bottom:1px solid rgba(255,255,255,.2);

}



.status{

padding:8px 20px;
border-radius:20px;
background:#00ffcc;
color:black;
font-weight:bold;

}



.btn{

padding:10px 20px;
border:none;
border-radius:20px;
cursor:pointer;
font-weight:bold;
background:#00ffcc;
color:black;
margin:5px;

}



.cancel{

background:#ff4d4d;
color:white;

}



.btn:hover{

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

<a href="admin-dashboard.jsp">
Dashboard
</a>

<a href="manage-vehicles.jsp">
Vehicles
</a>

</div>


</div>



<div class="container">


<h1 class="heading">

📋 Manage Bookings

</h1>



<div class="table-box">


<table>


<tr>

<th>ID</th>

<th>User Name</th>

<th>Vehicle</th>

<th>Pickup Date</th>

<th>Return Date</th>

<th>Payment</th>

<th>Status</th>

<th>Action</th>

</tr>
<tr>

<td>1</td>

<td>Rahul Sharma</td>

<td>Bugatti Chiron</td>

<td>28 July 2026</td>

<td>30 July 2026</td>

<td>Paid</td>

<td>

<span class="status">
Confirmed
</span>

</td>

<td>

<button class="btn">
Approve
</button>


<button class="btn cancel">
Cancel
</button>


</td>

</tr>




<tr>

<td>2</td>

<td>Amit Verma</td>

<td>Rolls Royce Phantom</td>

<td>05 Aug 2026</td>

<td>07 Aug 2026</td>

<td>Pending</td>

<td>

<span class="status">
Pending
</span>

</td>


<td>

<button class="btn">
Approve
</button>


<button class="btn cancel">
Cancel
</button>


</td>

</tr>





<tr>

<td>3</td>

<td>Shabber Hussain</td>

<td>Lamborghini Aventador</td>

<td>10 Aug 2026</td>

<td>12 Aug 2026</td>

<td>UPI</td>


<td>

<span class="status">
Completed
</span>

</td>


<td>

<button class="btn">
Approve
</button>


<button class="btn cancel">
Cancel
</button>


</td>


</tr>


</table>


</div>


</div>


</body>

</html>