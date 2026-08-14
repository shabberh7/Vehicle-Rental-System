<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    /*
     Sirf admin ko page access milega
    */
    if (session.getAttribute("userId") == null
            || session.getAttribute("userRole") == null
            || !"admin".equalsIgnoreCase(
                    session.getAttribute("userRole").toString()
            )) {

        response.sendRedirect("login.jsp");
        return;
    }

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Add Vehicle</title>

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
        radial-gradient(
            circle at top left,
            rgba(0, 255, 204, 0.18),
            transparent 30%
        ),
        radial-gradient(
            circle at bottom right,
            rgba(0, 140, 255, 0.18),
            transparent 35%
        ),
        linear-gradient(
            135deg,
            #07111f,
            #141e30,
            #243b55
        );

}

/* =========================
   NAVBAR
========================= */

.navbar {

    min-height: 75px;

    display: flex;
    justify-content: space-between;
    align-items: center;

    padding: 15px 40px;

    background: rgba(255, 255, 255, 0.09);

    border-bottom:
        1px solid rgba(255, 255, 255, 0.15);

    backdrop-filter: blur(20px);

    position: sticky;
    top: 0;
    z-index: 100;

}

.logo {

    font-size: 29px;
    font-weight: bold;

    color: #00ffcc;

    text-shadow:
        0 0 15px rgba(0, 255, 204, 0.45);

}

.nav-links {

    display: flex;
    align-items: center;
    gap: 12px;

}

.nav-links a {

    color: white;

    text-decoration: none;

    padding: 10px 16px;

    border-radius: 20px;

    transition: 0.3s;

}

.nav-links a:hover {

    color: #07111f;

    background: #00ffcc;

    box-shadow:
        0 0 18px rgba(0, 255, 204, 0.5);

}

/* =========================
   PAGE CONTAINER
========================= */

.container {

    width: 92%;
    max-width: 1000px;

    margin: 45px auto;

}

.box {

    padding: 40px;

    background: rgba(255, 255, 255, 0.10);

    border:
        1px solid rgba(255, 255, 255, 0.15);

    border-radius: 30px;

    backdrop-filter: blur(22px);

    box-shadow:
        0 25px 70px rgba(0, 0, 0, 0.48);

}

.box h1 {

    text-align: center;

    color: #00ffcc;

    font-size: 34px;

    margin-bottom: 10px;

}

.subtitle {

    text-align: center;

    color: #cbd5e1;

    margin-bottom: 30px;

}

/* =========================
   MESSAGE BOX
========================= */

.message {

    width: 100%;

    padding: 15px;

    border-radius: 14px;

    text-align: center;

    font-weight: bold;

    margin-bottom: 25px;

}

.success-message {

    color: #04251e;

    background: #00ffcc;

    box-shadow:
        0 0 20px rgba(0, 255, 204, 0.35);

}

.error-message {

    color: white;

    background: #ff4d5a;

    box-shadow:
        0 0 20px rgba(255, 77, 90, 0.35);

}

/* =========================
   FORM
========================= */

.form-grid {

    display: grid;

    grid-template-columns:
        repeat(2, minmax(0, 1fr));

    gap: 22px;

}

.input-box {

    display: flex;

    flex-direction: column;

}

.input-box label {

    margin-bottom: 9px;

    font-size: 15px;

    color: #e2e8f0;

    font-weight: 600;

}

.input-box input,
.input-box select,
.input-box textarea {

    width: 100%;

    padding: 15px 16px;

    color: #111827;

    background: rgba(255, 255, 255, 0.96);

    border:
        2px solid transparent;

    outline: none;

    border-radius: 14px;

    font-size: 15px;

    transition: 0.3s;

}

.input-box input:focus,
.input-box select:focus,
.input-box textarea:focus {

    border-color: #00ffcc;

    box-shadow:
        0 0 0 4px rgba(0, 255, 204, 0.14);

    transform: translateY(-1px);

}

.input-box textarea {

    min-height: 125px;

    resize: vertical;

}

.full {

    grid-column: 1 / 3;

}

/* File input styling */

input[type="file"] {

    padding: 11px;

}

input[type="file"]::file-selector-button {

    padding: 10px 16px;

    margin-right: 12px;

    border: none;

    border-radius: 10px;

    color: #07111f;

    background: #00ffcc;

    font-weight: bold;

    cursor: pointer;

}

/* =========================
   IMAGE PREVIEW
========================= */

.preview-wrapper {

    display: none;

    margin-top: 15px;

    text-align: center;

}

.preview-wrapper p {

    margin-bottom: 10px;

    color: #cbd5e1;

}

#imagePreview {

    width: 100%;
    max-width: 340px;
    height: 190px;

    object-fit: cover;

    border-radius: 18px;

    border:
        2px solid rgba(0, 255, 204, 0.7);

    box-shadow:
        0 0 24px rgba(0, 255, 204, 0.24);

}

/* =========================
   BUTTONS
========================= */

.button-row {

    display: flex;

    gap: 15px;

    margin-top: 30px;

}

.btn {

    flex: 1;

    padding: 17px;

    border: none;

    border-radius: 30px;

    font-size: 18px;

    font-weight: bold;

    cursor: pointer;

    transition: 0.3s;

}

.submit-btn {

    color: #07111f;

    background:
        linear-gradient(
            135deg,
            #00ffcc,
            #43e8b8
        );

    box-shadow:
        0 0 24px rgba(0, 255, 204, 0.30);

}

.submit-btn:hover {

    transform: translateY(-3px) scale(1.01);

    box-shadow:
        0 12px 30px rgba(0, 255, 204, 0.38);

}

.reset-btn {

    color: white;

    background:
        rgba(255, 255, 255, 0.12);

    border:
        1px solid rgba(255, 255, 255, 0.22);

}

.reset-btn:hover {

    color: #07111f;

    background: white;

    transform: translateY(-3px);

}

/* =========================
   RESPONSIVE
========================= */

@media (max-width: 800px) {

    .navbar {

        padding: 15px 20px;

        flex-direction: column;

        gap: 15px;

    }

    .logo {

        font-size: 24px;

    }

    .nav-links {

        flex-wrap: wrap;

        justify-content: center;

    }

    .container {

        width: 94%;

        margin: 25px auto;

    }

    .box {

        padding: 25px 18px;

        border-radius: 22px;

    }

    .box h1 {

        font-size: 27px;

    }

    .form-grid {

        grid-template-columns: 1fr;

    }

    .full {

        grid-column: 1;

    }

    .button-row {

        flex-direction: column;

    }

}

</style>


<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vehicle-theme.css">
</head>

<body>

<!-- =========================
     NAVBAR
========================= -->

<div class="navbar">

    <div class="logo">
        🚘 LuxeDrive Admin
    </div>

    <div class="nav-links">

        <a href="admin-dashboard.jsp">
            Dashboard
        </a>

        <a href="manage-vehicles.jsp">
            Vehicles
        </a>

        <a href="add-vehicle.jsp">
            Add Vehicle
        </a>

        <a href="LogoutServlet">
            Logout
        </a>

    </div>

</div>

<!-- =========================
     MAIN CONTENT
========================= -->

<div class="container">

    <div class="box">

        <h1>
            ➕ Add New Vehicle
        </h1>

        <p class="subtitle">
            Enter complete vehicle details and add it to the rental system.
        </p>

        <!-- Success message -->

        <% if ("1".equals(success)) { %>

            <div class="message success-message">
                Vehicle successfully added ✅
            </div>

        <% } %>

        <!-- Error message -->

        <% if ("1".equals(error)) { %>

            <div class="message error-message">
                Vehicle add nahi hua. Details check karke dobara try karo.
            </div>

        <% } %>

        <!-- =========================
             ADD VEHICLE FORM
        ========================= -->

        <form
            action="<%= request.getContextPath() %>/AddVehicleServlet"
            method="post"
            enctype="multipart/form-data"
            onsubmit="return validateVehicleForm();">

            <div class="form-grid">

                <!-- Vehicle Name -->

                <div class="input-box">

                    <label for="carName">
                        Vehicle Name
                    </label>

                    <input
                        type="text"
                        id="carName"
                        name="carName"
                        placeholder="Example: Lamborghini Aventador"
                        maxlength="100"
                        required>

                </div>

                <!-- Price -->

                <div class="input-box">

                    <label for="price">
                        Price Per Day
                    </label>

                    <input
                        type="number"
                        id="price"
                        name="price"
                        placeholder="Example: 25000"
                        min="1"
                        step="0.01"
                        required>

                </div>

                <!-- Vehicle Image -->

                <div class="input-box full">

                    <label for="image">
                        Vehicle Image
                    </label>

                    <input
                        type="file"
                        id="image"
                        name="image"
                        accept=".jpg,.jpeg,.png,.webp,image/*"
                        onchange="showImagePreview(event)"
                        required>

                    <div
                        class="preview-wrapper"
                        id="previewWrapper">

                        <p>Image Preview</p>

                        <img
                            id="imagePreview"
                            alt="Vehicle preview">

                    </div>

                </div>

                <!-- Engine -->

                <div class="input-box">

                    <label for="engine">
                        Engine
                    </label>

                    <input
                        type="text"
                        id="engine"
                        name="engine"
                        placeholder="Example: 6.5L V12"
                        maxlength="100"
                        required>

                </div>

                <!-- Power -->

                <div class="input-box">

                    <label for="power">
                        Power
                    </label>

                    <input
                        type="text"
                        id="power"
                        name="power"
                        placeholder="Example: 769 HP"
                        maxlength="100"
                        required>

                </div>

                <!-- Speed -->

                <div class="input-box">

                    <label for="speed">
                        Top Speed
                    </label>

                    <input
                        type="text"
                        id="speed"
                        name="speed"
                        placeholder="Example: 350 km/h"
                        maxlength="100"
                        required>

                </div>

                <!-- Fuel -->

                <div class="input-box">

                    <label for="fuel">
                        Fuel Type
                    </label>

                    <select
                        id="fuel"
                        name="fuel"
                        required>

                        <option value="">
                            Select Fuel Type
                        </option>

                        <option value="Petrol">
                            Petrol
                        </option>

                        <option value="Diesel">
                            Diesel
                        </option>

                        <option value="Hybrid">
                            Hybrid
                        </option>

                        <option value="Electric">
                            Electric
                        </option>

                    </select>

                </div>

                <!-- Seats -->

                <div class="input-box">

                    <label for="seats">
                        Seats
                    </label>

                    <input
                        type="number"
                        id="seats"
                        name="seats"
                        placeholder="Example: 2"
                        min="1"
                        max="20"
                        required>

                </div>

                <!-- Transmission -->

                <div class="input-box">

                    <label for="transmission">
                        Transmission
                    </label>

                    <select
                        id="transmission"
                        name="transmission"
                        required>

                        <option value="">
                            Select Transmission
                        </option>

                        <option value="Automatic">
                            Automatic
                        </option>

                        <option value="Manual">
                            Manual
                        </option>

                    </select>

                </div>

                <!-- Category -->

                <div class="input-box">

                    <label for="category">
                        Category
                    </label>

                    <select
                        id="category"
                        name="category"
                        required>

                        <option value="">
                            Select Category
                        </option>

                        <option value="Super Car">
                            Super Car
                        </option>

                        <option value="Luxury Sedan">
                            Luxury Sedan
                        </option>

                        <option value="SUV">
                            SUV
                        </option>

                        <option value="Sports Car">
                            Sports Car
                        </option>

                        <option value="Hyper Car">
                            Hyper Car
                        </option>

                    </select>

                </div>

                <!-- Description -->

                <div class="input-box full">

                    <label for="description">
                        Description
                    </label>

                    <textarea
                        id="description"
                        name="description"
                        placeholder="Write complete vehicle description..."
                        maxlength="1000"
                        required></textarea>

                </div>

            </div>

            <!-- Buttons -->

            <div class="button-row">

                <button
                    class="btn submit-btn"
                    type="submit">

                    Add Vehicle 🚘

                </button>

                <button
                    class="btn reset-btn"
                    type="reset"
                    onclick="clearPreview();">

                    Clear Form

                </button>

            </div>

        </form>

    </div>

</div>

<script>

/*
 Vehicle form validation
*/

function validateVehicleForm() {

    const carName =
        document.getElementById("carName").value.trim();

    const price =
        document.getElementById("price").value.trim();

    const engine =
        document.getElementById("engine").value.trim();

    const power =
        document.getElementById("power").value.trim();

    const speed =
        document.getElementById("speed").value.trim();

    const seats =
        document.getElementById("seats").value.trim();

    const description =
        document.getElementById("description").value.trim();

    const image =
        document.getElementById("image");

    if (carName === "") {

        alert("Vehicle name enter karo.");
        return false;

    }

    if (Number(price) <= 0) {

        alert("Price zero se bada hona chahiye.");
        return false;

    }

    if (engine === "") {

        alert("Engine details enter karo.");
        return false;

    }

    if (power === "") {

        alert("Vehicle power enter karo.");
        return false;

    }

    if (speed === "") {

        alert("Top speed enter karo.");
        return false;

    }

    if (Number(seats) <= 0) {

        alert("Seats ki valid value enter karo.");
        return false;

    }

    if (description.length < 10) {

        alert(
            "Description kam se kam 10 characters ki honi chahiye."
        );

        return false;

    }

    if (image.files.length === 0) {

        alert("Vehicle image select karo.");
        return false;

    }

    const selectedFile =
        image.files[0];

    const allowedTypes = [
        "image/jpeg",
        "image/png",
        "image/webp"
    ];

    if (!allowedTypes.includes(selectedFile.type)) {

        alert(
            "Sirf JPG, JPEG, PNG ya WEBP image select karo."
        );

        return false;

    }

    const maximumSize =
        5 * 1024 * 1024;

    if (selectedFile.size > maximumSize) {

        alert(
            "Image size maximum 5 MB honi chahiye."
        );

        return false;

    }

    return true;

}


/*
 Selected image preview
*/

function showImagePreview(event) {

    const file =
        event.target.files[0];

    const previewWrapper =
        document.getElementById("previewWrapper");

    const imagePreview =
        document.getElementById("imagePreview");

    if (!file) {

        clearPreview();
        return;

    }

    const reader =
        new FileReader();

    reader.onload = function(e) {

        imagePreview.src =
            e.target.result;

        previewWrapper.style.display =
            "block";

    };

    reader.readAsDataURL(file);

}


/*
 Reset karne par preview remove
*/

function clearPreview() {

    const previewWrapper =
        document.getElementById("previewWrapper");

    const imagePreview =
        document.getElementById("imagePreview");

    previewWrapper.style.display =
        "none";

    imagePreview.src =
        "";

}

</script>

</body>

</html>