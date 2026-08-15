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

    background:rgba(0,0,0,0.55);
    backdrop-filter:blur(15px);
    border-bottom:1px solid rgba(0,245,255,0.12);
}

.logo{
    font-size:32px;
    font-weight:900;
    color:#00f5ff;
    text-shadow:0 0 15px rgba(0,245,255,.35);
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
    position:relative;
}

.navbar a:hover{
    color:#00f5ff;
}

.navbar a::after{
    content:"";
    position:absolute;
    left:0;
    bottom:-7px;
    width:0;
    height:2px;
    background:#00f5ff;
    transition:.3s;
}

.navbar a:hover::after{
    width:100%;
}

/* HERO */

.hero{
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    text-align:center;
    position:relative;
    overflow:hidden;

    background:
    linear-gradient(rgba(0,0,0,.55),rgba(0,0,0,.72)),
    url("<%= request.getContextPath() %>/images/audi.jpg") center/cover no-repeat;
}

.hero::before{
    content:"";
    position:absolute;
    inset:0;

    background:
    radial-gradient(circle at 20% 25%, rgba(255,70,30,.20), transparent 30%),
    radial-gradient(circle at 80% 70%, rgba(0,245,255,.18), transparent 30%);
}

.car-light{
    position:absolute;
    width:650px;
    height:650px;
    background:#00f5ff;
    filter:blur(180px);
    opacity:.12;
}

.hero-content{
    z-index:2;
    padding:30px;
}

.hero h1{
    font-size:85px;
    font-weight:900;
    letter-spacing:3px;
    line-height:1.05;

    background:linear-gradient(90deg,#fff,#00f5ff);
    -webkit-background-clip:text;
    color:transparent;

    text-shadow:0 15px 50px rgba(0,0,0,.7);
}

.hero p{
    margin-top:20px;
    font-size:24px;
    color:#d3d3d3;
}

.btn{
    margin-top:40px;
    padding:18px 50px;
    border-radius:50px;
    border:2px solid #00f5ff;
    background:rgba(0,0,0,.35);
    color:white;
    font-size:18px;
    cursor:pointer;
    transition:.4s;
    box-shadow:0 0 25px rgba(0,245,255,.10);
}

.btn:hover{
    background:#00f5ff;
    color:black;
    transform:translateY(-4px) scale(1.05);
    box-shadow:0 0 35px rgba(0,245,255,.45);
}

/* VEHICLE SECTION */

.section{
    padding:100px 8%;
    background:
    linear-gradient(rgba(5,5,5,.95),rgba(5,5,5,.95)),
    url("<%= request.getContextPath() %>/images/car-bg.jpg") center/cover fixed;
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
    flex-wrap:wrap;
}

.card{
    width:300px;
    min-height:350px;
    border-radius:25px;
    padding:30px;
    background:linear-gradient(145deg,#111,#050505);
    border:1px solid #222;
    transition:.5s;
    cursor:pointer;
    position:relative;
    overflow:hidden;
}

.card::before{
    content:"";
    position:absolute;
    width:150px;
    height:150px;
    background:#00f5ff;
    filter:blur(90px);
    opacity:.06;
    top:-30px;
    right:-30px;
}

.card:hover{
    transform:translateY(-15px);
    box-shadow:0 0 35px rgba(0,245,255,.25);
    border-color:rgba(0,245,255,.35);
}

.card h2{
    color:#00f5ff;
    margin-top:100px;
}

.card p{
    color:#bbb;
    margin-top:15px;
}

.card-link{
    text-decoration:none;
    color:inherit;
}

/* FOOTER */

footer{
    padding:30px;
    text-align:center;
    background:#000;
    color:#888;
    border-top:1px solid #161616;
}

/* MOBILE */

@media(max-width:900px){

    .navbar{
        padding:18px 5%;
        flex-direction:column;
        gap:15px;
    }

    .navbar ul{
        gap:15px;
        flex-wrap:wrap;
        justify-content:center;
    }

    .logo{
        font-size:25px;
    }

    .hero h1{
        font-size:45px;
    }

    .hero p{
        font-size:18px;
    }

    .cards{
        flex-direction:column;
        align-items:center;
    }

}

</style>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/vehicle-theme.css">

</head>

<body>

<div class="navbar">

    <div class="logo">
        🚘 LUXURY DRIVE
    </div>

    <ul>

        <li>
            <a href="<%= request.getContextPath() %>/Home.jsp">
                Home
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/vehicle.jsp">
                Cars
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/my-bookings.jsp">
                Booking
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/login.jsp">
                Login
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/admin-login.jsp">
                Admin
            </a>
        </li>

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

        <button class="btn"
                onclick="window.location.href='<%= request.getContextPath() %>/vehicle.jsp'">

            START YOUR JOURNEY

        </button>

    </div>

</section>

<section class="section">

    <h1 class="title">
        Choose Your Ride
    </h1>

    <div class="cards">

        <a class="card-link"
           href="<%= request.getContextPath() %>/vehicle.jsp">

            <div class="card">

                <h2>SPORTS CAR</h2>

                <p>
                    Luxury performance vehicles
                </p>

            </div>

        </a>

        <a class="card-link"
           href="<%= request.getContextPath() %>/vehicle.jsp">

            <div class="card">

                <h2>LUXURY SUV</h2>

                <p>
                    Comfort with power
                </p>

            </div>

        </a>

        <a class="card-link"
           href="<%= request.getContextPath() %>/vehicle.jsp">

            <div class="card">

                <h2>BIKES</h2>

                <p>
                    Ride your adventure
                </p>

            </div>

        </a>

    </div>

</section>

<footer>

    LuxuryDrive © 2026 | Premium Rental System

</footer>

</body>
</html>
