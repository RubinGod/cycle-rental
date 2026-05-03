package com.rental.controller;

import com.rental.dao.UserDAO;
import com.rental.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
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
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = userDAO.authenticateUser(request.getParameter("username"), request.getParameter("password"));
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            String rememberMe = request.getParameter("rememberMe");
            if ("on".equals(rememberMe)) {
                jakarta.servlet.http.Cookie cookie = new jakarta.servlet.http.Cookie("rememberedUser", user.getUsername());
                cookie.setMaxAge(60 * 60 * 24 * 7); // 7 days
                response.addCookie(cookie);
            } else {
                jakarta.servlet.http.Cookie cookie = new jakarta.servlet.http.Cookie("rememberedUser", "");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }

            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect("adminDashboard");
            } else {
                response.sendRedirect("userDashboard");
            }
        } else {
            request.setAttribute("error", "Invalid credentials!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
