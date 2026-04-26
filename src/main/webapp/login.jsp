<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
<<<<<<< HEAD
    String rememberedUser = "";
    jakarta.servlet.http.Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (jakarta.servlet.http.Cookie cookie : cookies) {
            if ("rememberedUser".equals(cookie.getName())) {
                rememberedUser = cookie.getValue();
=======
    // Check for "Remember Me" cookie
    String savedUsername = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("rememberedUser".equals(c.getName())) {
                savedUsername = c.getValue();
>>>>>>> 4a24cff9c03506184abda190970dd9b200373907
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
<<<<<<< HEAD
    <title>Login - Pedal Point</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <a href="index.jsp" class="logo">Pedal <span>Point</span></a>
        <div class="nav-links"><a href="signup.jsp">Sign Up</a></div>
    </header>

    <div class="container">
        <div class="form-card">
            <h2>User Login</h2>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getParameter("msg") != null) { %>
                <div class="alert alert-success"><%= request.getParameter("msg") %></div>
            <% } %>
            <form action="login" method="POST">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" value="<%= rememberedUser %>" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <div class="form-group" style="display: flex; align-items: center; gap: 0.5rem;">
                    <input type="checkbox" name="rememberMe" id="rememberMe" <%= !rememberedUser.isEmpty() ? "checked" : "" %>>
                    <label for="rememberMe" style="margin: 0; color: var(--text-main);">Remember Me</label>
                </div>
                <button type="submit" class="btn btn-primary">Login</button>
            </form>
        </div>
=======
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Velocity Rentals</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <a href="index.jsp" class="logo">Velocity <span>Rentals</span></a>
    </header>

    <div class="form-card">
        <h2>Welcome Back</h2>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getParameter("msg") != null) { %>
            <div class="alert alert-success"><%= request.getParameter("msg") %></div>
        <% } %>

        <form action="login" method="POST">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" class="form-control" value="<%= savedUsername %>" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            
            <div class="form-group" style="display: flex; align-items: center; gap: 0.5rem;">
                <input type="checkbox" id="rememberMe" name="rememberMe" value="true" <%= !savedUsername.isEmpty() ? "checked" : "" %>>
                <label for="rememberMe" style="margin-bottom: 0;">Remember me</label>
            </div>

            <button type="submit" class="btn btn-primary">Login</button>
        </form>
        <p style="text-align: center; margin-top: 1.5rem; color: var(--text-muted);">
            Don't have an account? <a href="signup.jsp" style="color: var(--primary-color);">Sign up</a>
        </p>
>>>>>>> 4a24cff9c03506184abda190970dd9b200373907
    </div>
</body>
</html>
