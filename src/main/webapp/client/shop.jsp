<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*" %>
<%
    // Check if user is logged in as client
    if (session.getAttribute("user") == null || !"client".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    String username = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop - Client Area</title>
    <link rel="stylesheet" href="../css/style.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .navbar {
            background: #333;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar h1 { font-size: 24px; }
        .navbar .user-info { display: flex; gap: 20px; align-items: center; }
        .btn-logout {
            background: #dc3545;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 20px; }
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .product-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .product-card h3 { color: #333; margin-bottom: 10px; }
        .product-price { font-size: 20px; color: #28a745; font-weight: bold; margin: 10px 0; }
        .product-category { color: #666; font-size: 14px; margin-bottom: 10px; }
        .btn-add-cart {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-add-cart:hover { background: #0056b3; }
        .cart-icon {
            position: relative;
            cursor: pointer;
        }
        .cart-count {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #dc3545;
            color: white;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
        }
        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .filter-section select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>🛒 E-Shop - Client Area</h1>
        <div class="user-info">
            <span>Welcome, <%= username %>!</span>
            <a href="cart.jsp" class="cart-icon">
                🛒 Cart
                <span class="cart-count">0</span>
            </a>
            <form action="../LogoutServlet" method="post" style="display: inline;">
                <button type="submit" class="btn-logout">Logout</button>
            </form>
        </div>
    </nav>

    <div class="container">
        <div class="filter-section">
            <strong>Filter by Category:</strong>
            <select id="categoryFilter" onchange="filterProducts()">
                <option value="all">All Categories</option>
                <option value="electronics">Electronics</option>
                <option value="clothing">Clothing</option>
                <option value="food">Food</option>
                <option value="books">Books</option>
            </select>
        </div>

        <h2>Available Products</h2>
        <div class="products-grid" id="productsGrid">
            <!-- Sample products - In real app, fetch from database -->
            <div class="product-card" data-category="electronics">
                <h3>Laptop</h3>
                <p class="product-category">Category: Electronics</p>
                <p class="product-price">$999.99</p>
                <p>High-performance laptop for work and gaming</p>
                <button class="btn-add-cart" onclick="addToCart(1)">Add to Cart</button>
            </div>
            
            <div class="product-card" data-category="clothing">
                <h3>T-Shirt</h3>
                <p class="product-category">Category: Clothing</p>
                <p class="product-price">$19.99</p>
                <p>Comfortable cotton t-shirt</p>
                <button class="btn-add-cart" onclick="addToCart(2)">Add to Cart</button>
            </div>
            
            <div class="product-card" data-category="food">
                <h3>Coffee Beans</h3>
                <p class="product-category">Category: Food</p>
                <p class="product-price">$12.99</p>
                <p>Premium arabica coffee beans</p>
                <button class="btn-add-cart" onclick="addToCart(3)">Add to Cart</button>
            </div>
            
            <div class="product-card" data-category="books">
                <h3>Programming Book</h3>
                <p class="product-category">Category: Books</p>
                <p class="product-price">$39.99</p>
                <p>Learn advanced programming concepts</p>
                <button class="btn-add-cart" onclick="addToCart(4)">Add to Cart</button>
            </div>
            
            <div class="product-card" data-category="electronics">
                <h3>Smartphone</h3>
                <p class="product-category">Category: Electronics</p>
                <p class="product-price">$699.99</p>
                <p>Latest model with advanced features</p>
                <button class="btn-add-cart" onclick="addToCart(5)">Add to Cart</button>
            </div>
            
            <div class="product-card" data-category="clothing">
                <h3>Jeans</h3>
                <p class="product-category">Category: Clothing</p>
                <p class="product-price">$49.99</p>
                <p>Classic denim jeans</p>
                <button class="btn-add-cart" onclick="addToCart(6)">Add to Cart</button>
            </div>
        </div>
    </div>

    <script>
        let cartCount = 0;
        
        function addToCart(productId) {
            cartCount++;
            document.querySelector('.cart-count').textContent = cartCount;
            alert('Product added to cart!');
            // In real app: Make AJAX call to add to cart in session/database
        }
        
        function filterProducts() {
            const filter = document.getElementById('categoryFilter').value;
            const products = document.querySelectorAll('.product-card');
            
            products.forEach(product => {
                if (filter === 'all' || product.dataset.category === filter) {
                    product.style.display = 'block';
                } else {
                    product.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>