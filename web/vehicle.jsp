<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.ArrayList" %>

<%
    ArrayList<String[]> vehicleList =
            (ArrayList<String[]>) request.getAttribute("vehicleList");

    if (vehicleList == null) {

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

<title>LuxeDrive - Luxury Vehicles</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, sans-serif;
}

body{
    background:
        radial-gradient(circle at top left,
        rgba(0,255,204,0.15),
        transparent 35%),
        radial-gradient(circle at bottom right,
        rgba(52,152,219,0.18),
        transparent 35%),
        linear-gradient(135deg,#08111f,#142238,#243b55);

    color:white;
    min-height:100vh;
}

/* NAVBAR */

.navbar{
    min-height:75px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:0 40px;
    background:rgba(255,255,255,0.10);
    backdrop-filter:blur(20px);
    box-shadow:0 8px 30px rgba(0,0,0,0.55);
    border-bottom:1px solid rgba(255,255,255,0.12);
    position:sticky;
    top:0;
    z-index:1000;
}

.logo{
    font-size:32px;
    font-weight:bold;
    color:#00ffcc;
    text-shadow:0 0 18px rgba(0,255,204,0.6);
}

.navbar a{
    color:white;
    text-decoration:none;
    margin-left:25px;
    font-size:17px;
    transition:0.3s;
}

.navbar a:hover{
    color:#00ffcc;
    text-shadow:0 0 12px #00ffcc;
}

/* HEADER */

.header{
    margin:40px;
    padding:45px 35px;
    background:rgba(255,255,255,0.10);
    backdrop-filter:blur(20px);
    border-radius:30px;
    text-align:center;
    border:1px solid rgba(255,255,255,0.12);
    box-shadow:0 20px 50px rgba(0,0,0,0.35);
}

.header h1{
    font-size:45px;
    letter-spacing:1px;
}

.header span{
    color:#00ffcc;
    text-shadow:0 0 20px rgba(0,255,204,0.55);
}

.header p{
    margin-top:12px;
    font-size:17px;
    color:#d5dbe4;
}

/* SEARCH */

.search-box{
    margin:30px auto 0;
    text-align:center;
}

.search-box input{
    width:430px;
    max-width:90%;
    padding:17px 22px;
    border:1px solid rgba(0,255,204,0.35);
    outline:none;
    border-radius:30px;
    font-size:16px;
    background:rgba(255,255,255,0.95);
    box-shadow:0 0 25px rgba(0,255,204,0.15);
}

/* FILTER */

.filter{
    display:flex;
    justify-content:center;
    gap:20px;
    margin-bottom:40px;
    flex-wrap:wrap;
}

.filter button{
    padding:12px 27px;
    border:none;
    border-radius:25px;
    background:#00ffcc;
    color:#07131d;
    cursor:pointer;
    font-weight:bold;
    font-size:15px;
    transition:0.3s;
    box-shadow:0 0 15px rgba(0,255,204,0.2);
}

.filter button:hover,
.filter button.active{
    background:#00b894;
    color:white;
    transform:translateY(-3px);
    box-shadow:0 0 22px rgba(0,255,204,0.55);
}

/* CAR CONTAINER */

.container{
    padding:0 40px 60px;
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:30px;
}

.car{
    background:rgba(255,255,255,0.10);
    border-radius:30px;
    overflow:hidden;
    backdrop-filter:blur(20px);
    box-shadow:0 18px 40px rgba(0,0,0,0.50);
    border:1px solid rgba(255,255,255,0.10);
    transition:0.4s;
    position:relative;
}

.car:hover{
    transform:translateY(-12px) scale(1.01);
    border-color:rgba(0,255,204,0.45);
    box-shadow:
        0 25px 55px rgba(0,0,0,0.65),
        0 0 30px rgba(0,255,204,0.15);
}

.image-box{
    width:100%;
    height:240px;
    position:relative;
    overflow:hidden;
}

.image-box::after{
    content:"";
    position:absolute;
    left:0;
    right:0;
    bottom:0;
    height:80px;
    background:linear-gradient(
        transparent,
        rgba(5,15,25,0.85)
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

.category-badge{
    position:absolute;
    top:18px;
    left:18px;
    z-index:2;
    padding:8px 15px;
    border-radius:20px;
    background:rgba(0,0,0,0.65);
    color:#00ffcc;
    font-size:13px;
    font-weight:bold;
    border:1px solid rgba(0,255,204,0.40);
    backdrop-filter:blur(10px);
}

.info{
    padding:25px;
}

.info h2{
    color:#00ffcc;
    font-size:26px;
    text-shadow:0 0 12px rgba(0,255,204,0.25);
}

.price{
    font-size:22px;
    margin:15px 0;
    font-weight:bold;
}

.details{
    display:flex;
    justify-content:space-between;
    gap:10px;
    margin-top:12px;
    color:#e3e7eb;
}

.details span{
    width:48%;
    background:rgba(255,255,255,0.07);
    padding:10px;
    border-radius:12px;
    font-size:14px;
}

.status{
    margin-top:18px;
    font-weight:bold;
    color:#00ffcc;
}

.not-available{
    color:#ff6b6b;
}

.book{
    margin-top:20px;
    width:100%;
    padding:14px;
    border:none;
    border-radius:25px;
    background:#00ffcc;
    font-size:17px;
    font-weight:bold;
    cursor:pointer;
    display:block;
    text-align:center;
    text-decoration:none;
    color:black;
    transition:0.3s;
}

.book:hover{
    background:#00b894;
    color:white;
    transform:translateY(-2px);
    box-shadow:0 0 22px rgba(0,255,204,0.45);
}

.empty-message{
    grid-column:1/-1;
    text-align:center;
    font-size:25px;
    padding:50px;
    background:rgba(255,255,255,0.08);
    border-radius:25px;
}

/* RESPONSIVE */

@media(max-width:1000px){

    .container{
        grid-template-columns:repeat(2,1fr);
    }
}

@media(max-width:650px){

    .navbar{
        height:auto;
        padding:20px;
        flex-direction:column;
        gap:20px;
    }

    .navbar div:last-child{
        text-align:center;
    }

    .navbar a{
        display:inline-block;
        margin:8px;
    }

    .header{
        margin:20px;
        padding:35px 20px;
    }

    .header h1{
        font-size:32px;
    }

    .container{
        grid-template-columns:1fr;
        padding:20px;
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

        <a href="<%= request.getContextPath() %>/my-bookings.jsp">
            My Bookings
        </a>

        <a href="<%= request.getContextPath() %>/profile.jsp">
            Profile
        </a>

    </div>

</div>

<div class="header">

    <h1>
        Explore <span>Luxury Cars</span> Collection
    </h1>

    <p>
        Drive the world's most premium automobiles
    </p>

    <div class="search-box">

        <input type="text"
               id="search"
               placeholder="Search your dream car..."
               onkeyup="searchCar()">

    </div>

</div>

<div class="filter">

    <button type="button"
            class="filter-button active"
            onclick="filterCar('all', this)">
        All
    </button>

    <button type="button"
            class="filter-button"
            onclick="filterCar('super', this)">
        Supercar
    </button>

    <button type="button"
            class="filter-button"
            onclick="filterCar('luxury', this)">
        Luxury
    </button>

    <button type="button"
            class="filter-button"
            onclick="filterCar('suv', this)">
        SUV
    </button>

</div>

<div class="container" id="cars">

<%
    if (vehicleList.isEmpty()) {
%>

    <div class="empty-message">
        No vehicles available.
    </div>

<%
    } else {

        for (String[] vehicle : vehicleList) {

            String category = vehicle[10];

            String filterClass = "luxury";

            if (category != null) {

                String lowerCategory =
                        category.toLowerCase();

                if (lowerCategory.contains("suv")) {

                    filterClass = "suv";

                } else if (
                        lowerCategory.contains("super")
                        || lowerCategory.contains("sports")
                        || lowerCategory.contains("hyper")) {

                    filterClass = "super";
                }
            }

            String status = vehicle[12];

            boolean available =
                    status != null
                    && status.equalsIgnoreCase("Available");
%>

    <div class="car <%= filterClass %>">

        <div class="image-box">

            <span class="category-badge">
                <%= vehicle[10] %>
            </span>

            <img
                src="<%= request.getContextPath() %>/<%= vehicle[2] %>"

                alt="<%= vehicle[1] %>"

                onerror="this.onerror=null;
                this.src='<%= request.getContextPath() %>/images/cars/bugatti.jpg';">

        </div>

        <div class="info">

            <h2>
                <%= vehicle[1] %>
            </h2>

            <p class="price">
                ₹<%= vehicle[3] %> / Day
            </p>

            <div class="details">

                <span>
                    🚘 <%= vehicle[10] %>
                </span>

                <span>
                    ⚡ <%= vehicle[5] %>
                </span>

            </div>

            <div class="details">

                <span>
                    ⚙ <%= vehicle[9] %>
                </span>

                <span>
                    💺 <%= vehicle[8] %> Seats
                </span>

            </div>

            <p class="status <%= available ? "" : "not-available" %>">

                <%= available
                        ? "● Available"
                        : "● Not Available" %>

            </p>

            <a class="book"
               href="<%= request.getContextPath() %>/VehicleDetailsServlet?id=<%= vehicle[0] %>">

                View Details

            </a>

        </div>

    </div>

<%
        }
    }
%>

</div>

<script>

let selectedCategory = "all";

function searchCar(){

    let input = document
        .getElementById("search")
        .value
        .toLowerCase()
        .trim();

    let cars = document
        .getElementsByClassName("car");

    for(let i = 0; i < cars.length; i++){

        let heading =
            cars[i].getElementsByTagName("h2")[0];

        let name = heading
            ? heading.innerText.toLowerCase()
            : "";

        let nameMatched =
            name.includes(input);

        let categoryMatched =
            selectedCategory === "all"
            || cars[i].classList.contains(selectedCategory);

        if(nameMatched && categoryMatched){

            cars[i].style.display = "block";

        }else{

            cars[i].style.display = "none";
        }
    }
}

function filterCar(category, button){

    selectedCategory = category;

    let buttons = document
        .getElementsByClassName("filter-button");

    for(let i = 0; i < buttons.length; i++){

        buttons[i].classList.remove("active");
    }

    button.classList.add("active");

    searchCar();
}

</script>

</body>
</html>