package com.cyclerental.controller;

import com.cyclerental.dao.CycleDAO;
import com.cyclerental.model.Cycle;
import com.cyclerental.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/adminCycle")
public class AdminCycleServlet extends HttpServlet {
    private CycleDAO cycleDAO = new CycleDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String brand = request.getParameter("brand");
            String imageUrl = request.getParameter("imageUrl");
            double hourlyRate = Double.parseDouble(request.getParameter("hourlyRate"));
            double dailyRate = Double.parseDouble(request.getParameter("dailyRate"));
            
            Cycle cycle = new Cycle(0, name, brand, imageUrl, "AVAILABLE", hourlyRate, dailyRate);
            cycleDAO.addCycle(cycle);
        } else if ("remove".equals(action)) {
            int cycleId = Integer.parseInt(request.getParameter("cycleId"));
            cycleDAO.removeCycle(cycleId);
        }
        
        response.sendRedirect("adminDashboard");
    }
}
