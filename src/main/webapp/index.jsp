<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pedal Point - Premium Cycle Rentals</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=2">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <a href="index.jsp" class="logo">Pedal <span>Point</span></a>
        <div class="nav-links">
            <a href="login.jsp">Login</a>
            <a href="signup.jsp" class="btn btn-primary" style="padding: 0.6rem 1.5rem; width: auto; margin-left: 1.5rem;">Sign Up Free</a>
        </div>
    </header>
    <script>
        if (window.location.protocol === "file:") {
            alert("STOP! You are opening this file directly. Please use http://localhost:8080/CycleRental/");
            document.write("<h1 style='color:red; text-align:center; margin-top:50px;'>PLEASE ACCESS VIA TOMCAT:<br>http://localhost:8080/CycleRental/</h1>");
        }
    </script>

    <div class="hero">
        <video autoplay loop muted playsinline class="video-bg">
            <source src="videos/cycling_video.mp4" type="video/mp4">
        </video>
        <div class="hero-overlay"></div>

        <div class="hero-content">
            <span class="hero-badge">🚴 Premium Cycle Rentals</span>
            <h1>Ride With <span class="hero-gradient">Pedal Point</span></h1>
            <p>Experience the city like never before. Choose your cycle, pay securely, and ride instantly.</p>
            <div class="hero-buttons">
                <a href="signup.jsp" class="btn btn-hero-primary">Start Riding</a>
                <a href="login.jsp" class="btn btn-hero-outline">Login</a>
            </div>
            <div class="hero-stats">
                <div class="stat">
                    <strong>12</strong>
                    <span>Cycle Models</span>
                </div>
                <div class="stat-divider"></div>
                <div class="stat">
                    <strong>रू 250</strong>
                    <span>Starting Rate/hr</span>
                </div>
                <div class="stat-divider"></div>
                <div class="stat">x`
                    <strong>24/7</strong>
                    <span>Available</span>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
