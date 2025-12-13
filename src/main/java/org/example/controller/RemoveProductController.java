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

@WebServlet("/removeProduct")
public class RemoveProductController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productIdStr = request.getParameter("productId");
        String categoryIdStr = request.getParameter("categoryId");

        try {
            int productId = Integer.parseInt(productIdStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            CategoryRepository repo = CategoryRepository.getInstance();
            Category category = repo.findById(categoryId);

            if (category != null) {
                category.getProducts().removeIf(p -> p.getId() == productId);
            }

            response.sendRedirect("categories");
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp");
        }
    }
}
