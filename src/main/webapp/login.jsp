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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
    </div>
</body>
</html>
