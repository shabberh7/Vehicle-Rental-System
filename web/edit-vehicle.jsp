<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="collage.DBConnection" %>

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
    if (session.getAttribute("userId") == null
            || session.getAttribute("userRole") == null
            || !"admin".equalsIgnoreCase(
                    session.getAttribute("userRole").toString()
            )) {

        response.sendRedirect("login.jsp");
        return;
    }

    String idValue = request.getParameter("id");

    if (idValue == null || idValue.trim().isEmpty()) {

        response.sendRedirect("manage-vehicles.jsp?error=invalidVehicle");
        return;
    }

    int vehicleId;

    try {

        vehicleId = Integer.parseInt(idValue);

    } catch (NumberFormatException e) {

        response.sendRedirect("manage-vehicles.jsp?error=invalidVehicle");
        return;
    }

    String carName = "";
    String image = "";
    double price = 0;
    String engine = "";
    String power = "";
    String speed = "";
    String fuel = "";
    int seats = 0;
    String transmission = "";
    String category = "";
    String description = "";

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {

        con = DBConnection.getConnection();

        String sql =
                "SELECT car_name, image, price, engine, power, "
                + "speed, fuel, seats, transmission, category, "
                + "description FROM vehicles WHERE id = ?";

        ps = con.prepareStatement(sql);

        ps.setInt(1, vehicleId);

        rs = ps.executeQuery();

        if (rs.next()) {

            carName = rs.getString("car_name");
            image = rs.getString("image");
            price = rs.getDouble("price");
            engine = rs.getString("engine");
            power = rs.getString("power");
            speed = rs.getString("speed");
            fuel = rs.getString("fuel");
            seats = rs.getInt("seats");
            transmission = rs.getString("transmission");
            category = rs.getString("category");
            description = rs.getString("description");

        } else {

            response.sendRedirect(
                    "manage-vehicles.jsp?error=vehicleNotFound"
            );

            return;
        }

    } catch (Exception e) {

        e.printStackTrace();

        response.sendRedirect(
                "manage-vehicles.jsp?error=loadFailed"
        );

        return;

    } finally {

        try {

            if (rs != null) {
                rs.close();
            }

            if (ps != null) {
                ps.close();
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
    }

    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Edit Vehicle</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Poppins, Arial, sans-serif;
}

body {

    min-height: 100vh;

    color: white;

    background:
        linear-gradient(
            135deg,
            #141e30,
            #243b55
        );
}

.navbar {

    min-height: 75px;

    display: flex;
    justify-content: space-between;
    align-items: center;

    padding: 15px 40px;

    background: #102030;

    border-bottom:
        1px solid rgba(255, 255, 255, 0.15);
}

.logo {

    color: #00ffcc;

    font-size: 30px;
    font-weight: bold;
}

.navbar a {

    margin-left: 25px;

    color: white;

    text-decoration: none;
}

.navbar a:hover {

    color: #00ffcc;
}

.container {

    width: 90%;
    max-width: 900px;

    margin: 40px auto;
}

.box {

    padding: 40px;

    background: #1c2b3d;

    border:
        1px solid rgba(255, 255, 255, 0.15);

    border-radius: 30px;

    box-shadow:
        0 20px 50px rgba(0, 0, 0, 0.45);
}

.box h1 {

    margin-bottom: 35px;

    color: #00ffcc;

    text-align: center;
}

.error-message {

    margin-bottom: 25px;

    padding: 14px;

    color: white;

    background: #ff4d5a;

    border-radius: 15px;

    text-align: center;

    font-weight: bold;
}

.current-image {

    margin-bottom: 25px;

    text-align: center;
}

.current-image img {

    width: 100%;
    max-width: 430px;
    height: 230px;

    object-fit: cover;

    display: block;

    margin: 0 auto 12px;

    border-radius: 20px;

    background: #101827;

    border:
        1px solid rgba(255, 255, 255, 0.15);
}

.current-image p {

    color: #cbd5e1;

    font-size: 14px;
}

.form-grid {

    display: grid;

    grid-template-columns: 1fr 1fr;

    gap: 20px;
}

.input-box {

    margin-bottom: 15px;
}

.input-box label {

    display: block;

    margin-bottom: 8px;

    font-size: 16px;
}

.input-box input,
.input-box select,
.input-box textarea {

    width: 100%;

    padding: 15px;

    color: #111827;

    background: white;

    border: 2px solid transparent;

    outline: none;

    border-radius: 15px;

    font-size: 16px;
}

.input-box input:focus,
.input-box select:focus,
.input-box textarea:focus {

    border-color: #00ffcc;

    box-shadow:
        0 0 0 4px rgba(0, 255, 204, 0.12);
}

.input-box textarea {

    min-height: 130px;

    resize: vertical;
}

.full {

    grid-column: 1 / 3;
}

.btn {

    width: 100%;

    margin-top: 25px;

    padding: 18px;

    color: #07111f;

    background: #00ffcc;

    border: none;

    border-radius: 30px;

    font-size: 20px;
    font-weight: bold;

    cursor: pointer;

    transition:
        background 0.3s ease,
        transform 0.3s ease;
}

.btn:hover {

    background: #00c7a3;

    transform: translateY(-2px);
}

@media (max-width: 800px) {

    .navbar {

        padding: 15px 20px;

        flex-direction: column;

        gap: 15px;
    }

    .navbar a {

        margin: 0 10px;
    }

    .box {

        padding: 25px 20px;
    }

    .form-grid {

        grid-template-columns: 1fr;
    }

    .full {

        grid-column: 1;
    }
}

</style>


<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vehicle-theme.css">
</head>

<body>

<div class="navbar">

    <div class="logo">
        🚘 LuxeDrive Admin
    </div>

    <div>

        <a href="admin-dashboard.jsp">
            Dashboard
        </a>

        <a href="manage-vehicles.jsp">
            Vehicles
        </a>

    </div>

</div>

<div class="container">

    <div class="box">

        <h1>
            ✏ Edit Vehicle
        </h1>

        <% if ("invalidData".equals(error)) { %>

            <div class="error-message">
                Please sabhi details sahi bharo.
            </div>

        <% } %>

        <% if ("updateFailed".equals(error)) { %>

            <div class="error-message">
                Vehicle update nahi hua.
            </div>

        <% } %>

        <div class="current-image">

            <%
                String imagePath;

                if (image == null || image.trim().isEmpty()) {

                    imagePath =
                            request.getContextPath()
                            + "/images/no-car.png";

                } else if (image.startsWith("http://")
                        || image.startsWith("https://")) {

                    imagePath = image;

                } else {

                    imagePath =
                            request.getContextPath()
                            + "/"
                            + image;
                }
            %>

            <img
                src="<%= imagePath %>"
                alt="<%= safeText(carName) %>"
                onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/images/no-car.png';">

            <p>
                Current vehicle image
            </p>

        </div>

        <form
            action="<%= request.getContextPath() %>/UpdateVehicleServlet"
            method="post"
            enctype="multipart/form-data">

            <input
                type="hidden"
                name="vehicleId"
                value="<%= vehicleId %>">

            <input
                type="hidden"
                name="oldImage"
                value="<%= safeText(image) %>">

            <div class="form-grid">

                <div class="input-box">

                    <label>Vehicle Name</label>

                    <input
                        type="text"
                        name="carName"
                        value="<%= safeText(carName) %>"
                        required>

                </div>

                <div class="input-box">

                    <label>Price Per Day</label>

                    <input
                        type="number"
                        name="price"
                        value="<%= price %>"
                        min="1"
                        step="0.01"
                        required>

                </div>

                <div class="input-box full">

                    <label>
                        New Vehicle Image
                        (optional)
                    </label>

                    <input
                        type="file"
                        name="image"
                        accept="image/*">

                </div>

                <div class="input-box">

                    <label>Engine</label>

                    <input
                        type="text"
                        name="engine"
                        value="<%= safeText(engine) %>"
                        required>

                </div>

                <div class="input-box">

                    <label>Power</label>

                    <input
                        type="text"
                        name="power"
                        value="<%= safeText(power) %>"
                        required>

                </div>

                <div class="input-box">

                    <label>Top Speed</label>

                    <input
                        type="text"
                        name="speed"
                        value="<%= safeText(speed) %>"
                        required>

                </div>

                <div class="input-box">

                    <label>Fuel Type</label>

                    <select name="fuel" required>

                        <option value="Petrol"
                            <%= "Petrol".equalsIgnoreCase(fuel)
                                    ? "selected" : "" %>>
                            Petrol
                        </option>

                        <option value="Diesel"
                            <%= "Diesel".equalsIgnoreCase(fuel)
                                    ? "selected" : "" %>>
                            Diesel
                        </option>

                        <option value="Hybrid"
                            <%= "Hybrid".equalsIgnoreCase(fuel)
                                    ? "selected" : "" %>>
                            Hybrid
                        </option>

                        <option value="Electric"
                            <%= "Electric".equalsIgnoreCase(fuel)
                                    ? "selected" : "" %>>
                            Electric
                        </option>

                    </select>

                </div>

                <div class="input-box">

                    <label>Seats</label>

                    <input
                        type="number"
                        name="seats"
                        value="<%= seats %>"
                        min="1"
                        max="20"
                        required>

                </div>

                <div class="input-box">

                    <label>Transmission</label>

                    <select
                        name="transmission"
                        required>

                        <option value="Automatic"
                            <%= "Automatic".equalsIgnoreCase(transmission)
                                    ? "selected" : "" %>>
                            Automatic
                        </option>

                        <option value="Manual"
                            <%= "Manual".equalsIgnoreCase(transmission)
                                    ? "selected" : "" %>>
                            Manual
                        </option>

                    </select>

                </div>

                <div class="input-box">

                    <label>Category</label>

                    <select
                        name="category"
                        required>

                        <option value="Hyper Car"
                            <%= "Hyper Car".equalsIgnoreCase(category)
                                    ? "selected" : "" %>>
                            Hyper Car
                        </option>

                        <option value="Super Car"
                            <%= "Super Car".equalsIgnoreCase(category)
                                    ? "selected" : "" %>>
                            Super Car
                        </option>

                        <option value="Luxury Sedan"
                            <%= "Luxury Sedan".equalsIgnoreCase(category)
                                    ? "selected" : "" %>>
                            Luxury Sedan
                        </option>

                        <option value="SUV"
                            <%= "SUV".equalsIgnoreCase(category)
                                    ? "selected" : "" %>>
                            SUV
                        </option>

                    </select>

                </div>

                <div class="input-box full">

                    <label>Description</label>

                    <textarea
                        name="description"
                        required><%= safeText(description) %></textarea>

                </div>

            </div>

            <button
                class="btn"
                type="submit">

                Update Vehicle 🚘

            </button>

        </form>

    </div>

</div>

</body>

</html>