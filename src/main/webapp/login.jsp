<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String rememberedUser = "";
    jakarta.servlet.http.Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (jakarta.servlet.http.Cookie cookie : cookies) {
            if ("rememberedUser".equals(cookie.getName())) {
                rememberedUser = cookie.getValue();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Pedal Point</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap');
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: url('${pageContext.request.contextPath}/images/cycle_auth_bg.png') no-repeat;
            background-size: cover;
            background-position: center;
        }
        header {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            padding: 20px 100px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 99;
        }
        .logo {
            font-size: 2em;
            color: #fff;
            user-select: none;
            text-decoration: none;
            font-weight: 700;
        }
        .logo span { color: #4f46e5; }
        .nav-links a {
            position: relative;
            font-size: 1.1em;
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            margin-left: 40px;
        }
        .wrapper {
            width: 420px;
            background: transparent;
            border: 2px solid rgba(255, 255, 255, .2);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            box-shadow: 0 0 10px rgba(0, 0, 0, .2);
            color: #fff;
            border-radius: 10px;
            padding: 30px 40px;
            margin-top: 60px;
        }
        .wrapper h1 {
            font-size: 36px;
            text-align: center;
        }
        .wrapper .input-box {
            position: relative;
            width: 100%;
            height: 50px;
            margin: 30px 0;
        }
        .input-box input {
            width: 100%;
            height: 100%;
            background: transparent;
            border: none;
            outline: none;
            border: 2px solid rgba(255, 255, 255, .2);
            border-radius: 40px;
            font-size: 16px;
            color: #fff;
            padding: 20px 45px 20px 20px;
        }
        .input-box input::placeholder {
            color: #fff;
        }
        .input-box i {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 20px;
        }
        .wrapper .remember-forgot {
            display: flex;
            justify-content: space-between;
            font-size: 14.5px;
            margin: -15px 0 15px;
        }
        .remember-forgot label input {
            accent-color: #fff;
            margin-right: 3px;
        }
        .remember-forgot a {
            color: #fff;
            text-decoration: none;
        }
        .remember-forgot a:hover {
            text-decoration: underline;
        }
        .wrapper .btn {
            width: 100%;
            height: 45px;
            background: #fff;
            border: none;
            outline: none;
            border-radius: 40px;
            box-shadow: 0 0 10px rgba(0, 0, 0, .1);
            cursor: pointer;
            font-size: 16px;
            color: #333;
            font-weight: 600;
        }
        .wrapper .register-link {
            font-size: 14.5px;
            text-align: center;
            margin: 20px 0 15px;
        }
        .register-link p a {
            color: #fff;
            text-decoration: none;
            font-weight: 600;
        }
        .register-link p a:hover {
            text-decoration: underline;
        }
        .alert { padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; font-weight: 500; text-align: center; font-size: 0.95rem; }
        .alert-error { background: rgba(254,242,242,0.8); color: #b91c1c; border: 1px solid #fecaca; }
        .alert-success { background: rgba(240,253,244,0.8); color: #15803d; border: 1px solid #bbf7d0; }
    </style>
</head>
<body>
    <header>
        <a href="index.jsp" class="logo">Pedal <span>Point</span></a>
        <div class="nav-links"><a href="signup.jsp">Sign Up</a></div>
    </header>

    <div class="wrapper">
        <form action="login" method="POST">
            <h1>Login</h1>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getParameter("msg") != null) { %>
                <div class="alert alert-success"><%= request.getParameter("msg") %></div>
            <% } %>
            <div class="input-box">
                <input type="text" name="username" placeholder="Username" value="<%= rememberedUser %>" required>
                <i class='bx bxs-user'></i>
            </div>
            <div class="input-box">
                <input type="password" name="password" placeholder="Password" required>
                <i class='bx bxs-lock-alt'></i>
            </div>
            <div class="remember-forgot">
                <label><input type="checkbox" name="rememberMe" id="rememberMe" <%= !rememberedUser.isEmpty() ? "checked" : "" %>> Remember me</label>
                <a href="#">Forgot Password?</a>
            </div>
            <button type="submit" class="btn">Login</button>
            <div class="register-link">
                <p>Don't have an account? <a href="signup.jsp">Register</a></p>
            </div>
        </form>
    </div>
</body>
</html>
