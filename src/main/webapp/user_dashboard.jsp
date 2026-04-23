<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.cyclerental.model.Cycle" %>
<%@ page import="com.cyclerental.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"USER".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Cycle> cycles = (List<Cycle>) request.getAttribute("cycles");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Velocity Rentals</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <a href="userDashboard" class="logo">Velocity <span>Rentals</span></a>
        <div class="nav-links">
            <a href="login.jsp" class="btn btn-outline" style="padding: 0.4rem 1rem; border-radius: 6px;">Logout</a>
        </div>
    </header>

    <div class="container">
        <% if ("true".equals(request.getParameter("welcome"))) { %>
            <div class="alert alert-success" style="font-size: 1.1rem; text-align: center;">Welcome back, <strong><%= user.getUsername() %></strong>! Ready for your next ride?</div>
        <% } %>
        <% if (request.getParameter("msg") != null) { %>
            <div class="alert alert-success"><%= request.getParameter("msg") %></div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-error"><%= request.getParameter("error") %></div>
        <% } %>

        <h2 style="font-size: 2rem; margin-bottom: 1rem;">Available Cycles</h2>
        
        <div class="grid">
            <% if (cycles != null && !cycles.isEmpty()) {
                for (Cycle cycle : cycles) { %>
                    <div class="cycle-card">
                        <% if (cycle.getImageUrl() != null && !cycle.getImageUrl().isEmpty()) { %>
                            <img src="<%= cycle.getImageUrl() %>" alt="<%= cycle.getName() %>" class="cycle-image">
                        <% } else { %>
                            <div class="cycle-image" style="background: #1e293b; display: flex; align-items: center; justify-content: center; color: var(--text-muted);">No Image</div>
                        <% } %>
                        <div class="cycle-info">
                            <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                                <div>
                                    <h3><%= cycle.getName() %></h3>
                                    <p style="color: var(--text-muted);"><%= cycle.getBrand() %></p>
                                </div>
                                <span class="badge badge-available">In Stock</span>
                            </div>
                            <div class="price-tag">
                                $<%= cycle.getHourlyRate() %>/hr | $<%= cycle.getDailyRate() %>/day
                            </div>
                            <a href="rentCycle?cycleId=<%= cycle.getId() %>" class="btn btn-primary" style="display: block; margin-top: 1rem;">Rent Now</a>
                        </div>
                    </div>
            <%  }
            } else { %>
                <p style="color: var(--text-muted); grid-column: 1 / -1; text-align: center; padding: 3rem; background: var(--card-bg); border-radius: 12px; border: 1px dashed var(--border-color);">
                    No cycles currently available. Please check back later.
                </p>
            <% } %>
        </div>
    </div>
</body>
</html>
