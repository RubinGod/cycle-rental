<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.rental.model.Cycle" %>
            <%@ page import="com.rental.model.User" %>
                <% User user=(User) session.getAttribute("user"); List<Cycle> cycles = (List<Cycle>)
                        request.getAttribute("cycles");
                        %>
                        <!DOCTYPE html>
                        <html lang="en">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Admin Dashboard - Pedal Point</title>
                            <link rel="stylesheet" href="css/style.css">
                            <link
                                href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                                rel="stylesheet">
                        </head>

                        <body>
                            <header>
                                <a href="adminDashboard" class="logo">Pedal <span>Point</span> <small
                                        style="font-size:0.6rem; opacity:0.5; font-weight:600; letter-spacing:1px;">ADMIN</small></a>
                                <div class="nav-links" style="display:flex; align-items:center;">
                                    <span style="color: var(--text-muted); font-size: 0.9rem; margin-right: 0.5rem;">Hi,
                                        <strong style="color: var(--text-main);">
                                            <%= user.getUsername() %>
                                        </strong></span>
                                    <!-- Theme Toggle Button -->
                                    <button class="theme-toggle" id="themeToggle" onclick="toggleTheme()">
                                        <span id="themeIcon">🌙</span>
                                        <span id="themeLabel">Dark</span>
                                    </button>
                                    <a href="logout" class="btn btn-danger"
                                        style="padding:0.45rem 1.2rem; width:auto; margin-left:0.75rem;">Logout</a>
                                </div>
                            </header>

                            <div class="container">
                                <div
                                    style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:1rem; margin-bottom:2rem;">
                                    <div>
                                        <h2 style="font-size: 2rem; font-weight: 800; color: var(--text-main);">Fleet
                                            Management</h2>
                                        <p style="color: var(--text-muted); margin-top: 0.25rem;">Add, view or remove
                                            cycles from your fleet</p>
                                    </div>
                                    <div style="position:relative; min-width:280px;">
                <span style="position:absolute; left:0.9rem; top:50%; transform:translateY(-50%); color:var(--text-muted); pointer-events:none; display:flex; align-items:center;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="11" cy="11" r="8"/>
                        <line x1="21" y1="21" x2="16.65" y2="16.65"/>
                    </svg>
                </span>
                <input type="text" id="cycleSearch" class="form-control"
                                            placeholder="Search by name or brand..." oninput="searchCycles()"
                                            style="padding-left:2.5rem; border-radius:999px;" autocomplete="off">
                                    </div>
                                </div>
                                <p id="searchNoResult"
                                    style="display:none; color:var(--text-muted); text-align:center; padding:3rem; background:var(--card-bg); border-radius:12px; border:1px dashed var(--border);">
                                    No cycles found matching your search.</p>

                                <% if (request.getParameter("msg") !=null) { %>
                                    <div class="alert alert-success">
                                        <%= request.getParameter("msg") %>
                                    </div>
                                    <% } %>

                                        <!-- Add New Cycle Form -->
                                        <div class="form-card"
                                            style="margin: 0 0 3rem 0; max-width: 100%; padding: 2rem;">
                                            <h3
                                                style="margin-bottom: 1.5rem; color: var(--primary); font-size: 1.2rem; font-weight: 700;">
                                                + Add New Cycle</h3>
                                            <form action="adminCycle" method="POST"
                                                style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: flex-end;">
                                                <input type="hidden" name="action" value="add">
                                                <div class="form-group" style="margin: 0; flex: 1; min-width: 180px;">
                                                    <label>Cycle Name</label>
                                                    <input type="text" name="name" class="form-control"
                                                        placeholder="e.g. Speed King" required>
                                                </div>
                                                <div class="form-group" style="margin: 0; flex: 1; min-width: 150px;">
                                                    <label>Brand</label>
                                                    <input type="text" name="brand" class="form-control"
                                                        placeholder="e.g. Trek" required>
                                                </div>
                                                <div class="form-group" style="margin: 0; flex: 2; min-width: 250px;">
                                                    <label>Image URL</label>
                                                    <input type="url" name="imageUrl" class="form-control"
                                                        placeholder="https://images.unsplash.com/..." required>
                                                </div>
                                                <div class="form-group" style="margin: 0; width: 110px;">
                                                    <label>Hourly ($)</label>
                                                    <input type="number" step="0.01" name="hourlyRate"
                                                        class="form-control" placeholder="10.00" required>
                                                </div>
                                                <div class="form-group" style="margin: 0; width: 110px;">
                                                    <label>Daily ($)</label>
                                                    <input type="number" step="0.01" name="dailyRate"
                                                        class="form-control" placeholder="40.00" required>
                                                </div>
                                                <button type="submit" class="btn btn-primary"
                                                    style="width: auto; padding: 0.8rem 2rem; white-space:nowrap;">Add
                                                    Cycle</button>
                                            </form>
                                        </div>

                                        <!-- Stats Bar -->
                                        <div style="display:flex; gap:1.5rem; margin-bottom:2rem; flex-wrap:wrap;">
                                            <% int available=0, rented=0, total=0; if (cycles !=null) {
                                                total=cycles.size(); for (Cycle c : cycles) { if
                                                ("AVAILABLE".equals(c.getStatus())) available++; else rented++; } } %>
                                                <div
                                                    style="background: var(--card-bg); border: 1px solid var(--border); border-radius:12px; padding:1.2rem 2rem; box-shadow: var(--shadow-sm); text-align:center;">
                                                    <div
                                                        style="font-size:2rem; font-weight:800; color: var(--text-main);">
                                                        <%= total %>
                                                    </div>
                                                    <div
                                                        style="color: var(--text-muted); font-size:0.85rem; font-weight:600;">
                                                        Total Cycles</div>
                                                </div>
                                                <div
                                                    style="background: var(--card-bg); border: 1px solid var(--border); border-radius:12px; padding:1.2rem 2rem; box-shadow: var(--shadow-sm); text-align:center;">
                                                    <div style="font-size:2rem; font-weight:800; color:#059669;">
                                                        <%= available %>
                                                    </div>
                                                    <div
                                                        style="color: var(--text-muted); font-size:0.85rem; font-weight:600;">
                                                        Available</div>
                                                </div>
                                                <div
                                                    style="background: var(--card-bg); border: 1px solid var(--border); border-radius:12px; padding:1.2rem 2rem; box-shadow: var(--shadow-sm); text-align:center;">
                                                    <div style="font-size:2rem; font-weight:800; color:#dc2626;">
                                                        <%= rented %>
                                                    </div>
                                                    <div
                                                        style="color: var(--text-muted); font-size:0.85rem; font-weight:600;">
                                                        Rented Out</div>
                                                </div>
                                        </div>

                                        <!-- Cycle Grid -->
                                        <div class="grid">
                                            <% if (cycles !=null) { for (Cycle c : cycles) { %>
                                                <div class="cycle-card">
                                                    <img src="<%= c.getImageUrl() %>" class="cycle-image"
                                                        alt="<%= c.getName() %>">
                                                    <div class="cycle-info">
                                                        <div
                                                            style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:0.5rem;">
                                                            <h3>
                                                                <%= c.getName() %>
                                                            </h3>
                                                            <span style="
                                    background: <%= " AVAILABLE".equals(c.getStatus()) ? "rgba(16,185,129,0.1)"
                                                                : "rgba(239,68,68,0.1)" %>;
                                                                color: <%= "AVAILABLE" .equals(c.getStatus())
                                                                    ? "#059669" : "#dc2626" %>;
                                                                    border: 1px solid <%= "AVAILABLE"
                                                                        .equals(c.getStatus()) ? "rgba(16,185,129,0.3)"
                                                                        : "rgba(239,68,68,0.3)" %>;
                                                                        padding: 0.2rem 0.7rem;
                                                                        border-radius: 999px;
                                                                        font-size: 0.75rem;
                                                                        font-weight: 700;
                                                                        text-transform: uppercase;
                                                                        letter-spacing: 0.5px;
                                                                        white-space: nowrap;
                                                                        "><%= c.getStatus() %></span>
                                                        </div>
                                                        <p style="color: var(--text-muted); font-size:0.9rem;">
                                                            <%= c.getBrand() %>
                                                        </p>
                                                        <div class="price-tag">रू <%= (int)c.getHourlyRate() %><span
                                                                    style="font-size:0.9rem; font-weight:500; color: var(--text-muted);">/hr</span>
                                                                &nbsp;·&nbsp; रू <%= (int)c.getDailyRate() %><span
                                                                        style="font-size:0.9rem; font-weight:500; color: var(--text-muted);">/day</span>
                                                        </div>
                                                        <div
                                                            style="margin-top: 1rem; display:flex; flex-direction:column; gap:0.5rem;">
                                                            <% if ("RENTED".equals(c.getStatus())) { %>
                                                                <form action="adminCycle" method="POST">
                                                                    <input type="hidden" name="action"
                                                                        value="markAvailable">
                                                                    <input type="hidden" name="cycleId"
                                                                        value="<%= c.getId() %>">
                                                                    <button type="submit" class="btn"
                                                                        style="width:100%; padding:0.6rem; background:#059669; color:white; border:none; border-radius:8px; font-weight:600; cursor:pointer;">
                                                                        ✅ Mark as Available
                                                                    </button>
                                                                </form>
                                                                <% } %>
                                                                    <form action="adminCycle" method="POST"
                                                                        onsubmit="return confirm('Are you sure you want to remove this cycle?');">
                                                                        <input type="hidden" name="action"
                                                                            value="remove">
                                                                        <input type="hidden" name="cycleId"
                                                                            value="<%= c.getId() %>">
                                                                        <button type="submit" class="btn btn-danger"
                                                                            style="width: 100%; padding: 0.6rem;">🗑
                                                                            Remove Cycle</button>
                                                                    </form>
                                                        </div>
                                                    </div>
                                                </div>
                                                <% } } %>
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