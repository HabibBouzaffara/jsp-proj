package org.example.model;

public class User {

    private String email;
    private String password;
    private String fullname;
    private boolean isAdmin;

    public User(String email, String password) {
        this.email = email;
        this.password = password;
        this.isAdmin = false;
    }

    public User(String email, String password, String fullname) {
        this(email, password);
        this.fullname = fullname;
    }

    public User(String email, String password, String fullname, boolean isAdmin) {
        this(email, password, fullname);
        this.isAdmin = isAdmin;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }
}
