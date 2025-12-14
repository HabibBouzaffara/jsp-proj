package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.Category;
import org.example.model.Product;
import org.example.repository.CategoryRepository;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CategoryRepository categoryRepo = CategoryRepository.getInstance();
        
        // Get all categories
        List<Category> categories = categoryRepo.findAll();
        
        // Get all products with discounts
        List<Product> discountedProducts = new ArrayList<>();
        for (Category category : categories) {
            for (Product product : category.getProducts()) {
                if (product.getDiscount() > 0) {
                    discountedProducts.add(product);
                }
            }
        }
        
        // Get all products
        List<Product> allProducts = new ArrayList<>();
        for (Category category : categories) {
            allProducts.addAll(category.getProducts());
        }
        
        req.setAttribute("categories", categories);
        req.setAttribute("discountedProducts", discountedProducts);
        req.setAttribute("allProducts", allProducts);
        
        req.getRequestDispatcher("home.jsp").forward(req, resp);
    }
}
