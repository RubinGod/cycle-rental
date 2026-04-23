<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Velocity Rentals - Ride the City</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <a href="index.jsp" class="logo">Velocity <span>Rentals</span></a>
        <div class="nav-links">
            <a href="login.jsp">Login</a>
            <a href="signup.jsp" class="btn btn-primary" style="padding: 0.5rem 1rem; color: white;">Sign Up</a>
        </div>
    </header>

    <div class="hero">
        <video class="video-bg" autoplay loop muted playsinline>
            <!-- High quality bicycle stock video from Pexels (free to use) -->
            <source src="https://videos.pexels.com/video-files/3208752/3208752-uhd_2560_1440_25fps.mp4" type="video/mp4">
        </video>
        <div class="hero-overlay"></div>
        
        <div class="hero-content">
            <h1>Unlock Your City Adventure</h1>
            <p>Premium cycle rentals for urban explorers and mountain trailblazers. Ride anytime, anywhere with Velocity.</p>
            <div class="hero-buttons">
                <a href="signup.jsp" class="btn btn-primary">Start Riding</a>
                <a href="login.jsp" class="btn btn-outline">Member Login</a>
            </div>
        </div>
    </div>
</body>
</html>
