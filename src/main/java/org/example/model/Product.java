package org.example.model;

public class Product {
    private int id;
    private String name;
    private double price;
    private String description;
    private String imagePath;
    private double discount; // Discount percentage (0-100)
    private int categoryId;

    public Product() {
        this.discount = 0.0;
    }

    public Product(int id, String name, double price, String description, int categoryId) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
        this.categoryId = categoryId;
        this.imagePath = "assets/img/products/"+name+".jpg";
        this.discount = 0.0;
    }

    // Calculate final price after discount
    public double getFinalPrice() {
        return price - (price * discount / 100);
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public double getDiscount() { return discount; }
    public void setDiscount(double discount) { this.discount = discount; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
}
