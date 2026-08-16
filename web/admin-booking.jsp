<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="collage.DBConnection" %>

<%
    String success = request.getParameter("success");
    String error = request.getParameter("error");

    DecimalFormat priceFormat =
            new DecimalFormat("#,##0.00");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Manage Bookings</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Poppins,Arial,sans-serif;
}

body{
    min-height:100vh;
    color:white;

    background:
        radial-gradient(
            circle at top left,
            rgba(0,255,204,.12),
            transparent 30%
        ),
        radial-gradient(
            circle at bottom right,
            rgba(0,119,255,.16),
            transparent 35%
        ),
        linear-gradient(
            135deg,
            #07111f,
            #141e30,
            #243b55
        );
}

.navbar{
    min-height:75px;

    display:flex;
    justify-content:space-between;
    align-items:center;

    padding:15px 40px;

    background:#102030;

    border-bottom:
        1px solid rgba(255,255,255,.15);

    position:sticky;
    top:0;
    z-index:100;
}

.logo{
    color:#00ffcc;

    font-size:29px;
    font-weight:bold;
}

.nav-links{
    display:flex;
    align-items:center;
    gap:10px;
}

.nav-links a{
    color:white;

    padding:10px 15px;

    text-decoration:none;

    border-radius:22px;

    transition:.3s;
}

.nav-links a:hover{
    color:#07111f;
    background:#00ffcc;
}

.container{
    width:94%;
    max-width:1450px;

    margin:40px auto;
}

.heading{
    color:#00ffcc;

    text-align:center;

    font-size:40px;

    margin-bottom:8px;
}

.subtitle{
    color:#cbd5e1;

    text-align:center;

    margin-bottom:30px;
}

.message{
    max-width:900px;

    margin:0 auto 25px;

    padding:15px;

    border-radius:15px;

    text-align:center;

    font-weight:bold;
}

.success-message{
    color:#05251e;
    background:#00ffcc;
}

.error-message{
    color:white;
    background:#ff4d5a;
}

.search-box{
    max-width:650px;

    margin:0 auto 30px;
}

.search-box input{
    width:100%;

    padding:15px 20px;

    border:2px solid transparent;

    outline:none;

    border-radius:30px;

    font-size:16px;
}

.search-box input:focus{
    border-color:#00ffcc;

    box-shadow:
        0 0 0 4px rgba(0,255,204,.13);
}

.table-box{
    overflow-x:auto;

    background:#1c2b3d;

    border:
        1px solid rgba(255,255,255,.14);

    border-radius:25px;

    box-shadow:
        0 20px 45px rgba(0,0,0,.40);
}

table{
    width:100%;

    border-collapse:collapse;

    min-width:1200px;
}

thead{
    background:#00ffcc;
    color:#07111f;
}

th{
    padding:18px 14px;

    text-align:left;

    font-size:15px;
}

td{
    padding:17px 14px;

    color:#e2e8f0;

    border-bottom:
        1px solid rgba(255,255,255,.10);

    vertical-align:middle;
}

tbody tr:hover{
    background:
        rgba(255,255,255,.06);
}

.user-name{
    color:#00ffcc;
    font-weight:bold;
}

.email{
    color:#94a3b8;

    font-size:13px;

    margin-top:4px;
}

.car-name{
    color:white;
    font-weight:bold;
}

.price{
    color:#00ffcc;
    font-weight:bold;
}

.status{
    display:inline-block;

    min-width:100px;

    padding:8px 12px;

    border-radius:20px;

    text-align:center;

    font-size:13px;
    font-weight:bold;

    text-transform:capitalize;
}

.pending{
    color:#111827;
    background:#facc15;
}

.approved{
    color:#05251e;
    background:#00ffcc;
}

.rejected{
    color:white;
    background:#ff4d5a;
}

.completed{
    color:white;
    background:#3b82f6;
}

.cancelled{
    color:white;
    background:#64748b;
}

.action-box{
    display:flex;

    flex-wrap:wrap;

    gap:7px;
}

.action-btn{
    display:inline-block;

    padding:8px 12px;

    border:none;

    border-radius:18px;

    color:white;

    text-decoration:none;

    font-size:12px;
    font-weight:bold;

    cursor:pointer;

    transition:.3s;
}

.action-btn:hover{
    transform:translateY(-2px);

    filter:brightness(1.10);
}

.approve-btn{
    color:#05251e;
    background:#00ffcc;
}

.reject-btn{
    background:#ff4d5a;
}

.complete-btn{
    background:#3b82f6;
}

.pending-btn{
    color:#111827;
    background:#facc15;
}

.empty-box{
    padding:60px 20px;

    text-align:center;
}

.empty-box h2{
    color:#00ffcc;

    margin-bottom:12px;
}

.empty-box p{
    color:#cbd5e1;
}

@media(max-width:800px){

    .navbar{
        padding:15px 20px;

        flex-direction:column;

        gap:14px;
    }

    .nav-links{
        flex-wrap:wrap;

        justify-content:center;
    }

    .logo{
        font-size:24px;
    }

    .heading{
        font-size:30px;
    }
}

</style>

<link rel="stylesheet"
href="<%= request.getContextPath() %>/assets/vehicle-theme.css">

</head>

<body>

<div class="navbar">

    <div class="logo">
        🚘 LuxeDrive Admin
    </div>

    <div class="nav-links">

        <a href="<%= request.getContextPath() %>/admin-dashboard.jsp">
            Dashboard
        </a>

        <a href="<%= request.getContextPath() %>/manage-vehicles.jsp">
            Vehicles
        </a>

        <a href="<%= request.getContextPath() %>/admin-booking.jsp">
            Bookings
        </a>

        <a href="<%= request.getContextPath() %>/LogoutServlet">
            Logout
        </a>

    </div>

</div>


<div class="container">

<h1 class="heading">
    📋 Manage Bookings
</h1>

<p class="subtitle">
    View and update all customer vehicle bookings.
</p>


<%
if ("updated".equals(success)) {
%>

<div class="message success-message">
    Booking status successfully updated ✅
</div>

<%
}
%>


<%
if ("updateFailed".equals(error)) {
%>

<div class="message error-message">
    Booking status update nahi hua ❌
</div>

<%
}
%>


<%
if ("invalidData".equals(error)) {
%>

<div class="message error-message">
    Invalid booking information ❌
</div>

<%
}
%>


<div class="search-box">

<input
    type="text"
    id="searchInput"
    placeholder="Search by user, email, vehicle or status..."
    onkeyup="searchBookings()">

</div>


<div class="table-box">

<table>

<thead>

<tr>

<th>Booking ID</th>

<th>Customer</th>

<th>Vehicle</th>

<th>Pickup Date</th>

<th>Return Date</th>

<th>Total Price</th>

<th>Status</th>

<th>Actions</th>

</tr>

</thead>


<tbody id="bookingTableBody">


<%

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

boolean bookingFound = false;

try {

    con =
        DBConnection.getConnection();


    String sql =
        "SELECT "
        + "b.id AS booking_id, "
        + "b.pickup_date, "
        + "b.return_date, "
        + "b.total_price, "
        + "b.status, "
        + "u.name AS user_name, "
        + "u.email AS user_email, "
        + "v.name AS car_name "
        + "FROM bookings b "
        + "INNER JOIN users u "
        + "ON b.user_id = u.id "
        + "INNER JOIN vehicles v "
        + "ON b.vehicle_id = v.id "
        + "ORDER BY b.id DESC";


    ps =
        con.prepareStatement(sql);


    rs =
        ps.executeQuery();


    while(rs.next()) {


        bookingFound = true;


        int bookingId =
            rs.getInt("booking_id");


        String userName =
            rs.getString("user_name");


        String userEmail =
            rs.getString("user_email");


        String carName =
            rs.getString("car_name");


        String pickupDate =
            rs.getString("pickup_date");


        String returnDate =
            rs.getString("return_date");


        double totalPrice =
            rs.getDouble("total_price");


        String status =
            rs.getString("status");


        if(status == null
                || status.trim().isEmpty()) {

            status = "pending";
        }


        String statusClass =
            status.toLowerCase();

%>


<tr
    class="booking-row"

    data-search="<%= (
        userName + " "
        + userEmail + " "
        + carName + " "
        + status
    ).toLowerCase() %>">


<td>
    #<%= bookingId %>
</td>


<td>

<div class="user-name">
    <%= userName %>
</div>

<div class="email">
    <%= userEmail %>
</div>

</td>


<td class="car-name">
    <%= carName %>
</td>


<td>
    <%= pickupDate %>
</td>


<td>
    <%= returnDate %>
</td>


<td class="price">
    ₹<%= priceFormat.format(totalPrice) %>
</td>


<td>

<span class="status <%= statusClass %>">
    <%= status %>
</span>

</td>


<td>

<div class="action-box">


<a
href="<%= request.getContextPath() %>/UpdateBookingStatusServlet?id=<%= bookingId %>&status=approved"
class="action-btn approve-btn">

Approve

</a>


<a
href="<%= request.getContextPath() %>/UpdateBookingStatusServlet?id=<%= bookingId %>&status=rejected"
class="action-btn reject-btn"
onclick="return confirmStatus('reject');">

Reject

</a>


<a
href="<%= request.getContextPath() %>/UpdateBookingStatusServlet?id=<%= bookingId %>&status=completed"
class="action-btn complete-btn"
onclick="return confirmStatus('complete');">

Complete

</a>


<a
href="<%= request.getContextPath() %>/UpdateBookingStatusServlet?id=<%= bookingId %>&status=pending"
class="action-btn pending-btn"
onclick="return confirmStatus('pending');">

Pending

</a>


</div>

</td>


</tr>


<%

    }


    if(!bookingFound) {

%>


<tr>

<td colspan="8">

<div class="empty-box">

<h2>
    Koi booking nahi mili
</h2>

<p>
    Customer booking karega to yahan show hogi.
</p>

</div>

</td>

</tr>


<%

    }


} catch(Exception e) {


    e.printStackTrace();

%>


<tr>

<td colspan="8">

<div class="empty-box">

<h2>
    Database Error
</h2>

<p>
    Booking load nahi hui.
</p>

</div>

</td>

</tr>


<%

} finally {


    try {


        if(rs != null) {

            rs.close();

        }


        if(ps != null) {

            ps.close();

        }


    } catch(Exception e) {

        e.printStackTrace();

    }

}

%>


</tbody>

</table>

</div>

</div>


<script>


function searchBookings(){

    const searchValue =
        document
        .getElementById(
            "searchInput"
        )
        .value
        .toLowerCase()
        .trim();


    const rows =
        document
        .querySelectorAll(
            ".booking-row"
        );


    rows.forEach(
        function(row){


            const searchData =
                row.getAttribute(
                    "data-search"
                ) || "";


            row.style.display =
                searchData.includes(
                    searchValue
                )
                ? ""
                : "none";

        }
    );

}


function confirmStatus(status){

    return confirm(
        "Kya aap booking status "
        + status
        + " karna chahte ho?"
    );

}


</script>


</body>

</html>
