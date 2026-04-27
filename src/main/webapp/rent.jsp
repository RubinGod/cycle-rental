<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.rental.model.Cycle" %>
<%
    Cycle c = (Cycle) request.getAttribute("cycle");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Rent <%= c.getName() %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header>
        <a href="userDashboard" class="logo">Pedal <span>Point</span></a>
        <div class="nav-links"><a href="userDashboard">Back</a></div>
    </header>

    <div class="container">
        <div class="form-card">
            <h2>Rent <%= c.getName() %></h2>
            <img src="<%= c.getImageUrl() %>" style="width:100%; border-radius:8px; margin-bottom:1rem;">
            <p style="text-align:center; color:var(--primary); font-size:1.2rem; font-weight:bold; margin-bottom:2rem;">
                Rate: रू <%= c.getHourlyRate() %> / hour
            </p>
            <form action="rentCycle" method="POST">
                <input type="hidden" name="cycleId" value="<%= c.getId() %>">
                <div class="form-group">
                    <label>Duration (Hours)</label>
                    <input type="number" name="hours" class="form-control" min="1" max="72" value="1" required>
                </div>
                <button type="submit" class="btn btn-primary">Confirm Rental</button>
            </form>
        </div>
    </div>
</body>
</html>
