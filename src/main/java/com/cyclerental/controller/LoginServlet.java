package com.cyclerental.controller;

import com.cyclerental.dao.UserDAO;
import com.cyclerental.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        User user = userDAO.authenticateUser(username, password);

        if (user != null) {
            // Handle Session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Handle Cookie
            if ("true".equals(rememberMe)) {
                Cookie cookie = new Cookie("rememberedUser", username);
                cookie.setMaxAge(60 * 60 * 24 * 30); // 30 days
                response.addCookie(cookie);
            } else {
                // Clear the cookie if not checked
                Cookie cookie = new Cookie("rememberedUser", "");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }

            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect("adminDashboard?welcome=true");
            } else {
                response.sendRedirect("userDashboard?welcome=true");
            }
        } else {
            request.setAttribute("error", "Invalid credentials.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
