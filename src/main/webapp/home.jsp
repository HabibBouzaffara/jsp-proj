<%@ page import="org.example.model.Category" %>
<%@ page import="org.example.model.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>IIT/GR3 - Home</title>
    <link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 80px 0;
            margin-bottom: 50px;
        }
        .category-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            transition: transform 0.3s ease;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            height: 100%;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
        }
        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.2);
        }
        .category-card img {
            height: 200px;
            object-fit: cover;
        }
        .product-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            transition: transform 0.3s ease;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            height: 100%;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.2);
        }
        .product-card img {
            height: 250px;
            object-fit: cover;
            cursor: pointer;
        }
        .discount-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #ff4757;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 14px;
            z-index: 1;
        }
        .price-section {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .original-price {
            text-decoration: line-through;
            color: #999;
            font-size: 14px;
        }
        .final-price {
            font-size: 20px;
            font-weight: bold;
            color: #2ecc71;
        }
        .section-title {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 30px;
            position: relative;
            padding-bottom: 15px;
        }
        .section-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 80px;
            height: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .btn-add-cart {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            transition: all 0.3s ease;
        }
        .btn-add-cart:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 10px rgba(102, 126, 234, 0.4);
        }
        .clickable-product {
            text-decoration: none;
            color: inherit;
        }
        .product-card .card-body {
            cursor: default;
        }
    </style>
</head>
<body>

<%@include file="shared/navbar.jsp"%>

<!-- Hero Section -->
<div class="hero-section">
    <div class="container text-center">
        <h1 class="display-4 fw-bold mb-4">Welcome to Our Store</h1>
        <p class="lead mb-4">Discover amazing products with exclusive discounts</p>
        <a href="#products" class="btn btn-light btn-lg">Shop Now</a>
    </div>
</div>

<div class="container mb-5">
    <% 
        List<Product> discountedProducts = (List<Product>) request.getAttribute("discountedProducts");
        if (discountedProducts != null && !discountedProducts.isEmpty()) {
    %>
    <!-- Featured Discounts Section -->
    <section class="mb-5">
        <h2 class="section-title">🔥 Hot Deals</h2>
        <div class="row g-4">
            <% for (Product product : discountedProducts) { %>
            <div class="col-md-4">
                <div class="card product-card position-relative">
                    <span class="discount-badge">-<%= String.format("%.0f", product.getDiscount()) %>%</span>
                    <img src="<%= product.getImagePath() %>" 
                         class="card-img-top" 
                         alt="<%= product.getName() %>" 
                         loading="lazy"
                         onclick="window.location.href='product-detail?id=<%= product.getId() %>&categoryId=<%= product.getCategoryId() %>'">
                    <div class="card-body">
                        <h5 class="card-title" style="cursor: pointer;" onclick="window.location.href='product-detail?id=<%= product.getId() %>&categoryId=<%= product.getCategoryId() %>'"><%= product.getName() %></h5>
                        <p class="card-text text-muted"><%= product.getDescription() %></p>
                        <div class="price-section mb-3">
                            <span class="original-price">$<%= String.format("%.2f", product.getPrice()) %></span>
                            <span class="final-price">$<%= String.format("%.2f", product.getFinalPrice()) %></span>
                        </div>
                        <form method="post" action="cart" class="w-100">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                            <input type="hidden" name="categoryId" value="<%= product.getCategoryId() %>">
                            <button type="submit" class="btn btn-add-cart w-100">Add to Cart</button>
                        </form>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </section>
    <% } %>

    <!-- Categories Section -->
    <section class="mb-5" id="categories">
        <h2 class="section-title">Browse Categories</h2>
        <div class="row g-4">
            <% 
                List<Category> categories = (List<Category>) request.getAttribute("categories");
                if (categories != null) {
                    for (Category category : categories) {
            %>
            <div class="col-md-3">
                <a href="categories?id=<%= category.getId() %>" class="category-card text-decoration-none">
                    <div class="card">
                        <img src="<%= category.getImagePath() %>" class="card-img-top" alt="<%= category.getName() %>" loading="lazy">
                        <div class="card-body text-center">
                            <h5 class="card-title text-dark"><%= category.getName() %></h5>
                            <p class="card-text text-muted"><%= category.getDescription() %></p>
                        </div>
                    </div>
                </a>
            </div>
            <% 
                    }
                }
            %>
        </div>
    </section>

    <!-- All Products Section -->
    <section id="products">
        <h2 class="section-title">All Products</h2>
        <div class="row g-4">
            <% 
                List<Product> allProducts = (List<Product>) request.getAttribute("allProducts");
                if (allProducts != null) {
                    for (Product product : allProducts) {
            %>
            <div class="col-md-3">
                <div class="card product-card position-relative">
                    <% if (product.getDiscount() > 0) { %>
                    <span class="discount-badge">-<%= String.format("%.0f", product.getDiscount()) %>%</span>
                    <% } %>
                    <img src="<%= product.getImagePath() %>" 
                         class="card-img-top" 
                         alt="<%= product.getName() %>" 
                         loading="lazy"
                         onclick="window.location.href='product-detail?id=<%= product.getId() %>&categoryId=<%= product.getCategoryId() %>'">
                    <div class="card-body">
                        <h5 class="card-title" style="cursor: pointer;" onclick="window.location.href='product-detail?id=<%= product.getId() %>&categoryId=<%= product.getCategoryId() %>'"><%= product.getName() %></h5>
                        <p class="card-text text-muted" style="font-size: 14px;"><%= product.getDescription() %></p>
                        <div class="price-section mb-3">
                            <% if (product.getDiscount() > 0) { %>
                            <span class="original-price">$<%= String.format("%.2f", product.getPrice()) %></span>
                            <span class="final-price">$<%= String.format("%.2f", product.getFinalPrice()) %></span>
                            <% } else { %>
                            <span class="final-price">$<%= String.format("%.2f", product.getPrice()) %></span>
                            <% } %>
                        </div>
                        <form method="post" action="cart" class="w-100">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                            <input type="hidden" name="categoryId" value="<%= product.getCategoryId() %>">
                            <button type="submit" class="btn btn-add-cart w-100">Add to Cart</button>
                        </form>
                    </div>
                </div>
            </div>
            <% 
                    }
                }
            %>
        </div>
    </section>
</div>

<script src="./libraries/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
