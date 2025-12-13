package com.eshop.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * LoginServlet - Handles user authentication
 * Simple implementation with hardcoded credentials
 * In production: Use database and password hashing
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get credentials from form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate credentials
        String role = validateUser(username, password);
        
        if (role != null) {
            // Create session for authenticated user
            HttpSession session = request.getSession();
            session.setAttribute("user", username);
            session.setAttribute("role", role);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            
            // Redirect based on role
            if ("admin".equals(role)) {
                response.sendRedirect("admin/dashboard.jsp");
            } else if ("client".equals(role)) {
                response.sendRedirect("client/shop.jsp");
            }
        } else {
            // Invalid credentials - redirect back to login
            response.sendRedirect("login.jsp?error=true");
        }
    }
    
    /**
     * Validate user credentials
     * @return user role if valid, null if invalid
     */
    private String validateUser(String username, String password) {
        // Simple validation - In production: Query database
        if ("admin".equals(username) && "admin123".equals(password)) {
            return "admin";
        } else if ("client".equals(username) && "client123".equals(password)) {
            return "client";
        }
        return null;
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to login page
        response.sendRedirect("login.jsp");
    }
}