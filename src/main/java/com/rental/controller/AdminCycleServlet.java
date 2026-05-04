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

@WebServlet("/adminCycle")
public class AdminCycleServlet extends HttpServlet {
    private CycleDAO cycleDAO = new CycleDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            Cycle cycle = new Cycle();
            cycle.setName(request.getParameter("name"));
            cycle.setBrand(request.getParameter("brand"));
            cycle.setImageUrl(request.getParameter("imageUrl"));
            cycle.setHourlyRate(Double.parseDouble(request.getParameter("hourlyRate")));
            cycle.setDailyRate(Double.parseDouble(request.getParameter("dailyRate")));
            cycle.setStatus("AVAILABLE");
            cycleDAO.addCycle(cycle);
            response.sendRedirect("adminDashboard?msg=Cycle added successfully!");
        } else if ("remove".equals(action)) {
            int cycleId = Integer.parseInt(request.getParameter("cycleId"));
            cycleDAO.removeCycle(cycleId);
            response.sendRedirect("adminDashboard?msg=Cycle removed successfully!");
        } else if ("markAvailable".equals(action)) {
            int cycleId = Integer.parseInt(request.getParameter("cycleId"));
            cycleDAO.updateStatus(cycleId, "AVAILABLE");
            response.sendRedirect("adminDashboard?msg=Cycle marked as Available! Customer return recorded.");
        } else if ("updatePrice".equals(action)) {
            int cycleId = Integer.parseInt(request.getParameter("cycleId"));
            double hourlyRate = Double.parseDouble(request.getParameter("hourlyRate"));
            double dailyRate = Double.parseDouble(request.getParameter("dailyRate"));
            cycleDAO.updatePrices(cycleId, hourlyRate, dailyRate);
            response.sendRedirect("adminDashboard?msg=Cycle prices updated successfully!");
        } else if ("bulkUpdatePrices".equals(action)) {
            String[] cycleIds = request.getParameterValues("cycleId");
            String[] hourlyRates = request.getParameterValues("hourlyRate");
            String[] dailyRates = request.getParameterValues("dailyRate");
            if (cycleIds != null && hourlyRates != null && dailyRates != null) {
                for (int i = 0; i < cycleIds.length; i++) {
                    int cycleId = Integer.parseInt(cycleIds[i]);
                    double hourlyRate = Double.parseDouble(hourlyRates[i]);
                    double dailyRate = Double.parseDouble(dailyRates[i]);
                    cycleDAO.updatePrices(cycleId, hourlyRate, dailyRate);
                }
            }
            response.sendRedirect("adminDashboard?msg=All cycle prices updated successfully!");
        } else {
            response.sendRedirect("adminDashboard");
        }
    }
}
