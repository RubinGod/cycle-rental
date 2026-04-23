package com.cyclerental.controller;

import com.cyclerental.dao.CycleDAO;
import com.cyclerental.dao.RentalDAO;
import com.cyclerental.model.Cycle;
import com.cyclerental.model.Rental;
import com.cyclerental.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.Duration;
import java.util.UUID;

@WebServlet("/rentCycle")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class RentCycleServlet extends HttpServlet {
    private CycleDAO cycleDAO = new CycleDAO();
    private RentalDAO rentalDAO = new RentalDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int cycleId = Integer.parseInt(request.getParameter("cycleId"));
        Cycle cycle = cycleDAO.getCycleById(cycleId);
        
        request.setAttribute("cycle", cycle);
        request.getRequestDispatcher("rent_cycle.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int cycleId = Integer.parseInt(request.getParameter("cycleId"));
        String rentalType = request.getParameter("rentalType");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        
        // Parse the HTML5 datetime-local string (format: YYYY-MM-DDThh:mm)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime startLocal = LocalDateTime.parse(startTimeStr, formatter);
        LocalDateTime endLocal = LocalDateTime.parse(endTimeStr, formatter);
        
        Timestamp startTimestamp = Timestamp.valueOf(startLocal);
        Timestamp endTimestamp = Timestamp.valueOf(endLocal);

        // Calculate Duration
        Duration duration = Duration.between(startLocal, endLocal);
        long hours = duration.toHours();
        long days = duration.toDays();
        
        Cycle cycle = cycleDAO.getCycleById(cycleId);
        double totalAmount = 0;
        
        if ("HOURLY".equals(rentalType)) {
            long billableHours = hours > 0 ? hours : 1; // minimum 1 hour
            totalAmount = cycle.getHourlyRate() * billableHours;
        } else if ("DAILY".equals(rentalType)) {
            long billableDays = days > 0 ? days : 1; // minimum 1 day
            totalAmount = cycle.getDailyRate() * billableDays;
        }

        // Handle File Upload
        Part filePart = request.getPart("document");
        String fileName = UUID.randomUUID().toString() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();
        
        filePart.write(uploadPath + File.separator + fileName);

        Rental rental = new Rental();
        rental.setUserId(user.getId());
        rental.setCycleId(cycleId);
        rental.setRentalType(rentalType);
        rental.setStartTime(startTimestamp);
        rental.setEndTime(endTimestamp);
        rental.setDocumentPath("uploads/" + fileName);
        rental.setTotalAmount(totalAmount);
        rental.setPaymentStatus("PENDING");

        int rentalId = rentalDAO.createRental(rental);
        
        // Temporarily mark cycle as rented to prevent double booking
        cycleDAO.updateCycleStatus(cycleId, "RENTED");

        response.sendRedirect("payment.jsp?rentalId=" + rentalId + "&amount=" + totalAmount);
    }
}
