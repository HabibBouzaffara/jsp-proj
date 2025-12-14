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
import java.util.List;

@WebServlet(name = "ProductDetailController", urlPatterns = {"/product-detail"})
public class ProductDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productIdStr = req.getParameter("id");
        String categoryIdStr = req.getParameter("categoryId");
        
        if (productIdStr == null || categoryIdStr == null) {
            resp.sendRedirect("home");
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            
            CategoryRepository categoryRepo = CategoryRepository.getInstance();
            Product product = categoryRepo.findProductById(categoryId, productId);
            Category category = categoryRepo.findById(categoryId);
            
            if (product != null && category != null) {
                req.setAttribute("product", product);
                req.setAttribute("category", category);
                
                // Get related products from the same category
                List<Product> relatedProducts = category.getProducts().stream()
                    .filter(p -> p.getId() != productId)
                    .limit(4)
                    .toList();
                req.setAttribute("relatedProducts", relatedProducts);
                
                req.getRequestDispatcher("productDetail.jsp").forward(req, resp);
            } else {
                resp.sendRedirect("home");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect("home");
        }
    }
}
