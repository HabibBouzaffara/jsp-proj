package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.Category;
import org.example.repository.CategoryRepository;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoryController", urlPatterns = "/categories")
public class CategoryController extends HttpServlet {

    private CategoryRepository repository;

    @Override
    public void init() throws ServletException {
        super.init();
        // ✅ get singleton instance
        repository = CategoryRepository.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ✅ fetch categories from repository
        List<Category> categories = repository.getAllCategories();
        request.setAttribute("categories", categories);

        // forward to JSP
        request.getRequestDispatcher("categories.jsp").forward(request, response);
    }
}
