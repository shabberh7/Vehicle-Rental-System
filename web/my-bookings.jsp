<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="collage.Booking" %>

<%
    ArrayList<Booking> bookingList =
            (ArrayList<Booking>) request.getAttribute("bookingList");

    String success =
            request.getParameter("success");

    String errorMessage =
            (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>My Bookings</title>

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
            rgba(0,255,204,0.12),
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

    box-shadow:
        0 10px 35px rgba(0,0,0,0.45);

    border-bottom:
        1px solid rgba(255,255,255,0.10);
}

.logo{
    font-size:30px;
    font-weight:bold;
    color:#00ffcc;

    text-shadow:
        0 0 18px rgba(0,255,204,0.50);
}

.navbar a{
    color:white;
    text-decoration:none;
    margin-left:25px;
    transition:0.3s;
}

.navbar a:hover{
    color:#00ffcc;
}

/* CONTAINER */

.container{
    width:90%;
    max-width:1450px;
    margin:40px auto;
}

.heading{
    text-align:center;
    font-size:42px;
    color:#00ffcc;
    margin-bottom:35px;

    text-shadow:
        0 0 20px rgba(0,255,204,0.30);
}

/* MESSAGES */

.success-message{
    max-width:800px;
    margin:0 auto 30px;
    padding:17px;

    border-radius:15px;
    text-align:center;

    background:rgba(0,255,204,0.15);
    border:1px solid #00ffcc;

    color:#00ffcc;
    font-weight:bold;
}

.error-message{
    max-width:800px;
    margin:0 auto 30px;
    padding:17px;

    border-radius:15px;
    text-align:center;

    background:rgba(255,77,77,0.15);
    border:1px solid #ff4d4d;

    color:#ff7676;
    font-weight:bold;
}

/* GRID */

.booking-grid{
    display:grid;

    grid-template-columns:
        repeat(auto-fit,minmax(360px,1fr));

    gap:30px;
}

/* BOOKING CARD */

.card{
    background:rgba(255,255,255,0.11);
    backdrop-filter:blur(20px);

    border-radius:25px;
    overflow:hidden;

    box-shadow:
        0 18px 45px rgba(0,0,0,0.50);

    border:
        1px solid rgba(255,255,255,0.10);

    transition:0.4s;
}

.card:hover{
    transform:translateY(-10px);

    border-color:
        rgba(0,255,204,0.45);

    box-shadow:
        0 25px 55px rgba(0,0,0,0.65),
        0 0 25px rgba(0,255,204,0.12);
}

/* IMAGE */

.image-box{
    width:100%;
    height:240px;
    overflow:hidden;
    position:relative;

    background:#101820;
}

.image-box::after{
    content:"";

    position:absolute;
    left:0;
    right:0;
    bottom:0;

    height:85px;

    background:
        linear-gradient(
            transparent,
            rgba(5,15,25,0.88)
        );
}

.car-image{
    width:100%;
    height:100%;

    object-fit:cover;
    display:block;

    transition:0.5s;
}

.card:hover .car-image{
    transform:scale(1.07);
}

/* CONTENT */

.content{
    padding:25px;
}

.booking-id{
    color:#dfe6e9;
    font-size:15px;
    margin-bottom:10px;
}

.car-name{
    font-size:28px;
    color:#00ffcc;
    margin-bottom:20px;
}

/* DETAILS */

.details{
    display:grid;
    grid-template-columns:1fr 1fr;

    gap:15px;
    margin-bottom:20px;
}

.box{
    background:rgba(255,255,255,0.10);

    padding:15px;
    border-radius:15px;

    text-align:center;

    border:
        1px solid rgba(255,255,255,0.06);
}

.box h4{
    color:#00ffcc;
    margin-bottom:8px;
}

.box p{
    word-break:break-word;
}

.price-box{
    grid-column:1 / -1;

    background:
        rgba(0,255,204,0.12);

    border:
        1px solid rgba(0,255,204,0.45);
}

.price-box p{
    color:#00ffcc;
    font-size:22px;
    font-weight:bold;
}

/* STATUS */

.status{
    display:inline-block;

    padding:10px 25px;
    border-radius:30px;

    font-weight:bold;

    background:#00ffcc;
    color:black;

    margin-top:5px;
    text-transform:capitalize;
}

.cancelled-status{
    background:#ff4d4d;
    color:white;
}

.pending-status{
    background:#f39c12;
    color:white;
}

.approved-status{
    background:#00b894;
    color:white;
}

.completed-status{
    background:#0984e3;
    color:white;
}

.rejected-status{
    background:#d63031;
    color:white;
}

/* BUTTONS */

.invoice-btn{
    width:100%;
    display:block;

    padding:16px;
    margin-top:20px;

    border:none;
    border-radius:30px;

    font-size:18px;
    font-weight:bold;

    cursor:pointer;

    background:#00ffcc;
    color:black;

    text-align:center;
    text-decoration:none;

    transition:0.3s;
}

.invoice-btn:hover{
    background:#00d9ad;

    transform:translateY(-2px);

    box-shadow:
        0 0 22px rgba(0,255,204,0.35);
}

.cancel-btn{
    width:100%;

    padding:16px;
    margin-top:15px;

    border:none;
    border-radius:30px;

    font-size:18px;
    font-weight:bold;

    cursor:pointer;

    background:#ff4d4d;
    color:white;

    transition:0.3s;
}

.cancel-btn:hover{
    background:#ff1a1a;

    transform:translateY(-2px);

    box-shadow:
        0 0 20px rgba(255,77,77,0.30);
}

.cancel-btn:disabled{
    cursor:not-allowed;
    background:#777;
    transform:none;
    box-shadow:none;
}

/* EMPTY BOX */

.empty-box{
    max-width:700px;

    margin:70px auto;
    padding:50px 30px;

    text-align:center;

    border-radius:25px;

    background:
        rgba(255,255,255,0.11);

    backdrop-filter:blur(20px);

    box-shadow:
        0 20px 45px rgba(0,0,0,0.45);
}

.empty-box h2{
    color:#00ffcc;
    font-size:30px;
    margin-bottom:15px;
}

.empty-box p{
    margin-bottom:25px;
    color:#dfe6e9;
}

.browse-btn{
    display:inline-block;

    padding:14px 30px;
    border-radius:30px;

    background:#00ffcc;
    color:black;

    text-decoration:none;
    font-weight:bold;
}

/* RESPONSIVE */

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

    .heading{
        font-size:34px;
    }
}

@media(max-width:500px){

    .booking-grid{
        grid-template-columns:1fr;
    }

    .details{
        grid-template-columns:1fr;
    }

    .price-box{
        grid-column:auto;
    }

    .image-box{
        height:220px;
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

        <a href="<%= request.getContextPath() %>/LogoutServlet">
            Logout
        </a>

    </div>

</div>

<div class="container">

    <h1 class="heading">
        🚘 My Bookings
    </h1>

    <% if ("booked".equals(success)) { %>

        <div class="success-message">

            ✅ Your vehicle has been booked successfully.

        </div>

    <% } %>

    <% if (errorMessage != null) { %>

        <div class="error-message">

            <%= errorMessage %>

        </div>

    <% } %>

    <% if (bookingList == null
            || bookingList.isEmpty()) { %>

        <div class="empty-box">

            <h2>
                No Bookings Found
            </h2>

            <p>
                Aapne abhi tak koi vehicle book nahi kiya hai.
            </p>

            <a
                class="browse-btn"
                href="<%= request.getContextPath() %>/VehicleServlet">

                Browse Vehicles

            </a>

        </div>

    <% } else { %>

        <div class="booking-grid">

        <% for (Booking booking : bookingList) {

            String statusClass = "";

            if (booking.getBookingStatus() != null) {

                String status =
                        booking.getBookingStatus()
                        .toLowerCase();

                if ("cancelled".equals(status)) {

                    statusClass =
                            "cancelled-status";

                } else if ("pending".equals(status)) {

                    statusClass =
                            "pending-status";

                } else if ("approved".equals(status)) {

                    statusClass =
                            "approved-status";

                } else if ("completed".equals(status)) {

                    statusClass =
                            "completed-status";

                } else if ("rejected".equals(status)) {

                    statusClass =
                            "rejected-status";
                }
            }
        %>

            <div class="card">

                <div class="image-box">

                    <img
                        src="<%= request.getContextPath() %>/<%= booking.getImage() %>"
                        class="car-image"
                        alt="<%= booking.getCarName() %>"

                        onerror="
                            this.onerror=null;
                            this.src='<%= request.getContextPath() %>/images/cars/bugatti.jpg';
                        ">

                </div>

                <div class="content">

                    <p class="booking-id">

                        Booking ID:
                        #<%= booking.getBookingId() %>

                    </p>

                    <h2 class="car-name">

                        <%= booking.getCarName() %>

                    </h2>

                    <div class="details">

                        <div class="box">

                            <h4>
                                Pickup Date
                            </h4>

                            <p>
                                <%= booking.getPickupDate() %>
                            </p>

                        </div>

                        <div class="box">

                            <h4>
                                Return Date
                            </h4>

                            <p>
                                <%= booking.getReturnDate() %>
                            </p>

                        </div>

                        <div class="box">

                            <h4>
                                Location
                            </h4>

                            <p>
                                <%= booking.getLocation() %>
                            </p>

                        </div>

                        <div class="box">

                            <h4>
                                Payment
                            </h4>

                            <p>
                                <%= booking.getPaymentMethod() %>
                            </p>

                        </div>

                        <div class="box price-box">

                            <h4>
                                Total Price
                            </h4>

                            <p>

                                ₹<%= String.format(
                                        "%,.2f",
                                        booking.getTotalPrice()
                                ) %>

                            </p>

                        </div>

                    </div>

                    <span class="status <%= statusClass %>">

                        <%= booking.getBookingStatus() %>

                    </span>

                    <a
                        class="invoice-btn"
                        href="<%= request.getContextPath() %>/InvoiceServlet?id=<%= booking.getBookingId() %>">

                        🧾 View Invoice

                    </a>

                    <% if (!"Cancelled".equalsIgnoreCase(
                            booking.getBookingStatus())) { %>

                        <button
                            type="button"
                            class="cancel-btn"
                            onclick="cancelBooking(
                                <%= booking.getBookingId() %>
                            )">

                            Cancel Booking

                        </button>

                    <% } else { %>

                        <button
                            type="button"
                            class="cancel-btn"
                            disabled>

                            Booking Cancelled

                        </button>

                    <% } %>

                </div>

            </div>

        <% } %>

        </div>

    <% } %>

</div>

<script>

function cancelBooking(bookingId){

    let answer = confirm(
        "Are you sure you want to cancel this booking?"
    );

    if(answer){

        window.location.href =
            "<%= request.getContextPath() %>/CancelBookingServlet?id="
            + bookingId;
    }
}

</script>

</body>

</html>