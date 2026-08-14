<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Luxury Vehicle Dashboard</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',Arial,sans-serif;
}

body{
    min-height:100vh;
    background:
        radial-gradient(circle at top left,
        rgba(0,255,204,0.13),
        transparent 35%),
        radial-gradient(circle at bottom right,
        rgba(52,152,219,0.16),
        transparent 35%),
        linear-gradient(135deg,#08111f,#142238,#243b55);

    color:white;
}

/* SIDEBAR */

.sidebar{
    position:fixed;
    top:0;
    left:0;
    width:260px;
    height:100vh;
    background:rgba(255,255,255,0.10);
    backdrop-filter:blur(20px);
    padding:30px;
    box-shadow:10px 0 35px rgba(0,0,0,0.45);
    border-right:1px solid rgba(255,255,255,0.10);
    z-index:1000;
}

.logo{
    font-size:30px;
    color:#00ffcc;
    font-weight:bold;
    margin-bottom:40px;
    text-shadow:0 0 18px rgba(0,255,204,0.55);
}

.sidebar a{
    display:block;
    padding:15px;
    margin:15px 0;
    color:white;
    text-decoration:none;
    border-radius:15px;
    transition:0.3s;
}

.sidebar a:hover{
    background:#00ffcc;
    color:black;
    transform:translateX(10px);
    box-shadow:0 0 20px rgba(0,255,204,0.40);
}

/* MAIN */

.main{
    margin-left:260px;
    padding:30px;
}

/* TOPBAR */

.topbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    background:rgba(255,255,255,0.10);
    padding:20px 30px;
    border-radius:25px;
    backdrop-filter:blur(20px);
    border:1px solid rgba(255,255,255,0.10);
    box-shadow:0 15px 35px rgba(0,0,0,0.30);
}

.search input{
    padding:14px 20px;
    width:280px;
    border:none;
    outline:none;
    border-radius:20px;
    font-size:15px;
    background:rgba(255,255,255,0.95);
}

/* WELCOME */

.welcome{
    margin-top:30px;
    padding:35px;
    border-radius:30px;
    background:rgba(255,255,255,0.10);
    backdrop-filter:blur(20px);
    border:1px solid rgba(255,255,255,0.10);
    box-shadow:0 18px 45px rgba(0,0,0,0.30);
}

.welcome h1{
    font-size:42px;
}

.welcome span{
    color:#00ffcc;
    text-shadow:0 0 18px rgba(0,255,204,0.50);
}

.welcome p{
    margin-top:10px;
    color:#d7dde5;
}

/* STATS */

.stats{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:25px;
    margin-top:30px;
}

.stat{
    padding:25px;
    border-radius:25px;
    background:rgba(255,255,255,0.10);
    text-align:center;
    backdrop-filter:blur(20px);
    transition:0.4s;
    border:1px solid rgba(255,255,255,0.10);
    box-shadow:0 15px 35px rgba(0,0,0,0.28);
}

.stat:hover{
    transform:translateY(-10px);
    border-color:rgba(0,255,204,0.45);
}

.stat h2{
    color:#00ffcc;
    font-size:35px;
}

/* TITLE */

.title{
    margin:40px 0 25px;
    font-size:35px;
}

/* CAR SECTION */

.cars{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:30px;
}

.car{
    background:rgba(255,255,255,0.10);
    border-radius:30px;
    overflow:hidden;
    backdrop-filter:blur(20px);
    transition:0.4s;
    box-shadow:0 18px 40px rgba(0,0,0,0.50);
    border:1px solid rgba(255,255,255,0.10);
}

.car:hover{
    transform:translateY(-15px) scale(1.02);
    border-color:rgba(0,255,204,0.45);
    box-shadow:
        0 25px 55px rgba(0,0,0,0.65),
        0 0 30px rgba(0,255,204,0.15);
}

.car-image{
    width:100%;
    height:230px;
    overflow:hidden;
    position:relative;
}

.car-image::after{
    content:"";
    position:absolute;
    left:0;
    right:0;
    bottom:0;
    height:70px;
    background:linear-gradient(
        transparent,
        rgba(5,15,25,0.80)
    );
}

.car img{
    width:100%;
    height:100%;
    object-fit:cover;
    display:block;
    transition:0.5s;
}

.car:hover img{
    transform:scale(1.08);
}

.car-content{
    padding:25px;
}

.car h2{
    color:#00ffcc;
    font-size:25px;
}

.price{
    font-size:22px;
    margin:15px 0;
    font-weight:bold;
}

.details{
    display:flex;
    justify-content:space-between;
    gap:12px;
}

.details span{
    width:48%;
    padding:10px;
    border-radius:12px;
    background:rgba(255,255,255,0.07);
    font-size:14px;
}

.book-btn{
    margin-top:20px;
    width:100%;
    padding:14px;
    border:none;
    border-radius:20px;
    background:#00ffcc;
    color:black;
    font-weight:bold;
    cursor:pointer;
    font-size:17px;
    transition:0.3s;
}

.book-btn:hover{
    background:#00b894;
    color:white;
    transform:translateY(-2px);
    box-shadow:0 0 22px rgba(0,255,204,0.40);
}

/* RESPONSIVE */

@media(max-width:1100px){

    .stats{
        grid-template-columns:repeat(2,1fr);
    }

    .cars{
        grid-template-columns:repeat(2,1fr);
    }
}

@media(max-width:750px){

    .sidebar{
        position:relative;
        width:100%;
        height:auto;
    }

    .main{
        margin-left:0;
        padding:20px;
    }

    .topbar{
        flex-direction:column;
        gap:20px;
    }

    .search input{
        width:100%;
    }

    .stats{
        grid-template-columns:1fr;
    }

    .cars{
        grid-template-columns:1fr;
    }

    .welcome h1{
        font-size:30px;
    }
}

</style>


<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vehicle-theme.css">
</head>

<body>

<div class="sidebar">

    <div class="logo">
        🚘 LuxeDrive
    </div>

    <a href="<%= request.getContextPath() %>/Deshboard.jsp">
        🏠 Dashboard
    </a>

    <a href="<%= request.getContextPath() %>/VehicleServlet">
        🚗 Luxury Cars
    </a>

    <a href="<%= request.getContextPath() %>/MyBookingsServlet">
        📅 My Booking
    </a>

    <a href="#">
        💳 Payment
    </a>

    <a href="<%= request.getContextPath() %>/ProfileServlet">
        👤 Profile
    </a>

    <a href="<%= request.getContextPath() %>/LogoutServlet">
        🚪 Logout
    </a>

</div>

<div class="main">

    <div class="topbar">

        <h2>
            Luxury Car Rental
        </h2>

        <div class="search">

            <input type="text"
                   id="search"
                   placeholder="Search Luxury Car..."
                   onkeyup="searchCar()">

        </div>

    </div>

    <div class="welcome">

        <h1>
            Welcome Back <span>Shabber</span> 👋
        </h1>

        <p>
            Experience the world's most luxurious cars with premium service.
        </p>

    </div>

    <div class="stats">

        <div class="stat">
            <h2>12+</h2>
            <p>Luxury Cars</p>
        </div>

        <div class="stat">
            <h2>850+</h2>
            <p>Bookings</p>
        </div>

        <div class="stat">
            <h2>4.9⭐</h2>
            <p>Rating</p>
        </div>

        <div class="stat">
            <h2>24/7</h2>
            <p>Support</p>
        </div>

    </div>

    <h1 class="title">
        🔥 Elite Luxury Collection
    </h1>

    <div class="cars" id="carList">

        <!-- CAR 1 -->

        <div class="car">

            <div class="car-image">

                <img src="<%= request.getContextPath() %>/images/cars/bugatti.jpg"
                     alt="Bugatti Chiron"
                     onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/images/cars/ferrari.jpg';">

            </div>

            <div class="car-content">

                <h2>Bugatti Chiron</h2>

                <p class="price">
                    ₹25,00,000 / Day
                </p>

                <div class="details">
                    <span>🏎 Hypercar</span>
                    <span>⚡ 1500 HP</span>
                </div>

                <button class="book-btn"
                        type="button"
                        onclick="bookCar(1)">
                    Book Now
                </button>

            </div>

        </div>

        <!-- CAR 2 -->

        <div class="car">

            <div class="car-image">

                <img src="<%= request.getContextPath() %>/images/cars/ferrari.jpg"
                     alt="Ferrari SF90">

            </div>

            <div class="car-content">

                <h2>Ferrari SF90</h2>

                <p class="price">
                    ₹18,00,000 / Day
                </p>

                <div class="details">
                    <span>🏎 Sports</span>
                    <span>⚡ 986 HP</span>
                </div>

                <button class="book-btn"
                        type="button"
                        onclick="bookCar(2)">
                    Book Now
                </button>

            </div>

        </div>

        <!-- CAR 3 -->

        <div class="car">

            <div class="car-image">

                <img src="<%= request.getContextPath() %>/images/cars/lamborghini.jpg"
                     alt="Lamborghini Aventador">

            </div>

            <div class="car-content">

                <h2>Lamborghini Aventador</h2>

                <p class="price">
                    ₹15,00,000 / Day
                </p>

                <div class="details">
                    <span>🔥 V12 Engine</span>
                    <span>⚡ 770 HP</span>
                </div>

                <button class="book-btn"
                        type="button"
                        onclick="bookCar(3)">
                    Book Now
                </button>

            </div>

        </div>

        <!-- CAR 4 -->

        <div class="car">

            <div class="car-image">

                <img src="<%= request.getContextPath() %>/images/cars/rollsroyce.jpg"
                     alt="Rolls Royce Phantom">

            </div>

            <div class="car-content">

                <h2>Rolls Royce Phantom</h2>

                <p class="price">
                    ₹20,00,000 / Day
                </p>

                <div class="details">
                    <span>👑 Luxury</span>
                    <span>⭐ Premium</span>
                </div>

                <button class="book-btn"
                        type="button"
                        onclick="bookCar(4)">
                    Book Now
                </button>

            </div>

        </div>

        <!-- CAR 5 -->

        <div class="car">

            <div class="car-image">

                <img src="<%= request.getContextPath() %>/images/cars/bentley.jpg"
                     alt="Bentley Continental GT">

            </div>

            <div class="car-content">

                <h2>Bentley Continental GT</h2>

                <p class="price">
                    ₹12,00,000 / Day
                </p>

                <div class="details">
                    <span>💎 Grand Tourer</span>
                    <span>⚡ 650 HP</span>
                </div>

                <button class="book-btn"
                        type="button"
                        onclick="bookCar(5)">
                    Book Now
                </button>

            </div>

        </div>

        <!-- CAR 6 -->

        <div class="car">

            <div class="car-image">

                <img src="<%= request.getContextPath() %>/images/cars/amg.jpg"
                     alt="Mercedes AMG GT">

            </div>

            <div class="car-content">

                <h2>Mercedes AMG GT</h2>

                <p class="price">
                    ₹10,00,000 / Day
                </p>

                <div class="details">
                    <span>🏁 AMG</span>
                    <span>⚡ 585 HP</span>
                </div>

                <button class="book-btn"
                        type="button"
                        onclick="bookCar(6)">
                    Book Now
                </button>

            </div>

        </div>

        <!-- CAR 7 -->

        <div class="car">

            <div class="car-image">

                <img src="<%= request.getContextPath() %>/images/cars/porsche.jpg"
                     alt="Porsche 911 Turbo S">

            </div>

            <div class="car-content">

                <h2>Porsche 911 Turbo S</h2>

                <p class="price">
                    ₹9,00,000 / Day
                </p>

                <div class="details">
                    <span>🏎 Racing</span>
                    <span>⚡ 640 HP</span>
                </div>

                <button class="book-btn"
                        type="button"
                        onclick="bookCar(7)">
                    Book Now
                </button>

            </div>

        </div>

        <!-- CAR 8 -->

        <div class="car">

            <div class="car-image">

                <img src="<%= request.getContextPath() %>/images/cars/mclaren.jpg"
                     alt="McLaren 720S">

            </div>

            <div class="car-content">

                <h2>McLaren 720S</h2>

                <p class="price">
                    ₹11,00,000 / Day
                </p>

                <div class="details">
                    <span>🚀 Supercar</span>
                    <span>⚡ 710 HP</span>
                </div>

                <button class="book-btn"
                        type="button"
                        onclick="bookCar(8)">
                    Book Now
                </button>

            </div>

        </div>

        <!-- CAR 9 -->

        <div class="car">

            <div class="car-image">

                <img src="<%= request.getContextPath() %>/images/cars/astonmartin.jpg"
                     alt="Aston Martin DB12">

            </div>

            <div class="car-content">

                <h2>Aston Martin DB12</h2>

                <p class="price">
                    ₹13,00,000 / Day
                </p>

                <div class="details">
                    <span>🇬🇧 Luxury</span>
                    <span>⚡ V8</span>
                </div>

                <button class="book-btn"
                        type="button"
                        onclick="bookCar(9)">
                    Book Now
                </button>

            </div>

        </div>

        <!-- CAR 10 -->

        <div class="car">

            <div class="car-image">

                <img src="<%= request.getContextPath() %>/images/cars/range rover.jpg"
                     alt="Range Rover Autobiography">

            </div>

            <div class="car-content">

                <h2>Range Rover Autobiography</h2>

                <p class="price">
                    ₹8,00,000 / Day
                </p>

                <div class="details">
                    <span>🚙 SUV</span>
                    <span>👑 Royal</span>
                </div>

                <button class="book-btn"
                        type="button"
                        onclick="bookCar(10)">
                    Book Now
                </button>

            </div>

        </div>

        <!-- CAR 11 -->

        <div class="car">

            <div class="car-image">

                <img src="<%= request.getContextPath() %>/images/cars/bmwm8.jpg"
                     alt="BMW XM">

            </div>

            <div class="car-content">

                <h2>BMW XM</h2>

                <p class="price">
                    ₹7,00,000 / Day
                </p>

                <div class="details">
                    <span>🔥 M Series</span>
                    <span>⚡ Hybrid</span>
                </div>

                <button class="book-btn"
                        type="button"
                        onclick="bookCar(11)">
                    Book Now
                </button>

            </div>

        </div>

        <!-- CAR 12 -->

        <div class="car">

            <div class="car-image">

                <img src="<%= request.getContextPath() %>/images/cars/audir8.jpg"
                     alt="Audi R8 V10">

            </div>

            <div class="car-content">

                <h2>Audi R8 V10</h2>

                <p class="price">
                    ₹9,50,000 / Day
                </p>

                <div class="details">
                    <span>🏎 Supercar</span>
                    <span>⚡ V10</span>
                </div>

                <button class="book-btn"
                        type="button"
                        onclick="bookCar(12)">
                    Book Now
                </button>

            </div>

        </div>

    </div>

</div>

<script>

function bookCar(id){

    window.location.href =
        "<%= request.getContextPath() %>/book-vehicle.jsp?id=" + id;
}

function searchCar(){

    let input = document
        .getElementById("search")
        .value
        .toLowerCase()
        .trim();

    let cars =
        document.getElementsByClassName("car");

    for(let i = 0; i < cars.length; i++){

        let heading =
            cars[i].getElementsByTagName("h2")[0];

        let carName =
            heading.innerText.toLowerCase();

        if(carName.includes(input)){

            cars[i].style.display = "block";

        }else{

            cars[i].style.display = "none";
        }
    }
}

</script>

</body>
</html>