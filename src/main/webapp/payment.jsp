<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cyclerental.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"USER".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String rentalId = request.getParameter("rentalId");
    String amount = request.getParameter("amount");
    
    if (rentalId == null || amount == null) {
        response.sendRedirect("userDashboard");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Payment</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .payment-summary {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            text-align: center;
        }
        .amount {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin: 0.5rem 0;
        }
    </style>
</head>
<body>
    <header>
        <a href="userDashboard" class="logo">Velocity Rentals</a>
    </header>

    <div class="form-card">
        <h2>Secure Payment</h2>
        
        <div class="payment-summary">
            <p style="color: var(--text-muted); font-weight: 500;">Total Amount Due</p>
            <div class="amount">$<%= amount %></div>
            <p style="font-size: 0.875rem; color: var(--text-muted);">Rental #<%= rentalId %></p>
        </div>

        <!-- Mock Payment Form -->
        <form action="processPayment" method="POST">
            <input type="hidden" name="rentalId" value="<%= rentalId %>">
            
            <div class="form-group">
                <label>Cardholder Name</label>
                <input type="text" class="form-control" placeholder="John Doe" required>
            </div>
            
            <div class="form-group">
                <label>Card Number</label>
                <input type="text" class="form-control" placeholder="0000 0000 0000 0000" pattern="\d{16}" title="16 digit card number" required>
            </div>
            
            <div style="display: flex; gap: 1rem;">
                <div class="form-group" style="flex: 1;">
                    <label>Expiry Date</label>
                    <input type="text" class="form-control" placeholder="MM/YY" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>CVC</label>
                    <input type="text" class="form-control" placeholder="123" pattern="\d{3,4}" required>
                </div>
            </div>

            <button type="submit" class="btn btn-primary" style="margin-top: 1rem;">Pay $<%= amount %> Now</button>
        </form>
    </div>
</body>
</html>
