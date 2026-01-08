/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author khadk
 */
public class User {
    
    private String name;
    private String username;
    private String password;
    private String role; // Added to distinguish between user types

    // Constructor updated to include role
    public User(String name, String username, String password, String role) {
        this.name = name;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    // Getters and setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    // Override toString to save/load from users.txt easily
    @Override
    public String toString() {
        return name + "," + username + "," + password + "," + role;
    }

    // Parse User from a CSV line (Updated for 4 parts, backward compatible with 3)
    public static User fromString(String line) {
        String[] parts = line.split(",");
        if (parts.length == 4) {
            return new User(parts[0], parts[1], parts[2], parts[3]);
        } else if (parts.length == 3) {
            return new User(parts[0], parts[1], parts[2], "user"); // Default role
        }
        return null;
    }
}