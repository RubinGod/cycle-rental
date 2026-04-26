package com.rental.model;
import java.sql.Timestamp;

public class Rental {
    private int id;
    private int userId;
    private int cycleId;
    private Timestamp startTime;
    private Timestamp endTime;
    private double totalAmount;
    private String status;

    public Rental() {}

    public Rental(int id, int userId, int cycleId, Timestamp startTime, Timestamp endTime, double totalAmount, String status) {
        this.id = id;
        this.userId = userId;
        this.cycleId = cycleId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.totalAmount = totalAmount;
        this.status = status;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getCycleId() { return cycleId; }
    public void setCycleId(int cycleId) { this.cycleId = cycleId; }
    public Timestamp getStartTime() { return startTime; }
    public void setStartTime(Timestamp startTime) { this.startTime = startTime; }
    public Timestamp getEndTime() { return endTime; }
    public void setEndTime(Timestamp endTime) { this.endTime = endTime; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
