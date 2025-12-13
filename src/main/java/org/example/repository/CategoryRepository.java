package org.example.repository;

import org.example.model.Category;
import org.example.model.Product;

import java.util.ArrayList;
import java.util.List;

public class CategoryRepository {
    private static CategoryRepository instance;
    private List<Category> categories;
    private int nextCategoryId = 1;
    private int nextProductId = 1;

    private CategoryRepository() {
        categories = new ArrayList<>();
        initializeDemoData();
    }

    public static synchronized CategoryRepository getInstance() {
        if (instance == null) {
            instance = new CategoryRepository();
        }
        return instance;
    }

    private void initializeDemoData() {
        // Electronics category
        Category electronics = new Category(nextCategoryId++, "Electronics",
                "Latest gadgets and devices", new ArrayList<>());

        Product laptop = new Product(nextProductId++, "Laptop", 999.99,
                "High-performance laptop", electronics.getId());
        Product phone = new Product(nextProductId++, "Smartphone", 699.99,
                "Latest smartphone", electronics.getId());

        electronics.getProducts().add(laptop);
        electronics.getProducts().add(phone);
        categories.add(electronics);

        // Fashion category
        Category fashion = new Category(nextCategoryId++, "Fashion",
                "Trendy clothing and accessories", new ArrayList<>());

        Product tshirt = new Product(nextProductId++, "T-Shirt", 29.99,
                "Comfortable cotton t-shirt", fashion.getId());
        Product jeans = new Product(nextProductId++, "Jeans", 59.99,
                "Classic denim jeans", fashion.getId());

        fashion.getProducts().add(tshirt);
        fashion.getProducts().add(jeans);
        categories.add(fashion);
    }

    public List<Category> findAll() {
        return new ArrayList<>(categories);
    }

    public Category findById(int id) {
        return categories.stream()
                .filter(c -> c.getId() == id)
                .findFirst()
                .orElse(null);
    }

    public Category findByName(String name) {
        return categories.stream()
                .filter(c -> c.getName().equalsIgnoreCase(name))
                .findFirst()
                .orElse(null);
    }

    public void add(Category category) {
        category.setId(nextCategoryId++);
        categories.add(category);
    }

    public void remove(int id) {
        categories.removeIf(c -> c.getId() == id);
    }

    public Product findProductById(int categoryId, int productId) {
        Category category = findById(categoryId);
        if (category != null) {
            return category.getProducts().stream()
                    .filter(p -> p.getId() == productId)
                    .findFirst()
                    .orElse(null);
        }
        return null;
    }

    public int getNextProductId() {
        return nextProductId++;
    }
}
