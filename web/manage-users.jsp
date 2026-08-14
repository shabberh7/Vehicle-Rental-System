<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="collage.DBConnection" %>

<%
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

<title>Manage Users</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Poppins, Arial, sans-serif;
}

body{
    min-height:100vh;
    color:white;

    background:
        radial-gradient(circle at top left,
        rgba(0,255,204,0.12),transparent 30%),

        radial-gradient(circle at bottom right,
        rgba(0,119,255,0.16),transparent 35%),

        linear-gradient(135deg,#07111f,#141e30,#243b55);
}

.navbar{
    min-height:75px;

    display:flex;
    justify-content:space-between;
    align-items:center;

    padding:15px 40px;

    background:#102030;

    border-bottom:
        1px solid rgba(255,255,255,0.15);

    position:sticky;
    top:0;
    z-index:100;
}

.logo{
    font-size:29px;
    font-weight:bold;
    color:#00ffcc;
}

.nav-links{
    display:flex;
    align-items:center;
    gap:10px;
}

.nav-links a{
    color:white;
    text-decoration:none;

    padding:10px 15px;

    border-radius:22px;

    transition:0.3s;
}

.nav-links a:hover{
    color:#07111f;
    background:#00ffcc;
}

.container{
    width:94%;
    max-width:1350px;

    margin:40px auto;
}

.heading{
    text-align:center;

    font-size:40px;

    color:#00ffcc;

    margin-bottom:8px;
}

.subtitle{
    color:#cbd5e1;

    text-align:center;

    margin-bottom:30px;
}

.message{
    max-width:800px;

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
        0 0 0 4px rgba(0,255,204,0.13);
}

.table-box{
    overflow-x:auto;

    background:#1c2b3d;

    border:
        1px solid rgba(255,255,255,0.14);

    border-radius:25px;

    box-shadow:
        0 20px 45px rgba(0,0,0,0.40);
}

table{
    width:100%;

    border-collapse:collapse;

    min-width:1050px;
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
        1px solid rgba(255,255,255,0.10);

    vertical-align:middle;
}

tbody tr{
    transition:0.3s;
}

tbody tr:hover{
    background:rgba(255,255,255,0.06);
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

.booking-count{
    color:#00ffcc;
    font-weight:bold;
}

.status{
    display:inline-block;

    min-width:90px;

    padding:8px 12px;

    border-radius:20px;

    text-align:center;

    color:#05251e;
    background:#00ffcc;

    font-size:13px;
    font-weight:bold;
}

.action-box{
    display:flex;
    flex-wrap:wrap;
    gap:8px;
}

.btn{
    display:inline-block;

    padding:9px 14px;

    border:none;

    border-radius:18px;

    text-decoration:none;

    font-size:12px;
    font-weight:bold;

    cursor:pointer;

    transition:0.3s;
}

.btn:hover{
    transform:translateY(-2px);
    filter:brightness(1.10);
}

.view-btn{
    color:#07111f;
    background:#00ffcc;
}

.delete-btn{
    color:white;
    background:#ff4d5a;
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

    .heading{
        font-size:30px;
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

    <div class="nav-links">

        <a href="admin-dashboard.jsp">
            Dashboard
        </a>

        <a href="manage-vehicles.jsp">
            Vehicles
        </a>

        <a href="admin-booking.jsp">
            Bookings
        </a>

        <a href="manage-users.jsp">
            Users
        </a>

        <a href="LogoutServlet">
            Logout
        </a>

    </div>

</div>

<div class="container">

    <h1 class="heading">
        👥 Manage Users
    </h1>

    <p class="subtitle">
        View and manage all registered customers.
    </p>

    <% if ("deleted".equals(success)) { %>

        <div class="message success-message">
            User successfully deleted ✅
        </div>

    <% } %>

    <% if ("deleteFailed".equals(error)) { %>

        <div class="message error-message">
            User delete nahi hua ❌
        </div>

    <% } %>

    <% if ("invalidUser".equals(error)) { %>

        <div class="message error-message">
            Invalid user information ❌
        </div>

    <% } %>

    <div class="search-box">

        <input
            type="text"
            id="searchInput"
            placeholder="Search by name, email or mobile..."
            onkeyup="searchUsers()">

    </div>

    <div class="table-box">

        <table>

            <thead>

                <tr>

                    <th>ID</th>

                    <th>Name</th>

                    <th>Email</th>

                    <th>Mobile</th>

                    <th>Total Bookings</th>

                    <th>Status</th>

                    <th>Action</th>

                </tr>

            </thead>

            <tbody>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    boolean userFound = false;

    try {

        con = DBConnection.getConnection();

        String sql =
                "SELECT "
                + "u.id, "
                + "u.name, "
                + "u.email, "
                + "u.mobile, "
                + "COUNT(b.id) AS total_bookings "
                + "FROM users u "
                + "LEFT JOIN bookings b "
                + "ON u.id = b.user_id "
                + "WHERE LOWER(u.role) = 'user' "
                + "GROUP BY "
                + "u.id, u.name, u.email, u.mobile "
                + "ORDER BY u.id DESC";

        ps = con.prepareStatement(sql);

        rs = ps.executeQuery();

        while (rs.next()) {

            userFound = true;

            int userId =
                    rs.getInt("id");

            String userName =
                    rs.getString("name");

            String userEmail =
                    rs.getString("email");

            String userMobile =
                    rs.getString("mobile");

            int totalBookings =
                    rs.getInt("total_bookings");
%>

                <tr class="user-row"
                    data-search="<%= (
                            userName + " "
                            + userEmail + " "
                            + userMobile
                    ).toLowerCase() %>">

                    <td>
                        #<%= userId %>
                    </td>

                    <td>
                        <div class="user-name">
                            <%= userName %>
                        </div>
                    </td>

                    <td>
                        <div class="email">
                            <%= userEmail %>
                        </div>
                    </td>

                    <td>
                        <%= userMobile %>
                    </td>

                    <td class="booking-count">
                        <%= totalBookings %>
                    </td>

                    <td>
                        <span class="status">
                            Active
                        </span>
                    </td>

                    <td>

                        <div class="action-box">

                            <a
                                href="view-user.jsp?id=<%= userId %>"
                                class="btn view-btn">

                                View

                            </a>

                            <a
                                href="<%= request.getContextPath() %>/DeleteUserServlet?id=<%= userId %>"
                                class="btn delete-btn"
                                onclick="return confirmDelete('<%= userName %>');">

                                Delete

                            </a>

                        </div>

                    </td>

                </tr>

<%
        }

        if (!userFound) {
%>

                <tr>

                    <td colspan="7">

                        <div class="empty-box">

                            <h2>
                                Koi user nahi mila
                            </h2>

                            <p>
                                Register hone wale users yahan show honge.
                            </p>

                        </div>

                    </td>

                </tr>

<%
        }

    } catch (Exception e) {

        e.printStackTrace();
%>

                <tr>

                    <td colspan="7">

                        <div class="empty-box">

                            <h2>
                                Database Error
                            </h2>

                            <p>
                                Users load nahi hue. NetBeans console check karo.
                            </p>

                        </div>

                    </td>

                </tr>

<%
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
%>

            </tbody>

        </table>

    </div>

</div>

<script>

function searchUsers() {

    const searchValue =
        document
        .getElementById("searchInput")
        .value
        .toLowerCase()
        .trim();

    const rows =
        document.querySelectorAll(".user-row");

    rows.forEach(function(row) {

        const searchData =
            row.getAttribute("data-search") || "";

        if (searchData.includes(searchValue)) {

            row.style.display = "";

        } else {

            row.style.display = "none";
        }
    });
}

function confirmDelete(userName) {

    return confirm(
        "Kya aap "
        + userName
        + " ko delete karna chahte ho?"
    );
}

</script>

</body>

</html>