<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cyclerental.model.Cycle" %>
<%@ page import="com.cyclerental.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"USER".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    Cycle cycle = (Cycle) request.getAttribute("cycle");
    if (cycle == null) {
        response.sendRedirect("userDashboard");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rent Cycle - Velocity Rentals</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <a href="userDashboard" class="logo">Velocity <span>Rentals</span></a>
        <div class="nav-links">
            <a href="userDashboard">Back to Dashboard</a>
        </div>
    </header>

    <div class="form-card" style="max-width: 500px; padding: 2rem;">
        <h2 style="font-size: 1.5rem; margin-bottom: 0.5rem;">Rent <%= cycle.getName() %></h2>
        <p style="text-align: center; color: var(--text-muted); margin-bottom: 2rem; font-weight: 500;">
            <%= cycle.getBrand() %> &bull; $<%= cycle.getHourlyRate() %>/hr or $<%= cycle.getDailyRate() %>/day
        </p>

        <form action="rentCycle" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="cycleId" value="<%= cycle.getId() %>">
            
            <div class="form-group">
                <label for="rentalType">Rental Rate Base</label>
                <select id="rentalType" name="rentalType" class="form-control" required>
                    <option value="HOURLY">Hourly ($<%= cycle.getHourlyRate() %>/hr)</option>
                    <option value="DAILY">Daily ($<%= cycle.getDailyRate() %>/day)</option>
                </select>
            </div>
            
            <div style="display: flex; gap: 1rem;">
                <div class="form-group" style="flex: 1;">
                    <label for="startTime">From</label>
                    <input type="datetime-local" id="startTime" name="startTime" class="form-control" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label for="endTime">To</label>
                    <input type="datetime-local" id="endTime" name="endTime" class="form-control" required>
                </div>
            </div>

            <div class="form-group">
                <label for="document">Upload Identity Document (ID/Passport)</label>
                <input type="file" id="document" name="document" class="form-control" accept=".pdf,.jpg,.jpeg,.png" required style="padding: 0.6rem 1rem;">
                <small style="color: var(--text-muted); display: block; margin-top: 0.4rem; font-size: 0.8rem;">Max file size: 10MB.</small>
            </div>

            <button type="submit" class="btn btn-primary" style="margin-top: 1rem;">Calculate & Proceed</button>
        </form>
    </div>
</body>
</html>
