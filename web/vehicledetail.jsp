<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
    Object id = request.getAttribute("id");

    if (id == null) {
        response.sendRedirect("VehicleServlet");
        return;
    }

    String carName =
            String.valueOf(request.getAttribute("carName"));

    String image =
            String.valueOf(request.getAttribute("image"));

    String price =
            String.valueOf(request.getAttribute("price"));

    String engine =
            String.valueOf(request.getAttribute("engine"));

    String power =
            String.valueOf(request.getAttribute("power"));

    String speed =
            String.valueOf(request.getAttribute("speed"));

    String fuel =
            String.valueOf(request.getAttribute("fuel"));

    String seats =
            String.valueOf(request.getAttribute("seats"));

    String transmission =
            String.valueOf(request.getAttribute("transmission"));

    String category =
            String.valueOf(request.getAttribute("category"));

    String description =
            String.valueOf(request.getAttribute("description"));

    String status =
            String.valueOf(request.getAttribute("status"));

    boolean available =
            status.equalsIgnoreCase("Available");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title><%= carName %> Details</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
}

body{
    background:linear-gradient(135deg,#141e30,#243b55);
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
    box-shadow:0 0 25px black;
}

.logo{
    font-size:32px;
    font-weight:bold;
    color:#00ffcc;
}

.navbar a{
    color:white;
    text-decoration:none;
    margin-left:25px;
    font-size:17px;
}

.navbar a:hover{
    color:#00ffcc;
}

.container{
    padding:40px;
}

.box{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:40px;
    background:rgba(255,255,255,0.12);
    backdrop-filter:blur(20px);
    padding:40px;
    border-radius:35px;
    box-shadow:0 0 30px black;
}

.car-img img{
    width:100%;
    height:450px;
    object-fit:cover;
    border-radius:30px;
    display:block;
}

.info h1{
    font-size:45px;
    color:#00ffcc;
    margin-bottom:20px;
}

.price{
    font-size:30px;
    font-weight:bold;
    margin:20px 0;
}

.description{
    font-size:18px;
    line-height:1.6;
    color:#eee;
}

.status{
    margin-top:20px;
    font-size:20px;
    font-weight:bold;
    color:#00ffcc;
}

.not-available{
    color:#ff6b6b;
}

.specs{
    display:grid;
    grid-template-columns:repeat(2,1fr);
    gap:20px;
    margin-top:30px;
}

.spec{
    background:rgba(255,255,255,0.15);
    padding:20px;
    border-radius:20px;
    text-align:center;
    transition:.3s;
}

.spec:hover{
    transform:translateY(-8px);
    background:#00ffcc;
    color:black;
}

.spec h3{
    color:#00ffcc;
    margin-bottom:10px;
}

.spec:hover h3{
    color:black;
}

.features{
    margin-top:35px;
}

.features h2{
    color:#00ffcc;
    margin-bottom:20px;
}

.features li{
    list-style:none;
    font-size:18px;
    line-height:2;
}

.book-btn{
    width:100%;
    padding:18px;
    margin-top:35px;
    border:none;
    border-radius:30px;
    background:#00ffcc;
    font-size:20px;
    font-weight:bold;
    cursor:pointer;
    transition:.3s;
}

.book-btn:hover{
    background:#00b894;
    transform:scale(1.03);
}

.book-btn:disabled{
    background:#777;
    color:#ddd;
    cursor:not-allowed;
    transform:none;
}

@media(max-width:900px){

    .box{
        grid-template-columns:1fr;
    }

    .container{
        padding:20px;
    }

    .info h1{
        font-size:35px;
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
        <a href="Deshboard.jsp">Dashboard</a>
        <a href="VehicleServlet">Vehicles</a>
        <a href="my-bookings.jsp">My Bookings</a>
        <a href="profile.jsp">Profile</a>
    </div>

</div>

<div class="container">

    <div class="box">

        <div class="car-img">

            <img
                src="<%= request.getContextPath() %>/<%= image %>"
                alt="<%= carName %>"
                onerror="this.onerror=null;
                this.src='<%= request.getContextPath() %>/images/cars/bugatti.jpg';">

        </div>

        <div class="info">

            <h1><%= carName %></h1>

            <p class="price">
                ₹<%= price %> / Day
            </p>

            <p class="description">
                <%= description %>
            </p>

            <p class="status <%= available ? "" : "not-available" %>">

                <%= available
                    ? "● Available for Booking"
                    : "● Currently Not Available" %>

            </p>

            <div class="specs">

                <div class="spec">
                    <h3>Engine</h3>
                    <p><%= engine %></p>
                </div>

                <div class="spec">
                    <h3>Power</h3>
                    <p><%= power %></p>
                </div>

                <div class="spec">
                    <h3>Top Speed</h3>
                    <p><%= speed %></p>
                </div>

                <div class="spec">
                    <h3>Category</h3>
                    <p><%= category %></p>
                </div>

                <div class="spec">
                    <h3>Fuel</h3>
                    <p><%= fuel %></p>
                </div>

                <div class="spec">
                    <h3>Seats</h3>
                    <p><%= seats %></p>
                </div>

                <div class="spec">
                    <h3>Transmission</h3>
                    <p><%= transmission %></p>
                </div>

                <div class="spec">
                    <h3>Rating</h3>
                    <p>⭐⭐⭐⭐⭐</p>
                </div>

            </div>

            <div class="features">

                <h2>✨ Premium Features</h2>

                <ul>
                    <li>✔ Luxury Leather Interior</li>
                    <li>✔ 360° Camera System</li>
                    <li>✔ Premium Sound System</li>
                    <li>✔ Smart Key Technology</li>
                    <li>✔ GPS Navigation</li>
                    <li>✔ Automatic Climate Control</li>
                </ul>

            </div>

            <button
                class="book-btn"
                onclick="bookCar()"
                <%= available ? "" : "disabled" %>>

                <%= available
                    ? "🚘 Book This Luxury Car"
                    : "Vehicle Not Available" %>

            </button>

        </div>

    </div>

</div>

<script>

function bookCar(){

    let confirmBooking =
        confirm("Do you want to book <%= carName %>?");

    if(confirmBooking){

        window.location.href =
            "book-vehicle.jsp?id=<%= id %>";
    }
}

</script>

</body>
</html>