package com.rental.dao;

import com.rental.model.Rental;
import com.rental.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

public class RentalDAO {
    public boolean rentCycle(Rental rental) {
        String sql = "INSERT INTO rentals (user_id, cycle_id, start_time, end_time, total_amount, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, rental.getUserId());
            ps.setInt(2, rental.getCycleId());
            ps.setTimestamp(3, rental.getStartTime());
            ps.setTimestamp(4, rental.getEndTime());
            ps.setDouble(5, rental.getTotalAmount());
            ps.setString(6, "ACTIVE");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
