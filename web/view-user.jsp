<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet" %>
<%@ page import="collage.DBConnection" %>
<%
    if (session.getAttribute("userId") == null
            || session.getAttribute("userRole") == null
            || !"admin".equalsIgnoreCase(String.valueOf(session.getAttribute("userRole")))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String idParam = request.getParameter("id");
    if (idParam == null || !idParam.matches("\\d+")) {
        response.sendRedirect("manage-users.jsp");
        return;
    }

    String name = "", email = "", mobile = "", address = "", role = "user";
    int bookingCount = 0;
    boolean found = false;

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(
             "SELECT u.name,u.email,u.mobile,u.address,u.role," +
             "(SELECT COUNT(*) FROM bookings b WHERE b.user_id=u.id) booking_count " +
             "FROM users u WHERE u.id=?")) {

        ps.setInt(1, Integer.parseInt(idParam));
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                found = true;
                name = rs.getString("name");
                email = rs.getString("email");
                mobile = rs.getString("mobile");
                address = rs.getString("address");
                role = rs.getString("role");
                bookingCount = rs.getInt("booking_count");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (!found) {
        response.sendRedirect("manage-users.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Details | LuxeDrive</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Arial,sans-serif}
body{min-height:100vh}
.navbar{min-height:75px;display:flex;justify-content:space-between;align-items:center;padding:0 40px}
.logo{font-size:29px;font-weight:800}
.navbar a{color:white;text-decoration:none;margin-left:20px}
.container{width:90%;max-width:900px;margin:50px auto}
.user-card{padding:35px;border-radius:24px}
.avatar{width:96px;height:96px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:40px;font-weight:700;background:#242a33;margin-bottom:22px}
h1{font-size:34px;margin-bottom:6px}.role{color:#ff8a3d;margin-bottom:28px;text-transform:capitalize}
.grid{display:grid;grid-template-columns:1fr 1fr;gap:18px}.item{padding:18px;border-radius:15px;background:#0f1318;border:1px solid #303844}
.item span{display:block;color:#8f98a5;font-size:13px;margin-bottom:7px}.item strong{font-size:17px;word-break:break-word}
.actions{margin-top:28px;display:flex;gap:12px;flex-wrap:wrap}.btn{padding:12px 20px;border-radius:12px;text-decoration:none;font-weight:700}
@media(max-width:650px){.grid{grid-template-columns:1fr}.navbar{padding:0 18px}.container{margin-top:25px}}
</style>
<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vehicle-theme.css">
</head>
<body>
<div class="navbar">
  <div class="logo">🚘 LuxeDrive Admin</div>
  <div><a href="admin-dashboard.jsp">Dashboard</a><a href="manage-users.jsp">Users</a><a href="LogoutServlet">Logout</a></div>
</div>
<div class="container">
  <div class="user-card card">
    <div class="avatar"><%= name == null || name.isEmpty() ? "U" : name.substring(0,1).toUpperCase() %></div>
    <h1><%= name %></h1>
    <div class="role"><%= role == null ? "user" : role %> account</div>
    <div class="grid">
      <div class="item"><span>Email</span><strong><%= email == null ? "Not provided" : email %></strong></div>
      <div class="item"><span>Mobile</span><strong><%= mobile == null ? "Not provided" : mobile %></strong></div>
      <div class="item"><span>Address</span><strong><%= address == null || address.trim().isEmpty() ? "Not provided" : address %></strong></div>
      <div class="item"><span>Total Bookings</span><strong><%= bookingCount %></strong></div>
    </div>
    <div class="actions">
      <a class="btn" href="manage-users.jsp">← Back to Users</a>
    </div>
  </div>
</div>
</body>
</html>
