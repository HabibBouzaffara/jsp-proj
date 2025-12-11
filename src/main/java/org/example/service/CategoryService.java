package org.example.service;

import org.example.model.Category;
import org.example.repository.CategoryRepository;

import java.util.List;

public class CategoryService {

    private CategoryRepository repository;

    public CategoryService() {
        this.repository = CategoryRepository.getInstance();
    }

    public List<Category> getAllCategories() {
        return repository.getAllCategories();
    }

    public void addCategory(Category category) {
        repository.add(category);
    }

    public Category getCategoryByName(String name) {
        return repository.getByName(name);
    }
}
