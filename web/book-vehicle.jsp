<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String id = request.getParameter("id");

    if(id == null || id.trim().isEmpty()){
        response.sendRedirect(
            request.getContextPath() + "/VehicleServlet"
        );
        return;
    }

    String carName = "";
    String image = "";
    String price = "";

    switch(id){

        case "1":
            carName = "Bugatti Chiron";
            image = "bugatti.jpg";
            price = "2500000";
            break;

        case "2":
            carName = "Ferrari SF90 Stradale";
            image = "ferrari.jpg";
            price = "1800000";
            break;

        case "3":
            carName = "Lamborghini Aventador";
            image = "lamborghini.jpg";
            price = "1500000";
            break;

        case "4":
            carName = "Rolls Royce Phantom";
            image = "rollsroyce.jpg";
            price = "2000000";
            break;

        case "5":
            carName = "Bentley Continental GT";
            image = "bentley.jpg";
            price = "1200000";
            break;

        case "6":
            carName = "Mercedes AMG GT";

            /*
              Tumhare images folder me agar amg.jpg nahi hai,
              to filhaal mclaren2.jpg use ki hai.

              Mercedes ki image add karne ke baad:
              image = "mercedes.jpg";
            */

            image = "mclaren2.jpg";
            price = "1000000";
            break;

        case "7":
            carName = "Porsche 911 Turbo S";
            image = "porsche.jpg";
            price = "900000";
            break;

        case "8":
            carName = "McLaren 720S";
            image = "mclaren.jpg";
            price = "1100000";
            break;

        case "9":
            carName = "Aston Martin DB12";
            image = "astonmartin.jpg";
            price = "1300000";
            break;

        case "10":
            carName = "Range Rover Autobiography";
            image = "range rover.jpg";
            price = "800000";
            break;

        case "11":
            carName = "BMW XM";
            image = "bmwm8.jpg";
            price = "700000";
            break;

        case "12":
            carName = "Audi R8 V10";
            image = "audir8.jpg";
            price = "950000";
            break;

        default:
            response.sendRedirect(
                request.getContextPath() + "/VehicleServlet"
            );
            return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Book <%= carName %></title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
}

body{
    min-height:100vh;
    color:white;

    background:
        radial-gradient(
            circle at top left,
            rgba(0,255,204,0.14),
            transparent 35%
        ),
        linear-gradient(
            135deg,
            #08111f,
            #141e30,
            #243b55
        );
}

/* NAVBAR */

.navbar{
    min-height:75px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:15px 40px;

    background:rgba(255,255,255,0.10);
    backdrop-filter:blur(20px);

    box-shadow:0 10px 30px rgba(0,0,0,0.40);
    border-bottom:1px solid rgba(255,255,255,0.10);
}

.logo{
    font-size:30px;
    font-weight:bold;
    color:#00ffcc;

    text-shadow:
        0 0 18px rgba(0,255,204,0.50);
}

.navbar a{
    text-decoration:none;
    color:white;
    margin-left:25px;
    transition:0.3s;
}

.navbar a:hover{
    color:#00ffcc;
}

/* MAIN CONTAINER */

.container{
    width:90%;
    max-width:1200px;
    margin:40px auto;
}

.booking-box{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:40px;

    padding:40px;
    border-radius:30px;

    background:rgba(255,255,255,0.10);
    backdrop-filter:blur(20px);

    border:1px solid rgba(255,255,255,0.12);

    box-shadow:
        0 25px 60px rgba(0,0,0,0.55);
}

/* LEFT CAR SECTION */

.car-image-box{
    width:100%;
    height:430px;
    overflow:hidden;
    border-radius:25px;
    position:relative;

    box-shadow:
        0 20px 45px rgba(0,0,0,0.50);
}

.car-image-box::after{
    content:"";
    position:absolute;
    left:0;
    right:0;
    bottom:0;
    height:100px;

    background:
        linear-gradient(
            transparent,
            rgba(5,15,25,0.85)
        );
}

.left img{
    width:100%;
    height:100%;
    object-fit:cover;
    display:block;
    transition:0.5s;
}

.car-image-box:hover img{
    transform:scale(1.06);
}

.car-name{
    font-size:40px;
    margin-top:25px;
    color:#00ffcc;

    text-shadow:
        0 0 18px rgba(0,255,204,0.35);
}

.price{
    font-size:30px;
    font-weight:bold;
    margin-top:15px;
}

/* RIGHT FORM SECTION */

.right h1{
    margin-bottom:30px;
    color:#00ffcc;
    font-size:34px;
}

.input-box{
    margin-bottom:20px;
}

.input-box label{
    display:block;
    margin-bottom:8px;
    font-size:17px;
}

.input-box input,
.input-box select{
    width:100%;
    padding:15px;

    border:1px solid transparent;
    outline:none;
    border-radius:15px;

    font-size:16px;

    background:rgba(255,255,255,0.95);

    transition:0.3s;
}

.input-box input:focus,
.input-box select:focus{
    border-color:#00ffcc;

    box-shadow:
        0 0 15px rgba(0,255,204,0.35);
}

.error{
    color:#ff6b6b;
    font-size:14px;
    margin-top:7px;
    display:block;
}

.book-btn{
    width:100%;
    padding:18px;

    border:none;
    border-radius:30px;

    background:#00ffcc;
    color:black;

    font-size:20px;
    font-weight:bold;

    cursor:pointer;
    transition:0.3s;
}

.book-btn:hover{
    background:#00c7a3;
    color:white;

    transform:translateY(-3px);

    box-shadow:
        0 0 25px rgba(0,255,204,0.40);
}

/* RESPONSIVE */

@media(max-width:900px){

    .booking-box{
        grid-template-columns:1fr;
        padding:25px;
    }

    .navbar{
        flex-direction:column;
        gap:20px;
    }

    .navbar a{
        margin:8px;
    }

    .car-image-box{
        height:320px;
    }

    .car-name{
        font-size:32px;
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

    <div class="booking-box">

        <div class="left">

            <div class="car-image-box">

                <img
                    src="<%= request.getContextPath() %>/images/cars/<%= image %>"
                    alt="<%= carName %>"

                    onerror="
                        this.onerror=null;
                        this.src='<%= request.getContextPath() %>/images/cars/bugatti.jpg';
                    ">

            </div>

            <h2 class="car-name">
                <%= carName %>
            </h2>

            <p class="price">

                ₹<%= String.format(
                    "%,d",
                    Integer.parseInt(price)
                ) %> / Day

            </p>

        </div>

        <div class="right">

            <h1>
                Book Your Luxury Car
            </h1>

            <form
                action="<%= request.getContextPath() %>/BookVehicleServlet"
                method="post"
                onsubmit="return validateBooking()">

                <input
                    type="hidden"
                    name="vehicleId"
                    value="<%= id %>">

                <div class="input-box">

                    <label>Full Name</label>

                    <input
                        type="text"
                        name="fullname"
                        id="fullname"
                        placeholder="Enter Full Name"
                        pattern="[A-Za-z ]{3,50}"
                        title="Name me sirf alphabets allowed hain"
                        required>

                </div>

                <div class="input-box">

                    <label>Mobile Number</label>

                    <input
                        type="tel"
                        name="mobile"
                        id="mobile"
                        placeholder="Enter 10 Digit Mobile Number"
                        pattern="[0-9]{10}"
                        maxlength="10"
                        title="Mobile number exactly 10 digits ka hona chahiye"
                        required>

                </div>

                <div class="input-box">

                    <label>Email Address</label>

                    <input
                        type="email"
                        name="email"
                        id="email"
                        placeholder="Enter Email Address"
                        required>

                </div>

                <div class="input-box">

                    <label>Pickup Date</label>

                    <input
                        type="date"
                        name="pickupDate"
                        id="pickupDate"
                        onchange="setReturnDate()"
                        required>

                </div>

                <div class="input-box">

                    <label>Return Date</label>

                    <input
                        type="date"
                        name="returnDate"
                        id="returnDate"
                        required>

                    <span
                        class="error"
                        id="dateError">
                    </span>

                </div>

                <div class="input-box">

                    <label>Pickup Location</label>

                    <select name="location" required>

                        <option value="">
                            Select Pickup Location
                        </option>

                        <option value="Udaipur">
                            Udaipur
                        </option>

                        <option value="Jaipur">
                            Jaipur
                        </option>

                        <option value="Jodhpur">
                            Jodhpur
                        </option>

                        <option value="Ahmedabad">
                            Ahmedabad
                        </option>

                        <option value="Mumbai">
                            Mumbai
                        </option>

                        <option value="Delhi">
                            Delhi
                        </option>

                        <option value="Bangalore">
                            Bangalore
                        </option>

                    </select>

                </div>

                <div class="input-box">

                    <label>Payment Method</label>

                    <select
                        name="paymentMethod"
                        required>

                        <option value="">
                            Select Payment Method
                        </option>

                        <option value="Cash">
                            Cash
                        </option>

                        <option value="UPI">
                            UPI
                        </option>

                        <option value="Credit Card">
                            Credit Card
                        </option>

                        <option value="Debit Card">
                            Debit Card
                        </option>

                    </select>

                </div>

                <button
                    class="book-btn"
                    type="submit">

                    🚘 Confirm Booking

                </button>

            </form>

        </div>

    </div>

</div>

<script>

let today =
    new Date().toISOString().split("T")[0];

document
    .getElementById("pickupDate")
    .min = today;

document
    .getElementById("returnDate")
    .min = today;

function setReturnDate(){

    let pickupDate =
        document.getElementById(
            "pickupDate"
        ).value;

    let returnDate =
        document.getElementById(
            "returnDate"
        );

    returnDate.min = pickupDate;

    if(
        returnDate.value !== "" &&
        returnDate.value < pickupDate
    ){
        returnDate.value = "";
    }
}

function validateBooking(){

    let pickupDate =
        document.getElementById(
            "pickupDate"
        ).value;

    let returnDate =
        document.getElementById(
            "returnDate"
        ).value;

    let dateError =
        document.getElementById(
            "dateError"
        );

    dateError.innerText = "";

    if(returnDate < pickupDate){

        dateError.innerText =
            "Return date pickup date se pehle nahi ho sakti.";

        return false;
    }

    return confirm(
        "Kya aap <%= carName %> ki booking confirm karna chahte hain?"
    );
}

</script>

</body>
</html>