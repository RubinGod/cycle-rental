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
    private String role; // Field to distinguish between 'admin' and 'user'

    public User(String name, String username, String password, String role) {
        this.name = name;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public String getName() { return name; }
    public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getRole() { return role; }

    @Override
    public String toString() {
        return name + "," + username + "," + password + "," + role;
    }

    public static User fromString(String line) {
        String[] parts = line.split(",");
        // Must have 4 parts to be valid
        if (parts.length != 4) return null;
        return new User(parts[0], parts[1], parts[2], parts[3]);
    }
}

