package com.rental.controller;

import com.rental.dao.CycleDAO;
import com.rental.model.Cycle;
import com.rental.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    private CycleDAO cycleDAO = new CycleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }
        List<Cycle> cycles = cycleDAO.getAllCycles();
        request.setAttribute("cycles", cycles);
        request.getRequestDispatcher("/admin_dashboard.jsp").forward(request, response);
    }
}
