<%@ page import="org.example.model.Category" %>
<%@ page import="org.example.model.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - IIT Store</title>
    <link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">
    <style>
        .admin-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 40px;
            border-radius: 10px;
        }
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }
        .stat-number {
            font-size: 48px;
            font-weight: bold;
            color: #667eea;
        }
        .action-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            border: 2px solid transparent;
        }
        .action-card:hover {
            border-color: #667eea;
            transform: scale(1.05);
        }
        .action-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }
        .category-table {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        .product-mini-card {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 10px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .product-mini-card img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<%@include file="shared/navbar.jsp"%>

<% 
    // Check admin access
    Boolean isAdminUser = (Boolean) session.getAttribute("isAdmin");
    if (isAdminUser == null || !isAdminUser) {
        response.sendRedirect("home");
        return;
    }
    
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    Integer totalCategories = (Integer) request.getAttribute("totalCategories");
    Integer totalProducts = (Integer) request.getAttribute("totalProducts");
%>

<div class="container mb-5">
    <!-- Header -->
    <div class="admin-header text-center">
        <h1 class="display-4 fw-bold">👨‍💼 Admin Dashboard</h1>
        <p class="lead">Manage your store products and categories</p>
    </div>
    
    <!-- Statistics -->
    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="stat-card text-center">
                <div class="stat-number"><%= totalCategories != null ? totalCategories : 0 %></div>
                <h5 class="text-muted">Total Categories</h5>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card text-center">
                <div class="stat-number"><%= totalProducts != null ? totalProducts : 0 %></div>
                <h5 class="text-muted">Total Products</h5>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card text-center">
                <div class="stat-number"><%
                    int discountedCount = 0;
                    if (categories != null) {
                        for (Category cat : categories) {
                            for (Product prod : cat.getProducts()) {
                                if (prod.getDiscount() > 0) discountedCount++;
                            }
                        }
                    }
                %><%=discountedCount%></div>
                <h5 class="text-muted">Active Discounts</h5>
            </div>
        </div>
    </div>
    
    <!-- Quick Actions -->
    <section class="mb-5">
        <h3 class="mb-4">Quick Actions</h3>
        <div class="row g-4">
            <div class="col-md-3">
                <a href="addCategory.jsp" class="text-decoration-none">
                    <div class="action-card">
                        <div class="action-icon">📁</div>
                        <h5>Add Category</h5>
                        <p class="text-muted mb-0">Create new category</p>
                    </div>
                </a>
            </div>
            <div class="col-md-3">
                <a href="addProduct.jsp" class="text-decoration-none">
                    <div class="action-card">
                        <div class="action-icon">📦</div>
                        <h5>Add Product</h5>
                        <p class="text-muted mb-0">Create new product</p>
                    </div>
                </a>
            </div>
            <div class="col-md-3">
                <a href="discount" class="text-decoration-none">
                    <div class="action-card">
                        <div class="action-icon">🏷️</div>
                        <h5>Manage Discounts</h5>
                        <p class="text-muted mb-0">Set product discounts</p>
                    </div>
                </a>
            </div>
            <div class="col-md-3">
                <a href="categories" class="text-decoration-none">
                    <div class="action-card">
                        <div class="action-icon">👁️</div>
                        <h5>View All</h5>
                        <p class="text-muted mb-0">Browse all products</p>
                    </div>
                </a>
            </div>
        </div>
    </section>
    
    <!-- Categories & Products Overview -->
    <section>
        <h3 class="mb-4">Categories & Products</h3>
        <div class="category-table">
            <% 
            if (categories != null && !categories.isEmpty()) {
                for (Category category : categories) {
            %>
            <div class="mb-4 pb-4 border-bottom">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <h5 class="mb-1"><%= category.getName() %></h5>
                        <p class="text-muted mb-0"><%= category.getDescription() %></p>
                    </div>
                    <span class="badge bg-primary"><%= category.getProducts().size() %> Products</span>
                </div>
                
                <div class="row g-2">
                    <% for (Product product : category.getProducts()) { %>
                    <div class="col-md-6">
                        <div class="product-mini-card">
                            <img src="<%= product.getImagePath() %>" alt="<%= product.getName() %>">
                            <div class="flex-grow-1">
                                <strong><%= product.getName() %></strong>
                                <div class="small text-muted">
                                    $<%= String.format("%.2f", product.getFinalPrice()) %>
                                    <% if (product.getDiscount() > 0) { %>
                                    <span class="badge bg-danger ms-2">-<%= String.format("%.0f", product.getDiscount()) %>%</span>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
            <% 
                }
            } else {
            %>
            <p class="text-center text-muted">No categories available</p>
            <% } %>
        </div>
    </section>
</div>

<script src="./libraries/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
