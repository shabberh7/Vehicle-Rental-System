<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>

<title>LuxuryDrive | Vehicle Rental</title>

<style>

@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700;900&display=swap');


*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}


body{
    background:#050505;
    color:white;
    overflow-x:hidden;
}


/* NAVBAR */

.navbar{

    position:fixed;
    top:0;
    width:100%;
    padding:25px 8%;
    display:flex;
    justify-content:space-between;
    align-items:center;
    z-index:100;

    background:rgba(0,0,0,0.4);
    backdrop-filter:blur(15px);

}


.logo{

    font-size:32px;
    font-weight:900;
    color:#00f5ff;

}



.navbar ul{

    display:flex;
    gap:35px;
    list-style:none;

}


.navbar a{

    color:white;
    text-decoration:none;
    font-size:17px;
    transition:.3s;

}


.navbar a:hover{

    color:#00f5ff;

}



/* HERO */


.hero{

    height:100vh;

    display:flex;
    align-items:center;
    justify-content:center;

    text-align:center;

    position:relative;

    background:

    radial-gradient(circle at top,#1c1c1c,#000 70%);

}



.car-light{

    position:absolute;
    width:700px;
    height:700px;

    background:#00f5ff;

    filter:blur(180px);

    opacity:.15;

}



.hero-content{

    z-index:2;

}



.hero h1{

    font-size:90px;
    font-weight:900;

    letter-spacing:3px;

    background:linear-gradient(90deg,#fff,#00f5ff);

    -webkit-background-clip:text;

    color:transparent;

}



.hero p{

    margin-top:20px;

    font-size:25px;
    color:#ccc;

}



.btn{

    margin-top:40px;

    padding:18px 50px;

    border-radius:50px;

    border:2px solid #00f5ff;

    background:transparent;

    color:white;

    font-size:18px;

    cursor:pointer;

    transition:.4s;

}



.btn:hover{

    background:#00f5ff;

    color:black;

    transform:scale(1.1);

}




/* VEHICLE SECTION */


.section{

    padding:80px 8%;

}



.title{

    text-align:center;

    font-size:45px;

    margin-bottom:50px;

}



.cards{

    display:flex;

    justify-content:center;

    gap:30px;

}



.card{

    width:300px;

    height:350px;

    border-radius:25px;

    padding:30px;

    background:

    linear-gradient(145deg,#111,#050505);

    border:1px solid #222;

    transition:.5s;

}



.card:hover{

    transform:translateY(-20px);

    box-shadow:0 0 40px #00f5ff;

}



.card h2{

    color:#00f5ff;

    margin-top:100px;

}



.card p{

    color:#bbb;

    margin-top:15px;

}



/* FOOTER */


footer{

    padding:30px;

    text-align:center;

    background:#000;

    color:#888;

}



/* MOBILE */

@media(max-width:900px){

.hero h1{

font-size:45px;

}

.cards{

flex-direction:column;
align-items:center;

}

}



</style>



<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vehicle-theme.css">
</head>


<body>



<div class="navbar">


<div class="logo">
🚘 LUXURY DRIVE
</div>


<ul>

<li><a href="#">Home</a></li>

<li><a href="#">Cars</a></li>

<li><a href="#">Booking</a></li>

<li><a href="#">Login</a></li>

<li><a href="#">Admin</a></li>


</ul>


</div>





<section class="hero">


<div class="car-light"></div>


<div class="hero-content">


<h1>
MOVE WITHOUT LIMITS
</h1>


<p>
Premium Vehicle Rental Experience
</p>



<button class="btn" onclick="book()">

START YOUR JOURNEY

</button>


</div>


</section>






<section class="section">


<h1 class="title">
Choose Your Ride
</h1>



<div class="cards">


<div class="card">

<h2>SPORTS CAR</h2>

<p>
Luxury performance vehicles
</p>

</div>



<div class="card">

<h2>LUXURY SUV</h2>

<p>
Comfort with power
</p>

</div>



<div class="card">

<h2>BIKES</h2>

<p>
Ride your adventure
</p>

</div>


</div>


</section>






<footer>

LuxuryDrive © 2026 | Premium Rental System

</footer>




<script>


function book(){

alert("Welcome To LuxuryDrive Booking System 🚗");

}



</script>



</body>

</html>