package org.example.repository;

import org.example.model.Category;
import org.example.model.Product;

import java.util.ArrayList;
import java.util.List;

public class CategoryRepository {

    private static CategoryRepository instance;
    private List<Category> categories = new ArrayList<>();
    private int nextId = 1;

    public CategoryRepository() {
        // Initialize with some categories and products

        // Electronics
        categories.add(new Category(nextId++, "Electronics", "Devices and gadgets", new ArrayList<>(List.of(
                new Product("Laptop", 999.99, "A high-performance laptop with 16GB RAM and SSD storage"),
                new Product("Smartphone", 799.99, "A sleek smartphone with a crystal-clear display"),
                new Product("Headphones", 199.99, "Noise-cancelling over-ear headphones"),
                new Product("Smartwatch", 249.99, "Track your fitness and notifications on the go"),
                new Product("Bluetooth Speaker", 149.99, "Portable wireless speaker with deep bass"),
                new Product("Tablet", 599.99, "10-inch tablet ideal for entertainment and work"),
                new Product("Gaming Console", 499.99, "Next-gen console for immersive gaming"),
                new Product("Camera", 899.99, "DSLR camera with 24MP sensor and 4K video"),
                new Product("Monitor", 279.99, "27-inch 4K UHD monitor with vivid colors"),
                new Product("Keyboard", 89.99, "Mechanical keyboard with RGB lighting")
        ))));

        // Clothes
        categories.add(new Category(nextId++, "Clothes", "Trendy and comfortable apparel", new ArrayList<>(List.of(
                new Product("T-Shirt", 29.99, "Soft cotton T-shirt available in various colors"),
                new Product("Jeans", 59.99, "Slim-fit jeans with stretchable fabric"),
                new Product("Jacket", 119.99, "Warm winter jacket with inner lining"),
                new Product("Sneakers", 89.99, "Comfortable sneakers for everyday wear"),
                new Product("Hoodie", 49.99, "Casual hoodie made of organic cotton"),
                new Product("Dress", 109.99, "Elegant evening dress with a modern cut"),
                new Product("Shorts", 34.99, "Light summer shorts for outdoor activities"),
                new Product("Sweater", 69.99, "Knitted sweater for cool weather"),
                new Product("Socks", 9.99, "Pack of 3 soft cotton socks"),
                new Product("Cap", 19.99, "Adjustable cap with stylish design")
        ))));

        // Kitchen Appliances
        categories.add(new Category(nextId++, "Kitchen-Appliances", "Everything for a cozy home", new ArrayList<>(List.of(
                new Product("Coffee Maker", 89.99, "Automatic drip coffee maker with timer"),
                new Product("Microwave Oven", 149.99, "800W microwave with digital display"),
                new Product("Blender", 79.99, "High-speed blender for smoothies and soups"),
                new Product("Vacuum Cleaner", 159.99, "Bagless vacuum cleaner with strong suction"),
                new Product("Toaster", 39.99, "2-slice toaster with browning control"),
                new Product("Air Fryer", 129.99, "Healthy frying with little to no oil"),
                new Product("Cookware Set", 199.99, "10-piece non-stick cookware set"),
                new Product("Electric Kettle", 49.99, "1.7L fast-boil electric kettle"),
                new Product("Iron", 59.99, "Steam iron with ceramic soleplate"),
                new Product("Dish Rack", 24.99, "Stainless steel drying rack for dishes")
        ))));

        // Sports & Outdoors
        categories.add(new Category(nextId++, "Sports-Outdoors", "Gear for active lifestyles", new ArrayList<>(List.of(
                new Product("Running Shoes", 119.99, "Lightweight and breathable running shoes"),
                new Product("Yoga Mat", 29.99, "Non-slip yoga mat with carrying strap"),
                new Product("Bicycle", 499.99, "21-speed mountain bike with durable frame"),
                new Product("Tent", 199.99, "2-person waterproof camping tent"),
                new Product("Backpack", 59.99, "Spacious hiking backpack with multiple pockets"),
                new Product("Water Bottle", 19.99, "Stainless steel insulated bottle"),
                new Product("Dumbbell Set", 89.99, "Adjustable dumbbells up to 20kg"),
                new Product("Tennis Racket", 99.99, "Lightweight graphite tennis racket"),
                new Product("Camping Stove", 79.99, "Portable gas stove for outdoor cooking"),
                new Product("Sleeping Bag", 69.99, "Warm sleeping bag for all seasons")
        ))));
    }


    public static synchronized CategoryRepository getInstance() {
        if (instance == null) instance = new CategoryRepository();
        return instance;
    }

    public List<Category> getAllCategories() { return categories; }

    public void add(Category category) {
        category.setId(nextId++);
        categories.add(category);
    }

    public Category getByName(String name) {
        return categories.stream().filter(c -> c.getName().equalsIgnoreCase(name)).findFirst().orElse(null);
    }

    public Category getById(int id) {
        return categories.stream().filter(c -> c.getId() == id).findFirst().orElse(null);
    }
}
