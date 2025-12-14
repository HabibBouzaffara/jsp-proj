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
                "Latest gadgets and cutting-edge technology", new ArrayList<>());
        electronics.setImagePath("https://images.unsplash.com/photo-1498049794561-7780e7231661?w=400");

        Product laptop = new Product(nextProductId++, "MacBook Pro", 2499.99,
                "Apple M2 Pro chip with 16GB RAM", electronics.getId());
        laptop.setImagePath("https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400");
        laptop.setDiscount(15.0);

        Product phone = new Product(nextProductId++, "iPhone 15 Pro", 1199.99,
                "Latest flagship with A17 Pro chip", electronics.getId());
        phone.setImagePath("https://images.unsplash.com/photo-1592286927505-2fd0f9447c89?w=400");
        phone.setDiscount(10.0);

        Product headphones = new Product(nextProductId++, "Sony WH-1000XM5", 399.99,
                "Premium noise-canceling headphones", electronics.getId());
        headphones.setImagePath("https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400");
        headphones.setDiscount(20.0);

        Product smartwatch = new Product(nextProductId++, "Apple Watch Ultra", 799.99,
                "Rugged GPS smartwatch", electronics.getId());
        smartwatch.setImagePath("https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=400");

        electronics.getProducts().add(laptop);
        electronics.getProducts().add(phone);
        electronics.getProducts().add(headphones);
        electronics.getProducts().add(smartwatch);
        categories.add(electronics);

        // Fashion category
        Category fashion = new Category(nextCategoryId++, "Fashion",
                "Trendy clothing and premium accessories", new ArrayList<>());
        fashion.setImagePath("https://images.unsplash.com/photo-1445205170230-053b83016050?w=400");

        Product tshirt = new Product(nextProductId++, "Designer T-Shirt", 49.99,
                "Premium cotton graphic tee", fashion.getId());
        tshirt.setImagePath("https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400");
        tshirt.setDiscount(25.0);

        Product jeans = new Product(nextProductId++, "Levi's 501 Jeans", 89.99,
                "Classic straight fit denim", fashion.getId());
        jeans.setImagePath("https://images.unsplash.com/photo-1542272604-787c3835535d?w=400");

        Product sneakers = new Product(nextProductId++, "Nike Air Max", 159.99,
                "Iconic running sneakers", fashion.getId());
        sneakers.setImagePath("https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400");
        sneakers.setDiscount(30.0);

        Product jacket = new Product(nextProductId++, "Leather Jacket", 299.99,
                "Genuine leather bomber jacket", fashion.getId());
        jacket.setImagePath("https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400");

        fashion.getProducts().add(tshirt);
        fashion.getProducts().add(jeans);
        fashion.getProducts().add(sneakers);
        fashion.getProducts().add(jacket);
        categories.add(fashion);

        // Home & Living category
        Category homeLiving = new Category(nextCategoryId++, "Home & Living",
                "Beautiful furniture and home decor", new ArrayList<>());
        homeLiving.setImagePath("https://images.unsplash.com/photo-1556912172-45b7abe8b7e1?w=400");

        Product coffeeMaker = new Product(nextProductId++, "Nespresso Machine", 199.99,
                "Professional espresso maker", homeLiving.getId());
        coffeeMaker.setImagePath("https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=400");
        coffeeMaker.setDiscount(15.0);

        Product lamp = new Product(nextProductId++, "Modern Floor Lamp", 129.99,
                "Scandinavian design floor lamp", homeLiving.getId());
        lamp.setImagePath("https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=400");

        Product chair = new Product(nextProductId++, "Ergonomic Chair", 399.99,
                "Premium office chair with lumbar support", homeLiving.getId());
        chair.setImagePath("https://images.unsplash.com/photo-1592078615290-033ee584e267?w=400");
        chair.setDiscount(20.0);

        homeLiving.getProducts().add(coffeeMaker);
        homeLiving.getProducts().add(lamp);
        homeLiving.getProducts().add(chair);
        categories.add(homeLiving);

        // Sports & Fitness category
        Category sports = new Category(nextCategoryId++, "Sports & Fitness",
                "Equipment for active lifestyle", new ArrayList<>());
        sports.setImagePath("https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400");

        Product yogaMat = new Product(nextProductId++, "Premium Yoga Mat", 59.99,
                "Extra thick non-slip yoga mat", sports.getId());
        yogaMat.setImagePath("https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=400");
        yogaMat.setDiscount(35.0);

        Product dumbbells = new Product(nextProductId++, "Adjustable Dumbbells", 249.99,
                "5-52.5 lbs adjustable weight set", sports.getId());
        dumbbells.setImagePath("https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=400");

        Product bicycle = new Product(nextProductId++, "Mountain Bike", 899.99,
                "21-speed aluminum frame bike", sports.getId());
        bicycle.setImagePath("https://images.unsplash.com/photo-1576435728678-68d0fbf94e91?w=400");
        bicycle.setDiscount(10.0);

        sports.getProducts().add(yogaMat);
        sports.getProducts().add(dumbbells);
        sports.getProducts().add(bicycle);
        categories.add(sports);
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
