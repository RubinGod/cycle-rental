package com.rental.dao;

import com.rental.model.Cycle;
import com.rental.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CycleDAO {
    public List<Cycle> getAllCycles() {
        List<Cycle> cycles = new ArrayList<>();
        String sql = "SELECT * FROM cycles";
        try {
            Connection conn = DBConnection.getConnection();
            if (conn == null) return cycles;
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cycles.add(new Cycle(
                    rs.getInt("id"), rs.getString("name"), rs.getString("brand"),
                    rs.getString("image_url"), rs.getString("status"),
                    rs.getDouble("hourly_rate"), rs.getDouble("daily_rate")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cycles;
    }

    public Cycle getCycleById(int id) {
        String sql = "SELECT * FROM cycles WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Cycle(
                        rs.getInt("id"), rs.getString("name"), rs.getString("brand"),
                        rs.getString("image_url"), rs.getString("status"),
                        rs.getDouble("hourly_rate"), rs.getDouble("daily_rate")
                    );
                }
            }
            ps.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void updateStatus(int cycleId, String status) {
        String sql = "UPDATE cycles SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, cycleId);
            ps.executeUpdate();
            ps.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void addCycle(Cycle cycle) {
        String sql = "INSERT INTO cycles (name, brand, image_url, status, hourly_rate, daily_rate) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cycle.getName());
            ps.setString(2, cycle.getBrand());
            ps.setString(3, cycle.getImageUrl());
            ps.setString(4, cycle.getStatus());
            ps.setDouble(5, cycle.getHourlyRate());
            ps.setDouble(6, cycle.getDailyRate());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeCycle(int cycleId) {
        String sql = "DELETE FROM cycles WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cycleId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updatePrices(int cycleId, double hourlyRate, double dailyRate) {
        String sql = "UPDATE cycles SET hourly_rate = ?, daily_rate = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, hourlyRate);
            ps.setDouble(2, dailyRate);
            ps.setInt(3, cycleId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
