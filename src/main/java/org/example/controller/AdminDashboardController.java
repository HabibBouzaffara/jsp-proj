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

@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin"})
public class AdminDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Boolean isAdmin = (Boolean) req.getSession().getAttribute("isAdmin");
        
        if (isAdmin == null || !isAdmin) {
            resp.sendRedirect("home");
            return;
        }
        
        CategoryRepository categoryRepo = CategoryRepository.getInstance();
        List<Category> categories = categoryRepo.findAll();
        
        int totalProducts = 0;
        for (Category category : categories) {
            totalProducts += category.getProducts().size();
        }
        
        req.setAttribute("categories", categories);
        req.setAttribute("totalCategories", categories.size());
        req.setAttribute("totalProducts", totalProducts);
        
        req.getRequestDispatcher("adminDashboard.jsp").forward(req, resp);
    }
}
