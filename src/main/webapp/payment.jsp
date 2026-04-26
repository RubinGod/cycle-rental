<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.rental.model.Cycle" %>
<%
    Cycle c = (Cycle) request.getAttribute("cycle");
    Double total = (Double) request.getAttribute("totalAmount");
    Integer hours = (Integer) request.getAttribute("hours");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Secure Checkout</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <a href="userDashboard" class="logo">Pedal <span>Point</span></a>
        <div class="nav-links"><a href="userDashboard">Cancel</a></div>
    </header>

    <div class="container">
        <div class="form-card" style="max-width: 500px;">
            <h2>Payment Details</h2>
            <div style="background: var(--bg-main); padding: 1.5rem; border-radius: 8px; margin-bottom: 2rem; border: 1px solid var(--border);">
                <h3 style="color: var(--primary); margin-bottom: 0.5rem;"><%= c.getName() %></h3>
                <p style="color: var(--text-muted)">Duration: <%= hours %> Hours</p>
                <p style="font-size: 1.5rem; font-weight: bold; margin-top: 1rem; color: var(--text-main);">Total: रू <%= String.format("%.0f", total) %></p>
            </div>

            <form action="processPayment" method="POST">
                <input type="hidden" name="cycleId" value="<%= c.getId() %>">
                <input type="hidden" name="hours" value="<%= hours %>">
                <input type="hidden" name="total" value="<%= total %>">
                
                <div class="form-group">
                    <label>Cardholder Name</label>
                    <input type="text" class="form-control" required placeholder="John Doe">
                </div>
                <div class="form-group">
                    <label>Card Number</label>
                    <input type="text" class="form-control" required placeholder="XXXX-XXXX-XXXX-XXXX" pattern="\d{4}-\d{4}-\d{4}-\d{4}">
                </div>
                <div style="display: flex; gap: 1rem;">
                    <div class="form-group" style="flex: 1;">
                        <label>Expiry (MM/YY)</label>
                        <input type="text" class="form-control" required placeholder="12/25" pattern="\d{2}/\d{2}">
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label>CVV</label>
                        <input type="password" class="form-control" required placeholder="123" pattern="\d{3}">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary" style="margin-top: 1rem;">Pay Now</button>
            </form>
        </div>
    </div>
</body>
</html>
