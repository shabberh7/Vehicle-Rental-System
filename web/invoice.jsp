<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    Integer bookingId =
            (Integer) request.getAttribute("bookingId");

    String customerName =
            (String) request.getAttribute("customerName");

    String customerEmail =
            (String) request.getAttribute("customerEmail");

    String customerMobile =
            (String) request.getAttribute("customerMobile");

    String carName =
            (String) request.getAttribute("carName");

    String carImage =
            (String) request.getAttribute("carImage");

    Object pickupDate =
            request.getAttribute("pickupDate");

    Object returnDate =
            request.getAttribute("returnDate");

    String location =
            (String) request.getAttribute("location");

    String paymentMethod =
            (String) request.getAttribute("paymentMethod");

    Double totalPrice =
            (Double) request.getAttribute("totalPrice");

    String bookingStatus =
            (String) request.getAttribute("bookingStatus");

    if (bookingId == null) {

        response.sendRedirect(
                request.getContextPath()
                + "/MyBookingsServlet"
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

<title>Booking Invoice</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, sans-serif;
}

body{
    min-height:100vh;
    padding:40px 20px;
    background:linear-gradient(135deg,#141E30,#243B55);
}

.invoice-container{
    width:100%;
    max-width:950px;
    margin:auto;
    background:white;
    color:#222;
    border-radius:25px;
    overflow:hidden;
    box-shadow:0 0 35px rgba(0,0,0,.55);
}

.invoice-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:30px 40px;
    background:#101820;
    color:white;
}

.logo{
    font-size:30px;
    font-weight:bold;
    color:#00ffcc;
}

.invoice-title{
    text-align:right;
}

.invoice-title h1{
    font-size:35px;
    color:#00ffcc;
    margin-bottom:7px;
}

.invoice-title p{
    color:#dfe6e9;
}

.car-section{
    position:relative;
}

.car-image{
    width:100%;
    height:320px;
    object-fit:cover;
    display:block;
}

.car-overlay{
    position:absolute;
    left:0;
    right:0;
    bottom:0;
    padding:25px 40px;
    background:linear-gradient(
        transparent,
        rgba(0,0,0,.9)
    );
    color:white;
}

.car-overlay h2{
    font-size:32px;
    color:#00ffcc;
}

.invoice-body{
    padding:35px 40px;
}

.section-title{
    font-size:22px;
    color:#101820;
    margin-bottom:20px;
    padding-bottom:10px;
    border-bottom:2px solid #00d9ad;
}

.info-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:18px;
    margin-bottom:35px;
}

.info-box{
    padding:18px;
    border-radius:14px;
    background:#f3f7f8;
    border:1px solid #d9e3e6;
}

.info-box h4{
    color:#008f78;
    margin-bottom:7px;
    font-size:14px;
    text-transform:uppercase;
}

.info-box p{
    font-size:17px;
    font-weight:bold;
    word-break:break-word;
}

.full-box{
    grid-column:1 / -1;
}

.status{
    display:inline-block;
    padding:9px 20px;
    border-radius:25px;
    background:#00d9ad;
    color:white;
    text-transform:capitalize;
}

.cancelled{
    background:#ff4d4d;
}

.pending{
    background:#f39c12;
}

.approved{
    background:#00b894;
}

.completed{
    background:#0984e3;
}

.rejected{
    background:#d63031;
}

.total-section{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:25px 30px;
    border-radius:18px;
    background:#101820;
    color:white;
    margin-top:10px;
}

.total-section h2{
    font-size:23px;
}

.total-price{
    font-size:32px;
    font-weight:bold;
    color:#00ffcc;
}

.note{
    margin-top:25px;
    padding:18px;
    border-radius:14px;
    background:#eefcf9;
    border-left:5px solid #00b894;
    color:#444;
    line-height:1.6;
}

.actions{
    display:flex;
    justify-content:center;
    gap:15px;
    padding:0 40px 35px;
}

.btn{
    display:inline-block;
    padding:14px 28px;
    border:none;
    border-radius:30px;
    font-size:17px;
    font-weight:bold;
    text-decoration:none;
    cursor:pointer;
    transition:.3s;
}

.back-btn{
    background:#dfe6e9;
    color:#222;
}

.print-btn{
    background:#00d9ad;
    color:white;
}

.btn:hover{
    transform:translateY(-3px);
}

.invoice-footer{
    padding:20px 40px;
    background:#f3f7f8;
    text-align:center;
    color:#555;
    border-top:1px solid #dfe6e9;
}

@media(max-width:700px){

    .invoice-header{
        flex-direction:column;
        gap:20px;
        text-align:center;
    }

    .invoice-title{
        text-align:center;
    }

    .info-grid{
        grid-template-columns:1fr;
    }

    .full-box{
        grid-column:auto;
    }

    .total-section{
        flex-direction:column;
        gap:12px;
        text-align:center;
    }

    .actions{
        flex-direction:column;
    }

    .btn{
        width:100%;
        text-align:center;
    }
}

@media print{

    body{
        padding:0;
        background:white;
    }

    .invoice-container{
        max-width:100%;
        box-shadow:none;
        border-radius:0;
    }

    .actions{
        display:none;
    }

    .car-image{
        height:250px;
    }
}

</style>


<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vehicle-theme.css">
</head>

<body>

<div class="invoice-container">

    <div class="invoice-header">

        <div class="logo">
            🚘 LuxeDrive
        </div>

        <div class="invoice-title">

            <h1>INVOICE</h1>

            <p>
                Invoice Number:
                INV-<%= bookingId %>
            </p>

        </div>

    </div>

    <div class="car-section">

        <img
            src="<%= request.getContextPath() %>/<%= carImage %>"
            class="car-image"
            alt="<%= carName %>"
            onerror="this.onerror=null;
            this.src='<%= request.getContextPath() %>/images/cars/bugatti.jpg';">

        <div class="car-overlay">

            <h2>
                <%= carName %>
            </h2>

        </div>

    </div>

    <div class="invoice-body">

        <h3 class="section-title">
            Customer Details
        </h3>

        <div class="info-grid">

            <div class="info-box">

                <h4>Customer Name</h4>

                <p>
                    <%= customerName %>
                </p>

            </div>

            <div class="info-box">

                <h4>Email Address</h4>

                <p>
                    <%= customerEmail %>
                </p>

            </div>

            <div class="info-box full-box">

                <h4>Mobile Number</h4>

                <p>
                    <%= customerMobile %>
                </p>

            </div>

        </div>

        <h3 class="section-title">
            Booking Details
        </h3>

        <div class="info-grid">

            <div class="info-box">

                <h4>Booking ID</h4>

                <p>
                    #<%= bookingId %>
                </p>

            </div>

            <div class="info-box">

                <h4>Vehicle</h4>

                <p>
                    <%= carName %>
                </p>

            </div>

            <div class="info-box">

                <h4>Pickup Date</h4>

                <p>
                    <%= pickupDate %>
                </p>

            </div>

            <div class="info-box">

                <h4>Return Date</h4>

                <p>
                    <%= returnDate %>
                </p>

            </div>

            <div class="info-box">

                <h4>Pickup Location</h4>

                <p>
                    <%= location %>
                </p>

            </div>

            <div class="info-box">

                <h4>Payment Method</h4>

                <p>
                    <%= paymentMethod %>
                </p>

            </div>

            <div class="info-box full-box">

                <h4>Booking Status</h4>

                <p>

                    <span class="status
                        <%= bookingStatus == null
                                ? ""
                                : bookingStatus.toLowerCase() %>">

                        <%= bookingStatus %>

                    </span>

                </p>

            </div>

        </div>

        <div class="total-section">

            <h2>
                Total Rental Amount
            </h2>

            <div class="total-price">

                ₹<%= String.format(
                        "%,.2f",
                        totalPrice == null
                                ? 0.0
                                : totalPrice
                ) %>

            </div>

        </div>

        <div class="note">

            Thank you for choosing LuxeDrive.
            Please keep this invoice for your booking record.
            Vehicle pickup ke time valid ID proof saath lekar aayein.

        </div>

    </div>

    <div class="actions">

        <a
            href="<%= request.getContextPath() %>/MyBookingsServlet"
            class="btn back-btn">

            ← Back to My Bookings

        </a>

        <button
            type="button"
            class="btn print-btn"
            onclick="window.print()">

            🖨 Print Invoice

        </button>

    </div>

    <div class="invoice-footer">

        LuxeDrive Vehicle Rental System |
        Booking Invoice #<%= bookingId %>

    </div>

</div>

</body>

</html>