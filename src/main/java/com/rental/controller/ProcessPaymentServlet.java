package com.rental.controller;

import com.rental.dao.CycleDAO;
import com.rental.dao.RentalDAO;
import com.rental.model.Rental;
import com.rental.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/processPayment")
public class ProcessPaymentServlet extends HttpServlet {
    private CycleDAO cycleDAO = new CycleDAO();
    private RentalDAO rentalDAO = new RentalDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        int cycleId = Integer.parseInt(request.getParameter("cycleId"));
        int hours = Integer.parseInt(request.getParameter("hours"));
        double total = Double.parseDouble(request.getParameter("total"));

        Rental rental = new Rental();
        rental.setUserId(user.getId());
        rental.setCycleId(cycleId);
        rental.setStartTime(new Timestamp(System.currentTimeMillis()));
        rental.setEndTime(new Timestamp(System.currentTimeMillis() + (hours * 3600000L)));
        rental.setTotalAmount(total);

        if (rentalDAO.rentCycle(rental)) {
            cycleDAO.updateStatus(cycleId, "RENTED");
            response.sendRedirect("userDashboard?msg=Payment Successful! Enjoy your ride.");
        } else {
            response.sendRedirect("userDashboard?error=Payment processing failed.");
        }
    }
}
