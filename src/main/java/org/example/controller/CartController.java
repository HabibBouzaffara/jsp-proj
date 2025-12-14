package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.model.CartItem;
import org.example.model.Product;
import org.example.repository.CategoryRepository;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if ("add".equals(action)) {
            addToCart(request, cart);
            String referer = request.getHeader("Referer");
            if (referer != null && referer.contains("home")) {
                response.sendRedirect("home");
            } else if (referer != null && referer.contains("product-detail")) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect("categories");
            }
        } else if ("remove".equals(action)) {
            removeFromCart(request, cart);
            response.sendRedirect("cart");
        } else if ("buy".equals(action)) {
            cart.clear();
            session.setAttribute("purchaseSuccess", true);
            response.sendRedirect("cart");
        }
    }

    private void addToCart(HttpServletRequest request, List<CartItem> cart) {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            CategoryRepository repo = CategoryRepository.getInstance();
            Product product = repo.findProductById(categoryId, productId);

            if (product != null) {
                // Check if product already in cart
                boolean found = false;
                for (CartItem item : cart) {
                    if (item.getProduct().getId() == productId) {
                        item.setQuantity(item.getQuantity() + 1);
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    cart.add(new CartItem(product, 1));
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    private void removeFromCart(HttpServletRequest request, List<CartItem> cart) {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cart.removeIf(item -> item.getProduct().getId() == productId);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
