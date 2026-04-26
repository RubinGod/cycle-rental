<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.rental.model.Cycle" %>
<%@ page import="com.rental.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    List<Cycle> cycles = (List<Cycle>) request.getAttribute("cycles");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Pedal Point</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <a href="userDashboard" class="logo">Pedal <span>Point</span></a>
        <div class="nav-links" style="display:flex; align-items:center;">
            <span style="color: var(--text-muted); font-size: 0.9rem; margin-right: 0.5rem;">Hi, <strong style="color: var(--text-main);"><%= user.getUsername() %></strong></span>
            <!-- Theme Toggle Button -->
            <button class="theme-toggle" id="themeToggle" onclick="toggleTheme()">
                <span id="themeIcon">🌙</span>
                <span id="themeLabel">Dark</span>
            </button>
            <a href="logout" class="btn btn-danger" style="padding:0.45rem 1.2rem; width:auto; margin-left:0.75rem;">Logout</a>
        </div>
    </header>

    <div class="container">
        <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:1rem; margin-bottom:2rem;">
            <div>
                <h2 style="font-size: 2rem; font-weight: 800; color: var(--text-main);">Available Cycles</h2>
                <p style="color: var(--text-muted); margin-top: 0.25rem;">Browse and rent from our premium fleet</p>
            </div>
            <div style="position:relative; min-width:280px;">
                <span style="position:absolute; left:0.9rem; top:50%; transform:translateY(-50%); color:var(--text-muted); pointer-events:none; display:flex; align-items:center;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="11" cy="11" r="8"/>
                        <line x1="21" y1="21" x2="16.65" y2="16.65"/>
                    </svg>
                </span>
                <input
                    type="text"
                    id="cycleSearch"
                    class="form-control"
                    placeholder="Search by name or brand..."
                    oninput="searchCycles()"
                    style="padding-left:2.5rem; border-radius:999px;"
                    autocomplete="off"
                >
            </div>
        </div>
        <p id="searchNoResult" style="display:none; color:var(--text-muted); text-align:center; padding:3rem; background:var(--card-bg); border-radius:12px; border:1px dashed var(--border);">No cycles found matching your search.</p>

        <% if (request.getParameter("msg") != null) { %>
            <div class="alert alert-success"><%= request.getParameter("msg") %></div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-error"><%= request.getParameter("error") %></div>
        <% } %>

        <div class="grid">
            <% if (cycles != null) {
                for (Cycle c : cycles) { %>
                    <div class="cycle-card">
                        <img src="<%= c.getImageUrl() %>" class="cycle-image" alt="<%= c.getName() %>">
                        <div class="cycle-info">
                            <div style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:0.5rem;">
                                <h3><%= c.getName() %></h3>
                                <span style="
                                    background: <%= "AVAILABLE".equals(c.getStatus()) ? "rgba(16,185,129,0.1)" : "rgba(239,68,68,0.1)" %>;
                                    color: <%= "AVAILABLE".equals(c.getStatus()) ? "#059669" : "#dc2626" %>;
                                    border: 1px solid <%= "AVAILABLE".equals(c.getStatus()) ? "rgba(16,185,129,0.3)" : "rgba(239,68,68,0.3)" %>;
                                    padding: 0.2rem 0.7rem;
                                    border-radius: 999px;
                                    font-size: 0.75rem;
                                    font-weight: 700;
                                    text-transform: uppercase;
                                    letter-spacing: 0.5px;
                                    white-space: nowrap;
                                "><%= c.getStatus() %></span>
                            </div>
                            <p style="color: var(--text-muted); font-size:0.9rem;"><%= c.getBrand() %></p>
                            <div class="price-tag">रू <%= (int)c.getHourlyRate() %><span style="font-size:0.9rem; font-weight:500; color: var(--text-muted);">/hr</span></div>
                            <% if ("AVAILABLE".equals(c.getStatus())) { %>
                                <a href="rentCycle?id=<%= c.getId() %>" class="btn btn-primary" style="display:block; margin-top:1rem;">Rent Now</a>
                            <% } else { %>
                                <button class="btn" style="display:block; margin-top:1rem; width:100%; background: var(--border); color: var(--text-muted); cursor:not-allowed;" disabled>Currently Rented</button>
                            <% } %>
                        </div>
                    </div>
            <%  } } %>
        </div>
    </div>

    <script>
        function searchCycles() {
            const query = document.getElementById('cycleSearch').value.toLowerCase().trim();
            const cards = document.querySelectorAll('.cycle-card');
            let visibleCount = 0;
            cards.forEach(card => {
                const name = card.querySelector('h3') ? card.querySelector('h3').textContent.toLowerCase() : '';
                const brand = card.querySelector('p') ? card.querySelector('p').textContent.toLowerCase() : '';
                const matches = name.includes(query) || brand.includes(query);
                card.style.display = matches ? '' : 'none';
                if (matches) visibleCount++;
            });
            document.getElementById('searchNoResult').style.display = visibleCount === 0 ? 'block' : 'none';
        }

        // Apply saved theme on page load
        const savedTheme = localStorage.getItem('pedalpoint-theme');
        if (savedTheme === 'dark') {
            document.body.classList.add('dark-theme');
            document.getElementById('themeIcon').textContent = '☀️';
            document.getElementById('themeLabel').textContent = 'Light';
        }

        function toggleTheme() {
            const isDark = document.body.classList.toggle('dark-theme');
            const icon = document.getElementById('themeIcon');
            const label = document.getElementById('themeLabel');
            if (isDark) {
                icon.textContent = '☀️';
                label.textContent = 'Light';
                localStorage.setItem('pedalpoint-theme', 'dark');
            } else {
                icon.textContent = '🌙';
                label.textContent = 'Dark';
                localStorage.setItem('pedalpoint-theme', 'light');
            }
        }
    </script>
</body>
</html>
