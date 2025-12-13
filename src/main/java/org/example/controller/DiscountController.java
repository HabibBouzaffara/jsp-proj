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

@WebServlet("/discount")
public class DiscountController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryRepository repo = CategoryRepository.getInstance();
        request.setAttribute("categories", repo.findAll());
        request.getRequestDispatcher("discount.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");
        String discountStr = request.getParameter("discount");

        try {
            double discount = Double.parseDouble(discountStr);
            CategoryRepository repo = CategoryRepository.getInstance();

            if ("category".equals(type)) {
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                Category category = repo.findById(categoryId);
                if (category != null) {
                    category.setDiscount(discount);
                    // Apply to all products in category
                    for (Product p : category.getProducts()) {
                        p.setDiscount(discount);
                    }
                }
            } else if ("product".equals(type)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                Product product = repo.findProductById(categoryId, productId);
                if (product != null) {
                    product.setDiscount(discount);
                }
            }

            response.sendRedirect("discount?success=true");
        } catch (NumberFormatException e) {
            response.sendRedirect("discount?error=true");
        }
    }
}
