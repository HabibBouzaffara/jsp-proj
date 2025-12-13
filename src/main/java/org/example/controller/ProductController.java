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

@WebServlet("/addProduct")
public class ProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryName = request.getParameter("category");
        if (categoryName != null) {
            request.setAttribute("categoryName", categoryName);
        }
        request.getRequestDispatcher("addProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String categoryName = request.getParameter("categoryName");
        String productName = request.getParameter("productName");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String discountStr = request.getParameter("discount");

        try {
            double price = Double.parseDouble(priceStr);
            double discount = discountStr != null && !discountStr.isEmpty()
                    ? Double.parseDouble(discountStr) : 0.0;

            // Find category
            CategoryRepository repo = CategoryRepository.getInstance();
            Category category = repo.findByName(categoryName);

            if (category != null) {
                Product product = new Product(
                        repo.getNextProductId(),
                        productName,
                        price,
                        description,
                        category.getId()
                );
                product.setDiscount(discount);

                category.getProducts().add(product);
                response.sendRedirect("categories");
            } else {
                request.setAttribute("error", "Category not found");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid price or discount format");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
