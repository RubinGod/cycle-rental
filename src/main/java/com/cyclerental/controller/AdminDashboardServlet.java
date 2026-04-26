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
import java.util.List;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    private CycleDAO cycleDAO = new CycleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp?error=Unauthorized Access");
            return;
        }

        List<Cycle> cycles = cycleDAO.getAllCycles();
        request.setAttribute("cycles", cycles);
        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }
}
