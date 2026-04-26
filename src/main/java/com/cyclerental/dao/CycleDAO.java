package com.cyclerental.dao;

import com.cyclerental.model.Cycle;
import com.cyclerental.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CycleDAO {

    public List<Cycle> getAllCycles() {
        List<Cycle> cycles = new ArrayList<>();
        String query = "SELECT * FROM cycles";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                cycles.add(new Cycle(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("brand"),
                    rs.getString("image_url"),
                    rs.getString("status"),
                    rs.getDouble("hourly_rate"),
                    rs.getDouble("daily_rate")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cycles;
    }

    public List<Cycle> getAvailableCycles() {
        List<Cycle> cycles = new ArrayList<>();
        String query = "SELECT * FROM cycles WHERE status = 'AVAILABLE'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                cycles.add(new Cycle(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("brand"),
                    rs.getString("image_url"),
                    rs.getString("status"),
                    rs.getDouble("hourly_rate"),
                    rs.getDouble("daily_rate")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cycles;
    }

    public Cycle getCycleById(int id) {
        String query = "SELECT * FROM cycles WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Cycle(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("brand"),
                    rs.getString("image_url"),
                    rs.getString("status"),
                    rs.getDouble("hourly_rate"),
                    rs.getDouble("daily_rate")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addCycle(Cycle cycle) {
        String query = "INSERT INTO cycles (name, brand, image_url, hourly_rate, daily_rate) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, cycle.getName());
            stmt.setString(2, cycle.getBrand());
            stmt.setString(3, cycle.getImageUrl());
            stmt.setDouble(4, cycle.getHourlyRate());
            stmt.setDouble(5, cycle.getDailyRate());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeCycle(int id) {
        String query = "DELETE FROM cycles WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCycleStatus(int id, String status) {
        String query = "UPDATE cycles SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
