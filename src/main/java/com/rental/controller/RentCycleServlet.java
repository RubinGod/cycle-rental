package com.rental.controller;

import com.rental.dao.CycleDAO;
import com.rental.dao.RentalDAO;
import com.rental.model.Cycle;
import com.rental.model.Rental;
import com.rental.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/rentCycle")
public class RentCycleServlet extends HttpServlet {
    private CycleDAO cycleDAO = new CycleDAO();
    private RentalDAO rentalDAO = new RentalDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Cycle c = cycleDAO.getCycleById(id);
        request.setAttribute("cycle", c);
        request.getRequestDispatcher("/rent.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        int cycleId = Integer.parseInt(request.getParameter("cycleId"));
        int hours = Integer.parseInt(request.getParameter("hours"));

        Cycle cycle = cycleDAO.getCycleById(cycleId);
        double total = cycle.getHourlyRate() * hours;

        request.setAttribute("cycle", cycle);
        request.setAttribute("totalAmount", total);
        request.setAttribute("hours", hours);
        request.getRequestDispatcher("/payment.jsp").forward(request, response);
    }
}
