<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="collage.DBConnection" %>
<%@ page import="collage.VehicleImageUtil" %>

<%!
    public String safeText(String value) {

        if (value == null) {
            return "";
        }

        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>

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

<title>Manage Vehicles</title>

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
            rgba(0,255,204,.16),
            transparent 30%
        ),
        radial-gradient(
            circle at bottom right,
            rgba(0,119,255,.18),
            transparent 35%
        ),
        linear-gradient(
            135deg,
            #07111f,
            #141e30,
            #243b55
        );

    background-attachment:fixed;
}

/* NAVBAR */

.navbar{
    min-height:75px;

    display:flex;
    justify-content:space-between;
    align-items:center;

    padding:15px 40px;

    background:rgba(16,31,48,.98);

    border-bottom:
        1px solid rgba(255,255,255,.15);

    position:sticky;
    top:0;
    z-index:100;
}

.logo{
    font-size:29px;
    font-weight:bold;

    color:#00ffcc;

    text-shadow:
        0 0 12px rgba(0,255,204,.35);
}

.nav-links{
    display:flex;
    align-items:center;
    gap:10px;
}

.nav-links a{
    color:white;
    text-decoration:none;

    padding:10px 16px;

    border-radius:22px;

    transition:.3s;
}

.nav-links a:hover{
    color:#07111f;
    background:#00ffcc;
}

/* MAIN */

.container{
    width:92%;
    max-width:1300px;

    margin:40px auto;
}

.heading{
    text-align:center;

    font-size:40px;

    color:#00ffcc;

    margin-bottom:8px;
}

.subtitle{
    text-align:center;

    color:#cbd5e1;

    margin-bottom:30px;
}

/* TOP BAR */

.top-bar{
    display:flex;
    justify-content:space-between;
    align-items:center;

    gap:20px;

    margin-bottom:30px;
}

.search-box{
    flex:1;
    max-width:600px;
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
        0 0 0 4px rgba(0,255,204,.14);
}

.add-btn{
    display:inline-block;

    padding:15px 24px;

    color:#07111f;

    background:#00ffcc;

    text-decoration:none;

    border-radius:30px;

    font-weight:bold;

    white-space:nowrap;
}

/* MESSAGE */

.message{
    padding:15px;

    margin-bottom:25px;

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

/* VEHICLE GRID */

.vehicle-grid{
    display:grid;

    grid-template-columns:
        repeat(auto-fit,minmax(310px,1fr));

    gap:30px;
}

.card{
    display:flex;
    flex-direction:column;

    overflow:hidden;

    background:#1c2b3d;

    border:
        1px solid rgba(255,255,255,.15);

    border-radius:25px;

    box-shadow:
        0 15px 35px rgba(0,0,0,.35);

    transition:.3s;
}

.card:hover{
    transform:translateY(-6px);

    box-shadow:
        0 20px 45px rgba(0,0,0,.45);
}

.image-box{
    position:relative;

    width:100%;
    height:230px;

    overflow:hidden;

    background:#101827;
}

.image-box img{
    width:100%;
    height:100%;

    object-fit:cover;

    display:block;
}

.type-tag{
    position:absolute;

    top:15px;
    right:15px;

    padding:8px 14px;

    color:#07111f;

    background:#00ffcc;

    border-radius:20px;

    font-size:13px;
    font-weight:bold;
}

.vehicle-id{
    position:absolute;

    top:15px;
    left:15px;

    padding:7px 12px;

    color:white;

    background:rgba(0,0,0,.65);

    border-radius:20px;

    font-size:13px;
}

.content{
    display:flex;
    flex-direction:column;

    flex:1;

    padding:24px;
}

.content h2{
    color:#00ffcc;

    margin-bottom:15px;

    font-size:24px;
}

.price{
    margin-bottom:16px;

    color:white;

    font-size:20px;
    font-weight:bold;
}

.price span{
    color:#94a3b8;

    font-size:14px;
    font-weight:normal;
}

.details-grid{
    display:grid;

    grid-template-columns:1fr 1fr;

    gap:10px;

    margin-bottom:18px;
}

.detail{
    padding:10px;

    color:#e2e8f0;

    background:
        rgba(255,255,255,.08);

    border-radius:12px;

    font-size:14px;
}

.status{
    margin-bottom:20px;

    font-weight:bold;

    color:#00ffcc;
}

.button-row{
    display:flex;

    gap:12px;

    margin-top:auto;
}

.btn{
    flex:1;

    display:inline-block;

    padding:12px 18px;

    border:none;

    border-radius:25px;

    text-align:center;

    text-decoration:none;

    font-weight:bold;

    cursor:pointer;

    transition:.3s;
}

.btn:hover{
    transform:translateY(-2px);
}

.edit{
    color:#07111f;
    background:#00ffcc;
}

.delete{
    color:white;
    background:#ff4d5a;
}

.empty-box{
    grid-column:1/-1;

    padding:50px 20px;

    text-align:center;

    background:#1c2b3d;

    border-radius:25px;
}

.empty-box h2{
    color:#00ffcc;

    margin-bottom:12px;
}

.empty-box p{
    color:#cbd5e1;
}

/* MOBILE */

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

    .container{
        width:94%;

        margin-top:25px;
    }

    .heading{
        font-size:30px;
    }

    .top-bar{
        flex-direction:column;
    }

    .search-box,
    .add-btn{
        width:100%;
        max-width:none;

        text-align:center;
    }

    .vehicle-grid{
        grid-template-columns:1fr;
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

        <a href="<%= request.getContextPath() %>/add-vehicle.jsp">
            Add Vehicle
        </a>

        <a href="<%= request.getContextPath() %>/LogoutServlet">
            Logout
        </a>

    </div>

</div>


<div class="container">


<h1 class="heading">
    🚘 Manage Vehicles
</h1>

<p class="subtitle">
    View, edit and delete all available vehicles.
</p>


<%
if ("added".equals(success)) {
%>

<div class="message success-message">
    Vehicle successfully added ✅
</div>

<%
}
%>


<%
if ("deleted".equals(success)) {
%>

<div class="message success-message">
    Vehicle successfully deleted ✅
</div>

<%
}
%>


<%
if ("updated".equals(success)) {
%>

<div class="message success-message">
    Vehicle successfully updated ✅
</div>

<%
}
%>


<%
if ("deleteFailed".equals(error)) {
%>

<div class="message error-message">
    Vehicle delete nahi hua ❌
</div>

<%
}
%>


<div class="top-bar">

    <div class="search-box">

        <input
            type="text"
            id="searchInput"
            placeholder="Search vehicle..."
            onkeyup="searchVehicles()">

    </div>


    <a
        href="<%= request.getContextPath() %>/add-vehicle.jsp"
        class="add-btn">

        ➕ Add New Vehicle

    </a>

</div>


<div class="vehicle-grid"
     id="vehicleGrid">


<%

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

boolean vehicleFound = false;

try {

    con =
        DBConnection.getConnection();


    String sql =
        "SELECT id, name, brand, type, "
        + "price, image, status "
        + "FROM vehicles "
        + "ORDER BY id DESC";


    ps =
        con.prepareStatement(sql);


    rs =
        ps.executeQuery();


    while(rs.next()) {


        vehicleFound = true;


        int vehicleId =
            rs.getInt("id");


        String carName =
            rs.getString("name");


        String brand =
            rs.getString("brand");


        String type =
            rs.getString("type");


        double price =
            rs.getDouble("price");


        String image =
            rs.getString("image");


        String status =
            rs.getString("status");


        if(image == null
                || image.trim().isEmpty()) {

            image =
                VehicleImageUtil.getImage(
                    carName
                );
        }


        String imagePath =
            request.getContextPath()
            + "/"
            + image;

%>


<div
    class="card vehicle-card"

    data-name="<%= safeText(carName).toLowerCase() %>"

    data-brand="<%= safeText(brand).toLowerCase() %>"

    data-type="<%= safeText(type).toLowerCase() %>">


<div class="image-box">


<img
    src="<%= imagePath %>"

    alt="<%= safeText(carName) %>"

    onerror="this.onerror=null;
    this.src='<%= request.getContextPath() %>/images/cars/bugatti.jpg';">


<span class="vehicle-id">

    ID: <%= vehicleId %>

</span>


<span class="type-tag">

    <%= safeText(type) %>

</span>


</div>


<div class="content">


<h2>

    <%= safeText(carName) %>

</h2>


<p class="price">

    ₹<%= priceFormat.format(price) %>

    <span>
        / Day
    </span>

</p>


<div class="details-grid">


<div class="detail">

    🏷 Brand:

    <%= safeText(brand) %>

</div>


<div class="detail">

    🚘 Type:

    <%= safeText(type) %>

</div>


</div>


<p class="status">

    ● <%= safeText(status) %>

</p>


<div class="button-row">


<a
    href="<%= request.getContextPath() %>/edit-vehicle.jsp?id=<%= vehicleId %>"

    class="btn edit">

    ✏ Edit

</a>


<a
    href="<%= request.getContextPath() %>/DeleteVehicleServlet?id=<%= vehicleId %>"

    class="btn delete"

    onclick="return confirmDelete('<%= safeText(carName) %>');">

    🗑 Delete

</a>


</div>


</div>

</div>


<%

    }


    if(!vehicleFound) {

%>


<div class="empty-box">

    <h2>
        Koi vehicle available nahi hai
    </h2>

    <p>
        Add New Vehicle button se pehla vehicle add karo.
    </p>

</div>


<%

    }


} catch(Exception e) {


    e.printStackTrace();

%>


<div class="empty-box">

    <h2>
        Database Error
    </h2>

    <p>
        Vehicles load nahi ho paayi.
    </p>

</div>


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


</div>

</div>


<script>


function searchVehicles(){


    const searchValue =
        document
        .getElementById(
            "searchInput"
        )
        .value
        .toLowerCase()
        .trim();


    const cards =
        document
        .querySelectorAll(
            ".vehicle-card"
        );


    cards.forEach(
        function(card){


            const name =
                card.getAttribute(
                    "data-name"
                ) || "";


            const brand =
                card.getAttribute(
                    "data-brand"
                ) || "";


            const type =
                card.getAttribute(
                    "data-type"
                ) || "";


            const matched =
                name.includes(
                    searchValue
                )
                ||
                brand.includes(
                    searchValue
                )
                ||
                type.includes(
                    searchValue
                );


            card.style.display =
                matched
                ? "flex"
                : "none";

        }
    );

}


function confirmDelete(vehicleName){


    return confirm(
        "Kya aap "
        + vehicleName
        + " ko delete karna chahte ho?"
    );

}


</script>


</body>

</html>
