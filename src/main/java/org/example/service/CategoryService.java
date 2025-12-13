package org.example.service;

import org.example.model.Category;
import org.example.model.Product;
import org.example.repository.CategoryRepository;

import java.util.List;

public class CategoryService {

    private CategoryRepository repository;

    public CategoryService() {
        this.repository = CategoryRepository.getInstance();
    }

    public List<Category> getAllCategories() {
        return repository.findAll();
    }

    public void addCategory(Category category) {
        repository.add(category);
    }

    public Category getCategoryByName(String name) {
        return repository.findByName(name);
    }

    public Category getCategoryById(int id) {
        return repository.findById(id);
    }

    public void removeCategory(int id) {
        repository.remove(id);
    }

    public Product getProductById(int categoryId, int productId) {
        return repository.findProductById(categoryId, productId);
    }

    public void addProductToCategory(String categoryName, Product product) {
        Category category = repository.findByName(categoryName);
        if (category != null) {
            product.setId(repository.getNextProductId());
            product.setCategoryId(category.getId());
            category.getProducts().add(product);
        }
    }

    public void removeProductFromCategory(int categoryId, int productId) {
        Category category = repository.findById(categoryId);
        if (category != null) {
            category.getProducts().removeIf(p -> p.getId() == productId);
        }
    }

    public void applyCategoryDiscount(int categoryId, double discount) {
        Category category = repository.findById(categoryId);
        if (category != null) {
            category.setDiscount(discount);
            // Apply discount to all products in the category
            for (Product product : category.getProducts()) {
                product.setDiscount(discount);
            }
        }
    }

    public void applyProductDiscount(int categoryId, int productId, double discount) {
        Product product = repository.findProductById(categoryId, productId);
        if (product != null) {
            product.setDiscount(discount);
        }
    }
}
