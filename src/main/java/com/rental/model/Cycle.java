package com.rental.model;

public class Cycle {
    private int id;
    private String name;
    private String brand;
    private String imageUrl;
    private String status;
    private double hourlyRate;
    private double dailyRate;

    public Cycle() {}

    public Cycle(int id, String name, String brand, String imageUrl, String status, double hourlyRate, double dailyRate) {
        this.id = id;
        this.name = name;
        this.brand = brand;
        this.imageUrl = imageUrl;
        this.status = status;
        this.hourlyRate = hourlyRate;
        this.dailyRate = dailyRate;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public double getHourlyRate() { return hourlyRate; }
    public void setHourlyRate(double hourlyRate) { this.hourlyRate = hourlyRate; }
    public double getDailyRate() { return dailyRate; }
    public void setDailyRate(double dailyRate) { this.dailyRate = dailyRate; }
}
