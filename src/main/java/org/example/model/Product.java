package org.example.model;

public class Product {
    private String name;
    private double price;
    private String description;
    private String imagePath;

    public Product() {}

    public Product(String name, double price, String description) {
        
        this.name = name;
        this.price = price;
        this.description = description;
        this.imagePath = "assets/img/products/default.jpg";
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    }
