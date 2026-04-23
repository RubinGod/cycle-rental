<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.cyclerental.model.Cycle" %>
<%@ page import="com.cyclerental.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
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
    <title>Admin Fleet - Velocity Rentals</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <a href="adminDashboard" class="logo">Velocity <span>Rentals</span> <small style="font-size: 0.9rem; color: var(--text-muted);">(Admin)</small></a>
        <div class="nav-links">
            <a href="login.jsp" class="btn btn-danger" style="padding: 0.4rem 1rem; border-radius: 6px;">Logout</a>
        </div>
    </header>

    <div class="container">
        <% if ("true".equals(request.getParameter("welcome"))) { %>
            <div class="alert alert-success">Welcome back, <%= user.getUsername() %>! You are logged in as an Administrator.</div>
        <% } %>

        <h2>Manage Fleet</h2>
        
        <div style="background: var(--card-bg); backdrop-filter: blur(10px); padding: 2rem; border-radius: 16px; margin-top: 1rem; border: 1px solid var(--border-color);">
            <h3>Add New Cycle</h3>
            <form action="adminCycle" method="POST" style="display: flex; gap: 1rem; margin-top: 1rem; flex-wrap: wrap; align-items: flex-end;">
                <input type="hidden" name="action" value="add">
                <div class="form-group" style="margin-bottom: 0;">
                    <label>Name</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                <div class="form-group" style="margin-bottom: 0;">
                    <label>Brand</label>
                    <input type="text" name="brand" class="form-control" required>
                </div>
                <div class="form-group" style="margin-bottom: 0;">
                    <label>Image URL</label>
                    <input type="url" name="imageUrl" class="form-control" placeholder="https://..." required>
                </div>
                <div class="form-group" style="margin-bottom: 0; width: 120px;">
                    <label>Hourly ($)</label>
                    <input type="number" step="0.01" name="hourlyRate" class="form-control" required>
                </div>
                <div class="form-group" style="margin-bottom: 0; width: 120px;">
                    <label>Daily ($)</label>
                    <input type="number" step="0.01" name="dailyRate" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary" style="width: auto; padding: 0.85rem 2rem;">Add Cycle</button>
            </form>
        </div>

        <div class="grid">
            <% if (cycles != null) {
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
                                <span class="badge <%= "AVAILABLE".equals(cycle.getStatus()) ? "badge-available" : "badge-rented" %>">
                                    <%= "AVAILABLE".equals(cycle.getStatus()) ? "In Stock" : "Rented" %>
                                </span>
                            </div>
                            <div class="price-tag">
                                $<%= cycle.getHourlyRate() %>/hr | $<%= cycle.getDailyRate() %>/day
                            </div>
                            <form action="adminCycle" method="POST" style="margin-top: 1rem;">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="cycleId" value="<%= cycle.getId() %>">
                                <button type="submit" class="btn btn-danger" style="width: 100%;">Remove</button>
                            </form>
                        </div>
                    </div>
            <%  }
            } %>
        </div>
    </div>
</body>
</html>
