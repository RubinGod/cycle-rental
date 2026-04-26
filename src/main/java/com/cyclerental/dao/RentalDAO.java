package com.cyclerental.dao;

import com.cyclerental.model.Rental;
import com.cyclerental.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class RentalDAO {

    public int createRental(Rental rental) {
        String query = "INSERT INTO rentals (user_id, cycle_id, rental_type, start_time, end_time, document_path, total_amount, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, rental.getUserId());
            stmt.setInt(2, rental.getCycleId());
            stmt.setString(3, rental.getRentalType());
            stmt.setTimestamp(4, rental.getStartTime());
            stmt.setTimestamp(5, rental.getEndTime());
            stmt.setString(6, rental.getDocumentPath());
            stmt.setDouble(7, rental.getTotalAmount());
            stmt.setString(8, rental.getPaymentStatus() != null ? rental.getPaymentStatus() : "PENDING");
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); 
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean updatePaymentStatus(int rentalId, String status) {
        String query = "UPDATE rentals SET payment_status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, rentalId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Rental getRentalById(int rentalId) {
        String query = "SELECT * FROM rentals WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, rentalId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Rental rental = new Rental();
                rental.setId(rs.getInt("id"));
                rental.setUserId(rs.getInt("user_id"));
                rental.setCycleId(rs.getInt("cycle_id"));
                rental.setRentalType(rs.getString("rental_type"));
                rental.setStartTime(rs.getTimestamp("start_time"));
                rental.setEndTime(rs.getTimestamp("end_time"));
                rental.setDocumentPath(rs.getString("document_path"));
                rental.setTotalAmount(rs.getDouble("total_amount"));
                rental.setPaymentStatus(rs.getString("payment_status"));
                return rental;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
