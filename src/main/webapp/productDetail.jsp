<%@ page import="org.example.model.Product" %>
<%@ page import="org.example.model.Category" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Details - IIT Store</title>
    <link rel="stylesheet" href="./libraries/bootstrap/bootstrap.min.css">
    <style>
        .product-image {
            width: 100%;
            height: 500px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .discount-badge {
            background: #ff4757;
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            font-weight: bold;
            font-size: 16px;
            display: inline-block;
            margin-bottom: 15px;
        }
        .price-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
        }
        .original-price {
            text-decoration: line-through;
            color: #999;
            font-size: 24px;
            margin-right: 15px;
        }
        .final-price {
            font-size: 36px;
            font-weight: bold;
            color: #2ecc71;
        }
        .btn-add-cart {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 15px 40px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .btn-add-cart:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }
        .product-info {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        .related-product-card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            cursor: pointer;
        }
        .related-product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.2);
        }
        .related-product-card img {
            height: 200px;
            object-fit: cover;
        }
        .breadcrumb {
            background: transparent;
            padding: 0;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

<%@include file="shared/navbar.jsp"%>

<div class="container mb-5">
    <%
        Product product = (Product) request.getAttribute("product");
        Category category = (Category) request.getAttribute("category");
        List<Product> relatedProducts = (List<Product>) request.getAttribute("relatedProducts");
        
        if (product != null && category != null) {
    %>
    
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="home">Home</a></li>
            <li class="breadcrumb-item"><a href="categories">Products</a></li>
            <li class="breadcrumb-item active" aria-current="page"><%= product.getName() %></li>
        </ol>
    </nav>
    
    <div class="row">
        <!-- Product Image -->
        <div class="col-md-6">
            <img src="<%= product.getImagePath() %>" alt="<%= product.getName() %>" class="product-image">
        </div>
        
        <!-- Product Info -->
        <div class="col-md-6">
            <div class="product-info">
                <% if (product.getDiscount() > 0) { %>
                <span class="discount-badge"> <%= String.format("%.0f", product.getDiscount()) %>% OFF</span>
                <% } %>
                
                <h1 class="mb-3"><%= product.getName() %></h1>
                
                <p class="text-muted mb-2">
                    <strong>Category:</strong> 
                    <a href="categories?id=<%= category.getId() %>" class="text-decoration-none">
                        <%= category.getName() %>
                    </a>
                </p>
                
                <div class="price-section">
                    <% if (product.getDiscount() > 0) { %>
                    <span class="original-price">$<%= String.format("%.2f", product.getPrice()) %></span>
                    <span class="final-price">$<%= String.format("%.2f", product.getFinalPrice()) %></span>
                    <p class="text-success mb-0 mt-2">
                        <strong>You save: $<%= String.format("%.2f", product.getPrice() - product.getFinalPrice()) %></strong>
                    </p>
                    <% } else { %>
                    <span class="final-price">$<%= String.format("%.2f", product.getPrice()) %></span>
                    <% } %>
                </div>
                
                <h5 class="mt-4 mb-3">Product Description</h5>
                <p class="lead"><%= product.getDescription() %></p>
                
                <div class="mt-4">
                    <h5 class="mb-3">Product Features</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"> High quality materials</li>
                        <li class="mb-2"> Fast shipping available</li>
                        <li class="mb-2"> 30-day return policy</li>
                        <li class="mb-2"> 1-year warranty included</li>
                    </ul>
                </div>
                
                <div class="d-grid gap-2 mt-4">
                    <button class="btn btn-add-cart" onclick="addToCart(<%= product.getId() %>)">
                         Add to Cart
                    </button>
                    <a href="categories" class="btn btn-outline-secondary">Continue Shopping</a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Related Products -->
    <% if (relatedProducts != null && !relatedProducts.isEmpty()) { %>
    <section class="mt-5">
        <h3 class="mb-4">More from <%= category.getName() %></h3>
        <div class="row g-4">
            <% for (Product related : relatedProducts) { %>
            <div class="col-md-3">
                <a href="product-detail?id=<%= related.getId() %>&categoryId=<%= category.getId() %>" class="text-decoration-none">
                    <div class="card related-product-card">
                        <img src="<%= related.getImagePath() %>" class="card-img-top" alt="<%= related.getName() %>">
                        <div class="card-body">
                            <h6 class="card-title text-dark"><%= related.getName() %></h6>
                            <% if (related.getDiscount() > 0) { %>
                            <p class="mb-0">
                                <span class="text-muted text-decoration-line-through">$<%= String.format("%.2f", related.getPrice()) %></span>
                                <span class="text-success fw-bold ms-2">$<%= String.format("%.2f", related.getFinalPrice()) %></span>
                            </p>
                            <% } else { %>
                            <p class="mb-0 fw-bold">$<%= String.format("%.2f", related.getPrice()) %></p>
                            <% } %>
                        </div>
                    </div>
                </a>
            </div>
            <% } %>
        </div>
    </section>
    <% } %>
    
    <% } else { %>
    <div class="alert alert-warning" role="alert">
        Product not found. <a href="home" class="alert-link">Return to home</a>
    </div>
    <% } %>
</div>

<script>
function addToCart(productId) {
    alert('Product added to cart! (Feature in development)');
}
</script>

<script src="./libraries/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
