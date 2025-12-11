package org.example.model;

import java.util.ArrayList;
import java.util.List;

public class Category {

    private int id; // auto-incremented
    private String name;
    private String description;
    private List<Product> products;
    private String imagePath;

    // Constructor with initial products
    public Category(int id, String name, String description, List<Product> products) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.products = products != null ? products : new ArrayList<>();

        // default image path based on name
        if (name != null && !name.isEmpty()) {
            this.imagePath = "assets/img/" + name.replaceAll("\\s+", "-") + ".jpg";
        } else {
            this.imagePath = "assets/img/default.jpg";
        }
    }

    public Category() {
        this.products = new ArrayList<>();
        this.imagePath = "assets/img/default.jpg";
    }

    // ---------- Getters & Setters ----------
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) {
        this.name = name;
        if (name != null && !name.isEmpty()) {
            this.imagePath = "assets/img/" + name.replaceAll("\\s+", "-") + ".jpg";
        }
    }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public List<Product> getProducts() { return products; }
    public void setProducts(List<Product> products) { this.products = products; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
}
