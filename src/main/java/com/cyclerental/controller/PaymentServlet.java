package com.cyclerental.controller;

import com.cyclerental.dao.RentalDAO;
import com.cyclerental.model.Rental;
import com.cyclerental.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/processPayment")
public class PaymentServlet extends HttpServlet {
    private RentalDAO rentalDAO = new RentalDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int rentalId = Integer.parseInt(request.getParameter("rentalId"));
        // In a real application, you would integrate with Stripe/PayPal here.
        // For this mockup, we just assume payment is successful.
        
        boolean updated = rentalDAO.updatePaymentStatus(rentalId, "PAID");
        
        if (updated) {
            response.sendRedirect("userDashboard?msg=Payment Successful! Cycle rented.");
        } else {
            response.sendRedirect("userDashboard?error=Payment Failed.");
        }
    }
}
